From: lkundrak@v3.sk (Lubomir Rintel)
Date: Mon, 12 Nov 2018 04:20:24 +0100
Subject: [PATCH v3 15/18] ARM: mmp: add a pxa-usb-phy device
In-Reply-To: <20181112032027.653931-1-lkundrak@v3.sk>
References: <20181112032027.653931-1-lkundrak@v3.sk>
Message-ID: <20181112032027.653931-16-lkundrak@v3.sk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is to replace the USB PHY initialization code (pxa_usb_phy_init(),
pxa_usb_phy_deinit()) with a proper PHY driver.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 arch/arm/mach-mmp/devices.c | 21 +++++++++++++++++++++
 arch/arm/mach-mmp/pxa910.h  |  1 +
 2 files changed, 22 insertions(+)

diff --git a/arch/arm/mach-mmp/devices.c b/arch/arm/mach-mmp/devices.c
index 0fca63c80e1a..822b8be042b9 100644
--- a/arch/arm/mach-mmp/devices.c
+++ b/arch/arm/mach-mmp/devices.c
@@ -240,6 +240,27 @@ void pxa_usb_phy_deinit(void __iomem *phy_reg)
 #if IS_ENABLED(CONFIG_USB_SUPPORT)
 static u64 __maybe_unused usb_dma_mask = ~(u32)0;
 
+#if IS_ENABLED(CONFIG_PHY_PXA_USB)
+struct resource pxa168_usb_phy_resources[] = {
+	[0] = {
+		.start	= PXA168_U2O_PHYBASE,
+		.end	= PXA168_U2O_PHYBASE + USB_PHY_RANGE,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+struct platform_device pxa168_device_usb_phy = {
+	.name		= "pxa-usb-phy",
+	.id		= -1,
+	.resource	= pxa168_usb_phy_resources,
+	.num_resources	= ARRAY_SIZE(pxa168_usb_phy_resources),
+	.dev		=  {
+		.dma_mask	= &usb_dma_mask,
+		.coherent_dma_mask = 0xffffffff,
+	}
+};
+#endif /* CONFIG_PHY_PXA_USB */
+
 #if IS_ENABLED(CONFIG_USB_MV_UDC)
 struct resource pxa168_u2o_resources[] = {
 	/* regbase */
diff --git a/arch/arm/mach-mmp/pxa910.h b/arch/arm/mach-mmp/pxa910.h
index 42009c349eae..2dfe38e4acc1 100644
--- a/arch/arm/mach-mmp/pxa910.h
+++ b/arch/arm/mach-mmp/pxa910.h
@@ -22,6 +22,7 @@ extern struct pxa_device_desc pxa910_device_pwm2;
 extern struct pxa_device_desc pxa910_device_pwm3;
 extern struct pxa_device_desc pxa910_device_pwm4;
 extern struct pxa_device_desc pxa910_device_nand;
+extern struct platform_device pxa168_device_usb_phy;
 extern struct platform_device pxa168_device_u2o;
 extern struct platform_device pxa168_device_u2ootg;
 extern struct platform_device pxa168_device_u2oehci;
-- 
2.19.1
