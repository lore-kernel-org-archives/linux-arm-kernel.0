From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 22 Nov 2011 18:21:18 -0700
Subject: [PATCH 10/17] ASoC: Tegra DAS: Add device tree binding
In-Reply-To: <1322011285-4002-1-git-send-email-swarren@nvidia.com>
References: <1322011285-4002-1-git-send-email-swarren@nvidia.com>
Message-ID: <1322011285-4002-11-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 .../devicetree/bindings/sound/tegra20-das.txt      |   12 ++++++++++++
 sound/soc/tegra/tegra_das.c                        |    8 ++++++++
 2 files changed, 20 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/tegra20-das.txt

diff --git a/Documentation/devicetree/bindings/sound/tegra20-das.txt b/Documentation/devicetree/bindings/sound/tegra20-das.txt
new file mode 100644
index 0000000..6de3a7e
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/tegra20-das.txt
@@ -0,0 +1,12 @@
+NVIDIA Tegra 20 DAS (Digital Audio Switch) controller
+
+Required properties:
+- compatible : "nvidia,tegra20-das"
+- reg : Should contain DAS registers location and length
+
+Example:
+
+das at 70000c00 {
+	compatible = "nvidia,tegra20-das";
+	reg = <0x70000c00 0x80>;
+};
diff --git a/sound/soc/tegra/tegra_das.c b/sound/soc/tegra/tegra_das.c
index fa3a442..5b82b4e 100644
--- a/sound/soc/tegra/tegra_das.c
+++ b/sound/soc/tegra/tegra_das.c
@@ -225,11 +225,18 @@ static int __devexit tegra_das_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id tegra_das_of_match[] __devinitconst = {
+	{ .compatible = "nvidia,tegra20-das", },
+	{},
+};
+
 static struct platform_driver tegra_das_driver = {
 	.probe = tegra_das_probe,
 	.remove = __devexit_p(tegra_das_remove),
 	.driver = {
 		.name = DRV_NAME,
+		.owner = THIS_MODULE,
+		.of_match_table = tegra_das_of_match,
 	},
 };
 module_platform_driver(tegra_das_driver);
@@ -238,3 +245,4 @@ MODULE_AUTHOR("Stephen Warren <swarren@nvidia.com>");
 MODULE_DESCRIPTION("Tegra DAS driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:" DRV_NAME);
+MODULE_DEVICE_TABLE(of, tegra_das_of_match);
-- 
1.7.0.4
