From: mirq-linux@rere.qmqm.pl (=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?=)
Date: Sat, 10 Nov 2018 22:18:09 +0100
Subject: [PATCH 2/2] ARM: tegra: avoid touching Secure registers in reset
 handler
In-Reply-To: <cover.1541884486.git.mirq-linux@rere.qmqm.pl>
References: <cover.1541884486.git.mirq-linux@rere.qmqm.pl>
Message-ID: <c93b79b052370f4058033dae716225aec94c4991.1541884486.git.mirq-linux@rere.qmqm.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows secondary CPUs to boot with Trusted Foundations firmware.

Signed-off-by: Micha? Miros?aw <mirq-linux@rere.qmqm.pl>
---
 arch/arm/mach-tegra/reset-handler.S | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/mach-tegra/reset-handler.S b/arch/arm/mach-tegra/reset-handler.S
index fe4c568aeace..56300ec9f1a0 100644
--- a/arch/arm/mach-tegra/reset-handler.S
+++ b/arch/arm/mach-tegra/reset-handler.S
@@ -139,6 +139,13 @@ ENTRY(__tegra_cpu_reset_handler)
 	cpsid	aif, 0x13			@ SVC mode, interrupts disabled
 
 	tegra_get_soc_id TEGRA_APB_MISC_BASE, r6
+
+#ifdef CONFIG_TRUSTED_FOUNDATIONS
+	adr	r3, __tegra_cpu_reset_handler_data
+	ldr	r0, [r3, #RESET_DATA(TF_PRESENT)]
+	cmp	r0, #0
+	bne	after_errata
+#endif	/* CONFIG_TRUSTED_FOUNDATIONS */
 #ifdef CONFIG_ARCH_TEGRA_2x_SOC
 t20_check:
 	cmp	r6, #TEGRA20
-- 
2.19.1
