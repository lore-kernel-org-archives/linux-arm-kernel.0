From: digetx@gmail.com (Dmitry Osipenko)
Date: Tue, 19 Dec 2017 22:07:00 +0300
Subject: [PATCH 7/9] ARM: tegra: enable cache via TF
In-Reply-To: <6a164b2270a3e996c083e94bf5b1e27028c1135e.1500510157.git.mirq-linux@rere.qmqm.pl>
References: <cover.1500510157.git.mirq-linux@rere.qmqm.pl>
 <6a164b2270a3e996c083e94bf5b1e27028c1135e.1500510157.git.mirq-linux@rere.qmqm.pl>
Message-ID: <8bc85444-e33b-63b5-db01-9f02f7dfd506@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20.07.2017 03:29, Micha? Miros?aw wrote:
> Cache enable needs to go via firmware call with TF running.
> 
> Signed-off-by: Micha? Miros?aw <mirq-linux@rere.qmqm.pl>
> ---

Perhaps we can unify secure and non-secure modes. The code below works on both
secure-t30 and nonsecure-t20, all CPU's booted and working fine.

The "ARM: enable secure platform-only erratas" patch isn't needed in this case.


diff --git a/arch/arm/mach-tegra/reset-handler.S
b/arch/arm/mach-tegra/reset-handler.S
index 805f306fa6f7..9a92bbf8b5b0 100644
--- a/arch/arm/mach-tegra/reset-handler.S
+++ b/arch/arm/mach-tegra/reset-handler.S
@@ -80,6 +80,28 @@ ENTRY(tegra_resume)
 #endif

 #ifdef CONFIG_CACHE_L2X0
+#ifdef CONFIG_TRUSTED_FOUNDATIONS
+	adr	r3, __tegra_cpu_reset_handler_data
+	ldr	r0, [r3, #RESET_DATA(TF_PRESENT)]
+	cmp	r0, #0
+	beq	ca9_scu_l2_resume
+
+	adr	r3, __tegra_smc_stack
+	stmia	r3, {r4-r12, sp, lr}
+
+	mov	r0, #3	// local wake
+	mov	r3, #0
+	mov	r4, #0
+	dsb
+	.arch_extension	sec
+	smc	#0
+
+	adr	r3, __tegra_smc_stack
+	ldmia	r3, {r4-r12, sp, pc}
+
+	b	end_ca9_scu_l2_resume
+ca9_scu_l2_resume:
+#endif
 	/* L2 cache resume & re-enable */
 	bl	l2c310_early_resume
 #endif
@@ -92,6 +114,16 @@ end_ca9_scu_l2_resume:
 ENDPROC(tegra_resume)
 #endif

+#ifdef CONFIG_TRUSTED_FOUNDATIONS
+	.align L1_CACHE_SHIFT
+	.type __tegra_smc_stack, %object
+__tegra_smc_stack:
+	.rept 11
+	.long 0
+	.endr
+	.size __tegra_smc_stack, . - __tegra_smc_stack
+#endif /* CONFIG_TRUSTED_FOUNDATIONS */
+
 	.align L1_CACHE_SHIFT
 ENTRY(__tegra_cpu_reset_handler_start)

@@ -121,6 +153,12 @@ ENTRY(__tegra_cpu_reset_handler)
 	cpsid	aif, 0x13			@ SVC mode, interrupts disabled

 	tegra_get_soc_id TEGRA_APB_MISC_BASE, r6
+
+	adr	r5, __tegra_cpu_reset_handler_data
+	ldr	r0, [r5, #RESET_DATA(TF_PRESENT)]
+	cmp	r0, #0
+	bne	after_errata
+
 #ifdef CONFIG_ARCH_TEGRA_2x_SOC
 t20_check:
 	cmp	r6, #TEGRA20
@@ -285,6 +323,10 @@ __tegra_cpu_reset_handler_data:
 	.equ	__tegra20_cpu1_resettable_status_offset, \
 					. - __tegra_cpu_reset_handler_start
 	.byte	0
+	.align	4
+	.globl	__tegra_tf_present
+	.equ	__tegra_tf_present, . - __tegra_cpu_reset_handler_start
+	.long	0
 	.align L1_CACHE_SHIFT

 ENTRY(__tegra_cpu_reset_handler_end)
diff --git a/arch/arm/mach-tegra/reset.c b/arch/arm/mach-tegra/reset.c
index dc558892753c..9b6558a69308 100644
--- a/arch/arm/mach-tegra/reset.c
+++ b/arch/arm/mach-tegra/reset.c
@@ -18,6 +18,7 @@
 #include <linux/cpumask.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/of.h>

 #include <soc/tegra/fuse.h>

@@ -89,6 +90,15 @@ static void __init tegra_cpu_reset_handler_enable(void)

 void __init tegra_cpu_reset_handler_init(void)
 {
+#ifdef CONFIG_TRUSTED_FOUNDATIONS
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, "tlm,trusted-foundations");
+	if (np) {
+		__tegra_cpu_reset_handler_data[TEGRA_RESET_TF_PRESENT] = true;
+		of_node_put(np);
+	}
+#endif

 #ifdef CONFIG_SMP
 	__tegra_cpu_reset_handler_data[TEGRA_RESET_MASK_PRESENT] =
diff --git a/arch/arm/mach-tegra/reset.h b/arch/arm/mach-tegra/reset.h
index 9c479c7925b8..0d9ddc022ece 100644
--- a/arch/arm/mach-tegra/reset.h
+++ b/arch/arm/mach-tegra/reset.h
@@ -25,7 +25,9 @@
 #define TEGRA_RESET_STARTUP_SECONDARY	3
 #define TEGRA_RESET_STARTUP_LP2		4
 #define TEGRA_RESET_STARTUP_LP1		5
-#define TEGRA_RESET_DATA_SIZE		6
+#define TEGRA_RESET_RESETTABLE_STATUS	6
+#define TEGRA_RESET_TF_PRESENT		7
+#define TEGRA_RESET_DATA_SIZE		8

 #ifndef __ASSEMBLY__
