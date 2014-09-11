From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 11 Sep 2014 09:57:27 +0900
Subject: [PATCH 5/5] ARM: shmobile: armadillo800eva legacy: Use
 rmobile_add_devices_to_domains()
In-Reply-To: <cover.1410395620.git.horms+renesas@verge.net.au>
References: <cover.1410395620.git.horms+renesas@verge.net.au>
Message-ID: <834720dbf03819a8b2d0ba5fbe01d008267f9da6.1410395620.git.horms+renesas@verge.net.au>
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
 arch/arm/mach-shmobile/board-armadillo800eva.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index 6dbaad6..e709835 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -1231,6 +1231,10 @@ clock_error:
 #define GPIO_PORT8CR	IOMEM(0xe6050008)
 static void __init eva_init(void)
 {
+	static struct pm_domain_device domain_devices[] __initdata = {
+		{ "A4LC", &lcdc0_device },
+		{ "A4LC", &hdmi_lcdc_device },
+	};
 	struct platform_device *usb = NULL;
 
 	regulator_register_always_on(0, "fixed-3.3V", fixed3v3_power_consumers,
@@ -1316,8 +1320,8 @@ static void __init eva_init(void)
 	platform_add_devices(eva_devices,
 			     ARRAY_SIZE(eva_devices));
 
-	rmobile_add_device_to_domain("A4LC", &lcdc0_device);
-	rmobile_add_device_to_domain("A4LC", &hdmi_lcdc_device);
+	rmobile_add_devices_to_domains(domain_devices,
+				       ARRAY_SIZE(domain_devices));
 	if (usb)
 		rmobile_add_device_to_domain("A3SP", usb);
 
-- 
2.0.1
