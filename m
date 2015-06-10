From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Wed, 10 Jun 2015 16:32:32 +0200
Subject: [PATCH 1/1] irqchip: exynos-combiner: Save IRQ enable set on
 suspend
In-Reply-To: <CAPTzV16uP9GFeq9hPLvk2kg2F9aaB_936UdR_rpRbqoUh_q9zg@mail.gmail.com>
References: <1433941831-16637-1-git-send-email-javier.martinez@collabora.co.uk>
 <CAPTzV16uP9GFeq9hPLvk2kg2F9aaB_936UdR_rpRbqoUh_q9zg@mail.gmail.com>
Message-ID: <55784A80.7000603@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Chanho,

Thanks a lot for your feedback.

On 06/10/2015 03:40 PM, Chanho Park wrote:
> Hi,
> 
> On Wed, Jun 10, 2015 at 10:10 PM, Javier Martinez Canillas
> <javier.martinez@collabora.co.uk> wrote:
>> The Exynos interrupt combiner IP looses its state when the SoC enters
>> into a low power state during a Suspend-to-RAM. This means that if a
>> IRQ is used as a source, the interrupts for the devices are disabled
>> when the system is resumed from a sleep state so are not triggered.
>>
>> Save the interrupt enable set register for each combiner group and
>> restore it after resume to make sure that the interrupts are enabled.
>>
>> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>> ---
>>
>> Hello,
>>
>> I noticed this issue because after a S2R, IRQs for some devices didn't
>> trigger anymore but others continued working and all of them had lines
>> from a GPIO chip as their interrupt source.
>>
>> The only difference was that the GPIO pins that were not working after
>> a resume, were the ones that had the interrupt combiner as interrupt
>> parent.
>>
>> With this patch now all perhiperals are working correctly after a resume.
>> Tested on an Exynos5250 Snow, Exynos5420 Peach Pit and Exynos5800 Peach Pi
>> Chromebooks.
>>
>> Best regards,
>> Javier
>>
>>  drivers/irqchip/exynos-combiner.c | 61 +++++++++++++++++++++++++++++++++++----
>>  1 file changed, 56 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/irqchip/exynos-combiner.c b/drivers/irqchip/exynos-combiner.c
>> index 5945223b73fa..69c710641bfa 100644
>> --- a/drivers/irqchip/exynos-combiner.c
>> +++ b/drivers/irqchip/exynos-combiner.c
>> @@ -13,6 +13,7 @@
>>  #include <linux/init.h>
>>  #include <linux/io.h>
>>  #include <linux/slab.h>
>> +#include <linux/syscore_ops.h>
>>  #include <linux/irqdomain.h>
>>  #include <linux/irqchip/chained_irq.h>
>>  #include <linux/interrupt.h>
>> @@ -34,9 +35,14 @@ struct combiner_chip_data {
>>         unsigned int irq_mask;
>>         void __iomem *base;
>>         unsigned int parent_irq;
>> +#ifdef CONFIG_PM
>> +       u32 pm_save;
>> +#endif
>>  };
>>
>> +static struct combiner_chip_data *combiner_data;
>>  static struct irq_domain *combiner_irq_domain;
>> +static unsigned int max_nr = 20;
>>
>>  static inline void __iomem *combiner_base(struct irq_data *data)
>>  {
>> @@ -170,12 +176,10 @@ static struct irq_domain_ops combiner_irq_domain_ops = {
>>  };
>>
>>  static void __init combiner_init(void __iomem *combiner_base,
>> -                                struct device_node *np,
>> -                                unsigned int max_nr)
>> +                                struct device_node *np)
>>  {
>>         int i, irq;
>>         unsigned int nr_irq;
>> -       struct combiner_chip_data *combiner_data;
>>
>>         nr_irq = max_nr * IRQ_IN_COMBINER;
>>
>> @@ -201,11 +205,56 @@ static void __init combiner_init(void __iomem *combiner_base,
>>         }
>>  }
>>
>> +#ifdef CONFIG_PM
>> +
>> +/**
>> + * combiner_suspend - save interrupt combiner state before suspend
>> + *
>> + * Save the interrupt enable set register for all combiner groups since
>> + * the state is lost when the system enters into a sleep state.
>> + *
>> + */
>> +static int combiner_suspend(void)
>> +{
>> +       int i;
>> +
>> +       for (i = 0; i < max_nr; i++)
>> +               combiner_data[i].pm_save =
>> +                       __raw_readl(combiner_data[i].base + COMBINER_ENABLE_SET);
>> +
>> +       return 0;
>> +}
>> +
>> +/**
>> + * combiner_resume - restore interrupt combiner state after resume
>> + *
>> + * Restore the interrupt enable set register for all combiner groups since
>> + * the state is lost when the system enters into a sleep state on suspend.
>> + *
>> + */
>> +static void combiner_resume(void)
>> +{
>> +       int i;
>> +
>> +       for (i = 0; i < max_nr; i++)
> 
> Don't you need to clear masking bits of the COMBINER_ENABLE_CLEAR
> before enabling the bits?
>

I thought that was not needed since the enable bits are all cleared to 0
(default reset value) after a suspend.

But I can add the following if you think that it is needed or more safe:

		/* Disable all interrupts */
		__raw_writel(combiner_data[i].irq_mask,
			     combiner_data[i].base + COMBINER_ENABLE_CLEAR);
 
>> +               __raw_writel(combiner_data[i].pm_save,
>> +                            combiner_data[i].base + COMBINER_ENABLE_SET);
>> +}
>> +
>> +#else
>> +#define combiner_suspend       NULL
>> +#define combiner_resume                NULL
>> +#endif
>> +
>> +static struct syscore_ops combiner_syscore_ops = {
>> +       .suspend        = combiner_suspend,
>> +       .resume         = combiner_resume,
>> +};
>> +
>>  static int __init combiner_of_init(struct device_node *np,
>>                                    struct device_node *parent)
>>  {
>>         void __iomem *combiner_base;
>> -       unsigned int max_nr = 20;
>>
>>         combiner_base = of_iomap(np, 0);
>>         if (!combiner_base) {
>> @@ -219,7 +268,9 @@ static int __init combiner_of_init(struct device_node *np,
>>                         __func__, max_nr);
>>         }
>>
>> -       combiner_init(combiner_base, np, max_nr);
>> +       combiner_init(combiner_base, np);
>> +
>> +       register_syscore_ops(&combiner_syscore_ops);
>>
>>         return 0;
>>  }
>> --

Best regards,
Javier
