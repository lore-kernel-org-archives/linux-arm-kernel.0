From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 10 Jan 2013 17:34:22 +0900
Subject: [PATCH 3/8] ARM: shmobile: Add support OF of INTC for sh7372
In-Reply-To: <20130109111742.GA7337@e106331-lin.cambridge.arm.com>
References: <1357713007-4005-1-git-send-email-horms+renesas@verge.net.au>
 <1357713007-4005-4-git-send-email-horms+renesas@verge.net.au>
 <20130109111742.GA7337@e106331-lin.cambridge.arm.com>
Message-ID: <CANqRtoSNDtr2zPu0t0fCa7K7CEOtoLpHPdoVBWuJSFs0nCM32Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

Thanks for your feedback!

On Wed, Jan 9, 2013 at 8:17 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Wed, Jan 09, 2013 at 06:30:02AM +0000, Simon Horman wrote:
>> From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
>>
>> This CPU has four interrupt controllers (INTCA, pins-High and pins-Low).
>> This supports these.
>> Note: This supports DT of INTCA only.
>>
>> Cc: Magnus Damm <damm@opensource.se>
>> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
>> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>>
>> ---
>>
>> v9
>> * Update compatible string to use '-' instead of '_'
>> ---
>>  arch/arm/mach-shmobile/include/mach/common.h |    1 +
>>  arch/arm/mach-shmobile/intc-sh7372.c         |  113 ++++++++++++++++++++------
>>  2 files changed, 89 insertions(+), 25 deletions(-)
>>
>> diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
>> index d0a5790..223250b 100644
>> --- a/arch/arm/mach-shmobile/include/mach/common.h
>> +++ b/arch/arm/mach-shmobile/include/mach/common.h
>> @@ -18,6 +18,7 @@ extern int shmobile_enter_wfi(struct cpuidle_device *dev,
>>                             struct cpuidle_driver *drv, int index);
>>  extern void shmobile_cpuidle_set_driver(struct cpuidle_driver *drv);
>>
>> +extern void sh7372_init_irq_of(void);
>>  extern void sh7372_init_irq(void);
>>  extern void sh7372_map_io(void);
>>  extern void sh7372_add_early_devices(void);
>> diff --git a/arch/arm/mach-shmobile/intc-sh7372.c b/arch/arm/mach-shmobile/intc-sh7372.c
>> index a91caad..bbde18d 100644
>> --- a/arch/arm/mach-shmobile/intc-sh7372.c
>> +++ b/arch/arm/mach-shmobile/intc-sh7372.c
>> @@ -16,6 +16,8 @@
>>   * along with this program; if not, write to the Free Software
>>   * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
>>   */
>> +#define pr_fmt(fmt) "intc: " fmt
>> +
>>  #include <linux/kernel.h>
>>  #include <linux/init.h>
>>  #include <linux/interrupt.h>
>> @@ -551,23 +553,28 @@ static void intcs_demux(unsigned int irq, struct irq_desc *desc)
>>
>>  static void __iomem *intcs_ffd2;
>>  static void __iomem *intcs_ffd5;
>> -
>> -void __init sh7372_init_irq(void)
>> +static void __iomem *intca_e694;
>> +static void __iomem *intca_e695;
>> +
>> +static void __init sh7372_init_intc(resource_size_t intca0_start,
>> +                                 resource_size_t intca1_start,
>> +                                 resource_size_t intcs0_start,
>> +                                 resource_size_t intcs1_start,
>> +                                 unsigned short vect)
>>  {
>>       void __iomem *intevtsa;
>>       int n;
>>
>> -     intcs_ffd2 = ioremap_nocache(0xffd20000, PAGE_SIZE);
>> -     intevtsa = intcs_ffd2 + 0x100;
>> -     intcs_ffd5 = ioremap_nocache(0xffd50000, PAGE_SIZE);
>> +     intca_e694 = IOMEM(intca0_start);
>> +     intca_e695 = IOMEM(intca1_start);
>>
>> -     register_intc_controller(&intca_desc);
>> -     register_intc_controller(&intca_irq_pins_lo_desc);
>> -     register_intc_controller(&intca_irq_pins_hi_desc);
>> -     register_intc_controller(&intcs_desc);
>> +     intcs_ffd2 = ioremap_nocache(intcs0_start, PAGE_SIZE);
>> +     intevtsa = intcs_ffd2 + 0x100;
>> +     intcs_ffd5 = ioremap_nocache(intcs1_start, PAGE_SIZE);
>
> I think you need to check the return value of ioremap_nocache (it looks like it
> could return NULL), but I'm not certain of its semantics.

I guess we could, but I suppose it is somewhat unclear how we shall
proceed in the case of failure.

But regardless, this is not really changing any logic in the current code.

>>
>>       /* setup dummy cascade chip for INTCS */
>> -     n = evt2irq(0xf80);
>> +     n = evt2irq(vect);
>> +
>>       irq_alloc_desc_at(n, numa_node_id());
>>       irq_set_chip_and_handler_name(n, &dummy_irq_chip,
>>                                     handle_level_irq, "level");
>> @@ -581,6 +588,65 @@ void __init sh7372_init_irq(void)
>>       iowrite16(0, intcs_ffd2 + 0x104);
>>  }
>>
>> +#ifdef CONFIG_OF
>> +static unsigned short intevtsa_vect;
>> +
>> +#define INTC_RES_MAX 2
>> +static struct {
>> +     struct intc_desc intc_desc;
>> +     struct resource intc_res[INTC_RES_MAX];
>> +} intc_data __initdata;
>> +
>> +static int __init intc_of_init(struct device_node *np,
>> +                            struct device_node *parent)
>> +{
>> +     int ret, i;
>> +
>> +     memset(&intc_data, 0, sizeof(intc_data));
>> +
>> +     for (i = 0; i < INTC_RES_MAX; i++) {
>> +             ret = of_address_to_resource(np, i, &intc_data.intc_res[i]);
>> +             if (ret < 0)
>> +                     break;
>> +     }
>> +
>> +     intc_data.intc_desc.name = (char *)of_node_full_name(np);
>> +     intc_data.intc_desc.resource = intc_data.intc_res;
>> +     intc_data.intc_desc.num_resources = i;
>> +
>> +     ret = of_sh_intc_get_intc(np, &intc_data.intc_desc);
>> +     if (ret)
>> +             return ret;
>> +
>> +     of_sh_intc_get_intevtsa_vect(np, &intevtsa_vect);
>> +
>> +     register_intc_controller(&intc_data.intc_desc);
>> +     return 0;
>> +}
>
> You seem to have the same code for r8a7740. They should be consolidated.

