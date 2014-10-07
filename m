From: seraphin.bonnaffe@st.com (Seraphin Bonnaffe)
Date: Tue, 7 Oct 2014 15:22:28 +0200
Subject: [RFC PATCH 2/2] mfd: syscon: specify rd_table and wr_table from DT
In-Reply-To: <1412688148-20835-1-git-send-email-seraphin.bonnaffe@st.com>
References: <54244655.1090801@st.com>
 <1412688148-20835-1-git-send-email-seraphin.bonnaffe@st.com>
Message-ID: <1412688148-20835-3-git-send-email-seraphin.bonnaffe@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The syscon driver is based on regmap, which offers the possibility to
declare registers as readable/writable or not, thanks to rd_table and
wr_table.

This patch takes register map's holes description from DT, and fills in
the rd_table and wr_table of the corresponding syson instance accordingly.

Signed-off-by: Seraphin Bonnaffe <seraphin.bonnaffe@st.com>
---
 drivers/mfd/syscon.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index ca15878..2bfb45d 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -125,9 +125,15 @@ static int syscon_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct syscon_platform_data *pdata = dev_get_platdata(dev);
+	struct device_node *np = dev->of_node;
+	struct regmap_access_table *syscon_rw_table;
+	struct regmap_range *holes;
 	struct syscon *syscon;
 	struct resource *res;
 	void __iomem *base;
+	const __be32 *hole_prop;
+	u32 min, max, size;
+	u32 i, hlen, ngaps;
 
 	syscon = devm_kzalloc(dev, sizeof(*syscon), GFP_KERNEL);
 	if (!syscon)
@@ -141,6 +147,35 @@ static int syscon_probe(struct platform_device *pdev)
 	if (!base)
 		return -ENOMEM;
 
+	hole_prop = of_get_property(np, "holes", &hlen);
+	if (hole_prop) {
+		hlen /= sizeof(*hole_prop);
+		ngaps = hlen / 2;
+
+		holes =  devm_kzalloc(dev, ngaps * sizeof(*holes), GFP_KERNEL);
+		if (!holes)
+			return -ENOMEM;
+
+		for (i = 0; i < ngaps; i++) {
+			min = (u32)of_read_number(&hole_prop[i * 2], 1);
+			size = (u32)of_read_number(&hole_prop[i * 2 + 1], 1);
+			max = min + size - 1;
+
+			holes[i].range_min = min;
+			holes[i].range_max = max;
+		}
+		syscon_rw_table = devm_kzalloc(dev, sizeof(*syscon_rw_table),
+					       GFP_KERNEL);
+		if (!syscon_rw_table)
+			return -ENOMEM;
+
+		syscon_rw_table->no_ranges = holes;
+		syscon_rw_table->n_no_ranges = ngaps;
+
+		syscon_regmap_config.rd_table = syscon_rw_table;
+		syscon_regmap_config.wr_table = syscon_rw_table;
+	}
+
 	syscon_regmap_config.max_register = res->end - res->start - 3;
 	if (pdata)
 		syscon_regmap_config.name = pdata->label;
-- 
1.9.1
