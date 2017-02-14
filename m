From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 14 Feb 2017 18:01:43 +0100
Subject: [PATCH v6 03/14] mmc: core: Add mmc-card dt sub-node parse in core
 layer
In-Reply-To: <cover.ff78bebe0384f650a51e5e6f0f1dca6e7894b53b.1487091464.git-series.gregory.clement@free-electrons.com>
References: <cover.ff78bebe0384f650a51e5e6f0f1dca6e7894b53b.1487091464.git-series.gregory.clement@free-electrons.com>
Message-ID: <34e51d32c82b57571e061e80df3bbaed731db554.1487091464.git-series.gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hu Ziji <huziji@marvell.com>

Some vendor host, like Xenon, can support multiple types.
In dts, use mmc-card dt sub-node to indicate eMMC is in use.

Add a generic mmc-card parse function in mmc core layer.
If mmc-card sub-node is detected, set eMMC common caps, such as
MMC_CAP_NONREMOVABLE, MMC_CAP2_NO_SD and MMC_CAP2_NO_SDIO.

Since it is likely that struct mmc_card is not allocated yet when
this mmc-card parse function is called, it will return true if
mmc-card sub-node is detected. Otherwise, return false.
It can help vendor host determine if the card type is eMMC.

Signed-off-by: Hu Ziji <huziji@marvell.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/mmc/core/mmc.c   | 24 ++++++++++++++++++++++++
 include/linux/mmc/core.h |  2 ++
 2 files changed, 26 insertions(+)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index b61b52f9da3d..dc480006a303 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -2111,6 +2111,30 @@ static const struct mmc_bus_ops mmc_ops = {
 };
 
 /*
+ * Parse mmc-card dt sub-node and set eMMC common caps
+ * if mmc-card exists.
+ * If mmc-card is detected, return true.
+ * Otherwise, return false.
+ */
+bool mmc_of_parse_mmc_card(struct mmc_host *host)
+{
+	struct device_node *np;
+	bool ret = false;
+
+	np = mmc_of_find_child_device(host, 0);
+	if (np && of_device_is_compatible(np, "mmc-card")) {
+		/* mmc-card sub-node indicates eMMC card is in use. */
+		host->caps |= MMC_CAP_NONREMOVABLE;
+		host->caps2 |= MMC_CAP2_NO_SDIO | MMC_CAP2_NO_SD;
+		ret = true;
+	}
+
+	of_node_put(np);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mmc_of_parse_mmc_card);
+
+/*
  * Starting point for MMC card init.
  */
 int mmc_attach_mmc(struct mmc_host *host)
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index e33cc748dcfe..1b27323f3b6e 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -234,4 +234,6 @@ struct device_node;
 extern u32 mmc_vddrange_to_ocrmask(int vdd_min, int vdd_max);
 extern int mmc_of_parse_voltage(struct device_node *np, u32 *mask);
 
+extern bool mmc_of_parse_mmc_card(struct mmc_host *host);
+
 #endif /* LINUX_MMC_CORE_H */
-- 
git-series 0.9.1
