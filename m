From: zumeng.chen@gmail.com (Zumeng Chen)
Date: Wed, 13 Jun 2012 09:44:09 +0800
Subject: [PATCH V2 4/5] ARM: OMAP3EVM: cosmetic fixes for parent clk set
In-Reply-To: <1339551850-20827-1-git-send-email-zumeng.chen@gmail.com>
References: <zumeng.chen@gmail.com>
 <1339551850-20827-1-git-send-email-zumeng.chen@gmail.com>
Message-ID: <1339551850-20827-5-git-send-email-zumeng.chen@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Zumeng Chen <zumeng.chen@windriver.com>

Since set parent for dummy clock will dump failed message,
so we can just ignore to mute it.

Signed-off-by: Signed-off-by: Jon Hunter <jon-hunter@ti.com>
Signed-off-by: Zumeng Chen <zumeng.chen@gmail.com>
---
 arch/arm/plat-omap/clock.c  |    4 ++++
 drivers/mfd/omap-usb-host.c |    2 +-
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index 62ec5c4..c7e26e4 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -149,6 +149,10 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
 	if (!arch_clock || !arch_clock->clk_set_parent)
 		return ret;
 
+	/* If the clock is a dummy clock just return */
+	if (clk == &dummy_ck)
+		return 0;
+
 	spin_lock_irqsave(&clockfw_lock, flags);
 	if (clk->usecount == 0) {
 		ret = arch_clock->clk_set_parent(clk, parent);
diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index 7e96bb2..c9d27c4 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -699,7 +699,7 @@ static int __devinit usbhs_omap_probe(struct platform_device *pdev)
 	}
 
 	if (is_ehci_phy_mode(pdata->port_mode[0])) {
-		/* for OMAP3 , the clk set paretn fails */
+		/* for OMAP3 , the clk set parent fails */
 		ret = clk_set_parent(omap->utmi_p1_fck,
 					omap->xclk60mhsp1_ck);
 		if (ret != 0)
-- 
1.7.5.4
