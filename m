From: hechtb@gmail.com (Bastian Hecht)
Date: Fri, 14 Dec 2012 16:33:39 +0100
Subject: [PATCH 2/2] ARM: SH-Mobile: sh73a0: Add CPU Hotplug
In-Reply-To: <50CB34F4.8060204@gmail.com>
References: <1354795719-5578-1-git-send-email-hechtb+renesas@gmail.com>
 <1354795719-5578-2-git-send-email-hechtb+renesas@gmail.com>
 <50CB34F4.8060204@gmail.com>
Message-ID: <CABYn4syb8yBRwUqbS=2dp1i3FYFt1edYPRh9xa=aHTY9RsWw8A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

2012/12/14 Rob Herring <robherring2@gmail.com>:
> On 12/06/2012 06:08 AM, Bastian Hecht wrote:
>> From: Bastian Hecht <hechtb@gmail.com>
>>
>> Add the capability to add and remove CPUs on the fly.
>> The Cortex-A9 offers the possibility to take single cores out of the
>> MP Core. We add this capabilty taking care that caches are kept
>> coherent. For the actual shutdown via a WFI instruction, a code snippet
>> from the omap2 code tree is copied. Thanks for that! For verifying the
>> shutdown we rely on the internal SH73A0 Power Status Register
>> PSTR.
>>
>> Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
>> ---
>>  arch/arm/mach-shmobile/headsmp-sh73a0.S      |   46 ++++++++++++++++++++++++++
>>  arch/arm/mach-shmobile/include/mach/common.h |    1 +
>>  arch/arm/mach-shmobile/smp-sh73a0.c          |   41 +++++++++++++++++++----
>>  3 files changed, 82 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm/mach-shmobile/headsmp-sh73a0.S b/arch/arm/mach-shmobile/headsmp-sh73a0.S
>> index bec4c0d..be463a3 100644
>> --- a/arch/arm/mach-shmobile/headsmp-sh73a0.S
>> +++ b/arch/arm/mach-shmobile/headsmp-sh73a0.S
>> @@ -23,6 +23,52 @@
>>  #include <linux/init.h>
>>  #include <asm/memory.h>
>>
>> +/* Taken from arch/arm/mach-omap2/sleep44xx.S. Thanks! */
>> +ENTRY(sh73a0_do_wfi)
>> +        stmfd   sp!, {lr}
>
> Why does the lr need to be pushed to the stack?

Yes I must admit this is paradox - we never return but prepare to do
so... In the OMAP code they've got a lead out code in case the WFI
doesn't succeed. I see no reason how this could ever happen here but
to take a safe route I've decided to keep the mechanism to be able to
return and spit out an error message back in the C code.

>> +
>> +        /*
>> +         * Execute an ISB instruction to ensure that all of the
>> +         * CP15 register changes have been committed.
>> +         */
>> +        isb
>
> Generally writes to cp15 registers that need an isb already do so.

Ok nice, I'll check that and throw it out.

>> +
>> +        /*
>> +         * Execute a barrier instruction to ensure that all cache,
>> +         * TLB and branch predictor maintenance operations issued
>> +         * by any CPU in the cluster have completed.
>> +         */
>> +        dsb
>> +        dmb
>
> A dsb is a superset of a dmb, so you should not need both.

Same here.

