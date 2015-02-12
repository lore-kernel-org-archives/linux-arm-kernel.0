From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Thu, 12 Feb 2015 10:55:16 +0800
Subject: [PATCH 1/2] pm: at91: add the PM initialization for the sama5d3 and
 sama5d4
In-Reply-To: <1423709668-8539-1-git-send-email-wenyou.yang@atmel.com>
References: <1423709668-8539-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1423709716-8576-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To get the mpddrc peripheral id from the PM initialization,
which will be used to disable mpddrc'c clock during suspending.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---
 arch/arm/mach-at91/generic.h              |    4 ++++
 arch/arm/mach-at91/include/mach/sama5d3.h |    1 +
 arch/arm/mach-at91/include/mach/sama5d4.h |    5 +++++
 arch/arm/mach-at91/pm.c                   |   21 +++++++++++++++++++++
 arch/arm/mach-at91/sama5.c                |   10 ++++++++--
 5 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generic.h
index a6e726a..fa70811 100644
--- a/arch/arm/mach-at91/generic.h
+++ b/arch/arm/mach-at91/generic.h
@@ -34,11 +34,15 @@ extern void __init at91rm9200_pm_init(void);
 extern void __init at91sam9260_pm_init(void);
 extern void __init at91sam9g45_pm_init(void);
 extern void __init at91sam9x5_pm_init(void);
+extern void __init sam5d3_pm_init(void);
+extern void __init sam5d4_pm_init(void);
 #else
 void __init at91rm9200_pm_init(void) { }
 void __init at91sam9260_pm_init(void) { }
 void __init at91sam9g45_pm_init(void) { }
 void __init at91sam9x5_pm_init(void) { }
+void __init sam5d3_pm_init(void) {}
+void __init sam5d4_pm_init(void) {}
 #endif
 
 #endif /* _AT91_GENERIC_H */
diff --git a/arch/arm/mach-at91/include/mach/sama5d3.h b/arch/arm/mach-at91/include/mach/sama5d3.h
index 25613d8..5a383d8 100644
--- a/arch/arm/mach-at91/include/mach/sama5d3.h
+++ b/arch/arm/mach-at91/include/mach/sama5d3.h
@@ -63,6 +63,7 @@
 #define SAMA5D3_ID_TDES		44	/* Triple Data Encryption Standard */
 #define SAMA5D3_ID_TRNG		45	/* True Random Generator Number */
 #define SAMA5D3_ID_IRQ0		47	/* Advanced Interrupt Controller (IRQ0) */
+#define SAMA5D3_ID_MPDDRC	49	/* MPDDR controller */
 
 /*
  * User Peripheral physical base addresses.
diff --git a/arch/arm/mach-at91/include/mach/sama5d4.h b/arch/arm/mach-at91/include/mach/sama5d4.h
index f256a45..e45f1b8 100644
--- a/arch/arm/mach-at91/include/mach/sama5d4.h
+++ b/arch/arm/mach-at91/include/mach/sama5d4.h
@@ -14,6 +14,11 @@
 #define SAMA5D4_H
 
 /*
+ * Peripheral identifiers/interrupts.
+ */
+#define SAMA5D4_ID_MPDDRC	16	/* MPDDR controller */
+
+/*
  * User Peripheral physical base addresses.
  */
 #define SAMA5D4_BASE_USART3	0xfc00c000 /* (USART3 non-secure) Base Address */
diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 2574bad..7acb40e 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -41,6 +41,8 @@
 static struct {
 	unsigned long uhp_udp_mask;
 	int memctrl;
+	unsigned int ddrc_pid;
+	bool is_sama5d4;
 } at91_pm_data;
 
 void __iomem *at91_ramc_base[2];
@@ -360,3 +362,22 @@ void __init at91sam9x5_pm_init(void)
 	at91_pm_data.memctrl = AT91_MEMCTRL_DDRSDR;
 	return at91_pm_init();
 }
+
+void __init sam5d3_pm_init(void)
+{
+	at91_dt_ramc();
+	at91_pm_data.uhp_udp_mask = AT91SAM926x_PMC_UHP | AT91SAM926x_PMC_UDP;
+	at91_pm_data.memctrl = AT91_MEMCTRL_DDRSDR;
+	at91_pm_data.ddrc_pid = SAMA5D3_ID_MPDDRC;
+	return at91_pm_init();
+}
+
+void __init sam5d4_pm_init(void)
+{
+	at91_dt_ramc();
+	at91_pm_data.uhp_udp_mask = AT91SAM926x_PMC_UHP | AT91SAM926x_PMC_UDP;
+	at91_pm_data.memctrl = AT91_MEMCTRL_DDRSDR;
+	at91_pm_data.ddrc_pid = SAMA5D4_ID_MPDDRC;
+	at91_pm_data.is_sama5d4 = true;
+	return at91_pm_init();
+}
diff --git a/arch/arm/mach-at91/sama5.c b/arch/arm/mach-at91/sama5.c
index 228814a..4338d43 100644
--- a/arch/arm/mach-at91/sama5.c
+++ b/arch/arm/mach-at91/sama5.c
@@ -31,7 +31,7 @@
 static void __init sama5_dt_device_init(void)
 {
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-	at91sam9x5_pm_init();
+	sam5d3_pm_init();
 }
 
 static const char *sama5_dt_board_compat[] __initconst = {
@@ -84,10 +84,16 @@ static const char *sama5_alt_dt_board_compat[] __initconst = {
 	NULL
 };
 
+static void __init sama5d4_dt_device_init(void)
+{
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	sam5d4_pm_init();
+}
+
 DT_MACHINE_START(sama5_alt_dt, "Atmel SAMA5")
 	/* Maintainer: Atmel */
 	.map_io		= sama5_alt_map_io,
-	.init_machine	= sama5_dt_device_init,
+	.init_machine	= sama5d4_dt_device_init,
 	.dt_compat	= sama5_alt_dt_board_compat,
 	.l2c_aux_mask	= ~0UL,
 MACHINE_END
-- 
1.7.9.5
