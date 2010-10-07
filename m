From: amit.kucheria@linaro.org (Amit Kucheria)
Date: Thu,  7 Oct 2010 03:58:25 +0300
Subject: [PATCH 2/3] mx51: efikamx: add otg support
In-Reply-To: <cover.1286412080.git.amit.kucheria@linaro.org>
References: <cover.1286412080.git.amit.kucheria@linaro.org>
Message-ID: <34d3df3c6ce621e58c17b38ffc23eb180b64a781.1286412080.git.amit.kucheria@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ethernet hangs off OTG

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm/mach-mx5/board-mx51_efikamx.c |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx51_efikamx.c b/arch/arm/mach-mx5/board-mx51_efikamx.c
index 4c921fc..b00502a 100644
--- a/arch/arm/mach-mx5/board-mx51_efikamx.c
+++ b/arch/arm/mach-mx5/board-mx51_efikamx.c
@@ -37,6 +37,8 @@
 #include "devices-imx51.h"
 #include "devices.h"
 
+#define	MX51_USB_PLL_DIV_24_MHZ	0x01
+
 static struct pad_desc mx51efikamx_pads[] = {
 	/* UART1 */
 	MX51_PAD_UART1_RXD__UART1_RXD,
@@ -63,10 +65,38 @@ static inline void mxc_init_imx_uart(void)
 }
 #endif /* SERIAL_IMX */
 
+/* This function is board specific as the bit mask for the plldiv will also
+ * be different for other Freescale SoCs, thus a common bitmask is not
+ * possible and cannot get place in /plat-mxc/ehci.c.
+ */
+static int initialize_otg_port(struct platform_device *pdev)
+{
+	u32 v;
+	void __iomem *usb_base;
+	void __iomem *usbother_base;
+	usb_base = ioremap(MX51_OTG_BASE_ADDR, SZ_4K);
+	usbother_base = (void __iomem *)(usb_base + MX5_USBOTHER_REGS_OFFSET);
+
+	/* Set the PHY clock to 19.2MHz */
+	v = __raw_readl(usbother_base + MXC_USB_PHY_CTR_FUNC2_OFFSET);
+	v &= ~MX5_USB_UTMI_PHYCTRL1_PLLDIV_MASK;
+	v |= MX51_USB_PLL_DIV_24_MHZ;
+	__raw_writel(v, usbother_base + MXC_USB_PHY_CTR_FUNC2_OFFSET);
+	iounmap(usb_base);
+	return 0;
+}
+
+static struct mxc_usbh_platform_data dr_utmi_config = {
+	.init   = initialize_otg_port,
+	.portsc = MXC_EHCI_UTMI_16BIT,
+	.flags  = MXC_EHCI_INTERNAL_PHY,
+};
+
 static void __init mxc_board_init(void)
 {
 	mxc_iomux_v3_setup_multiple_pads(mx51efikamx_pads,
 					ARRAY_SIZE(mx51efikamx_pads));
+	mxc_register_device(&mxc_usbdr_host_device, &dr_utmi_config);
 	mxc_init_imx_uart();
 }
 
-- 
1.7.0.4