>> +
>> +        /*
>> +         * Execute a WFI instruction and wait until the
>> +         * STANDBYWFI output is asserted to indicate that the
>> +         * CPU is in idle and low power state. CPU can specualatively
>> +         * prefetch the instructions so add NOPs after WFI. Sixteen
>> +         * NOPs as per Cortex-A9 pipeline.
>
> Why do you care what is prefetched? You're never coming back here, right?

We can jump back to the paradox top. The idea seems to be to have a
clean pipeline in case the WFI doesn't succeed.
The thing about this whole code snippet is: I saw no reason to
reinvent the wheel and tinker on my own solution when there is code
that does the job in a clean way. I thought this could maybe be moved
to a general ARM code base when more people rely on it.

cheers,

 Bastian


> Rob
>
>> +         */
>> +        wfi                                     @ Wait For Interrupt
>> +        nop
>> +        nop
>> +        nop
>> +        nop
>> +        nop
>> +        nop
>> +        nop
>> +        nop
>> +        nop
>> +        nop
>> +        nop
>> +        nop
>> +        nop
>> +        nop
>> +        nop
>> +        nop
>> +
>> +        ldmfd   sp!, {pc}
>> +ENDPROC(sh73a0_do_wfi)
>> +
>>       __CPUINIT
>>  /*
>>   * Reset vector for secondary CPUs.
>> diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
>> index f2e2c29..40f767e 100644
>> --- a/arch/arm/mach-shmobile/include/mach/common.h
>> +++ b/arch/arm/mach-shmobile/include/mach/common.h
>> @@ -55,6 +55,7 @@ extern void sh73a0_add_standard_devices(void);
>>  extern void sh73a0_clock_init(void);
>>  extern void sh73a0_pinmux_init(void);
>>  extern void sh73a0_secondary_vector(void);
>> +extern void sh73a0_do_wfi(void);
>>  extern struct clk sh73a0_extal1_clk;
>>  extern struct clk sh73a0_extal2_clk;
>>  extern struct clk sh73a0_extcki_clk;
>> diff --git a/arch/arm/mach-shmobile/smp-sh73a0.c b/arch/arm/mach-shmobile/smp-sh73a0.c
>> index 5e36f5d..9237e13 100644
>> --- a/arch/arm/mach-shmobile/smp-sh73a0.c
>> +++ b/arch/arm/mach-shmobile/smp-sh73a0.c
>> @@ -24,6 +24,7 @@
>>  #include <linux/io.h>
>>  #include <linux/delay.h>
>>  #include <mach/common.h>
>> +#include <asm/cacheflush.h>
>>  #include <asm/smp_plat.h>
>>  #include <mach/sh73a0.h>
>>  #include <asm/smp_scu.h>
>> @@ -36,6 +37,8 @@
>>  #define SBAR         IOMEM(0xe6180020)
>>  #define APARMBAREA   IOMEM(0xe6f10020)
>>
>> +#define PSTR_SHUTDOWN_MODE   3
>> +
>>  static void __iomem *scu_base_addr(void)
>>  {
>>       return (void __iomem *)0xf0000000;
>> @@ -92,16 +95,20 @@ static void __init sh73a0_smp_init_cpus(void)
>>       shmobile_smp_init_cpus(ncores);
>>  }
>>
>> -static int __maybe_unused sh73a0_cpu_kill(unsigned int cpu)
>> +#ifdef CONFIG_HOTPLUG_CPU
>> +static int sh73a0_cpu_kill(unsigned int cpu)
>>  {
>> +
>>       int k;
>> +     u32 pstr;
>>
>> -     /* this function is running on another CPU than the offline target,
>> -      * here we need wait for shutdown code in platform_cpu_die() to
>> -      * finish before asking SoC-specific code to power off the CPU core.
>> +     /*
>> +      * wait until the power status register confirms the shutdown of the
>> +      * offline target
>>        */
>>       for (k = 0; k < 1000; k++) {
>> -             if (shmobile_cpu_is_dead(cpu))
>> +             pstr = (__raw_readl(PSTR) >> (4 * cpu)) & 3;
>> +             if (pstr == PSTR_SHUTDOWN_MODE)
>>                       return 1;
>>
>>               mdelay(1);
>> @@ -110,6 +117,28 @@ static int __maybe_unused sh73a0_cpu_kill(unsigned int cpu)
>>       return 0;
>>  }
>>
>> +static void sh73a0_cpu_die(unsigned int cpu)
>> +{
>> +     /*
>> +      * The ARM MPcore does not issue a cache coherency request for the L1
>> +      * cache when powering off single CPUs. We must take care of this and
>> +      * further caches.
>> +      */
>> +     dsb();
>> +     flush_cache_all();
>> +
>> +     /* Set power off mode. This takes the CPU out of the MP cluster */
>> +     scu_power_mode(scu_base_addr(), SCU_PM_POWEROFF);
>> +
>> +     /* Enter shutdown mode */
>> +     sh73a0_do_wfi();
>> +
>> +     /* We assume success always. We never reach this */
>> +     pr_err("Shutting down CPU failed. This should never happen!\n");
>> +     for (;;)
>> +             ;
>> +}
>> +#endif /* CONFIG_HOTPLUG_CPU */
>>
>>  struct smp_operations sh73a0_smp_ops __initdata = {
>>       .smp_init_cpus          = sh73a0_smp_init_cpus,
>> @@ -118,7 +147,7 @@ struct smp_operations sh73a0_smp_ops __initdata = {
>>       .smp_boot_secondary     = sh73a0_boot_secondary,
>>  #ifdef CONFIG_HOTPLUG_CPU
>>       .cpu_kill               = sh73a0_cpu_kill,
>> -     .cpu_die                = shmobile_cpu_die,
>> +     .cpu_die                = sh73a0_cpu_die,
>>       .cpu_disable            = shmobile_cpu_disable,
>>  #endif
>>  };
>>
>
