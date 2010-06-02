From: grinberg@compulab.co.il (Igor Grinberg)
Date: Wed,  2 Jun 2010 10:40:49 +0300
Subject: [PATCH 4/5] [ARM] usb/host/ohci-pxa27x: make PXA310 USB OTG port work
	in host mode.
In-Reply-To: <1275464450-23003-4-git-send-email-grinberg@compulab.co.il>
References: <1275464450-23003-1-git-send-email-grinberg@compulab.co.il>
	<1275464450-23003-2-git-send-email-grinberg@compulab.co.il>
	<1275464450-23003-3-git-send-email-grinberg@compulab.co.il>
	<1275464450-23003-4-git-send-email-grinberg@compulab.co.il>
Message-ID: <1275464450-23003-5-git-send-email-grinberg@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
 arch/arm/mach-pxa/include/mach/ohci.h     |    3 +
 arch/arm/mach-pxa/include/mach/regs-u2d.h |    2 +
 drivers/usb/host/ohci-pxa27x.c            |  183 +++++++++++++++++++++++++++++
 3 files changed, 188 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/ohci.h b/arch/arm/mach-pxa/include/mach/ohci.h
index 95b6e2a..a543d0f 100644
--- a/arch/arm/mach-pxa/include/mach/ohci.h
+++ b/arch/arm/mach-pxa/include/mach/ohci.h
@@ -29,6 +29,9 @@ struct pxaohci_platform_data {
 #define PMM_PERPORT_MODE       3
 
 	int power_budget;
+
+	struct otg_transceiver *otg;
+	unsigned long ulpi_mode;
 };
 
 extern void pxa_set_ohci_info(struct pxaohci_platform_data *info);
diff --git a/arch/arm/mach-pxa/include/mach/regs-u2d.h b/arch/arm/mach-pxa/include/mach/regs-u2d.h
index c15c0c5..82597e7 100644
--- a/arch/arm/mach-pxa/include/mach/regs-u2d.h
+++ b/arch/arm/mach-pxa/include/mach/regs-u2d.h
@@ -3,6 +3,8 @@
 
 #include <mach/bitfield.h>
 
+#define U2D_PHYS_BASE   0x54100000
+
 /*
  * USB2 device controller registers and bits definitions
  */
diff --git a/drivers/usb/host/ohci-pxa27x.c b/drivers/usb/host/ohci-pxa27x.c
index a18debd..c4aa239 100644
--- a/drivers/usb/host/ohci-pxa27x.c
+++ b/drivers/usb/host/ohci-pxa27x.c
@@ -24,6 +24,8 @@
 #include <linux/platform_device.h>
 #include <linux/clk.h>
 #include <mach/ohci.h>
