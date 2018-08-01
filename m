From: arun.parameswaran@broadcom.com (Arun Parameswaran)
Date: Wed,  1 Aug 2018 10:56:25 -0700
Subject: [PATCH v3 7/8] net: phy: Add support to configure clock in Broadcom
 iProc mdio mux
In-Reply-To: <1533146186-8374-1-git-send-email-arun.parameswaran@broadcom.com>
References: <1533146186-8374-1-git-send-email-arun.parameswaran@broadcom.com>
Message-ID: <1533146186-8374-8-git-send-email-arun.parameswaran@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support to configure the internal rate adjust register based on the
core clock supplied through device tree in the Broadcom iProc mdio mux.

The operating frequency of the mdio mux block is 11MHz. This is derrived
by dividing the clock to the mdio mux with the rate adjust register.

In some SoC's the default values of the rate adjust register do not yield
11MHz. These SoC's are required to specify the clock via the device tree
for proper operation.

Signed-off-by: Arun Parameswaran <arun.parameswaran@broadcom.com>
---
 drivers/net/phy/mdio-mux-bcm-iproc.c | 42 ++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/mdio-mux-bcm-iproc.c b/drivers/net/phy/mdio-mux-bcm-iproc.c
index 5640d78..5127010 100644
--- a/drivers/net/phy/mdio-mux-bcm-iproc.c
+++ b/drivers/net/phy/mdio-mux-bcm-iproc.c
@@ -13,7 +13,7 @@
  * You should have received a copy of the GNU General Public License
  * version 2 (GPLv2) along with this source code.
  */
-
+#include <linux/clk.h>
 #include <linux/platform_device.h>
 #include <linux/device.h>
 #include <linux/of_mdio.h>
@@ -22,6 +22,10 @@
 #include <linux/mdio-mux.h>
 #include <linux/delay.h>
 
+#define MDIO_RATE_ADJ_EXT_OFFSET	0x000
+#define MDIO_RATE_ADJ_INT_OFFSET	0x004
+#define MDIO_RATE_ADJ_DIVIDENT_SHIFT	16
+
 #define MDIO_SCAN_CTRL_OFFSET		0x008
 #define MDIO_SCAN_CTRL_OVRIDE_EXT_MSTR	28
 
@@ -49,21 +53,38 @@
 
 #define MDIO_REG_ADDR_SPACE_SIZE	0x250
 
+#define MDIO_OPERATING_FREQUENCY	11000000
+#define MDIO_RATE_ADJ_DIVIDENT		1
+
 struct iproc_mdiomux_desc {
 	void *mux_handle;
 	void __iomem *base;
 	struct device *dev;
 	struct mii_bus *mii_bus;
+	struct clk *core_clk;
 };
 
 static void mdio_mux_iproc_config(struct iproc_mdiomux_desc *md)
 {
+	u32 divisor;
 	u32 val;
 
 	/* Disable external mdio master access */
 	val = readl(md->base + MDIO_SCAN_CTRL_OFFSET);
 	val |= BIT(MDIO_SCAN_CTRL_OVRIDE_EXT_MSTR);
 	writel(val, md->base + MDIO_SCAN_CTRL_OFFSET);
+
+	if (md->core_clk) {
+		/* use rate adjust regs to derrive the mdio's operating
+		 * frequency from the specified core clock
+		 */
+		divisor = clk_get_rate(md->core_clk) / MDIO_OPERATING_FREQUENCY;
+		divisor = divisor / (MDIO_RATE_ADJ_DIVIDENT + 1);
+		val = divisor;
+		val |= MDIO_RATE_ADJ_DIVIDENT << MDIO_RATE_ADJ_DIVIDENT_SHIFT;
+		writel(val, md->base + MDIO_RATE_ADJ_EXT_OFFSET);
+		writel(val, md->base + MDIO_RATE_ADJ_INT_OFFSET);
+	}
 }
 
 static int iproc_mdio_wait_for_idle(void __iomem *base, bool result)
@@ -204,6 +225,20 @@ static int mdio_mux_iproc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	md->core_clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(md->core_clk)) {
+		if (PTR_ERR(md->core_clk) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+
+		md->core_clk = NULL;
+	} else {
+		rc = clk_prepare_enable(md->core_clk);
+		if (rc) {
+			dev_err(&pdev->dev, "failed to enable core clk\n");
+			return rc;
+		}
+	}
+
 	bus = md->mii_bus;
 	bus->priv = md;
 	bus->name = "iProc MDIO mux bus";
@@ -217,7 +252,7 @@ static int mdio_mux_iproc_probe(struct platform_device *pdev)
 	rc = mdiobus_register(bus);
 	if (rc) {
 		dev_err(&pdev->dev, "mdiomux registration failed\n");
-		return rc;
+		goto out_clk;
 	}
 
 	platform_set_drvdata(pdev, md);
@@ -237,6 +272,8 @@ static int mdio_mux_iproc_probe(struct platform_device *pdev)
 
 out_register:
 	mdiobus_unregister(bus);
+out_clk:
+	clk_disable_unprepare(md->core_clk);
 	return rc;
 }
 
@@ -246,6 +283,7 @@ static int mdio_mux_iproc_remove(struct platform_device *pdev)
 
 	mdio_mux_uninit(md->mux_handle);
 	mdiobus_unregister(md->mii_bus);
+	clk_disable_unprepare(md->core_clk);
 	platform_set_drvdata(pdev, NULL);
 
 	return 0;
-- 
1.9.1
