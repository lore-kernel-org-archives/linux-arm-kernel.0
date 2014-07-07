From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  7 Jul 2014 09:54:55 +0200
Subject: [PATCH v2 30/30] ARM: shmobile: kzm9g-reference: Initialise CMT1
 device using DT
In-Reply-To: <1404719695-1634-1-git-send-email-horms+renesas@verge.net.au>
References: <1404719695-1634-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1404719695-1634-31-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Initialise CMT1 device using DT when booting kzm9g
using DT-reference.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
v2
* First post
---
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts |  4 ++++
 arch/arm/mach-shmobile/setup-sh73a0.c        | 11 +----------
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
index df2ae46..4cd9949 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
@@ -279,6 +279,10 @@
 	status = "okay";
 };
 
+&cmt1 {
+	status = "okay";
+};
+
 &pfc {
 	i2c3_pins: i2c3 {
 		renesas,groups = "i2c3_1";
diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index 2c802ae..5d3f1d8 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -696,10 +696,6 @@ static struct platform_device irqpin3_device = {
 	},
 };
 
-static struct platform_device *sh73a0_devices_dt[] __initdata = {
-	&cmt1_device,
-};
-
 static struct platform_device *sh73a0_early_devices[] __initdata = {
 	&scif0_device,
 	&scif1_device,
@@ -710,6 +706,7 @@ static struct platform_device *sh73a0_early_devices[] __initdata = {
 	&scif6_device,
 	&scif7_device,
 	&scif8_device,
+	&cmt1_device,
 	&tmu0_device,
 	&ipmmu_device,
 };
@@ -736,8 +733,6 @@ void __init sh73a0_add_standard_devices(void)
 	/* Clear software reset bit on SY-DMAC module */
 	__raw_writel(__raw_readl(SRCR2) & ~(1 << 18), SRCR2);
 
-	platform_add_devices(sh73a0_devices_dt,
-			    ARRAY_SIZE(sh73a0_devices_dt));
 	platform_add_devices(sh73a0_early_devices,
 			    ARRAY_SIZE(sh73a0_early_devices));
 	platform_add_devices(sh73a0_late_devices,
@@ -762,8 +757,6 @@ void __init sh73a0_earlytimer_init(void)
 
 void __init sh73a0_add_early_devices(void)
 {
-	early_platform_add_devices(sh73a0_devices_dt,
-				   ARRAY_SIZE(sh73a0_devices_dt));
 	early_platform_add_devices(sh73a0_early_devices,
 				   ARRAY_SIZE(sh73a0_early_devices));
 
@@ -780,8 +773,6 @@ void __init sh73a0_add_standard_devices_dt(void)
 	/* clocks are setup late during boot in the case of DT */
 	sh73a0_clock_init();
 
-	platform_add_devices(sh73a0_devices_dt,
-			     ARRAY_SIZE(sh73a0_devices_dt));
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 
 	/* Instantiate cpufreq-cpu0 */
-- 
2.0.0.rc2
