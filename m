From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 12 Dec 2013 11:05:20 -0800
Subject: [PATCH 7/8] mfd: pm8921: Migrate to irqdomains
In-Reply-To: <20131211213003.GC15223@sonymobile.com>
References: <1386718523-2587-1-git-send-email-sboyd@codeaurora.org>
 <1386718523-2587-8-git-send-email-sboyd@codeaurora.org>
 <20131211213003.GC15223@sonymobile.com>
Message-ID: <52AA08F0.2000308@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/11/13 13:30, Courtney Cavin wrote:
> On Wed, Dec 11, 2013 at 12:35:22AM +0100, Stephen Boyd wrote:
>> @@ -282,17 +278,14 @@ static struct irq_chip pm8xxx_irq_chip = {
>>   * RETURNS:
>>   * an int indicating the value read on that line
>>   */
>> -int pm8xxx_get_irq_stat(struct pm_irq_chip *chip, int irq)
>> +static int pm8xxx_get_irq_stat(struct pm_irq_chip *chip, int irq)
>>  {
>>         int pmirq, rc;
>>         u8  block, bits, bit;
>>         unsigned long flags;
>> +       struct irq_data *irq_data = irq_get_irq_data(irq);
>>
>> -       if (chip == NULL || irq < chip->irq_base ||
>> -                       irq >= chip->irq_base + chip->num_irqs)
>> -               return -EINVAL;
>> -
>> -       pmirq = irq - chip->irq_base;
>> +       pmirq = irq_data->hwirq;
>>
>>         block = pmirq / 8;
>>         bit = pmirq % 8;
>> @@ -322,64 +315,55 @@ bail_out:
>>  }
>>  EXPORT_SYMBOL_GPL(pm8xxx_get_irq_stat);
> Surely this isn't needed anymore, since the function is now static.

Sure. Deleted.

>
> [...]
>> +static int pm8xxx_irq_init(struct platform_device *pdev, unsigned int irq,
>> +                          unsigned int nirqs)
> 'nirqs' seems to always be 256.  Is there a benefit to keeping this
> dynamic?

I was future coding. Some pmics have less than 256 interrupts. I'll just
hardcode it for now and if/when we support the other pmics we can make
it a parameter.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
