From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 30 Jan 2015 17:01:18 +0000
Subject: [PATCH v3 1/1] arm64: kernel: remove ARM64_CPU_SUSPEND config
 option
In-Reply-To: <1598265.lHdhMYsZXo@amdc1032>
References: <1422297224-27834-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1422297224-27834-2-git-send-email-lorenzo.pieralisi@arm.com>
 <1598265.lHdhMYsZXo@amdc1032>
Message-ID: <20150130170118.GA11122@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 30, 2015 at 04:18:27PM +0000, Bartlomiej Zolnierkiewicz wrote:
> 
> Hi,
> 
> On Monday, January 26, 2015 06:33:44 PM Lorenzo Pieralisi wrote:
> > ARM64_CPU_SUSPEND config option was introduced to make code providing
> > context save/restore selectable only on platforms requiring power
> > management capabilities.
> >
> > Currently ARM64_CPU_SUSPEND depends on the PM_SLEEP config option which
> > in turn is set by the SUSPEND config option.
> >
> > The introduction of CPU_IDLE for arm64 requires that code configured
> > by ARM64_CPU_SUSPEND (context save/restore) should be compiled in
> > in order to enable the CPU idle driver to rely on CPU operations
> > carrying out context save/restore.
> >
> > The ARM64_CPUIDLE config option (ARM64 generic idle driver) is therefore
> > forced to select ARM64_CPU_SUSPEND, even if there may be (ie PM_SLEEP)
> > failed dependencies, which is not a clean way of handling the kernel
> > configuration option.
> >
> > For these reasons, this patch removes the ARM64_CPU_SUSPEND config option
> > and makes the context save/restore dependent on CPU_PM, which is selected
> > whenever either SUSPEND or CPU_IDLE are configured, cleaning up dependencies
> > in the process.
> >
> > This way, code previously configured through ARM64_CPU_SUSPEND is
> > compiled in whenever a power management subsystem requires it to be
> > present in the kernel (SUSPEND || CPU_IDLE), which is the behaviour
> > expected on ARM64 kernels.
> >
> > The cpu_suspend and cpu_init_idle CPU operations are added only if
> > CPU_IDLE is selected, since they are CPU_IDLE specific methods and
> > should be grouped and defined accordingly.
> >
> > PSCI CPU operations are updated to reflect the introduced changes.
> 
> cpu_suspend CPU operation is currently CPU_IDLE specific but I wonder
> whether this is correct in the context of PSCI?

On arm64 cpu_suspend() is the function interfacing the idle driver to
the arch code, I will rename it in a subsequent clean-up that will
include cpu_ops.cpu_suspend too (ie cpu_enter_idle).

PSCI implements the cpu_ops.cpu_suspend operation through the PSCI CPU
suspend call.

> 
> [ On 32-bit ARM PSCI cpu_suspend operation can be used in suspend code-path
>   (please take a look at arch/arm/mach-highbank/pm.c), on 64-bit ARM PSCI
>   this is not possible currently. ]

I did not merge that code, and in that context PSCI CPU suspend has been
used to enter what I guess what the deepest idle state, it slipped my
review, it is a valid usage, should have been documented though before
implementing it that way.

On arm64 we are defining a specific system suspend interface to give
system suspend a clearer semantics:

http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/318540.html

Does this answer your question ?

Thanks,
Lorenzo

