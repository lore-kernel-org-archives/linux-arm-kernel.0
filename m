From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 11 Apr 2013 11:07:52 +0200
Subject: [PATCH] ARM: shmobile: r8a7740: Add Suspend-To-RAM modes and
 CPUIdle
In-Reply-To: <CABYn4sxEOvQhZP7GnS5-AgNjkvJJXyv4n1UjVGBjXbVq0N+9_A@mail.gmail.com>
References: <1365609107-14290-1-git-send-email-hechtb+renesas@gmail.com>
 <5165E929.9030309@linaro.org>
 <CABYn4sxEOvQhZP7GnS5-AgNjkvJJXyv4n1UjVGBjXbVq0N+9_A@mail.gmail.com>
Message-ID: <51667D68.7070804@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/11/2013 09:07 AM, Bastian Hecht wrote:
> Hello Daniel,
> 
> thanks for the consolidation efforts.
> 
> 2013/4/11 Daniel Lezcano <daniel.lezcano@linaro.org>:
>> On 04/10/2013 05:51 PM, Bastian Hecht wrote:
>>> We add 2 sleep modes and register a CPUIdle driver that uses them.
>>>
>>> - A3SM PLL0 on/off:     Power domain A3SM that contains the ARM core
>>>                         and the 2nd level cache with either PLL0 on
>>>                       or off
>>>
>>> As the suspend to memory mechanism we use A3SM PLL off.
>>>
>>> The setup of the SYSC regarding the external IRQs is taken from
>>> pm-sh7372.c from Magnus Damm.
>>>
>>> Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
>>> ---
>>> Ok I need to add some remarks here:
>>>
>>> First this patch relies on a fix I've sent out today:
>>> "ARM: hw_breakpoint: Do not use __cpuinitdata for dbg_cpu_pm_nb"
>>> Without it we can't use suspend at all without a kernel panic.
>>>
>>> Next you can test this in two ways:
>>> Either add IRQF_NO_SUSPEND to the touchscreen driver st1232 at IRQ registration
>>> (hack) or extend the irqpin driver to support wakeup devices properly, meaning
>>> adding suspend and resume callbacks that handle it (proper way). Or you can add
>>> no_console_suspend to the boot options in r8a7740-armadillo800eva.dts. This way
>>> you can use the serial console as wakeup device.
>>>
>>>
>>>  arch/arm/mach-shmobile/Makefile               |    2 +-
>>>  arch/arm/mach-shmobile/include/mach/r8a7740.h |    2 +
>>>  arch/arm/mach-shmobile/pm-r8a7740.c           |  220 ++++++++++++++++++++++++-
>>>  arch/arm/mach-shmobile/sleep-r8a7740.S        |   68 ++++++++
>>>  4 files changed, 289 insertions(+), 3 deletions(-)
>>>  create mode 100644 arch/arm/mach-shmobile/sleep-r8a7740.S
>>>
>>> diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
>>> index 068f1da..0568894 100644
>>> --- a/arch/arm/mach-shmobile/Makefile
>>> +++ b/arch/arm/mach-shmobile/Makefile
>>> @@ -30,7 +30,7 @@ obj-$(CONFIG_SUSPEND)               += suspend.o
>>>  obj-$(CONFIG_CPU_IDLE)               += cpuidle.o
>>>  obj-$(CONFIG_ARCH_SHMOBILE)  += pm-rmobile.o
>>>  obj-$(CONFIG_ARCH_SH7372)    += pm-sh7372.o sleep-sh7372.o
>>> -obj-$(CONFIG_ARCH_R8A7740)   += pm-r8a7740.o
>>> +obj-$(CONFIG_ARCH_R8A7740)   += pm-r8a7740.o sleep-r8a7740.o
>>>  obj-$(CONFIG_ARCH_R8A7779)   += pm-r8a7779.o
>>>  obj-$(CONFIG_ARCH_SH73A0)    += pm-sh73a0.o
>>>
>>> diff --git a/arch/arm/mach-shmobile/include/mach/r8a7740.h b/arch/arm/mach-shmobile/include/mach/r8a7740.h
>>> index abdc4d4..ba4707b 100644
>>> --- a/arch/arm/mach-shmobile/include/mach/r8a7740.h
>>> +++ b/arch/arm/mach-shmobile/include/mach/r8a7740.h
>>> @@ -540,6 +540,8 @@ extern void r8a7740_add_standard_devices(void);
>>>  extern void r8a7740_clock_init(u8 md_ck);
>>>  extern void r8a7740_pinmux_init(void);
>>>  extern void r8a7740_pm_init(void);
>>> +extern void r8a7740_resume(void);
>>> +extern void r8a7740_shutdown(void);
>>>
>>>  #ifdef CONFIG_PM
>>>  extern void __init r8a7740_init_pm_domains(void);
>>> diff --git a/arch/arm/mach-shmobile/pm-r8a7740.c b/arch/arm/mach-shmobile/pm-r8a7740.c
>>> index 40b87aa..d4613f0 100644
>>> --- a/arch/arm/mach-shmobile/pm-r8a7740.c
>>> +++ b/arch/arm/mach-shmobile/pm-r8a7740.c
>>> @@ -8,10 +8,54 @@
>>>   * License.  See the file "COPYING" in the main directory of this archive
>>>   * for more details.
>>>   */
>>> +#include <linux/bitrev.h>
>>>  #include <linux/console.h>
>>> +#include <linux/cpuidle.h>
>>> +#include <linux/module.h>
>>>  #include <linux/suspend.h>
>>> +#include <linux/io.h>
>>> +#include <asm/suspend.h>
>>> +#include <asm/cacheflush.h>
>>> +#include <asm/cpuidle.h>
>>> +#include <asm/hardware/cache-l2x0.h>
>>>  #include <mach/pm-rmobile.h>
>>>  #include <mach/common.h>
>>> +#include <mach/r8a7740.h>
>>> +
>>> +/* CPGA */
>>> +#define PLLC01STPCR  IOMEM(0xe61500c8)
>>> +#define SYSTBCR              IOMEM(0xe6150024)
>>> +
>>> +/* SYSC */
>>> +#define STBCHR               IOMEM(0xe6180000)
>>> +#define STBCHRB              IOMEM(0xe6180040)
>>> +#define SPDCR                IOMEM(0xe6180008)
>>> +#define SBAR         IOMEM(0xe6180020)
>>> +#define SRSTFR               IOMEM(0xe61800B4)
>>> +#define WUPSMSK              IOMEM(0xe618002c)
>>> +#define WUPSMSK2     IOMEM(0xe6180048)
>>> +#define WUPSFAC              IOMEM(0xe6180098)
>>> +#define IRQCR                IOMEM(0xe618022c)
>>> +#define IRQCR2               IOMEM(0xe6180238)
>>> +#define IRQCR3               IOMEM(0xe6180244)
>>> +#define IRQCR4               IOMEM(0xe6180248)
>>> +
>>> +/* SRSTFR flags */
>>> +#define RAMST                (1 << 19)
>>> +#define RCLNKA               (1 << 7)
>>> +#define RCPRES               (1 << 5)
>>> +#define RCWD1                (1 << 4)
>>> +#define RPF          (1 << 0)
>>> +
>>> +/* INTC */
>>> +#define ICR1A                IOMEM(0xe6900000)
>>> +#define ICR2A                IOMEM(0xe6900004)
>>> +#define ICR3A                IOMEM(0xe6900008)
>>> +#define ICR4A                IOMEM(0xe690000c)
>>> +#define INTMSK00A    IOMEM(0xe6900040)
>>> +#define INTMSK10A    IOMEM(0xe6900044)
>>> +#define INTMSK20A    IOMEM(0xe6900048)
>>> +#define INTMSK30A    IOMEM(0xe690004c)
>>>
>>>  #ifdef CONFIG_PM
>>>  static int r8a7740_pd_a4s_suspend(void)
>>> @@ -58,12 +102,183 @@ void __init r8a7740_init_pm_domains(void)
>>>       rmobile_init_domains(r8a7740_pm_domains, ARRAY_SIZE(r8a7740_pm_domains));
>>>       pm_genpd_add_subdomain_names("A4S", "A3SP");
>>>  }
>>> -
>>>  #endif /* CONFIG_PM */
>>>
>>> +#if defined(CONFIG_SUSPEND) || defined(CONFIG_CPU_IDLE)
>>> +static void r8a7740_set_reset_vector(unsigned long address)
>>> +{
>>> +     __raw_writel(address, SBAR);
>>> +}
>>> +
>>> +static void r8a7740_icr_to_irqcr(unsigned long icr, u16 *irqcr1p, u16 *irqcr2p)
>>> +{
>>> +     u16 tmp, irqcr1, irqcr2;
>>> +     int k;
>>> +
>>> +     irqcr1 = 0;
>>> +     irqcr2 = 0;
>>> +
>>> +     /* convert INTCA ICR register layout to SYSC IRQCR+IRQCR2 */
>>> +     for (k = 0; k <= 7; k++) {
>>> +             tmp = (icr >> ((7 - k) * 4)) & 0xf;
>>> +             irqcr1 |= (tmp & 0x03) << (k * 2);
>>> +             irqcr2 |= (tmp >> 2) << (k * 2);
>>> +     }
>>> +
>>> +     *irqcr1p = irqcr1;
>>> +     *irqcr2p = irqcr2;
>>> +}
>>> +
>>> +static void r8a7740_setup_sysc(unsigned long msk, unsigned long msk2)
>>> +{
>>> +     u16 irqcrx_low, irqcrx_high, irqcry_low, irqcry_high;
>>> +     unsigned long tmp;
>>> +
>>> +     /* read IRQ0A -> IRQ15A mask */
>>> +     tmp = bitrev8(__raw_readb(INTMSK00A));
>>> +     tmp |= bitrev8(__raw_readb(INTMSK10A)) << 8;
>>> +
>>> +     /* setup WUPSMSK from clocks and external IRQ mask */
>>> +     msk = (~msk & 0xc030000f) | (tmp << 4);
>>> +     __raw_writel(msk, WUPSMSK);
>>> +
>>> +     /* propage level/edge trigger for external IRQ 0->15 */
>>> +     r8a7740_icr_to_irqcr(__raw_readl(ICR1A), &irqcrx_low, &irqcry_low);
>>> +     r8a7740_icr_to_irqcr(__raw_readl(ICR2A), &irqcrx_high, &irqcry_high);
>>> +     __raw_writel((irqcrx_high << 16) | irqcrx_low, IRQCR);
>>> +     __raw_writel((irqcry_high << 16) | irqcry_low, IRQCR2);
>>> +
>>> +     /* read IRQ16A -> IRQ31A mask */
>>> +     tmp = bitrev8(__raw_readb(INTMSK20A));
>>> +     tmp |= bitrev8(__raw_readb(INTMSK30A)) << 8;
>>> +
>>> +     /* setup WUPSMSK2 from clocks and external IRQ mask */
>>> +     msk2 = (~msk2 & 0x00030000) | tmp;
>>> +     __raw_writel(msk2, WUPSMSK2);
>>> +
>>> +     /* propage level/edge trigger for external IRQ 16->31 */
>>> +     r8a7740_icr_to_irqcr(__raw_readl(ICR3A), &irqcrx_low, &irqcry_low);
>>> +     r8a7740_icr_to_irqcr(__raw_readl(ICR4A), &irqcrx_high, &irqcry_high);
>>> +     __raw_writel((irqcrx_high << 16) | irqcrx_low, IRQCR3);
>>> +     __raw_writel((irqcry_high << 16) | irqcry_low, IRQCR4);
>>> +}
>>> +
>>> +static void r8a7740_prepare_wakeup(void)
>>> +{
>>> +     /* clear all flags that lead to a cold boot */
>>> +     __raw_writel(~(RAMST | RCLNKA | RCPRES | RCWD1 | RPF), SRSTFR);
>>> +     /* indicate warm boot */
>>> +     __raw_writel(0x80000000, STBCHRB);
>>> +     /* clear other flags checked by internal ROM boot loader */
>>> +     __raw_writel(0x00000000, STBCHR);
>>> +}
>>> +
>>> +static int r8a7740_do_suspend(unsigned long unused)
>>> +{
>>> +     /*
>>> +      * cpu_suspend() guarantees that all data made it to the L2.
>>> +      * Flush it out now and disable the cache controller.
>>> +      */
>>> +     outer_flush_all();
>>> +     outer_disable();
>>> +
>>> +     r8a7740_shutdown();
>>> +
>>> +     /* in case WFI fails to enter the low power state, restore things */
>>> +     outer_resume();
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static void r8a7740_enter_a3sm_common(int pllc0_on)
>>> +{
>>> +     u32 reg32;
>>> +
>>> +     if (pllc0_on)
>>> +             __raw_writel(0, PLLC01STPCR);
>>> +     else
>>> +             __raw_writel(1 << 28, PLLC01STPCR);
>>> +
>>> +     r8a7740_set_reset_vector(__pa(r8a7740_resume));
>>> +     r8a7740_prepare_wakeup();
>>> +     r8a7740_setup_sysc(1 << 0, 0);
>>> +
>>> +     /* Activate delayed shutdown of A3SM */
>>> +     reg32 = __raw_readl(SPDCR);
>>> +     reg32 |= (1 << 31) | (1 << 12);
>>> +     __raw_writel(reg32, SPDCR);
>>> +
>>> +     /* We activate CPU Core Standby as well here */
>>> +     reg32 = __raw_readl(SYSTBCR);
>>> +     reg32 |= (1 << 4);
>>> +     __raw_writel(reg32, SYSTBCR);
>>> +
>>> +     /* Clear Wakeup Factors and do suspend */
>>> +     reg32 = __raw_readl(WUPSFAC);
>>> +     cpu_suspend(0, r8a7740_do_suspend);
>>> +     outer_resume();
>>> +     reg32 = __raw_readl(WUPSFAC);
>>> +
>>> +     /* Clear CPU Core Standby flag for other WFI instructions */
>>> +     reg32 &= ~(1 << 4);
>>> +     __raw_writel(reg32, SYSTBCR);
>>> +
>>> +}
>>> +#endif /* CONFIG_SUSPEND || CONFIG_CPU_IDLE */
>>> +
>>> +#ifdef CONFIG_CPU_IDLE
>>> +static int r8a7740_enter_a3sm_pll_on(struct cpuidle_device *dev,
>>> +                                     struct cpuidle_driver *drv, int index)
>>> +{
>>> +     r8a7740_enter_a3sm_common(1);
>>> +     return 1;
>>> +}
>>> +
>>> +static int r8a7740_enter_a3sm_pll_off(struct cpuidle_device *dev,
>>> +                                     struct cpuidle_driver *drv, int index)
>>> +{
>>> +     r8a7740_enter_a3sm_common(0);
>>> +     return 2;
>>> +}
>>> +
>>> +static struct cpuidle_driver r8a7740_cpuidle_driver = {
>>> +     .name                   = "r8a7740_cpuidle",
>>> +     .owner                  = THIS_MODULE,
>>> +     .en_core_tk_irqen       = 1,
>>> +     .state_count            = 3,
>>> +     .safe_state_index       = 0, /* C1 */
>>> +     .states[0] = ARM_CPUIDLE_WFI_STATE,
>>> +     .states[0].enter = shmobile_enter_wfi,
>>
>> The WFI macro already set a simple enter function doing cpu_do_idle.
> 
> Oh yes, I'll remove it.
> 
>> We are trying to consolidate the cpuidle drivers across the different
>> platforms [1]. One of the objective is to move the cpuidle drivers to
>> drivers/cpuidle, a place where they belong to.
>>
>> Do you think it is possible you split your code to have one part with
>> the cpuidle driver and another part with the PM code ?
> 
> Hmm. The CPUIdle part is enclosed in the #ifdef CONFIG_CPU_IDLE part anyway.
> The other part (CONFIG_SUSPEND | CONFIG_CPU_IDLE) contains the part
> that actually does drive down the hardware and is needed as soon as
> SUSPEND or CPUIdle is used.
> 
> So is it split well enough already or does it help if I split my patch
> into 2, first adding suspend and then CPUIdle to the same file? But
> the outcome will be the same I think.


Well, if you can convert the pm functions into ops used in the cpuidle
driver and then create a file eg. cpuidle-r8a7740.c with the cpuidle
code calling the ops that will separate clearly the cpuidle code from
the pm code and make easier to move the cpuidle driver to the
drivers/cpuidle directory. Also, I think that will help to consolidate
the other shmobile cpuidle drivers, maybe into a single one.






-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
