From: mirq-linux@rere.qmqm.pl (=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?=)
Date: Sat, 10 Nov 2018 22:18:09 +0100
Subject: [PATCH 1/2] ARM: tegra: enable cache via TF
In-Reply-To: <cover.1541884486.git.mirq-linux@rere.qmqm.pl>
References: <cover.1541884486.git.mirq-linux@rere.qmqm.pl>
Message-ID: <fb1ef0fc042ba5cd768a59fa3e99d861338cfff9.1541884486.git.mirq-linux@rere.qmqm.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cache enable needs to go via firmware call with TF running.

This version is based on code proposed by Dmitry Osipenko that uses
run-time TF-presence instead of hardcoded in Kconfig.

Signed-off-by: Micha? Miros?aw <mirq-linux@rere.qmqm.pl>
---
 arch/arm/firmware/trusted_foundations.c    |  6 ++++--
 arch/arm/include/asm/trusted_foundations.h |  6 ++++--
 arch/arm/mach-tegra/reset-handler.S        | 20 +++++++++++++++++++-
 arch/arm/mach-tegra/reset.c                |  5 ++++-
 arch/arm/mach-tegra/reset.h                |  5 +++--
 arch/arm/mach-tegra/tegra.c                |  6 ++++--
 6 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/arch/arm/firmware/trusted_foundations.c b/arch/arm/firmware/trusted_foundations.c
index e59f44fcda35..148d890da0b6 100644
--- a/arch/arm/firmware/trusted_foundations.c
+++ b/arch/arm/firmware/trusted_foundations.c
@@ -141,7 +141,7 @@ void register_trusted_foundations(struct trusted_foundations_platform_data *pd)
 	register_firmware_ops(&trusted_foundations_ops);
 }
 
-void of_register_trusted_foundations(void)
+int of_register_trusted_foundations(void)
 {
 	struct device_node *node;
 	struct trusted_foundations_platform_data pdata;
@@ -149,7 +149,7 @@ void of_register_trusted_foundations(void)
 
 	node = of_find_compatible_node(NULL, NULL, "tlm,trusted-foundations");
 	if (!node)
-		return;
+		return -ENOENT;
 
 	err = of_property_read_u32(node, "tlm,version-major",
 				   &pdata.version_major);
@@ -161,4 +161,6 @@ void of_register_trusted_foundations(void)
 		panic("Trusted Foundation: missing version-minor property\n");
 
 	register_trusted_foundations(&pdata);
+
+	return 0;
 }
