From: eballetbo@gmail.com (Enric Balletbo Serra)
Date: Mon, 29 May 2017 11:23:01 +0200
Subject: [PATCH v2 1/2] arm: process: dump memory around registers when
 displaying regs
In-Reply-To: <20170425134430.5545-1-enric.balletbo@collabora.com>
References: <20170425134430.5545-1-enric.balletbo@collabora.com>
Message-ID: <CAFqH_52579LCOtvdNSnC2nsZpaQpecH282c-098xp2gJOD3fNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-04-25 15:44 GMT+02:00 Enric Balletbo i Serra
<enric.balletbo@collabora.com>:
> Dump a block of kernel memory from around the registers in the kernel oops
> dump. This is behind a config option (DEBUG_AROUND_REGS), since it adds
> a bunch of noise to the kernel logs (which someone can find valuable but
> not everyone else will).
>
> This is extremely useful in diagnosing remote crashes, and is based heavily
> on original work by Michael Davidson <md@google.com> and San Mehat
> <san@google.com>.
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> This is a second version of a patch that was initially sent by John Stultz
> in 2010[1], current version is a rework trying to address the feedback
> received in the first version. We're still carrying this patch on recent
> chromeos kernels and find it useful. This is a second attempt to try
> to get this acceptable, so waiting for your feedback, and I hope I'll be
> able to do the modifications needed.
>
> Changes since v1:
>  - Use dump_mem() to dump memory.
>  - Put the code behind a config option.
>
> [1] http://www.spinics.net/lists/arm-kernel/msg107477.html
> ---
>  arch/arm/include/asm/traps.h |  1 +
>  arch/arm/kernel/process.c    | 34 ++++++++++++++++++++++++++++++++++
>  arch/arm/kernel/traps.c      |  6 ++----
>  lib/Kconfig.debug            | 11 +++++++++++
>  4 files changed, 48 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/include/asm/traps.h b/arch/arm/include/asm/traps.h
> index f555bb3..24e65c2 100644
> --- a/arch/arm/include/asm/traps.h
> +++ b/arch/arm/include/asm/traps.h
> @@ -47,6 +47,7 @@ static inline int in_exception_text(unsigned long ptr)
>  }
>
>  extern void __init early_trap_init(void *);
> +extern void dump_mem(const char *lvl, const char *str, unsigned long bottom, unsigned long top);
>  extern void dump_backtrace_entry(unsigned long where, unsigned long from, unsigned long frame);
>  extern void ptrace_break(struct task_struct *tsk, struct pt_regs *regs);
>
> diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
> index 939e8b5..3894cf2 100644
> --- a/arch/arm/kernel/process.c
> +++ b/arch/arm/kernel/process.c
> @@ -34,6 +34,7 @@
>
>  #include <asm/processor.h>
>  #include <asm/thread_notify.h>
> +#include <asm/traps.h>
>  #include <asm/stacktrace.h>
>  #include <asm/system_misc.h>
>  #include <asm/mach/time.h>
> @@ -94,6 +95,37 @@ void arch_cpu_idle_exit(void)
>         ledtrig_cpu(CPU_LED_IDLE_END);
>  }
>
> +/*
> + * Dump a block of kernel memory from around the given address
> + */
> +static void __show_regs_extra_data(struct pt_regs *regs, int nbytes)
> +{
> +#ifdef CONFIG_DEBUG_AROUND_REGS
> +       struct map_regs {
> +               unsigned long reg;
> +               const char *name;
> +       };
> +       struct map_regs map_dump[] = {
> +               { regs->ARM_pc, "PC " }, { regs->ARM_lr, "LR " },
> +               { regs->ARM_sp, "SP " }, { regs->ARM_ip, "IP " },
> +               { regs->ARM_fp, "FP " }, { regs->ARM_r0, "R0 " },
> +               { regs->ARM_r1, "R1 " }, { regs->ARM_r2, "R2 " },
> +               { regs->ARM_r3, "R3 " }, { regs->ARM_r4, "R4 " },
> +               { regs->ARM_r5, "R5 " }, { regs->ARM_r6, "R6 " },
> +               { regs->ARM_r7, "R7 " }, { regs->ARM_r8, "R8 " },
> +               { regs->ARM_r9, "R9 " }, { regs->ARM_r10, "R10 " },
> +               { -1, NULL },
> +       };
> +       struct map_regs *map = map_dump;
> +
> +       while (map->name) {
> +               dump_mem("", map->name, map->reg - nbytes,
> +                        map->reg + nbytes);
> +               map++;
> +       }
> +#endif
> +}
> +
>  void __show_regs(struct pt_regs *regs)
>  {
>         unsigned long flags;
> @@ -185,6 +217,8 @@ void __show_regs(struct pt_regs *regs)
>                 printk("Control: %08x%s\n", ctrl, buf);
>         }
>  #endif
> +
> +       __show_regs_extra_data(regs, 128);
>  }
>
>  void show_regs(struct pt_regs * regs)
> diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
> index 948c648..f4ee05b 100644
> --- a/arch/arm/kernel/traps.c
> +++ b/arch/arm/kernel/traps.c
> @@ -62,8 +62,6 @@ static int __init user_debug_setup(char *str)
>  __setup("user_debug=", user_debug_setup);
>  #endif
>
> -static void dump_mem(const char *, const char *, unsigned long, unsigned long);
> -
>  void dump_backtrace_entry(unsigned long where, unsigned long from, unsigned long frame)
>  {
>  #ifdef CONFIG_KALLSYMS
> @@ -115,8 +113,8 @@ static int verify_stack(unsigned long sp)
>  /*
>   * Dump out the contents of some memory nicely...
>   */
> -static void dump_mem(const char *lvl, const char *str, unsigned long bottom,
> -                    unsigned long top)
> +void dump_mem(const char *lvl, const char *str, unsigned long bottom,
> +             unsigned long top)
>  {
>         unsigned long first;
>         mm_segment_t fs;
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 77fadfa..b72d4ce6 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -726,6 +726,17 @@ config DEBUG_STACKOVERFLOW
>
>           If in doubt, say "N".
>
> +config DEBUG_AROUND_REGS
> +       bool "Dump a block of kernel memory from around registers"
> +       depends on DEBUG_KERNEL
> +       help
> +         Say Y here to dump a block of kernel memory around the registers
> +         in the kernel oops dump. This is useful in diagnosing remote
> +         crashes.
> +
> +         Note that selecting this option will increase significally the
> +         information in the oops dump. Most people should say N here.
> +
>  source "lib/Kconfig.kmemcheck"
>
>  source "lib/Kconfig.kasan"
> --
> 2.9.3
>

Currently this patch might need to be rebased on top of linux-next,
but before do
this can I ask for some feedback on these patches. Thoughts?

Many thanks,
 Enric
