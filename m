From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 11 Sep 2014 09:57:25 +0900
Subject: [PATCH 3/5] ARM: shmobile: r8a7740: Use
 rmobile_add_devices_to_domains()
In-Reply-To: <cover.1410395620.git.horms+renesas@verge.net.au>
References: <cover.1410395620.git.horms+renesas@verge.net.au>
Message-ID: <c839f93bf8468f4380056d0638e3cba0488bb190.1410395620.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Use a table and the rmobile_add_devices_to_domains() helper function to
add all platform devices to their power domains at once, which is more
size-efficient than calling rmobile_add_device_to_domain() explicitly
for all devices individually.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7740.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index 3d5eaca..30df532 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -747,6 +747,19 @@ static void r8a7740_i2c_workaround(struct platform_device *pdev)
 
 void __init r8a7740_add_standard_devices(void)
 {
+	static struct pm_domain_device domain_devices[] __initdata = {
+		{ "A3SP", &scif0_device },
+		{ "A3SP", &scif1_device },
+		{ "A3SP", &scif2_device },
+		{ "A3SP", &scif3_device },
+		{ "A3SP", &scif4_device },
+		{ "A3SP", &scif5_device },
+		{ "A3SP", &scif6_device },
+		{ "A3SP", &scif7_device },
+		{ "A3SP", &scif8_device },
+		{ "A3SP", &i2c1_device },
+	};
+
 	/* I2C work-around */
 	r8a7740_i2c_workaround(&i2c0_device);
 	r8a7740_i2c_workaround(&i2c1_device);
@@ -762,17 +775,8 @@ void __init r8a7740_add_standard_devices(void)
 			     ARRAY_SIZE(r8a7740_late_devices));
 
 	/* add devices to PM domain  */
-
-	rmobile_add_device_to_domain("A3SP",	&scif0_device);
-	rmobile_add_device_to_domain("A3SP",	&scif1_device);
-	rmobile_add_device_to_domain("A3SP",	&scif2_device);
-	rmobile_add_device_to_domain("A3SP",	&scif3_device);
-	rmobile_add_device_to_domain("A3SP",	&scif4_device);
-	rmobile_add_device_to_domain("A3SP",	&scif5_device);
-	rmobile_add_device_to_domain("A3SP",	&scif6_device);
-	rmobile_add_device_to_domain("A3SP",	&scif7_device);
-	rmobile_add_device_to_domain("A3SP",	&scif8_device);
-	rmobile_add_device_to_domain("A3SP",	&i2c1_device);
+	rmobile_add_devices_to_domains(domain_devices,
+				       ARRAY_SIZE(domain_devices));
 }
 
 void __init r8a7740_add_early_devices(void)
-- 
2.0.1
