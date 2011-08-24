From: b-cousson@ti.com (Benoit Cousson)
Date: Wed, 24 Aug 2011 15:09:08 +0200
Subject: [RFC PATCH 02/10] arm/dts: OMAP4: Add a main ocp entry bound to
	l3-noc driver
In-Reply-To: <1314191356-10963-1-git-send-email-b-cousson@ti.com>
References: <1314191356-10963-1-git-send-email-b-cousson@ti.com>
Message-ID: <1314191356-10963-3-git-send-email-b-cousson@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Used the main OCP node to add bindings with the l3_noc driver.
Remove l3_noc static device creation if CONFIG_OF is defined.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi  |    3 ++-
 arch/arm/mach-omap2/devices.c |    2 ++
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 97a3ea7..928a74c 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -64,10 +64,11 @@
 	 * hierarchy.
 	 */
 	ocp {
-		compatible = "simple-bus";
+		compatible = "ti,l3-noc", "arteris,noc", "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges;
+		hwmods = "l3_main_1", "l3_main_2", "l3_main_3";
 
 		gic: interrupt-controller at 48241000 {
 			compatible = "ti,omap4-gic", "arm,gic";
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 2d4a199..5964650 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -70,6 +70,7 @@ static int __init omap3_l3_init(void)
 }
 postcore_initcall(omap3_l3_init);
 
+#ifndef CONFIG_OF
 static int __init omap4_l3_init(void)
 {
 	int l, i;
@@ -100,6 +101,7 @@ static int __init omap4_l3_init(void)
 	return IS_ERR(pdev) ? PTR_ERR(pdev) : 0;
 }
 postcore_initcall(omap4_l3_init);
+#endif
 
 #if defined(CONFIG_VIDEO_OMAP2) || defined(CONFIG_VIDEO_OMAP2_MODULE)
 
-- 
1.7.0.4
