From: daniel@caiaq.de (Daniel Mack)
Date: Wed, 25 Nov 2009 11:42:17 +0100
Subject: [PATCH 03/17] ARM: pxa/raumfeld: add SMSC9220 ethernet support
In-Reply-To: <1259145751-3331-1-git-send-email-daniel@caiaq.de>
References: <1259145751-3331-1-git-send-email-daniel@caiaq.de>
Message-ID: <1259145751-3331-4-git-send-email-daniel@caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 'Connector' and 'Speaker S/M' devices have an SMSC9220 ethernet chip
onboard.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
---
 arch/arm/mach-pxa/raumfeld.c |   51 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/raumfeld.c b/arch/arm/mach-pxa/raumfeld.c
index 075e337..82af0dc 100644
--- a/arch/arm/mach-pxa/raumfeld.c
+++ b/arch/arm/mach-pxa/raumfeld.c
@@ -19,7 +19,10 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/sysdev.h>
+#include <linux/platform_device.h>
 #include <linux/interrupt.h>
+#include <linux/gpio.h>
+#include <linux/smsc911x.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -92,6 +95,52 @@ static mfp_cfg_t raumfeld_pin_config[] __initdata = {
 	GPIO110_UART3_RXD,
 };
 
+/*
+ * SMSC LAN9220 Ethernet
+ */
+
+static struct resource smc91x_resources[] = {
+	{
+		.start	= PXA3xx_CS2_PHYS,
+		.end	= PXA3xx_CS2_PHYS + 0xfffff,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= gpio_to_irq(mfp_to_gpio(GPIO_ETH_IRQ)),
+		.end	= gpio_to_irq(mfp_to_gpio(GPIO_ETH_IRQ)),
+		.flags	= IORESOURCE_IRQ | IRQF_TRIGGER_FALLING,
+	}
+};
+
+static struct smsc911x_platform_config raumfeld_smsc911x_config = {
+	.phy_interface	= PHY_INTERFACE_MODE_MII,
+	.irq_polarity	= SMSC911X_IRQ_POLARITY_ACTIVE_LOW,
+	.irq_type	= SMSC911X_IRQ_TYPE_OPEN_DRAIN,
+	.flags		= SMSC911X_USE_32BIT | SMSC911X_SAVE_MAC_ADDRESS,
+};
+
+static struct platform_device smc91x_device = {
+	.name		= "smsc911x",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(smc91x_resources),
+	.resource	= smc91x_resources,
+	.dev		= {
+		.platform_data = &raumfeld_smsc911x_config,
+	}
+};
+
+static mfp_cfg_t raumfeld_eth_pin_config[] __initdata = {
+	GPIO1_nCS2,			/* CS */
+	GPIO40_GPIO | MFP_PULL_HIGH,	/* IRQ */
+};
+
+static void __init raumfeld_eth_init(void)
+{
+	pxa3xx_mfp_config(ARRAY_AND_SIZE(raumfeld_eth_pin_config));
+	platform_device_register(&smc91x_device);
+}
+
+
 static void __init raumfeld_common_init(void)
 {
 	enable_irq_wake(IRQ_WAKEUP0);
@@ -118,11 +167,13 @@ static void __init raumfeld_controller_init(void)
 static void __init raumfeld_connector_init(void)
 {
 	raumfeld_common_init();
+	raumfeld_eth_init();
 }
 
 static void __init raumfeld_speaker_init(void)
 {
 	raumfeld_common_init();
+	raumfeld_eth_init();
 }
 
 /* physical memory regions */
-- 
1.6.5.2