+#include <mach/regs-u2d.h>
+#include <mach/pxa310-ulpi.h>
 
 /*
  * UHC: USB Host Controller (OHCI-like) register definitions
@@ -104,10 +106,126 @@ struct pxa27x_ohci {
 	struct device	*dev;
 	struct clk	*clk;
 	void __iomem	*mmio_base;
+
+	struct clk	*u2d_clk;
+	void __iomem	*u2d_mmio_base;
 };
 
 #define to_pxa27x_ohci(hcd)	(struct pxa27x_ohci *)hcd_to_ohci(hcd)
 
+#if defined(CONFIG_PXA310_ULPI)
+static void pxa310_setup_otg_hc(struct pxa27x_ohci *ohci)
+{
+	void __iomem *u2d_mmio_base = ohci->u2d_mmio_base;
+	u32 u2dotgcr;
+
+	u2dotgcr = __raw_readl(u2d_mmio_base + U2DOTGCR);
+	u2dotgcr |= U2DOTGCR_ULAF | U2DOTGCR_UTMID;
+	u2dotgcr &= ~(U2DOTGCR_SMAF | U2DOTGCR_CKAF);
+	__raw_writel(u2dotgcr, u2d_mmio_base + U2DOTGCR);
+	msleep(5);
+	__raw_writel(u2dotgcr | U2DOTGCR_ULE, u2d_mmio_base + U2DOTGCR);
+	msleep(5);
+	__raw_writel(__raw_readl(u2d_mmio_base + U2DOTGICR) & ~0x37F7F,
+		     u2d_mmio_base + U2DOTGICR);
+}
+
+static void pxa310_otg_transceiver_rtsm(struct pxa27x_ohci *ohci)
+{
+	void __iomem *u2d_mmio_base = ohci->u2d_mmio_base;
+	u32 u2dotgcr;
+
+	/* put PHY to sync mode */
+	u2dotgcr = __raw_readl(u2d_mmio_base + U2DOTGCR);
+	u2dotgcr |=  U2DOTGCR_RTSM | U2DOTGCR_UTMID;
+	__raw_writel(u2dotgcr, u2d_mmio_base + U2DOTGCR);
+	msleep(10);
+	/* setup OTG sync mode */
+	u2dotgcr = __raw_readl(u2d_mmio_base + U2DOTGCR);
+	u2dotgcr |= U2DOTGCR_ULAF;
+	u2dotgcr &= ~(U2DOTGCR_SMAF | U2DOTGCR_CKAF);
+	__raw_writel(u2dotgcr, u2d_mmio_base + U2DOTGCR);
+}
+
+static int start_otg_transceiver(struct pxa27x_ohci *ohci,
+				 struct otg_transceiver *otg)
+{
+	int err;
+
+	err = otg_init(otg);
+	if (err) {
+		pr_err("OTG transceiver init failed");
+		return err;
+	}
+
+	err = otg_set_vbus(otg, 1);
+	if (err) {
+		pr_err("OTG transceiver VBUS set failed");
+		return err;
+	}
+
+	err = otg_set_host(otg, &ohci_to_hcd(&ohci->ohci)->self);
+	if (err)
+		pr_err("OTG transceiver Host mode set failed");
+
+	return err;
+}
+
+static int pxa310_start_otg_hc(struct pxa27x_ohci *ohci,
+			       struct pxaohci_platform_data *inf)
+{
+	void __iomem *u2d_mmio_base = ohci->u2d_mmio_base;
+	u32 u2dotgcr;
+	int err;
+
+	pxa310_otg_transceiver_rtsm(ohci);
+
+	/* disable USB device controller */
+	__raw_writel(__raw_readl(u2d_mmio_base + U2DCR) & ~U2DCR_UDE,
+		     u2d_mmio_base + U2DCR);
+	__raw_writel(__raw_readl(u2d_mmio_base + U2DOTGCR) |
+		     U2DOTGCR_UTMID, u2d_mmio_base + U2DOTGCR);
+	__raw_writel(__raw_readl(u2d_mmio_base + U2DOTGICR) & ~0x37F7F,
+		     u2d_mmio_base + U2DOTGICR);
+
+	err = start_otg_transceiver(ohci, inf->otg);
+	if (err)
+		return err;
+
+	/* set xceiver mode */
+	if (inf->ulpi_mode == ULPI_IC_6PIN)
+		__raw_writel(__raw_readl(u2d_mmio_base + U2DP3CR) &
+			     ~U2DP3CR_P2SS, u2d_mmio_base + U2DP3CR);
+	else if (inf->ulpi_mode == ULPI_IC_3PIN)
+		__raw_writel(__raw_readl(u2d_mmio_base + U2DP3CR) |
+			     U2DP3CR_P2SS, u2d_mmio_base + U2DP3CR);
+
+	/* start OTG host controller */
+	u2dotgcr =__raw_readl(u2d_mmio_base + U2DOTGCR) | U2DOTGCR_SMAF;
+	__raw_writel(u2dotgcr & ~(U2DOTGCR_ULAF | U2DOTGCR_CKAF),
+		     u2d_mmio_base + U2DOTGCR);
+
+	return 0;
+}
+
+static inline bool pxa310_u2d_is_setup(struct pxa27x_ohci *ohci)
+{
+	return cpu_is_pxa310() && !IS_ERR(ohci->u2d_clk) && ohci->u2d_mmio_base;
+}
+#else
+static inline void pxa310_setup_otg_hc(struct pxa27x_ohci *ohci) {}
+static inline void pxa310_otg_transceiver_rtsm(struct pxa27x_ohci *ohci) {}
+static inline int pxa310_start_otg_hc(struct pxa27x_ohci *ohci,
+				      struct pxaohci_platform_data *inf)
+{
+	return 0;
+}
+static inline bool pxa310_u2d_is_setup(struct pxa27x_ohci *ohci)
+{
+	return false;
+}
+#endif /* CONFIG_PXA310_ULPI */
+
 /*
   PMM_NPS_MODE -- PMM Non-power switching mode
       Ports are powered continuously.
@@ -229,12 +347,24 @@ static int pxa27x_start_hc(struct pxa27x_ohci *ohci, struct device *dev)
 
 	pxa27x_setup_hc(ohci, inf);
 
+	if (pxa310_u2d_is_setup(ohci)) {
+		clk_enable(ohci->u2d_clk);
+		pxa310_setup_otg_hc(ohci);
+	}
+
 	if (inf->init)
 		retval = inf->init(dev);
 
 	if (retval < 0)
 		return retval;
 
+	/*
+	 * Platform can have a special init for the ulpi phy,
+	 * therefore the rest of the init must be done after the platform code.
+	 */
+	if (pxa310_u2d_is_setup(ohci))
+		pxa310_start_otg_hc(ohci, inf);
+
 	uhchr = __raw_readl(ohci->mmio_base + UHCHR) & ~UHCHR_SSE;
 	__raw_writel(uhchr, ohci->mmio_base + UHCHR);
 	__raw_writel(UHCHIE_UPRIE | UHCHIE_RWIE, ohci->mmio_base + UHCHIE);
