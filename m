From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Thu, 30 Aug 2018 21:01:14 +0200
Subject: [PATCH v4 07/13] ata: ahci_sunxi: Bypass PHY init when using the new
 binding
In-Reply-To: <20180830190120.722-1-clabbe.montjoie@gmail.com>
References: <20180830190120.722-1-clabbe.montjoie@gmail.com>
Message-ID: <20180830190120.722-8-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The new binding split sata in two (ahci + PHY).
ahci_sunxi must not mess with PHY when the new binding is in use.
So when we detect sub-nodes, bypass the PHY init code.
This is a temporarly workaround for the period where DT and ata code
will be merged from separate tree.
When both new binding and PHY driver will be merged, a new patch which
remove all PHY code from ahci_sunxi.c will be sent.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 drivers/ata/ahci_sunxi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/ata/ahci_sunxi.c b/drivers/ata/ahci_sunxi.c
index 631610b72aa5..a09d189c6dda 100644
--- a/drivers/ata/ahci_sunxi.c
+++ b/drivers/ata/ahci_sunxi.c
@@ -96,6 +96,15 @@ static int ahci_sunxi_phy_init(struct device *dev, void __iomem *reg_base)
 	u32 reg_val;
 	int timeout;
 
+	/*
+	 * When using the new binding, the presence of a sata port node
+	 * means that PHY is handled by the PHY driver.
+	 * */
+	if (of_get_child_count(dev->of_node)) {
+		dev_info(dev, "Bypassing PHY init\n");
+		return 0;
+	}
+
 	/* This magic is from the original code */
 	writel(0, reg_base + AHCI_RWCR);
 	msleep(5);
-- 
2.16.4