> 
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
> 
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > ---
> >  arch/arm64/Kconfig                |  3 ---
> >  arch/arm64/include/asm/cpu_ops.h  |  8 ++++----
> >  arch/arm64/include/asm/cpuidle.h  |  6 ++++++
> >  arch/arm64/include/asm/suspend.h  |  2 --
> >  arch/arm64/kernel/Makefile        |  2 +-
> >  arch/arm64/kernel/asm-offsets.c   |  2 +-
> >  arch/arm64/kernel/cpuidle.c       | 20 ++++++++++++++++++++
> >  arch/arm64/kernel/hw_breakpoint.c |  2 +-
> >  arch/arm64/kernel/psci.c          |  2 --
> >  arch/arm64/kernel/suspend.c       | 21 ---------------------
> >  arch/arm64/mm/proc.S              |  2 +-
> >  drivers/cpuidle/Kconfig.arm64     |  1 -
> >  drivers/cpuidle/cpuidle-arm64.c   |  1 -
> >  13 files changed, 34 insertions(+), 38 deletions(-)
> >
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index b1f9a20..9ac078f 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -627,9 +627,6 @@ source "kernel/power/Kconfig"
> >  config ARCH_SUSPEND_POSSIBLE
> >       def_bool y
> >
> > -config ARM64_CPU_SUSPEND
> > -     def_bool PM_SLEEP
> > -
> >  endmenu
> >
> >  menu "CPU Power Management"
> > diff --git a/arch/arm64/include/asm/cpu_ops.h b/arch/arm64/include/asm/cpu_ops.h
> > index 6f8e2ef..da301ee 100644
> > --- a/arch/arm64/include/asm/cpu_ops.h
> > +++ b/arch/arm64/include/asm/cpu_ops.h
> > @@ -28,8 +28,6 @@ struct device_node;
> >   *           enable-method property.
> >   * @cpu_init:        Reads any data necessary for a specific enable-method from the
> >   *           devicetree, for a given cpu node and proposed logical id.
> > - * @cpu_init_idle: Reads any data necessary to initialize CPU idle states from
> > - *           devicetree, for a given cpu node and proposed logical id.
> >   * @cpu_prepare: Early one-time preparation step for a cpu. If there is a
> >   *           mechanism for doing so, tests whether it is possible to boot
> >   *           the given CPU.
> > @@ -42,6 +40,8 @@ struct device_node;
> >   * @cpu_die: Makes a cpu leave the kernel. Must not fail. Called from the
> >   *           cpu being killed.
> >   * @cpu_kill:  Ensures a cpu has left the kernel. Called from another cpu.
> > + * @cpu_init_idle: Reads any data necessary to initialize CPU idle states from
> > + *           devicetree, for a given cpu node and proposed logical id.
> >   * @cpu_suspend: Suspends a cpu and saves the required context. May fail owing
> >   *               to wrong parameters or error conditions. Called from the
> >   *               CPU being suspended. Must be called with IRQs disabled.
> > @@ -49,7 +49,6 @@ struct device_node;
> >  struct cpu_operations {
> >       const char      *name;
> >       int             (*cpu_init)(struct device_node *, unsigned int);
> > -     int             (*cpu_init_idle)(struct device_node *, unsigned int);
> >       int             (*cpu_prepare)(unsigned int);
> >       int             (*cpu_boot)(unsigned int);
> >       void            (*cpu_postboot)(void);
> > @@ -58,7 +57,8 @@ struct cpu_operations {
> >       void            (*cpu_die)(unsigned int cpu);
> >       int             (*cpu_kill)(unsigned int cpu);
> >  #endif
> > -#ifdef CONFIG_ARM64_CPU_SUSPEND
> > +#ifdef CONFIG_CPU_IDLE
> > +     int             (*cpu_init_idle)(struct device_node *, unsigned int);
> >       int             (*cpu_suspend)(unsigned long);
> >  #endif
> >  };
> > diff --git a/arch/arm64/include/asm/cpuidle.h b/arch/arm64/include/asm/cpuidle.h
> > index b52a993..0710654 100644
> > --- a/arch/arm64/include/asm/cpuidle.h
> > +++ b/arch/arm64/include/asm/cpuidle.h
> > @@ -3,11 +3,17 @@
> >
> >  #ifdef CONFIG_CPU_IDLE
> >  extern int cpu_init_idle(unsigned int cpu);
> > +extern int cpu_suspend(unsigned long arg);
> >  #else
> >  static inline int cpu_init_idle(unsigned int cpu)
> >  {
> >       return -EOPNOTSUPP;
> >  }
> > +
> > +static inline int cpu_suspend(unsigned long arg)
> > +{
> > +     return -EOPNOTSUPP;
> > +}
> >  #endif
> >
> >  #endif
> > diff --git a/arch/arm64/include/asm/suspend.h b/arch/arm64/include/asm/suspend.h
> > index 456d67c..003802f 100644
> > --- a/arch/arm64/include/asm/suspend.h
> > +++ b/arch/arm64/include/asm/suspend.h
> > @@ -23,6 +23,4 @@ struct sleep_save_sp {
> >
> >  extern int __cpu_suspend(unsigned long arg, int (*fn)(unsigned long));
> >  extern void cpu_resume(void);
> > -extern int cpu_suspend(unsigned long);
> > -
> >  #endif
> > diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> > index eaa77ed..0622599 100644
> > --- a/arch/arm64/kernel/Makefile
> > +++ b/arch/arm64/kernel/Makefile
> > @@ -27,7 +27,7 @@ arm64-obj-$(CONFIG_SMP)                     += smp.o smp_spin_table.o topology.o
> >  arm64-obj-$(CONFIG_PERF_EVENTS)              += perf_regs.o
> >  arm64-obj-$(CONFIG_HW_PERF_EVENTS)   += perf_event.o
> >  arm64-obj-$(CONFIG_HAVE_HW_BREAKPOINT)       += hw_breakpoint.o
> > -arm64-obj-$(CONFIG_ARM64_CPU_SUSPEND)        += sleep.o suspend.o
> > +arm64-obj-$(CONFIG_CPU_PM)           += sleep.o suspend.o
> >  arm64-obj-$(CONFIG_CPU_IDLE)         += cpuidle.o
> >  arm64-obj-$(CONFIG_JUMP_LABEL)               += jump_label.o
> >  arm64-obj-$(CONFIG_KGDB)             += kgdb.o
> > diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
> > index 9a9fce0..a2ae194 100644
> > --- a/arch/arm64/kernel/asm-offsets.c
> > +++ b/arch/arm64/kernel/asm-offsets.c
> > @@ -152,7 +152,7 @@ int main(void)
> >    DEFINE(KVM_VTTBR,          offsetof(struct kvm, arch.vttbr));
> >    DEFINE(KVM_VGIC_VCTRL,     offsetof(struct kvm, arch.vgic.vctrl_base));
> >  #endif
> > -#ifdef CONFIG_ARM64_CPU_SUSPEND
> > +#ifdef CONFIG_CPU_PM
> >    DEFINE(CPU_SUSPEND_SZ,     sizeof(struct cpu_suspend_ctx));
> >    DEFINE(CPU_CTX_SP,         offsetof(struct cpu_suspend_ctx, sp));
> >    DEFINE(MPIDR_HASH_MASK,    offsetof(struct mpidr_hash, mask));
> > diff --git a/arch/arm64/kernel/cpuidle.c b/arch/arm64/kernel/cpuidle.c
> > index 19d17f5..5c08966 100644
> > --- a/arch/arm64/kernel/cpuidle.c
> > +++ b/arch/arm64/kernel/cpuidle.c
> > @@ -29,3 +29,23 @@ int cpu_init_idle(unsigned int cpu)
> >       of_node_put(cpu_node);
> >       return ret;
> >  }
> > +
> > +/**
> > + * cpu_suspend() - function to enter a low-power idle state
> > + * @arg: argument to pass to CPU suspend operations
> > + *
> > + * Return: 0 on success, -EOPNOTSUPP if CPU suspend hook not initialized, CPU
> > + * operations back-end error code otherwise.
> > + */
> > +int cpu_suspend(unsigned long arg)
> > +{
> > +     int cpu = smp_processor_id();
> > +
> > +     /*
> > +      * If cpu_ops have not been registered or suspend
> > +      * has not been initialized, cpu_suspend call fails early.
> > +      */
> > +     if (!cpu_ops[cpu] || !cpu_ops[cpu]->cpu_suspend)
> > +             return -EOPNOTSUPP;
> > +     return cpu_ops[cpu]->cpu_suspend(arg);
> > +}
> > diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
> > index df1cf15..98bbe06 100644
> > --- a/arch/arm64/kernel/hw_breakpoint.c
> > +++ b/arch/arm64/kernel/hw_breakpoint.c
> > @@ -894,7 +894,7 @@ static struct notifier_block hw_breakpoint_reset_nb = {
> >       .notifier_call = hw_breakpoint_reset_notify,
> >  };
> >
> > -#ifdef CONFIG_ARM64_CPU_SUSPEND
> > +#ifdef CONFIG_CPU_PM
> >  extern void cpu_suspend_set_dbg_restorer(void (*hw_bp_restore)(void *));
> >  #else
> >  static inline void cpu_suspend_set_dbg_restorer(void (*hw_bp_restore)(void *))
> > diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
> > index f1dbca7..3425f31 100644
> > --- a/arch/arm64/kernel/psci.c
> > +++ b/arch/arm64/kernel/psci.c
> > @@ -540,8 +540,6 @@ const struct cpu_operations cpu_psci_ops = {
> >       .name           = "psci",
> >  #ifdef CONFIG_CPU_IDLE
> >       .cpu_init_idle  = cpu_psci_cpu_init_idle,
> > -#endif
> > -#ifdef CONFIG_ARM64_CPU_SUSPEND
> >       .cpu_suspend    = cpu_psci_cpu_suspend,
> >  #endif
> >  #ifdef CONFIG_SMP
> > diff --git a/arch/arm64/kernel/suspend.c b/arch/arm64/kernel/suspend.c
> > index 2d6b606..d7daf45 100644
> > --- a/arch/arm64/kernel/suspend.c
> > +++ b/arch/arm64/kernel/suspend.c
> > @@ -1,7 +1,6 @@
> >  #include <linux/percpu.h>
> >  #include <linux/slab.h>
> >  #include <asm/cacheflush.h>
> > -#include <asm/cpu_ops.h>
> >  #include <asm/debug-monitors.h>
> >  #include <asm/pgtable.h>
> >  #include <asm/memory.h>
> > @@ -51,26 +50,6 @@ void __init cpu_suspend_set_dbg_restorer(void (*hw_bp_restore)(void *))
> >       hw_breakpoint_restore = hw_bp_restore;
> >  }
> >
> > -/**
> > - * cpu_suspend() - function to enter a low-power state
> > - * @arg: argument to pass to CPU suspend operations
> > - *
> > - * Return: 0 on success, -EOPNOTSUPP if CPU suspend hook not initialized, CPU
> > - * operations back-end error code otherwise.
> > - */
> > -int cpu_suspend(unsigned long arg)
> > -{
> > -     int cpu = smp_processor_id();
> > -
> > -     /*
> > -      * If cpu_ops have not been registered or suspend
> > -      * has not been initialized, cpu_suspend call fails early.
> > -      */
> > -     if (!cpu_ops[cpu] || !cpu_ops[cpu]->cpu_suspend)
> > -             return -EOPNOTSUPP;
> > -     return cpu_ops[cpu]->cpu_suspend(arg);
> > -}
> > -
> >  /*
> >   * __cpu_suspend
> >   *
> > diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> > index 4e778b1..1257835 100644
> > --- a/arch/arm64/mm/proc.S
> > +++ b/arch/arm64/mm/proc.S
> > @@ -102,7 +102,7 @@ ENTRY(cpu_do_idle)
> >       ret
> >  ENDPROC(cpu_do_idle)
> >
> > -#ifdef CONFIG_ARM64_CPU_SUSPEND
> > +#ifdef CONFIG_CPU_PM
> >  /**
> >   * cpu_do_suspend - save CPU registers context
> >   *
> > diff --git a/drivers/cpuidle/Kconfig.arm64 b/drivers/cpuidle/Kconfig.arm64
> > index d0a08ed..6effb36 100644
> > --- a/drivers/cpuidle/Kconfig.arm64
> > +++ b/drivers/cpuidle/Kconfig.arm64
> > @@ -4,7 +4,6 @@
> >
> >  config ARM64_CPUIDLE
> >       bool "Generic ARM64 CPU idle Driver"
> > -     select ARM64_CPU_SUSPEND
> >       select DT_IDLE_STATES
> >       help
> >         Select this to enable generic cpuidle driver for ARM64.
> > diff --git a/drivers/cpuidle/cpuidle-arm64.c b/drivers/cpuidle/cpuidle-arm64.c
> > index 80704b9..39a2c62 100644
> > --- a/drivers/cpuidle/cpuidle-arm64.c
> > +++ b/drivers/cpuidle/cpuidle-arm64.c
> > @@ -19,7 +19,6 @@
> >  #include <linux/of.h>
> >
> >  #include <asm/cpuidle.h>
> > -#include <asm/suspend.h>
> >
> >  #include "dt_idle_states.h"
> 
> 
> 
