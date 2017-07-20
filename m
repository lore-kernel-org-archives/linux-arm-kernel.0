From: mirq-linux@rere.qmqm.pl (=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?=)
Date: Thu, 20 Jul 2017 02:29:25 +0200
Subject: [PATCH 7/9] ARM: tegra: enable cache via TF
In-Reply-To: <cover.1500510157.git.mirq-linux@rere.qmqm.pl>
References: <cover.1500510157.git.mirq-linux@rere.qmqm.pl>
Message-ID: <6a164b2270a3e996c083e94bf5b1e27028c1135e.1500510157.git.mirq-linux@rere.qmqm.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cache enable needs to go via firmware call with TF running.

Signed-off-by: Micha? Miros?aw <mirq-linux@rere.qmqm.pl>
---
 arch/arm/mach-tegra/reset-handler.S | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-tegra/reset-handler.S b/arch/arm/mach-tegra/reset-handler.S
index 805f306fa6f7..aae7f5961563 100644
--- a/arch/arm/mach-tegra/reset-handler.S
+++ b/arch/arm/mach-tegra/reset-handler.S
@@ -78,8 +78,20 @@ ENTRY(tegra_resume)
 	orr	r1, r1, #1
 	str	r1, [r0]
 #endif
+#ifdef CONFIG_TRUSTED_FOUNDATIONS
+	adr	r3, __tegra_smc_stack
+	stmia	r3, {r4-r12, sp, lr}
 
-#ifdef CONFIG_CACHE_L2X0
+	mov	r0, #3	// local wake
+	mov	r3, #0
+	mov	r4, #0
+	dsb
+	.arch_extension	sec
+	smc	#0
+
+	adr	r3, __tegra_smc_stack
+	ldmia	r3, {r4-r12, sp, pc}
+#elif defined(CONFIG_CACHE_L2X0)
 	/* L2 cache resume & re-enable */
 	bl	l2c310_early_resume
 #endif
@@ -92,6 +104,16 @@ end_ca9_scu_l2_resume:
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
 
-- 
2.11.0
