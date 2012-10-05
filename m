From: florian@openwrt.org (Florian Fainelli)
Date: Fri,  5 Oct 2012 18:20:42 +0200
Subject: [PATCH 10/32 v3] ARM: cns3xxx: use ehci platform driver
In-Reply-To: <1349454064-11606-1-git-send-email-florian@openwrt.org>
References: <1349454064-11606-1-git-send-email-florian@openwrt.org>
Message-ID: <1349454064-11606-11-git-send-email-florian@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch converts the cns3xxx platform to use the ehci-platform driver
instead of the ehci-cns3xxx platform driver.

The ehci-platform driver is provided with power_{on,off} callbacks to ensure
proper block gating and USB configuration of the EHCI controller.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
No changes in v2 and v3

 arch/arm/mach-cns3xxx/cns3420vb.c |   44 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-cns3xxx/cns3420vb.c b/arch/arm/mach-cns3xxx/cns3420vb.c
index 2c5fb4c..906094c 100644
--- a/arch/arm/mach-cns3xxx/cns3420vb.c
+++ b/arch/arm/mach-cns3xxx/cns3420vb.c
@@ -24,6 +24,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/physmap.h>
 #include <linux/mtd/partitions.h>
+#include <linux/usb/ehci_pdriver.h>
 #include <asm/setup.h>
 #include <asm/mach-types.h>
 #include <asm/hardware/gic.h>
@@ -32,6 +33,7 @@
 #include <asm/mach/time.h>
 #include <mach/cns3xxx.h>
 #include <mach/irqs.h>
+#include <mach/pm.h>
 #include "core.h"
 #include "devices.h"
 
@@ -125,13 +127,53 @@ static struct resource cns3xxx_usb_ehci_resources[] = {
 
 static u64 cns3xxx_usb_ehci_dma_mask = DMA_BIT_MASK(32);
 
+static int csn3xxx_usb_ehci_power_on(struct platform_device *pdev)
+{
+	/*
+	 * EHCI and OHCI share the same clock and power,
+	 * resetting twice would cause the 1st controller been reset.
+	 * Therefore only do power up  at the first up device, and
+	 * power down at the last down device.
+	 *
+	 * Set USB AHB INCR length to 16
+	 */
+	if (atomic_inc_return(&usb_pwr_ref) == 1) {
+		cns3xxx_pwr_power_up(1 << PM_PLL_HM_PD_CTRL_REG_OFFSET_PLL_USB);
+		cns3xxx_pwr_clk_en(1 << PM_CLK_GATE_REG_OFFSET_USB_HOST);
+		cns3xxx_pwr_soft_rst(1 << PM_SOFT_RST_REG_OFFST_USB_HOST);
+		__raw_writel((__raw_readl(MISC_CHIP_CONFIG_REG) | (0X2 << 24)),
+			MISC_CHIP_CONFIG_REG);
+	}
+
+	return 0;
+}
+
+static void csn3xxx_usb_ehci_power_off(struct platform_device *pdev)
+{
+	/*
+	 * EHCI and OHCI share the same clock and power,
+	 * resetting twice would cause the 1st controller been reset.
+	 * Therefore only do power up  at the first up device, and
+	 * power down@the last down device.
+	 */
+	if (atomic_dec_return(&usb_pwr_ref) == 0)
+		cns3xxx_pwr_clk_dis(1 << PM_CLK_GATE_REG_OFFSET_USB_HOST);
+}
+
+static struct usb_ehci_pdata cns3xxx_usb_ehci_pdata = {
+	.port_power_off	= 1,
+	.power_on	= csn3xxx_usb_ehci_power_on,
+	.power_off	= csn3xxx_usb_ehci_power_off,
+};
+
 static struct platform_device cns3xxx_usb_ehci_device = {
-	.name          = "cns3xxx-ehci",
+	.name          = "ehci-platform",
 	.num_resources = ARRAY_SIZE(cns3xxx_usb_ehci_resources),
 	.resource      = cns3xxx_usb_ehci_resources,
 	.dev           = {
 		.dma_mask          = &cns3xxx_usb_ehci_dma_mask,
 		.coherent_dma_mask = DMA_BIT_MASK(32),
+		.platform_data     = &cns3xxx_usb_ehci_pdata,
 	},
 };
 
-- 
1.7.9.5
