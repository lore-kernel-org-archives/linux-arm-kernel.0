From: mirq-linux@rere.qmqm.pl (=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?=)
Date: Thu, 20 Jul 2017 02:29:25 +0200
Subject: [PATCH 8/9] ARM: tegra: avoid touching Secure registers in reset
 handler
In-Reply-To: <cover.1500510157.git.mirq-linux@rere.qmqm.pl>
References: <cover.1500510157.git.mirq-linux@rere.qmqm.pl>
Message-ID: <22bba1196e745a5bdf66bd449bee7ccc17bd4761.1500510157.git.mirq-linux@rere.qmqm.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows secondary CPUs to boot with Trusted Foundations firmware.

Signed-off-by: Micha? Miros?aw <mirq-linux@rere.qmqm.pl>
---
 arch/arm/mach-tegra/reset-handler.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-tegra/reset-handler.S b/arch/arm/mach-tegra/reset-handler.S
index aae7f5961563..f642032a5a08 100644
--- a/arch/arm/mach-tegra/reset-handler.S
+++ b/arch/arm/mach-tegra/reset-handler.S
@@ -143,6 +143,8 @@ ENTRY(__tegra_cpu_reset_handler)
 	cpsid	aif, 0x13			@ SVC mode, interrupts disabled
 
 	tegra_get_soc_id TEGRA_APB_MISC_BASE, r6
+
+#ifdef CONFIG_ARCH_ASSUME_SECURE_PLATFORM
 #ifdef CONFIG_ARCH_TEGRA_2x_SOC
 t20_check:
 	cmp	r6, #TEGRA20
@@ -172,6 +174,7 @@ t30_errata:
 	b	after_errata
 after_t30_check:
 #endif
+#endif	/* CONFIG_ARCH_ASSUME_SECURE_PLATFORM */
 after_errata:
 	mrc	p15, 0, r10, c0, c0, 5		@ MPIDR
 	and	r10, r10, #0x3			@ R10 = CPU number
-- 
2.11.0