The plan is to consolidate part of this code. There is also a chained
interrupt handler that needs a bit more work, so we prefer to figure
out how to tie in GIC platforms first then merge code together.

>> +
>> +static const struct of_device_id irq_of_match[] __initconst = {
>> +     { .compatible = "renesas,sh-intc", .data = intc_of_init },
>> +     { /*sentinel*/ }
>> +};
>> +
>> +void __init sh7372_init_irq_of(void)
>> +{
>> +     of_irq_init(irq_of_match);
>> +
>> +     register_intc_controller(&intcs_desc);
>
> What if of_irq_init fails?

Good question. Perhaps Iwamatsu-san can answer that. =)

>> +}
>> +#endif /* CONFIG_OF */
>> +
>> +void __init sh7372_init_irq(void)
>> +{
>> +     register_intc_controller(&intca_desc);
>> +     register_intc_controller(&intca_irq_pins_lo_desc);
>> +     register_intc_controller(&intca_irq_pins_hi_desc);
>> +     register_intc_controller(&intcs_desc);
>> +
>> +     sh7372_init_intc(0xe6940000, 0xe6950000, 0xffd20000, 0xffd50000, 0xf80);
>
> It might be better if these magic numbers were macro'd out for legibility.

Sure, why not?

>> +}
>> +
>>  static unsigned short ffd2[0x200];
>>  static unsigned short ffd5[0x100];
>>
>> @@ -624,9 +690,6 @@ void sh7372_intcs_resume(void)
>>               __raw_writeb(ffd5[k], intcs_ffd5 + k);
>>  }
>>
>> -#define E694_BASE IOMEM(0xe6940000)
>> -#define E695_BASE IOMEM(0xe6950000)
>> -
>>  static unsigned short e694[0x200];
>>  static unsigned short e695[0x200];
>>
>> @@ -635,22 +698,22 @@ void sh7372_intca_suspend(void)
>>       int k;
>>
>>       for (k = 0x00; k <= 0x38; k += 4)
>> -             e694[k] = __raw_readw(E694_BASE + k);
>> +             e694[k] = __raw_readw(intca_e694 + k);
>>
>>       for (k = 0x80; k <= 0xb4; k += 4)
>> -             e694[k] = __raw_readb(E694_BASE + k);
>> +             e694[k] = __raw_readb(intca_e694 + k);
>>
>>       for (k = 0x180; k <= 0x1b4; k += 4)
>> -             e694[k] = __raw_readb(E694_BASE + k);
>> +             e694[k] = __raw_readb(intca_e694 + k);
>>
>>       for (k = 0x00; k <= 0x50; k += 4)
>> -             e695[k] = __raw_readw(E695_BASE + k);
>> +             e695[k] = __raw_readw(intca_e695 + k);
>>
>>       for (k = 0x80; k <= 0xa8; k += 4)
>> -             e695[k] = __raw_readb(E695_BASE + k);
>> +             e695[k] = __raw_readb(intca_e695 + k);
>>
>>       for (k = 0x180; k <= 0x1a8; k += 4)
>> -             e695[k] = __raw_readb(E695_BASE + k);
>> +             e695[k] = __raw_readb(intca_e695 + k);
>>  }
>
> I'm unfamiliar with the hardware, what are these registers being iterated over?
>
> How do they correspond to entries in the binding?

This is rather crude code to save and restore various registers that
will be reset when the power domain is turned off. Ideally we want
something more generic, but at this point the code exists and works.
Perhaps in the long run we should follow the same style as the GIC.

I hope that Iwamatsu-san (the original author) will follow up on this
and post an incremental patch to fix things.

Thanks,

/ magnus
