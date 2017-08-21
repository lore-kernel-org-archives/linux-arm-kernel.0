From: david.wu@rock-chips.com (David Wu)
Date: Mon, 21 Aug 2017 18:58:33 +0800
Subject: [PATCH v2] PM / AVS: rockchip-io: add io selectors and supplies for
 RV1108
Message-ID: <1503313113-31056-1-git-send-email-david.wu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the necessary data for handling io voltage domains on the RV1108.

Signed-off-by: David Wu <david.wu@rock-chips.com>
---
change in v2:
 - Alphabetic order for the binding string

 .../bindings/power/rockchip-io-domain.txt          |  2 ++
 drivers/power/avs/rockchip-io-domain.c             | 38 ++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/rockchip-io-domain.txt b/Documentation/devicetree/bindings/power/rockchip-io-domain.txt
index 43c21fb..4a4766e 100644
--- a/Documentation/devicetree/bindings/power/rockchip-io-domain.txt
+++ b/Documentation/devicetree/bindings/power/rockchip-io-domain.txt
@@ -39,6 +39,8 @@ Required properties:
   - "rockchip,rk3368-pmu-io-voltage-domain" for rk3368 pmu-domains
   - "rockchip,rk3399-io-voltage-domain" for rk3399
   - "rockchip,rk3399-pmu-io-voltage-domain" for rk3399 pmu-domains
+  - "rockchip,rv1108-io-voltage-domain" for rv1108
+  - "rockchip,rv1108-pmu-io-voltage-domain" for rv1108 pmu-domains
 
 Deprecated properties:
 - rockchip,grf: phandle to the syscon managing the "general register files"
diff --git a/drivers/power/avs/rockchip-io-domain.c b/drivers/power/avs/rockchip-io-domain.c
index 031a343..75f63e3 100644
--- a/drivers/power/avs/rockchip-io-domain.c
+++ b/drivers/power/avs/rockchip-io-domain.c
@@ -349,6 +349,36 @@ static void rk3399_pmu_iodomain_init(struct rockchip_iodomain *iod)
 	.init = rk3399_pmu_iodomain_init,
 };
 
+static const struct rockchip_iodomain_soc_data soc_data_rv1108 = {
+	.grf_offset = 0x404,
+	.supply_names = {
+		NULL,
+		NULL,
+		NULL,
+		NULL,
+		NULL,
+		NULL,
+		NULL,
+		NULL,
+		NULL,
+		NULL,
+		NULL,
+		"vccio1",
+		"vccio2",
+		"vccio3",
+		"vccio5",
+		"vccio6",
+	},
+
+};
+
+static const struct rockchip_iodomain_soc_data soc_data_rv1108_pmu = {
+	.grf_offset = 0x104,
+	.supply_names = {
+		"pmu",
+	},
+};
+
 static const struct of_device_id rockchip_iodomain_match[] = {
 	{
 		.compatible = "rockchip,rk3188-io-voltage-domain",
@@ -382,6 +412,14 @@ static void rk3399_pmu_iodomain_init(struct rockchip_iodomain *iod)
 		.compatible = "rockchip,rk3399-pmu-io-voltage-domain",
 		.data = (void *)&soc_data_rk3399_pmu
 	},
+	{
+		.compatible = "rockchip,rv1108-io-voltage-domain",
+		.data = (void *)&soc_data_rv1108
+	},
+	{
+		.compatible = "rockchip,rv1108-pmu-io-voltage-domain",
+		.data = (void *)&soc_data_rv1108_pmu
+	},
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, rockchip_iodomain_match);
-- 
1.9.1
