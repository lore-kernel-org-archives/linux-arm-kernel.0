From: saeed@marvell.com (Saeed Bishara)
Date: Sun,  2 May 2010 17:22:38 +0300
Subject: [PATCH 1/5] USB: add support for phy init for the Dove SoC
In-Reply-To: <1272810162-14858-1-git-send-email-saeed@marvell.com>
References: <1272810162-14858-1-git-send-email-saeed@marvell.com>
Message-ID: <1272810162-14858-2-git-send-email-saeed@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for initializing the USB phy of the Marvell's Dove SoC.

Signed-off-by: Saeed Bishara <saeed@marvell.com>
---
 arch/arm/plat-orion/include/plat/ehci-orion.h |    1 +
 drivers/usb/host/ehci-orion.c                 |  139 +++++++++++++++++++++----
 2 files changed, 120 insertions(+), 20 deletions(-)

diff --git a/arch/arm/plat-orion/include/plat/ehci-orion.h b/arch/arm/plat-orion/include/plat/ehci-orion.h
index 4ec668e..67df73e 100644
--- a/arch/arm/plat-orion/include/plat/ehci-orion.h
+++ b/arch/arm/plat-orion/include/plat/ehci-orion.h
@@ -13,6 +13,7 @@
 
 enum orion_ehci_phy_ver {
 	EHCI_PHY_ORION,
+	EHCI_PHY_DOVE,
 	EHCI_PHY_DD,
 	EHCI_PHY_KW,
 	EHCI_PHY_NA,
diff --git a/drivers/usb/host/ehci-orion.c b/drivers/usb/host/ehci-orion.c
index 0f87dc7..ba659e0 100644
--- a/drivers/usb/host/ehci-orion.c
+++ b/drivers/usb/host/ehci-orion.c
@@ -25,6 +25,7 @@
 #define USB_WINDOW_BASE(i)	(0x324 + ((i) << 4))
 #define USB_IPG			0x360
 #define USB_PHY_PWR_CTRL	0x400
+#define USB_PHY_PLL_CTRL	0x410
 #define USB_PHY_TX_CTRL		0x420
 #define USB_PHY_RX_CTRL		0x430
 #define USB_PHY_IVREF_CTRL	0x440
@@ -100,6 +101,93 @@ static void orion_usb_phy_v1_setup(struct usb_hcd *hcd)
 	wrl(USB_MODE, 0x13);
 }
 
