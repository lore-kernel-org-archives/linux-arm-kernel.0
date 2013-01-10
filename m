From: rogerq@ti.com (Roger Quadros)
Date: Thu, 10 Jan 2013 18:51:29 +0200
Subject: [PATCH 09/14] usb: ehci-omap: Remove PHY reset handling code
In-Reply-To: <1357836694-30788-1-git-send-email-rogerq@ti.com>
References: <1357836694-30788-1-git-send-email-rogerq@ti.com>
Message-ID: <1357836694-30788-10-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reset GPIO handling for the PHY must be done in the PHY
driver. We use the PHY helpers instead to reset the PHY.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/host/ehci-omap.c |   70 ++++++------------------------------------
 1 files changed, 10 insertions(+), 60 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index e6a2d76..46b28d6 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -77,79 +77,29 @@ static inline u32 ehci_read(void __iomem *base, u32 reg)
 	return __raw_readl(base + reg);
 }
 
-
-static void omap_ehci_soft_phy_reset(struct usb_hcd *hcd, u8 port)
-{
-	unsigned long timeout = jiffies + msecs_to_jiffies(1000);
-	unsigned reg = 0;
-
-	reg = ULPI_FUNC_CTRL_RESET
-		/* FUNCTION_CTRL_SET register */
-		| (ULPI_SET(ULPI_FUNC_CTRL) << EHCI_INSNREG05_ULPI_REGADD_SHIFT)
-		/* Write */
-		| (2 << EHCI_INSNREG05_ULPI_OPSEL_SHIFT)
-		/* PORTn */
-		| ((port + 1) << EHCI_INSNREG05_ULPI_PORTSEL_SHIFT)
-		/* start ULPI access*/
-		| (1 << EHCI_INSNREG05_ULPI_CONTROL_SHIFT);
-
-	ehci_write(hcd->regs, EHCI_INSNREG05_ULPI, reg);
-
-	/* Wait for ULPI access completion */
-	while ((ehci_read(hcd->regs, EHCI_INSNREG05_ULPI)
-			& (1 << EHCI_INSNREG05_ULPI_CONTROL_SHIFT))) {
-		cpu_relax();
-
-		if (time_after(jiffies, timeout)) {
-			dev_dbg(hcd->self.controller,
-					"phy reset operation timed out\n");
-			break;
-		}
-	}
-}
-
 static int omap_ehci_init(struct usb_hcd *hcd)
 {
 	struct ehci_hcd		*ehci = hcd_to_ehci(hcd);
-	int			rc;
-	struct usbhs_omap_platform_data	*pdata;
+	struct omap_ehci_hcd	*omap_hcd;
+	int			rc, i;
 
-	pdata = hcd->self.controller->platform_data;
+	omap_hcd = dev_get_drvdata(hcd->self.controller);
 
 	/* Hold PHYs in reset while initializing EHCI controller */
-	if (pdata->phy_reset) {
-		if (gpio_is_valid(pdata->reset_gpio_port[0]))
-			gpio_set_value_cansleep(pdata->reset_gpio_port[0], 0);
-
-		if (gpio_is_valid(pdata->reset_gpio_port[1]))
-			gpio_set_value_cansleep(pdata->reset_gpio_port[1], 0);
-
-		/* Hold the PHY in RESET for enough time till DIR is high */
-		udelay(10);
+	for (i = 0; i < omap_hcd->nports; i++) {
+		if (omap_hcd->phy[i])
+			usb_phy_shutdown(omap_hcd->phy[i]);
 	}
 
-	/* Soft reset the PHY using PHY reset command over ULPI */
-	if (pdata->port_mode[0] == OMAP_EHCI_PORT_MODE_PHY)
-		omap_ehci_soft_phy_reset(hcd, 0);
-	if (pdata->port_mode[1] == OMAP_EHCI_PORT_MODE_PHY)
-		omap_ehci_soft_phy_reset(hcd, 1);
-
 	/* we know this is the memory we want, no need to ioremap again */
 	ehci->caps = hcd->regs;
 
 	rc = ehci_setup(hcd);
 
-	if (pdata->phy_reset) {
-		/* Hold the PHY in RESET for enough time till
-		 * PHY is settled and ready
-		 */
-		udelay(10);
-
-		if (gpio_is_valid(pdata->reset_gpio_port[0]))
-			gpio_set_value_cansleep(pdata->reset_gpio_port[0], 1);
-
-		if (gpio_is_valid(pdata->reset_gpio_port[1]))
-			gpio_set_value_cansleep(pdata->reset_gpio_port[1], 1);
+	/* Bring PHYs out of reset */
+	for (i = 0; i < omap_hcd->nports; i++) {
+		if (omap_hcd->phy[i])
+			usb_phy_init(omap_hcd->phy[i]);
 	}
 
 	return rc;
-- 
1.7.4.1
