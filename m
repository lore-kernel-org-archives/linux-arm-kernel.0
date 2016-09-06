From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 6 Sep 2016 20:05:37 +0200
Subject: [PATCH 02/21] ARM: shmobile: Convert to hotplug state machine
In-Reply-To: <20160906170457.32393-3-bigeasy@linutronix.de>
References: <20160906170457.32393-1-bigeasy@linutronix.de>
 <20160906170457.32393-3-bigeasy@linutronix.de>
Message-ID: <CAMuHMdWOZnL1cACUHSK+3T7CYenOci3Jx226cK6C0vq9RssjWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastian,

CC linux-renesas-soc

On Tue, Sep 6, 2016 at 7:04 PM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> Install the callbacks via the state machine.

Please describe why this is desirable.

> Cc: Simon Horman <horms@verge.net.au>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-sh at vger.kernel.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  arch/arm/mach-shmobile/platsmp-scu.c | 26 ++++++++------------------
>  include/linux/cpuhotplug.h           |  1 +
>  2 files changed, 9 insertions(+), 18 deletions(-)
>
> diff --git a/arch/arm/mach-shmobile/platsmp-scu.c b/arch/arm/mach-shmobile/platsmp-scu.c
> index 8d478f1da265..d1ecaf37d142 100644
> --- a/arch/arm/mach-shmobile/platsmp-scu.c
> +++ b/arch/arm/mach-shmobile/platsmp-scu.c
> @@ -21,26 +21,14 @@
>  static phys_addr_t shmobile_scu_base_phys;
>  static void __iomem *shmobile_scu_base;
>
> -static int shmobile_smp_scu_notifier_call(struct notifier_block *nfb,
> -                                         unsigned long action, void *hcpu)
> +static int shmobile_scu_cpu_prepare(unsigned int cpu)
>  {
> -       unsigned int cpu = (long)hcpu;
> -
> -       switch (action) {
> -       case CPU_UP_PREPARE:
> -               /* For this particular CPU register SCU SMP boot vector */
> -               shmobile_smp_hook(cpu, virt_to_phys(shmobile_boot_scu),
> -                                 shmobile_scu_base_phys);
> -               break;
> -       };
> -
> -       return NOTIFY_OK;
> +       /* For this particular CPU register SCU SMP boot vector */
> +       shmobile_smp_hook(cpu, virt_to_phys(shmobile_boot_scu),
> +                         shmobile_scu_base_phys);
> +       return 0;
>  }
>
> -static struct notifier_block shmobile_smp_scu_notifier = {
> -       .notifier_call = shmobile_smp_scu_notifier_call,
> -};
> -
>  void __init shmobile_smp_scu_prepare_cpus(phys_addr_t scu_base_phys,
>                                           unsigned int max_cpus)
>  {
> @@ -54,7 +42,9 @@ void __init shmobile_smp_scu_prepare_cpus(phys_addr_t scu_base_phys,
>         scu_power_mode(shmobile_scu_base, SCU_PM_NORMAL);
>
>         /* Use CPU notifier for reset vector control */
> -       register_cpu_notifier(&shmobile_smp_scu_notifier);
> +       cpuhp_setup_state_nocalls(CPUHP_ARM_SHMOBILE_SCU_PREPARE,
> +                                 "arm/shmobile-scu:prepare",
> +                                 shmobile_scu_cpu_prepare, NULL);
>  }
>
>  #ifdef CONFIG_HOTPLUG_CPU
> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index 0da071ff36d2..008eed0c0787 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -35,6 +35,7 @@ enum cpuhp_state {
>         CPUHP_POWERPC_PMAC_PREPARE,
>         CPUHP_POWERPC_MMU_CTX_PREPARE,
>         CPUHP_NOTIFY_PREPARE,
> +       CPUHP_ARM_SHMOBILE_SCU_PREPARE,
>         CPUHP_TIMERS_DEAD,
>         CPUHP_BRINGUP_CPU,
>         CPUHP_AP_IDLE_DEAD,

What's the rationale behind adding all these numbers and always
iterating over all
of them, even though most/all of them cannot be used at the same time
(e.g. CPUHP_SH_SH3X_PREPARE is for SuperH, while
 CPUHP_ARM_SHMOBILE_SCU_PREPARE is for ARM)?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
