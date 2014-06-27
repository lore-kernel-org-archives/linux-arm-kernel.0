From: kesavan.abhilash@gmail.com (Abhilash Kesavan)
Date: Fri, 27 Jun 2014 07:19:40 +0530
Subject: [PATCH] ARM: EXYNOS: Restore the entry address setup code
 post-resume
In-Reply-To: <alpine.LFD.2.11.1406261550060.16842@knanqh.ubzr>
References: <1403780312-22885-1-git-send-email-a.kesavan@samsung.com>
 <CAM4voa=AYDkHG49EEnr0097Dw4eS__T95oDrhswcfHEzY=PTcw@mail.gmail.com>
 <alpine.LFD.2.11.1406261550060.16842@knanqh.ubzr>
Message-ID: <CAM4voa=U-Z=dOedfzBXFOckW_nS-mEGv76dJwPhcMPEfvQdRMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jun 27, 2014 at 1:36 AM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Thu, 26 Jun 2014, Abhilash Kesavan wrote:
>
>> Hi,
>>
>> On Thu, Jun 26, 2014 at 4:28 PM, Abhilash Kesavan <a.kesavan@samsung.com> wrote:
>> > Setup the mcpm entry address again on system resume as the
>> > iRAM contents are lost across an s2r cycle.
>> >
>> > Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
>> > ---
>> > This has been tested after applying the Exynos5420 S2R support series
>> > along with Nicolas Pitre's boot cluster CCI enablement patches on Peach
>> > Pit.
>> >
>> >  arch/arm/mach-exynos/mcpm-exynos.c | 31 +++++++++++++++++++++----------
>> >  1 file changed, 21 insertions(+), 10 deletions(-)
>> >
>> > diff --git a/arch/arm/mach-exynos/mcpm-exynos.c b/arch/arm/mach-exynos/mcpm-exynos.c
>> > index 8c610e2..0bf734d 100644
>> > --- a/arch/arm/mach-exynos/mcpm-exynos.c
>> > +++ b/arch/arm/mach-exynos/mcpm-exynos.c
>> > @@ -15,6 +15,7 @@
>> >  #include <linux/delay.h>
>> >  #include <linux/io.h>
>> >  #include <linux/of_address.h>
>> > +#include <linux/syscore_ops.h>
>> >
>> >  #include <asm/cputype.h>
>> >  #include <asm/cp15.h>
>> > @@ -26,6 +27,7 @@
>> >  #define EXYNOS5420_CPUS_PER_CLUSTER    4
>> >  #define EXYNOS5420_NR_CLUSTERS         2
>> >
>> > +static void __iomem *ns_sram_base_addr;
>> >  /*
>> >   * The common v7_exit_coherency_flush API could not be used because of the
>> >   * Erratum 799270 workaround. This macro is the same as the common one (in
>> > @@ -308,10 +310,26 @@ static const struct of_device_id exynos_dt_mcpm_match[] = {
>> >         {},
>> >  };
>> >
>> > +static void exynos_mcpm_setup_entry_point(void)
>> > +{
>> > +       /*
>> > +        * U-Boot SPL is hardcoded to jump to the start of ns_sram_base_addr
>> > +        * as part of secondary_cpu_start().  Let's redirect it to the
>> > +        * mcpm_entry_point(). This is done during both secondary boot-up as
>> > +        * well as system resume.
>> > +        */
>> > +       __raw_writel(0xe59f0000, ns_sram_base_addr);     /* ldr r0, [pc, #0] */
>> > +       __raw_writel(0xe12fff10, ns_sram_base_addr + 4); /* bx  r0 */
>> > +       __raw_writel(virt_to_phys(mcpm_entry_point), ns_sram_base_addr + 8);
>> > +}
>> > +
>> > +static struct syscore_ops exynos_mcpm_syscore_ops = {
>> > +       .resume = exynos_mcpm_setup_entry_point,
>> > +};
>> > +
>> >  static int __init exynos_mcpm_init(void)
>> >  {
>> >         struct device_node *node;
>> > -       void __iomem *ns_sram_base_addr;
>> >         int ret;
>> >
>> >         node = of_find_matching_node(NULL, exynos_dt_mcpm_match);
>> > @@ -357,16 +375,9 @@ static int __init exynos_mcpm_init(void)
>> >
>> >         pr_info("Exynos MCPM support installed\n");
>> >
>> > -       /*
>> > -        * U-Boot SPL is hardcoded to jump to the start of ns_sram_base_addr
>> > -        * as part of secondary_cpu_start().  Let's redirect it to the
>> > -        * mcpm_entry_point().
>> > -        */
>> > -       __raw_writel(0xe59f0000, ns_sram_base_addr);     /* ldr r0, [pc, #0] */
>> > -       __raw_writel(0xe12fff10, ns_sram_base_addr + 4); /* bx  r0 */
>> > -       __raw_writel(virt_to_phys(mcpm_entry_point), ns_sram_base_addr + 8);
>> > +       exynos_mcpm_setup_entry_point();
>> >
>> > -       iounmap(ns_sram_base_addr);
>> > +       register_syscore_ops(&exynos_mcpm_syscore_ops);
>> >
>> >         return ret;
>> >  }
>>
>> This patch alone is not enough to bring the 8 cores back up post
>> resume on exynos5420, We need to enable the boot cluster snoops as
>> well.
>>
>> Nicolas, if I add code to enable the boot cluster CCI in
>> mach-exynos/sleep.S, all 8 cores come up. However, if I use
>> mcpm_loopback as part of the newly added resume function to do the
>> same, I get a hang on resume.
>> Is there anything else that I need to take care of while doing this ?
>
> No no no.
>
> Forget about the MCPM loopback -- that's for boot time setup of the
> booting cluster nothing else.
Ok, I thought this is to be used at resume too.
>
> The snoops are enabled in a ***race free way*** by the low-level MCPM
> code.  But of course you must call it upon resume.  Nothing else than
> MCPM should ever play with the snoops enable/disable.  Certainly not
> mach-exynos/sleep.S.
The sleep.S change was something I tried to isolate where I was going
wrong. Of course, in this case my basic premise of using mcpm_loopback
to enable snoops itself was flawed.
>
> You must tell your firmware to resume execution after suspend at
> mcpm_entry_point.  Before suspending, you tell MCPM where it should
> branch to after it is done with its resuming business by calling
> mcpm_set_entry_vector(), passing the address for exynos_cpu_resume for
> example.
Thanks for the explantion, will re-work the patch.
>
> And of course the CPU shutdown during idle has to go through MCPM too.
>
> When resumed, you also have to call mcpm_cpu_powered_up().
>
> See how it is done in cpuidle-big_little.c for example
Will check the cpuidle big.LITTLE driver also.

Regards,
Abhilash
