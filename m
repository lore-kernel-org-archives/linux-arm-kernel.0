From: arun.parameswaran@broadcom.com (Arun Parameswaran)
Date: Fri, 27 Jul 2018 14:23:30 -0700
Subject: [PATCH v2 4/7] net: phy: Disable external master access in bcm mdio
 mux driver
In-Reply-To: <1532726613-6483-1-git-send-email-arun.parameswaran@broadcom.com>
References: <1532726613-6483-1-git-send-email-arun.parameswaran@broadcom.com>
Message-ID: <1532726613-6483-5-git-send-email-arun.parameswaran@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Configure the scan control register in the Broadcom iProc
mdio mux driver to disable access to external master.

In some SoC's, the scan control register defaults to an incorrect
value.

Signed-off-by: Arun Parameswaran <arun.parameswaran@broadcom.com>
---
 drivers/net/phy/mdio-mux-bcm-iproc.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/phy/mdio-mux-bcm-iproc.c b/drivers/net/phy/mdio-mux-bcm-iproc.c
index 48bb74a..c36ce4b 100644
--- a/drivers/net/phy/mdio-mux-bcm-iproc.c
+++ b/drivers/net/phy/mdio-mux-bcm-iproc.c
@@ -22,6 +22,9 @@
 #include <linux/mdio-mux.h>
 #include <linux/delay.h>
 
+#define MDIO_SCAN_CTRL_OFFSET		0x008
+#define MDIO_SCAN_CTRL_OVRIDE_EXT_MSTR	28
+
 #define MDIO_PARAM_OFFSET		0x23c
 #define MDIO_PARAM_MIIM_CYCLE		29
 #define MDIO_PARAM_INTERNAL_SEL		25
@@ -53,6 +56,16 @@ struct iproc_mdiomux_desc {
 	struct mii_bus *mii_bus;
 };
 
+static void mdio_mux_iproc_config(struct iproc_mdiomux_desc *md)
+{
+	u32 val;
+
+	/* Disable external mdio master access */
+	val = readl(md->base + MDIO_SCAN_CTRL_OFFSET);
+	val |= BIT(MDIO_SCAN_CTRL_OVRIDE_EXT_MSTR);
+	writel(val, md->base + MDIO_SCAN_CTRL_OFFSET);
+}
+
 static int iproc_mdio_wait_for_idle(void __iomem *base, bool result)
 {
 	unsigned int timeout = 1000; /* loop for 1s */
@@ -216,6 +229,8 @@ static int mdio_mux_iproc_probe(struct platform_device *pdev)
 		goto out_register;
 	}
 
+	mdio_mux_iproc_config(md);
+
 	dev_info(md->dev, "iProc mdiomux registered\n");
 	return 0;
 
-- 
1.9.1