@@ -251,6 +381,11 @@ static void pxa27x_stop_hc(struct pxa27x_ohci *ohci, struct device *dev)
 
 	inf = dev->platform_data;
 
+	if (pxa310_u2d_is_setup(ohci)) {
+		pxa310_otg_transceiver_rtsm(ohci);
+		clk_disable(ohci->u2d_clk);
+	}
+
 	if (inf->exit)
 		inf->exit(dev);
 
@@ -264,6 +399,38 @@ static void pxa27x_stop_hc(struct pxa27x_ohci *ohci, struct device *dev)
 	clk_disable(ohci->clk);
 }
 
+static int pxa310_init_otg_resources(struct pxa27x_ohci *ohci,
+				     struct pxaohci_platform_data *inf)
+{
+	int retval;
+
+	ohci->u2d_clk = clk_get(NULL, "U2DCLK");
+	if (IS_ERR(ohci->u2d_clk))
+		return PTR_ERR(ohci->u2d_clk);
+
+	inf->otg->io_priv = ioremap(U2D_PHYS_BASE, 0x1300);
+	if (!inf->otg->io_priv) {
+		retval = -ENOMEM;
+		goto err_ioremap;
+	}
+
+	ohci->u2d_mmio_base = inf->otg->io_priv;
+
+	return 0;
+
+err_ioremap:
+	clk_put(ohci->u2d_clk);
+	return retval;
+}
+
+static void pxa310_free_otg_resources(struct pxa27x_ohci *ohci)
+{
+	if (ohci->u2d_mmio_base)
+		iounmap(ohci->u2d_mmio_base);
+
+	if (ohci->u2d_clk)
+		clk_put(ohci->u2d_clk);
+}
 
 /*-------------------------------------------------------------------------*/
 
@@ -337,6 +504,12 @@ int usb_hcd_pxa27x_probe (const struct hc_driver *driver, struct platform_device
 	ohci->clk = usb_clk;
 	ohci->mmio_base = (void __iomem *)hcd->regs;
 
+	if (cpu_is_pxa310() && inf->otg) {
+		retval = pxa310_init_otg_resources(ohci, inf);
+		if (retval)
+			goto err3;
+	}
+
 	if ((retval = pxa27x_start_hc(ohci, &pdev->dev)) < 0) {
 		pr_debug("pxa27x_start_hc failed");
 		goto err3;
@@ -357,11 +530,15 @@ int usb_hcd_pxa27x_probe (const struct hc_driver *driver, struct platform_device
 	pxa27x_stop_hc(ohci, &pdev->dev);
  err3:
 	iounmap(hcd->regs);
+
+	if (cpu_is_pxa310() && inf->otg)
+		pxa310_free_otg_resources(ohci);
  err2:
 	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
  err1:
 	usb_put_hcd(hcd);
 	clk_put(usb_clk);
+
 	return retval;
 }
 
@@ -385,6 +562,12 @@ void usb_hcd_pxa27x_remove (struct usb_hcd *hcd, struct platform_device *pdev)
 
 	usb_remove_hcd(hcd);
 	pxa27x_stop_hc(ohci, &pdev->dev);
+
+	if (pxa310_u2d_is_setup(ohci)) {
+		iounmap(ohci->u2d_mmio_base);
+		clk_put(ohci->u2d_clk);
+	}
+
 	iounmap(hcd->regs);
 	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
 	usb_put_hcd(hcd);
-- 
1.6.4.4
