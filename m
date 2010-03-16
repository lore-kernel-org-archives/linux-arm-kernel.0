From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 16 Mar 2010 12:17:32 -0500
Subject: [PATCH] ep93xx/core.c: remove redundant static variable
Message-ID: <0D753D10438DA54287A00B02708426976368534061@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the pointer to the ep93xx_eth_data passed by the board support code
directly instead of copying it to a local static variable.

While here, also document the function used to register the ethernet
device.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Ryan Mallon <ryan@bluewatersys.com>

---

diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index 90fb591..3dfef45 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -330,8 +330,10 @@ static struct platform_device ep93xx_ohci_device = {
 	.resource	= ep93xx_ohci_resources,
 };
 
-static struct ep93xx_eth_data ep93xx_eth_data;
 
+/*************************************************************************
+ * EP93xx ethernet peripheral handling
+ *************************************************************************/
 static struct resource ep93xx_eth_resource[] = {
 	{
 		.start	= EP93XX_ETHERNET_PHYS_BASE,
@@ -347,19 +349,22 @@ static struct resource ep93xx_eth_resource[] = {
 static struct platform_device ep93xx_eth_device = {
 	.name		= "ep93xx-eth",
 	.id		= -1,
-	.dev		= {
-		.platform_data	= &ep93xx_eth_data,
-	},
 	.num_resources	= ARRAY_SIZE(ep93xx_eth_resource),
 	.resource	= ep93xx_eth_resource,
 };
 
+/**
+ * ep93xx_register_eth - Register the built-in ethernet platform device.
+ * @data:	platform specific ethernet configuration
+ * @copy_addr:	flag indicating that the MAC address should be copied
+ *		from the IndAd registers (as programmed by the bootloader)
+ */
 void __init ep93xx_register_eth(struct ep93xx_eth_data *data, int copy_addr)
 {
 	if (copy_addr)
 		memcpy_fromio(data->dev_addr, EP93XX_ETHERNET_BASE + 0x50, 6);
 
-	ep93xx_eth_data = *data;
+	ep93xx_eth_device.dev.platform_data = data;
 	platform_device_register(&ep93xx_eth_device);
 }
 
