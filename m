From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Mon, 8 Aug 2016 18:05:00 +0800
Subject: [PATCH v6 1/6] ARM: at91: sama5: Add a new DT_MACHINE for SAMA5D2
In-Reply-To: <1470650705-31418-1-git-send-email-wenyou.yang@atmel.com>
References: <1470650705-31418-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1470650705-31418-2-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To support the SAMA5D2 specific pm_init function, add a new
DT_MACHINE for SAMA5D2.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---

Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 arch/arm/mach-at91/sama5.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-at91/sama5.c b/arch/arm/mach-at91/sama5.c
index 922b85f..2debfe2 100644
--- a/arch/arm/mach-at91/sama5.c
+++ b/arch/arm/mach-at91/sama5.c
@@ -59,7 +59,7 @@ static const struct at91_soc sama5_socs[] = {
 	{ /* sentinel */ },
 };
 
-static void __init sama5_dt_device_init(void)
+static void __init sama5_common_init(void)
 {
 	struct soc_device *soc;
 	struct device *soc_dev = NULL;
@@ -69,6 +69,11 @@ static void __init sama5_dt_device_init(void)
 		soc_dev = soc_device_to_device(soc);
 
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, soc_dev);
+}
+
+static void __init sama5_dt_device_init(void)
+{
+	sama5_common_init();
 	sama5_pm_init();
 }
 
@@ -84,7 +89,6 @@ DT_MACHINE_START(sama5_dt, "Atmel SAMA5")
 MACHINE_END
 
 static const char *const sama5_alt_dt_board_compat[] __initconst = {
-	"atmel,sama5d2",
 	"atmel,sama5d4",
 	NULL
 };
@@ -95,3 +99,20 @@ DT_MACHINE_START(sama5_alt_dt, "Atmel SAMA5")
 	.dt_compat	= sama5_alt_dt_board_compat,
 	.l2c_aux_mask	= ~0UL,
 MACHINE_END
+
+static void __init sama5d2_dt_device_init(void)
+{
+	sama5_common_init();
+}
+
+static const char *const sama5d2_dt_board_compat[] __initconst = {
+	"atmel,sama5d2",
+	NULL
+};
+
+DT_MACHINE_START(sama5d2_dt, "Atmel SAMA5")
+	/* Maintainer: Atmel */
+	.init_machine	= sama5d2_dt_device_init,
+	.dt_compat	= sama5d2_dt_board_compat,
+	.l2c_aux_mask	= ~0UL,
+MACHINE_END
-- 
2.7.4