+static void orion_usb_phy_v2_setup(struct usb_hcd *hcd)
+{
+	u32 reg;
+
+	/* The below GLs are according to the Orion Errata document */
+	/*
+	 * Clear interrupt cause and mask
+	 */
+	wrl(USB_CAUSE, 0);
+	wrl(USB_MASK, 0);
+
+	/*
+	 * Reset controller
+	 */
+	wrl(USB_CMD, rdl(USB_CMD) | 0x2);
+	while (rdl(USB_CMD) & 0x2);
+
+	/* Clear bits 30 and 31. */
+	reg = rdl(USB_IPG);
+	reg &= ~(0x3 << 30);
+	/* Change bits[14:8] - IPG for non Start of Frame Packets
+	 * from 0x9(default) to 0xD
+	 */
+	reg &= ~(0x7f << 8);
+	reg |= 0xd << 8;
+	wrl(USB_IPG, reg);
+
+	/* VCO recalibrate */
+	wrl(USB_PHY_PLL_CTRL, rdl(USB_PHY_PLL_CTRL) | (1 << 21));
+	udelay(100);
+	wrl(USB_PHY_PLL_CTRL, rdl(USB_PHY_PLL_CTRL) & ~(1 << 21));
+
+	reg = rdl(USB_PHY_TX_CTRL);
+	reg |= 1 << 11; /* LOWVDD_EN */
+	reg |= 1 << 12; /* REG_RCAL_START */
+	/* bits[16:14]     (IMPCAL_VTH[2:0] = 101) */
+	reg &= ~(0x7 << 14);
+	reg |= (0x5 << 14);
+
+	reg &= ~(1 << 21); /* TX_BLOCK_EN */
+	reg &= ~(1 << 31); /* HS_STRESS_CTRL */
+	wrl(USB_PHY_TX_CTRL, reg);
+	udelay(100);
+	reg = rdl(USB_PHY_TX_CTRL);
+	reg &= ~(1 << 12); /* REG_RCAL_START */
+	wrl(USB_PHY_TX_CTRL, reg);
+
+	reg = rdl(USB_PHY_RX_CTRL);
+	reg &= ~(3 << 2); /* LPL_COEF */
+	reg |= 1 << 2;
+
+	reg &= ~(0xf << 4);
+	reg |= 0xc << 4; /* SQ_THRESH */
+
+	reg &= ~(3 << 15); /* REG_SQ_LENGTH */
+	reg |= 1 << 15;
+	reg &= ~(1 << 21); /* CDR_FASTLOCK_EN */
+	reg &= ~(3 << 26); /* EDGE_DET */
+	wrl(USB_PHY_RX_CTRL, reg);
+
+
+	/*
+	 * USB PHY IVREF Control
+	 * TXVDD12[9:8]=0x3
+	 */
+	wrl(USB_PHY_IVREF_CTRL, rdl(USB_PHY_IVREF_CTRL) | (0x3 << 8));
+
+
+	/*
+	 * GL# USB-3 GL# USB-9: USB PHY Test Group Control
+	 * REG_FIFO_SQ_RST[15]=0
+	 */
+	wrl(USB_PHY_TST_GRP_CTRL, rdl(USB_PHY_TST_GRP_CTRL) & ~0x8000);
+
+	/*
+	 * Stop and reset controller
+	 */
+	wrl(USB_CMD, rdl(USB_CMD) & ~0x1);
+	wrl(USB_CMD, rdl(USB_CMD) | 0x2);
+	while (rdl(USB_CMD) & 0x2);
+
+	/*
+	 * GL# USB-4 Setup USB Host mode
+	 */
+	wrl(USB_MODE, 0x3);
+}
+
 static int ehci_orion_setup(struct usb_hcd *hcd)
 {
 	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
@@ -190,6 +278,36 @@ ehci_orion_conf_mbus_windows(struct usb_hcd *hcd,
 	}
 }
 
+static void __devinit
+ehci_orion_hw_init(struct usb_hcd *hcd,  struct orion_ehci_data *pd)
+{
+	/*
+	 * (Re-)program MBUS remapping windows if we are asked to.
+	 */
+	if (pd != NULL && pd->dram != NULL)
+		ehci_orion_conf_mbus_windows(hcd, pd->dram);
+
+
+	/*
+	 * setup Orion USB controller.
+	 */
+	switch (pd->phy_version) {
+	case EHCI_PHY_NA:	/* dont change USB phy settings */
+		break;
+	case EHCI_PHY_ORION:
+		orion_usb_phy_v1_setup(hcd);
+		break;
+	case EHCI_PHY_DOVE:
+		orion_usb_phy_v2_setup(hcd);
+		break;
+	case EHCI_PHY_DD:
+	case EHCI_PHY_KW:
+	default:
+		printk(KERN_WARNING "Orion ehci -USB phy version isn't supported.\n");
+	}
+
+}
+
 static int __devinit ehci_orion_drv_probe(struct platform_device *pdev)
 {
 	struct orion_ehci_data *pd = pdev->dev.platform_data;
@@ -255,26 +373,7 @@ static int __devinit ehci_orion_drv_probe(struct platform_device *pdev)
 	hcd->has_tt = 1;
 	ehci->sbrn = 0x20;
 
-	/*
-	 * (Re-)program MBUS remapping windows if we are asked to.
-	 */
-	if (pd != NULL && pd->dram != NULL)
-		ehci_orion_conf_mbus_windows(hcd, pd->dram);
-
-	/*
-	 * setup Orion USB controller.
-	 */
-	switch (pd->phy_version) {
-	case EHCI_PHY_NA:	/* dont change USB phy settings */
-		break;
-	case EHCI_PHY_ORION:
-		orion_usb_phy_v1_setup(hcd);
-		break;
-	case EHCI_PHY_DD:
-	case EHCI_PHY_KW:
-	default:
-		printk(KERN_WARNING "Orion ehci -USB phy version isn't supported.\n");
-	}
+	ehci_orion_hw_init(hcd, pd);
 
 	err = usb_add_hcd(hcd, irq, IRQF_SHARED | IRQF_DISABLED);
 	if (err)
-- 
1.6.0.4
