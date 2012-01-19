From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 19 Jan 2012 15:34:05 +0000
Subject: [PATCH 05/11] ARM: sa11x0: fix collie build error
In-Reply-To: <20120119153149.GB1068@n2100.arm.linux.org.uk>
References: <20120119153149.GB1068@n2100.arm.linux.org.uk>
Message-ID: <E1Rnu05-0002pa-Tu@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

f408c985cefc (GPIO: sa1100: implement proper gpiolib gpio_to_irq conversion)
made gpio_to_irq() a function.  This breaks collie where it's used to
initialize some static data.  Fix that by moving the initialization to
the init code.

arch/arm/mach-sa1100/collie.c:139: error: initializer element is not constant
arch/arm/mach-sa1100/collie.c:139: error: (near initialization for 'collie_power_resource[0].start')
arch/arm/mach-sa1100/collie.c:140: error: initializer element is not constant
arch/arm/mach-sa1100/collie.c:140: error: (near initialization for 'collie_power_resource[0].end')

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-sa1100/collie.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-sa1100/collie.c b/arch/arm/mach-sa1100/collie.c
index c483912..cce8763 100644
--- a/arch/arm/mach-sa1100/collie.c
+++ b/arch/arm/mach-sa1100/collie.c
@@ -144,8 +144,6 @@ static struct pda_power_pdata collie_power_data = {
 static struct resource collie_power_resource[] = {
 	{
 		.name		= "ac",
-		.start		= gpio_to_irq(COLLIE_GPIO_AC_IN),
-		.end		= gpio_to_irq(COLLIE_GPIO_AC_IN),
 		.flags		= IORESOURCE_IRQ |
 				  IORESOURCE_IRQ_HIGHEDGE |
 				  IORESOURCE_IRQ_LOWEDGE,
@@ -347,7 +345,8 @@ static void __init collie_init(void)
 
 	GPSR |= _COLLIE_GPIO_UCB1x00_RESET;
 
-
+	collie_power_resource[0].start = gpio_to_irq(COLLIE_GPIO_AC_IN);
+	collie_power_resource[0].end = gpio_to_irq(COLLIE_GPIO_AC_IN);
 	platform_scoop_config = &collie_pcmcia_config;
 
 	ret = platform_add_devices(devices, ARRAY_SIZE(devices));
-- 
1.7.4.4
