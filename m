From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 21 Jun 2017 10:16:47 +0200
Subject: [PATCH v4 20/28] ARM: owl: Implement CPU enable-method for S500
In-Reply-To: <20170606005426.26446-21-afaerber@suse.de>
References: <20170606005426.26446-1-afaerber@suse.de>
 <20170606005426.26446-21-afaerber@suse.de>
Message-ID: <CAK8P3a1fLABzSc7kej6uw751uoZma1Qvpm7c3mkLB45rcBNQTA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 6, 2017 at 2:54 AM, Andreas F?rber <afaerber@suse.de> wrote:
> Allow to bring up CPU1.
>
> Based on LeMaker linux-actions tree.
>
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  v3 -> v4: Unchanged
>
>  v3: new
>
>  arch/arm/mach-actions/Makefile  |   3 +
>  arch/arm/mach-actions/headsmp.S |  68 ++++++++++++++++
>  arch/arm/mach-actions/platsmp.c | 166 ++++++++++++++++++++++++++++++++++++++++

I now see build errors in linux-next:

/git/arm-soc/arch/arm/mach-actions/platsmp.c: In function 'write_pen_release':
/git/arm-soc/arch/arm/mach-actions/platsmp.c:39:2: error:
'pen_release' undeclared (first use in this function); did you mean
'seq_release'?
  pen_release = val;
  ^~~~~~~~~~~
  seq_release
/git/arm-soc/arch/arm/mach-actions/platsmp.c:39:2: note: each
undeclared identifier is reported only once for each function it
appears in
/git/arm-soc/arch/arm/mach-actions/platsmp.c: In function
's500_wakeup_secondary':
/git/arm-soc/arch/arm/mach-actions/platsmp.c:79:2: error: implicit
declaration of function 'dsb_sev'
[-Werror=implicit-function-declaration]
  dsb_sev();
  ^~~~~~~
/git/arm-soc/arch/arm/mach-actions/platsmp.c: In function
's500_smp_boot_secondary':
/git/arm-soc/arch/arm/mach-actions/platsmp.c:108:7: error:
'pen_release' undeclared (first use in this function); did you mean
'seq_release'?


> +static DEFINE_SPINLOCK(boot_lock);
> +
> +static void write_pen_release(int val)
> +{
> +       pen_release = val;
> +       smp_wmb();
> +       __cpuc_flush_dcache_area((void *)&pen_release, sizeof(pen_release));
> +       outer_clean_range(__pa(&pen_release), __pa(&pen_release + 1));
> +}
> +
> +static void s500_smp_secondary_init(unsigned int cpu)
> +{
> +       /*
> +        * let the primary processor know we're out of the
> +        * pen, then head off into the C entry point
> +        */
> +       write_pen_release(-1);
> +
> +       spin_lock(&boot_lock);
> +       spin_unlock(&boot_lock);
> +}
> +
> +void owl_secondary_startup(void);
> +
> +static int s500_wakeup_secondary(unsigned int cpu)
> +{
> +       if (cpu > 3)
> +               return -EINVAL;
> +
> +       switch (cpu) {
> +       case 2:
> +       case 3:
> +               /* CPU2/3 are power-gated */
> +               return -EINVAL;
> +       }
> +
> +       /* wait for CPUx to run to WFE instruction */
> +       udelay(200);
> +
> +       writel(virt_to_phys(owl_secondary_startup),
> +              timer_base_addr + OWL_CPU1_ADDR + (cpu - 1) * 4);
> +       writel(OWL_CPUx_FLAG_BOOT,
> +              timer_base_addr + OWL_CPU1_FLAG + (cpu - 1) * 4);
> +
> +       dsb_sev();
> +       mb();
> +
> +       return 0;
> +}
> +
> +static int s500_smp_boot_secondary(unsigned int cpu, struct task_struct *idle)
> +{
> +       unsigned long timeout;
> +       int ret;
> +
> +       ret = s500_wakeup_secondary(cpu);
> +       if (ret)
> +               return ret;
> +
> +       udelay(10);
> +
> +       spin_lock(&boot_lock);
> +
> +       /*
> +        * The secondary processor is waiting to be released from
> +        * the holding pen - release it, then wait for it to flag
> +        * that it has been released by resetting pen_release.
> +        */
> +       write_pen_release(cpu_logical_map(cpu));
> +       smp_send_reschedule(cpu);
> +
> +       timeout = jiffies + (1 * HZ);
> +       while (time_before(jiffies, timeout)) {
> +               if (pen_release == -1)
> +                       break;
> +       }
> +
> +       writel(0, timer_base_addr + OWL_CPU1_ADDR + (cpu - 1) * 4);
> +       writel(0, timer_base_addr + OWL_CPU1_FLAG + (cpu - 1) * 4);
> +
> +       spin_unlock(&boot_lock);
> +
> +       return pen_release != -1 ? -ENOSYS : 0;
> +}

This looks more complicated than necessary. Why do you need the holding
pen when you have a register to start up the CPU?

        Arnd
