From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 18 Jan 2018 11:45:43 +0000
Subject: [PATCH v2 0/2] arm64: Run enable method for errata work arounds
 on late CPUs
In-Reply-To: <20180117174220.7959-1-suzuki.poulose@arm.com>
References: <20180117174220.7959-1-suzuki.poulose@arm.com>
Message-ID: <20180118114540.GL22781@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 17, 2018 at 05:42:19PM +0000, Suzuki K Poulose wrote:
> We issue the enable() call back for all CPU hwcaps capabilities
> available on the system, on all the CPUs. So far we have ignored
> the argument passed to the call back, which had a prototype to
> accept a "void *" for use with on_each_cpu() and later with
> stop_machine(). However, with commit 0a0d111d40fd1
> ("arm64: cpufeature: Pass capability structure to ->enable callback"),
> there are some users of the argument who wants the matching capability
> struct pointer where there are multiple matching criteria for a single
> capability. Changing the prototype is quite an invasive change and

It's not that bad, though it's debatable whether it's really worth
it.  See the appended patch below.

> will be part of a future series. For now, add a comment to clarify
> what is expected.

With the type change, it becomes more obvious what should be passed,
and the comment can probably be trimmed down.  I omit the comment
from my patch (I'm lazy).

Without it, I would prefer a comment alongside the (void *) cast,
something like "enable methods expect this to be passed as a void *,
for compatibility with stop_machine()".

For consistency, the stop_machine() call should also be changed to
pass the cap pointer instead of NULL, even if we don't actually rely
on that for any purpose today -- it will help avoid surprises in the
future.  (My patch does makes an equivalent change.)

[...]

> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index ac67cfc2585a..c049e28274d4 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -97,7 +97,14 @@ struct arm64_cpu_capabilities {
>  	u16 capability;
>  	int def_scope;			/* default scope */
>  	bool (*matches)(const struct arm64_cpu_capabilities *caps, int scope);
> -	int (*enable)(void *);		/* Called on all active CPUs */
> +	/*
> +	 * For each @capability set in CPU hwcaps, @enable() is called on all
> +	 * active CPUs with const struct arm64_cpu_capabilities * as argument.

The declaration tells us the type, so we don't need that in the comment.
But what object should the pointer point to?

> +	 * It is upto the callback (especially when multiple entries for the

up to

> +	 * same capability exists) to determine if any action should be taken
> +	 * based on @matches() applies to thie CPU.
> +	 */
> +	int (*enable)(void *caps);
>  	union {
>  		struct {	/* To be used for erratum handling only */
>  			u32 midr_model;

Cheers
---Dave


--8<--

>From 04a4bd998d02e339341db250e66b0d34a7c4e042 Mon Sep 17 00:00:00 2001
From: Dave Martin <Dave.Martin@arm.com>
Date: Thu, 18 Jan 2018 11:29:14 +0000
Subject: [PATCH] arm64: cpufeature: Formalise capability enable method type

Currently, all cpufeature enable methods specify their argument as
a void *, while what is actually passed is a pointer to a const
struct arm64_cpu_capabilities object.

Hiding the type information from the compiler increases the risk
of incorrect code.

Instead of requiring care to be taken in every enable method, this
patch makes the type of the argument explicitly struct
arm64_cpu_capabilities const *.

Since we need to call these methods via stop_machine(), a single
proxy function __cpu_enable_capability() is added which is passed
to stop_machine() to allow it to call feature enable methods
without defeating type checking in the compiler (except in this
one place).

This patch should not change the behaviour of the kernel.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>

---

Build-tested only.

 arch/arm64/include/asm/cpufeature.h |  4 +++-
 arch/arm64/include/asm/fpsimd.h     |  4 +++-
 arch/arm64/include/asm/processor.h  |  5 +++--
 arch/arm64/kernel/cpu_errata.c      |  3 ++-
 arch/arm64/kernel/cpufeature.c      | 20 +++++++++++++++++++-
 arch/arm64/kernel/fpsimd.c          |  3 ++-
 arch/arm64/kernel/traps.c           |  3 ++-
 arch/arm64/mm/fault.c               |  2 +-
 8 files changed, 35 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 060e3a4..98d22ce 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -100,7 +100,9 @@ struct arm64_cpu_capabilities {
 	u16 capability;
 	int def_scope;			/* default scope */
 	bool (*matches)(const struct arm64_cpu_capabilities *caps, int scope);
-	int (*enable)(void *);		/* Called on all active CPUs */
+	/* Called on all active CPUs: */
+	int (*enable)(struct arm64_cpu_capabilities const *);
+
 	union {
 		struct {	/* To be used for erratum handling only */
 			u32 midr_model;
diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 74f3439..ac9902d 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -83,7 +83,9 @@ extern void sve_save_state(void *state, u32 *pfpsr);
 extern void sve_load_state(void const *state, u32 const *pfpsr,
 			   unsigned long vq_minus_1);
 extern unsigned int sve_get_vl(void);
-extern int sve_kernel_enable(void *);
+
+struct arm64_cpu_capabilities;
+extern int sve_kernel_enable(struct arm64_cpu_capabilities const *);
 
 extern int __ro_after_init sve_max_vl;
 
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 023cacb..46959651a 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -34,6 +34,7 @@
 #include <linux/string.h>
 
 #include <asm/alternative.h>
+#include <asm/cpufeature.h>
 #include <asm/fpsimd.h>
 #include <asm/hw_breakpoint.h>
 #include <asm/lse.h>
@@ -214,8 +215,8 @@ static inline void spin_lock_prefetch(const void *ptr)
 
 #endif
 
-int cpu_enable_pan(void *__unused);
-int cpu_enable_cache_maint_trap(void *__unused);
+int cpu_enable_pan(struct arm64_cpu_capabilities const *__unused);
+int cpu_enable_cache_maint_trap(struct arm64_cpu_capabilities const *__unused);
 
 /* Userspace interface for PR_SVE_{SET,GET}_VL prctl()s: */
 #define SVE_SET_VL(arg)	sve_set_current_vl(arg)
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 0e27f86..addd7fd 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -39,7 +39,8 @@ has_mismatched_cache_line_size(const struct arm64_cpu_capabilities *entry,
 		(arm64_ftr_reg_ctrel0.sys_val & arm64_ftr_reg_ctrel0.strict_mask);
 }
 
-static int cpu_enable_trap_ctr_access(void *__unused)
+static int cpu_enable_trap_ctr_access(
+	struct arm64_cpu_capabilities const *__unused)
 {
 	/* Clear SCTLR_EL1.UCT */
 	config_sctlr_el1(SCTLR_EL1_UCT, 0);
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index a73a592..05486a9 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1084,6 +1084,18 @@ void update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
 	}
 }
 
+struct enable_arg {
+	int (*enable)(struct arm64_cpu_capabilities const *);
+	struct arm64_cpu_capabilities const *cap;
+};
+
+static int __enable_cpu_capability(void *arg)
+{
+	struct enable_arg const *e = arg;
+
+	return e->enable(e->cap);
+}
+
 /*
  * Run through the enabled capabilities and enable() it on all active
  * CPUs
@@ -1100,13 +1112,19 @@ void __init enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps)
 		static_branch_enable(&cpu_hwcap_keys[num]);
 
 		if (caps->enable) {
+			struct enable_arg e = {
+				.enable	= caps->enable,
+				.cap	= caps,
+			};
+
 			/*
 			 * Use stop_machine() as it schedules the work allowing
 			 * us to modify PSTATE, instead of on_each_cpu() which
 			 * uses an IPI, giving us a PSTATE that disappears when
 			 * we return.
 			 */
-			stop_machine(caps->enable, NULL, cpu_online_mask);
+			stop_machine(__enable_cpu_capability, &e,
+				     cpu_online_mask);
 		}
 	}
 }
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index fae81f7..b6dcfa3 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -40,6 +40,7 @@
 #include <linux/sysctl.h>
 
 #include <asm/fpsimd.h>
+#include <asm/cpufeature.h>
 #include <asm/cputype.h>
 #include <asm/simd.h>
 #include <asm/sigcontext.h>
@@ -757,7 +758,7 @@ static void __init sve_efi_setup(void)
  * Enable SVE for EL1.
  * Intended for use by the cpufeatures code during CPU boot.
  */
-int sve_kernel_enable(void *__always_unused p)
+int sve_kernel_enable(struct arm64_cpu_capabilities const *__always_unused p)
 {
 	write_sysreg(read_sysreg(CPACR_EL1) | CPACR_EL1_ZEN_EL1EN, CPACR_EL1);
 	isb();
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 3d3588f..2457514 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -38,6 +38,7 @@
 
 #include <asm/atomic.h>
 #include <asm/bug.h>
+#include <asm/cpufeature.h>
 #include <asm/daifflags.h>
 #include <asm/debug-monitors.h>
 #include <asm/esr.h>
@@ -374,7 +375,7 @@ asmlinkage void __exception do_undefinstr(struct pt_regs *regs)
 	force_signal_inject(SIGILL, ILL_ILLOPC, regs, 0);
 }
 
-int cpu_enable_cache_maint_trap(void *__unused)
+int cpu_enable_cache_maint_trap(struct arm64_cpu_capabilities const *__unused)
 {
 	config_sctlr_el1(SCTLR_EL1_UCI, 0);
 	return 0;
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 9b7f89d..82f6729 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -795,7 +795,7 @@ asmlinkage int __exception do_debug_exception(unsigned long addr,
 NOKPROBE_SYMBOL(do_debug_exception);
 
 #ifdef CONFIG_ARM64_PAN
-int cpu_enable_pan(void *__unused)
+int cpu_enable_pan(struct arm64_cpu_capabilities const *__unused)
 {
 	/*
 	 * We modify PSTATE. This won't work from irq context as the PSTATE
-- 
2.1.4
