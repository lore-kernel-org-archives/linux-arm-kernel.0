From: chanho61.park@samsung.com (Chanho Park)
Date: Tue, 13 Aug 2013 14:12:56 +0900
Subject: [PATCHv3 1/4] drm/exynos: add device tree support for rotator
In-Reply-To: <1376370779-26930-1-git-send-email-chanho61.park@samsung.com>
References: <1376370779-26930-1-git-send-email-chanho61.park@samsung.com>
Message-ID: <1376370779-26930-2-git-send-email-chanho61.park@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The exynos4 platform is only dt-based since 3.10, we should convert driver data
and ids to dt-based parsing methods. The rotator driver has a limit table to get
size limit of input picture. Each SoCs has slightly different limit value
compared with any others.
For example, exynos4210's max_size of RGB888 is 16k x 16k. But, others have
8k x 8k. Another example the exynos5250 should have multiple of 2 pixel size
for its X/Y axis. Thus, we should keep different tables for each of them.
This patch also includes desciptions of each nodes for the rotator and specifies
a example how to bind it.

Signed-off-by: Chanho Park <chanho61.park@samsung.com>
Cc: Inki Dae <inki.dae@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 .../devicetree/bindings/gpu/samsung-rotator.txt    |   27 +++++
 drivers/gpu/drm/exynos/exynos_drm_rotator.c        |  108 +++++++++++++++-----
 2 files changed, 107 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpu/samsung-rotator.txt

diff --git a/Documentation/devicetree/bindings/gpu/samsung-rotator.txt b/Documentation/devicetree/bindings/gpu/samsung-rotator.txt
new file mode 100644
index 0000000..82cd1ed
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpu/samsung-rotator.txt
@@ -0,0 +1,27 @@
+* Samsung Image Rotator
+
+Required properties:
+  - compatible : value should be one of the following:
+	(a) "samsung,exynos4210-rotator" for Rotator IP in Exynos4210
+	(b) "samsung,exynos4212-rotator" for Rotator IP in Exynos4212/4412
+	(c) "samsung,exynos5250-rotator" for Rotator IP in Exynos5250
+
+  - reg : Physical base address of the IP registers and length of memory
+	  mapped region.
+
+  - interrupts : Interrupt specifier for rotator interrupt, according to format
+		 specific to interrupt parent.
+
+  - clocks : Clock specifier for rotator clock, according to generic clock
+	     bindings. (See Documentation/devicetree/bindings/clock/exynos*.txt)
+
+  - clock-names : Names of clocks. For exynos rotator, it should be "rotator".
+
+Example:
+	rotator at 12810000 {
+		compatible = "samsung,exynos4210-rotator";
+		reg = <0x12810000 0x1000>;
+		interrupts = <0 83 0>;
+		clocks = <&clock 278>;
+		clock-names = "rotator";
+	};
diff --git a/drivers/gpu/drm/exynos/exynos_drm_rotator.c b/drivers/gpu/drm/exynos/exynos_drm_rotator.c
index 427640a..0485aea5 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_rotator.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_rotator.c
@@ -632,21 +632,98 @@ static int rotator_ippdrv_start(struct device *dev, enum drm_exynos_ipp_cmd cmd)
 	return 0;
 }
 
+static struct rot_limit_table rot_limit_tbl_4210 = {
+	.ycbcr420_2p = {
+		.min_w = 32,
+		.min_h = 32,
+		.max_w = SZ_64K,
+		.max_h = SZ_64K,
+		.align = 3,
+	},
+	.rgb888 = {
+		.min_w = 8,
+		.min_h = 8,
+		.max_w = SZ_16K,
+		.max_h = SZ_16K,
+		.align = 2,
+	},
+};
+
+static struct rot_limit_table rot_limit_tbl_4x12 = {
+	.ycbcr420_2p = {
+		.min_w = 32,
+		.min_h = 32,
+		.max_w = SZ_32K,
+		.max_h = SZ_32K,
+		.align = 3,
+	},
+	.rgb888 = {
+		.min_w = 8,
+		.min_h = 8,
+		.max_w = SZ_8K,
+		.max_h = SZ_8K,
+		.align = 2,
+	},
+};
+
+static struct rot_limit_table rot_limit_tbl_5250 = {
+	.ycbcr420_2p = {
+		.min_w = 32,
+		.min_h = 32,
+		.max_w = SZ_32K,
+		.max_h = SZ_32K,
+		.align = 3,
+	},
+	.rgb888 = {
+		.min_w = 8,
+		.min_h = 8,
+		.max_w = SZ_8K,
+		.max_h = SZ_8K,
+		.align = 1,
+	},
+};
+
+static const struct of_device_id exynos_rotator_match[] = {
+	{
+		.compatible = "samsung,exynos4210-rotator",
+		.data = &rot_limit_tbl_4210,
+	},
+	{
+		.compatible = "samsung,exynos4212-rotator",
+		.data = &rot_limit_tbl_4x12,
+	},
+	{
+		.compatible = "samsung,exynos5250-rotator",
+		.data = &rot_limit_tbl_5250,
+	},
+	{},
+};
+
 static int rotator_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct rot_context *rot;
 	struct exynos_drm_ippdrv *ippdrv;
+	const struct of_device_id *match;
 	int ret;
 
+	if (!dev->of_node) {
+		dev_err(dev, "cannot find of_node.\n");
+		return -ENODEV;
+	}
+
 	rot = devm_kzalloc(dev, sizeof(*rot), GFP_KERNEL);
 	if (!rot) {
 		dev_err(dev, "failed to allocate rot\n");
 		return -ENOMEM;
 	}
 
-	rot->limit_tbl = (struct rot_limit_table *)
-				platform_get_device_id(pdev)->driver_data;
+	match = of_match_node(exynos_rotator_match, dev->of_node);
+	if (!match) {
+		dev_err(dev, "failed to match node\n");
+		return -ENODEV;
+	}
+	rot->limit_tbl = (struct rot_limit_table *)match->data;
 
 	rot->regs_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	rot->regs = devm_ioremap_resource(dev, rot->regs_res);
@@ -718,31 +795,6 @@ static int rotator_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct rot_limit_table rot_limit_tbl = {
-	.ycbcr420_2p = {
-		.min_w = 32,
-		.min_h = 32,
-		.max_w = SZ_32K,
-		.max_h = SZ_32K,
-		.align = 3,
-	},
-	.rgb888 = {
-		.min_w = 8,
-		.min_h = 8,
-		.max_w = SZ_8K,
-		.max_h = SZ_8K,
-		.align = 2,
-	},
-};
-
-static struct platform_device_id rotator_driver_ids[] = {
-	{
-		.name		= "exynos-rot",
-		.driver_data	= (unsigned long)&rot_limit_tbl,
-	},
-	{},
-};
-
 static int rotator_clk_crtl(struct rot_context *rot, bool enable)
 {
 	if (enable) {
@@ -804,10 +856,10 @@ static const struct dev_pm_ops rotator_pm_ops = {
 struct platform_driver rotator_driver = {
 	.probe		= rotator_probe,
 	.remove		= rotator_remove,
-	.id_table	= rotator_driver_ids,
 	.driver		= {
 		.name	= "exynos-rot",
 		.owner	= THIS_MODULE,
 		.pm	= &rotator_pm_ops,
+		.of_match_table = exynos_rotator_match,
 	},
 };
-- 
1.7.9.5
