From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 23 Aug 2017 11:25:08 +0200
Subject: [PATCH 1/2] soc/tegra: Restrict SoC device registration to Tegra
Message-ID: <20170823092509.5243-1-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Commit 8a46828e623c ("soc/tegra: Register SoC device") added an initcall
to register the SoC device on Tegra. However, that code is unrestricted
and will run on all platforms, causing unwanted warnings.

Fix this by first checking that we're running on hardware that supports
the fuses block that we use to provide SoC information.

Fixes: 8a46828e623c ("soc/tegra: Register SoC device")
Reported-by: Sudeep Holla <sudeep.holla@arm.com>
Tested-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/soc/tegra/fuse/fuse-tegra.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/soc/tegra/fuse/fuse-tegra.c b/drivers/soc/tegra/fuse/fuse-tegra.c
index e4f78de8f95f..be003d04383f 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra.c
@@ -346,8 +346,16 @@ early_initcall(tegra_init_fuse);
 #ifdef CONFIG_ARM64
 static int __init tegra_init_soc(void)
 {
+	struct device_node *np;
 	struct device *soc;
 
+	/* make sure we're running on Tegra */
+	np = of_find_matching_node(NULL, tegra_fuse_match);
+	if (!np)
+		return 0;
+
+	of_node_put(np);
+
 	soc = tegra_soc_device_register();
 	if (IS_ERR(soc)) {
 		pr_err("failed to register SoC device: %ld\n", PTR_ERR(soc));
-- 
2.13.3
