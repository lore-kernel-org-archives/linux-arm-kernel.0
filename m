From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 29 Aug 2016 12:03:12 +0100
Subject: [PATCH 3/3] ARM: sa1100/cerf: switch to using
 gpio_led_register_device()
In-Reply-To: <20160829110157.GE1041@n2100.armlinux.org.uk>
References: <20160829110157.GE1041@n2100.armlinux.org.uk>
Message-ID: <E1beKLQ-000176-Kq@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rather than statically declaring the leds-gpio device, use the helper
function provided.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mach-sa1100/Kconfig |  1 +
 arch/arm/mach-sa1100/cerf.c  | 11 +----------
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-sa1100/Kconfig b/arch/arm/mach-sa1100/Kconfig
index b34f229fbfb4..d186d8c5029b 100644
--- a/arch/arm/mach-sa1100/Kconfig
+++ b/arch/arm/mach-sa1100/Kconfig
@@ -23,6 +23,7 @@ config ASSABET_NEPONSET
 config SA1100_CERF
 	bool "CerfBoard"
 	select ARM_SA1110_CPUFREQ
+	select LEDS_GPIO_REGISTER
 	help
 	  The Intrinsyc CerfBoard is based on the StrongARM 1110 (Discontinued).
 	  More information is available at:
diff --git a/arch/arm/mach-sa1100/cerf.c b/arch/arm/mach-sa1100/cerf.c
index b2a4b41626ef..88e526561a24 100644
--- a/arch/arm/mach-sa1100/cerf.c
+++ b/arch/arm/mach-sa1100/cerf.c
@@ -89,18 +89,8 @@ static struct gpio_led_platform_data cerf_gpio_led_info = {
 	.num_leds	= ARRAY_SIZE(cerf_gpio_leds),
 };
 
-static struct platform_device cerf_leds = {
-	.name	= "leds-gpio",
-	.id	= -1,
-	.dev	= {
-		.platform_data	= &cerf_gpio_led_info,
-	}
-};
-
-
 static struct platform_device *cerf_devices[] __initdata = {
 	&cerfuart2_device,
-	&cerf_leds,
 };
 
 #ifdef CONFIG_SA1100_CERF_FLASH_32MB
@@ -176,6 +166,7 @@ static void __init cerf_init(void)
 {
 	sa11x0_ppc_configure_mcp();
 	platform_add_devices(cerf_devices, ARRAY_SIZE(cerf_devices));
+	gpio_led_register_device(-1, &cerf_gpio_led_info);
 	sa11x0_register_mtd(&cerf_flash_data, &cerf_flash_resource, 1);
 	sa11x0_register_mcp(&cerf_mcp_data);
 	sa11x0_register_pcmcia(1, &cerf_cf_gpio_table);
-- 
2.1.0
