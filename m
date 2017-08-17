From: david.wu@rock-chips.com (David Wu)
Date: Thu, 17 Aug 2017 18:37:46 +0800
Subject: [PATCH] PM / AVS: rockchip-io: add io selectors and supplies for
 rv1108
Message-ID: <1502966266-15215-1-git-send-email-david.wu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the necessary data for handling io voltage domains on the rv1108.

Signed-off-by: David Wu <david.wu@rock-chips.com>
---
 .../bindings/power/rockchip-io-domain.txt          |  2 ++
 drivers/power/avs/rockchip-io-domain.c             | 38 ++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/rockchip-io-domain.txt b/Documentation/devicetree/bindings/power/rockchip-io-domain.txt
index 43c21fb..d9d96fd 100644
--- a/Documentation/devicetree/bindings/power/rockchip-io-domain.txt
+++ b/Documentation/devicetree/bindings/power/rockchip-io-domain.txt
@@ -31,6 +31,8 @@ SoC is on the same page.
 
 Required properties:
 - compatible: should be one of:
+  - "rockchip,rv1108-io-voltage-domain" for rv1108
+  - "rockchip,rv1108-pmu-io-voltage-domain" for rv1108 pmu-domains
   - "rockchip,rk3188-io-voltage-domain" for rk3188
   - "rockchip,rk3228-io-voltage-domain" for rk3228
   - "rockchip,rk3288-io-voltage-domain" for rk3288
diff --git a/drivers/power/avs/rockchip-io-domain.c b/drivers/power/avs/rockchip-io-domain.c
index 031a343..a55205eb 100644
--- a/drivers/power/avs/rockchip-io-domain.c
+++ b/drivers/power/avs/rockchip-io-domain.c
@@ -227,6 +227,36 @@ static void rk3399_pmu_iodomain_init(struct rockchip_iodomain *iod)
 		dev_warn(iod->dev, "couldn't update pmu io iodomain ctrl\n");
 }
 
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
 /*
  * On the rk3188 the io-domains are handled by a shared register with the
  * lower 8 bits being still being continuing drive-strength settings.
@@ -351,6 +381,14 @@ static void rk3399_pmu_iodomain_init(struct rockchip_iodomain *iod)
 
 static const struct of_device_id rockchip_iodomain_match[] = {
 	{
+		.compatible = "rockchip,rv1108-io-voltage-domain",
+		.data = (void *)&soc_data_rv1108
+	},
+	{
+		.compatible = "rockchip,rv1108-pmu-io-voltage-domain",
+		.data = (void *)&soc_data_rv1108_pmu
+	},
+	{
 		.compatible = "rockchip,rk3188-io-voltage-domain",
 		.data = (void *)&soc_data_rk3188
 	},
-- 
1.9.1