diff --git a/arch/arm/include/asm/trusted_foundations.h b/arch/arm/include/asm/trusted_foundations.h
index 00748350cf72..80104a4e8476 100644
--- a/arch/arm/include/asm/trusted_foundations.h
+++ b/arch/arm/include/asm/trusted_foundations.h
@@ -40,7 +40,7 @@ struct trusted_foundations_platform_data {
 #if IS_ENABLED(CONFIG_TRUSTED_FOUNDATIONS)
 
 void register_trusted_foundations(struct trusted_foundations_platform_data *pd);
-void of_register_trusted_foundations(void);
+int of_register_trusted_foundations(void);
 
 #else /* CONFIG_TRUSTED_FOUNDATIONS */
 
@@ -59,7 +59,7 @@ static inline void register_trusted_foundations(
 	cpu_idle_poll_ctrl(true);
 }
 
-static inline void of_register_trusted_foundations(void)
+static inline int of_register_trusted_foundations(void)
 {
 	/*
 	 * If we find the target should enable TF but does not support it,
@@ -67,6 +67,8 @@ static inline void of_register_trusted_foundations(void)
 	 */
 	if (of_find_compatible_node(NULL, NULL, "tlm,trusted-foundations"))
 		register_trusted_foundations(NULL);
+
+	return -ENOENT;
 }
 #endif /* CONFIG_TRUSTED_FOUNDATIONS */
 
diff --git a/arch/arm/mach-tegra/reset-handler.S b/arch/arm/mach-tegra/reset-handler.S
index 805f306fa6f7..fe4c568aeace 100644
--- a/arch/arm/mach-tegra/reset-handler.S
+++ b/arch/arm/mach-tegra/reset-handler.S
@@ -78,8 +78,26 @@ ENTRY(tegra_resume)
 	orr	r1, r1, #1
 	str	r1, [r0]
 #endif
-
 #ifdef CONFIG_CACHE_L2X0
+#ifdef CONFIG_TRUSTED_FOUNDATIONS
+	adr	r3, __tegra_cpu_reset_handler_data
+	ldr	r0, [r3, #RESET_DATA(TF_PRESENT)]
+	cmp	r0, #0
+	beq	ca9_scu_l2_resume
+
+	push	{r8}	/* TF call might corrupt r4-r12 */
+
+	mov	r0, #3	// local wake
+	mov	r3, #0
+	mov	r4, #0
+	dsb
+	.arch_extension	sec
+	smc	#0
+
+	pop	{r8}
+	b	end_ca9_scu_l2_resume
+ca9_scu_l2_resume:
+#endif
 	/* L2 cache resume & re-enable */
 	bl	l2c310_early_resume
 #endif
diff --git a/arch/arm/mach-tegra/reset.c b/arch/arm/mach-tegra/reset.c
index dc558892753c..1c3cb62255fe 100644
--- a/arch/arm/mach-tegra/reset.c
+++ b/arch/arm/mach-tegra/reset.c
@@ -18,6 +18,7 @@
 #include <linux/cpumask.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/of.h>
 
 #include <soc/tegra/fuse.h>
 
@@ -87,7 +88,7 @@ static void __init tegra_cpu_reset_handler_enable(void)
 	}
 }
 
-void __init tegra_cpu_reset_handler_init(void)
+void __init tegra_cpu_reset_handler_init(bool tf_present)
 {
 
 #ifdef CONFIG_SMP
@@ -104,5 +105,7 @@ void __init tegra_cpu_reset_handler_init(void)
 		__pa_symbol((void *)tegra_resume);
 #endif
 
+	__tegra_cpu_reset_handler_data[TEGRA_RESET_TF_PRESENT] = tf_present;
+
 	tegra_cpu_reset_handler_enable();
 }
diff --git a/arch/arm/mach-tegra/reset.h b/arch/arm/mach-tegra/reset.h
index 9c479c7925b8..5e42dd1e9841 100644
--- a/arch/arm/mach-tegra/reset.h
+++ b/arch/arm/mach-tegra/reset.h
@@ -25,7 +25,8 @@
 #define TEGRA_RESET_STARTUP_SECONDARY	3
 #define TEGRA_RESET_STARTUP_LP2		4
 #define TEGRA_RESET_STARTUP_LP1		5
-#define TEGRA_RESET_DATA_SIZE		6
+#define TEGRA_RESET_TF_PRESENT		6
+#define TEGRA_RESET_DATA_SIZE		7
 
 #ifndef __ASSEMBLY__
 
@@ -60,7 +61,7 @@ void __tegra_cpu_reset_handler_end(void);
 		(__tegra_cpu_reset_handler_end - \
 		 __tegra_cpu_reset_handler_start)
 
-void __init tegra_cpu_reset_handler_init(void);
+void __init tegra_cpu_reset_handler_init(bool tf_present);
 
 #endif
 #endif
diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
index f9587be48235..0281de82387e 100644
--- a/arch/arm/mach-tegra/tegra.c
+++ b/arch/arm/mach-tegra/tegra.c
@@ -72,8 +72,10 @@ u32 tegra_uart_config[3] = {
 
 static void __init tegra_init_early(void)
 {
-	of_register_trusted_foundations();
-	tegra_cpu_reset_handler_init();
+	bool tf_present;
+
+	tf_present = of_register_trusted_foundations() == 0;
+	tegra_cpu_reset_handler_init(tf_present);
 }
 
 static void __init tegra_dt_init_irq(void)
-- 
2.19.1
