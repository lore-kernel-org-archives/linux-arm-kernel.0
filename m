From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Wed, 28 Nov 2018 11:11:37 +0000
Subject: [PATCH 1/8] ARM: sa1100: explicitly register sa11x0-pcmcia devices
In-Reply-To: <20181128111041.GG30658@n2100.armlinux.org.uk>
Message-ID: <E1gRxkn-0001tx-Nn@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Simplify the code by getting rid of the conditional automatic
registration of the sa11x0 PCMCIA interfaces in sa1100_init(), and
require all platforms to explicitly call sa11x0_register_pcmcia().
Only one platform (iPAQ) is affected by this change.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mach-sa1100/generic.c | 10 ----------
 arch/arm/mach-sa1100/h3100.c   |  1 +
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/arm/mach-sa1100/generic.c b/arch/arm/mach-sa1100/generic.c
index 800321c6cbd8..755290bf658b 100644
--- a/arch/arm/mach-sa1100/generic.c
+++ b/arch/arm/mach-sa1100/generic.c
@@ -235,18 +235,11 @@ void sa11x0_register_lcd(struct sa1100fb_mach_info *inf)
 	sa11x0_register_device(&sa11x0fb_device, inf);
 }
 
-static bool sa11x0pcmcia_legacy = true;
-static struct platform_device sa11x0pcmcia_device = {
-	.name		= "sa11x0-pcmcia",
-	.id		= -1,
-};
-
 void sa11x0_register_pcmcia(int socket, struct gpiod_lookup_table *table)
 {
 	if (table)
 		gpiod_add_lookup_table(table);
 	platform_device_register_simple("sa11x0-pcmcia", socket, NULL, 0);
-	sa11x0pcmcia_legacy = false;
 }
 
 static struct platform_device sa11x0mtd_device = {
@@ -331,9 +324,6 @@ static int __init sa1100_init(void)
 {
 	pm_power_off = sa1100_power_off;
 
-	if (sa11x0pcmcia_legacy)
-		platform_device_register(&sa11x0pcmcia_device);
-
 	regulator_has_full_constraints();
 
 	return platform_add_devices(sa11x0_devices, ARRAY_SIZE(sa11x0_devices));
diff --git a/arch/arm/mach-sa1100/h3100.c b/arch/arm/mach-sa1100/h3100.c
index c6b412054a3c..9dc5bcb7326b 100644
--- a/arch/arm/mach-sa1100/h3100.c
+++ b/arch/arm/mach-sa1100/h3100.c
@@ -126,6 +126,7 @@ static void __init h3100_mach_init(void)
 {
 	h3xxx_mach_init();
 
+	sa11x0_register_pcmcia(-1, NULL);
 	sa11x0_register_lcd(&h3100_lcd_info);
 	sa11x0_register_irda(&h3100_irda_data);
 }
-- 
2.7.4
