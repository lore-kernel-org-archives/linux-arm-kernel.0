From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Fri, 5 Jul 2013 13:44:44 +0300
Subject: [PATCH v2 09/22] amba: Move AHB to core_initcall
In-Reply-To: <1373021097-32420-1-git-send-email-hdoyu@nvidia.com>
References: <1373021097-32420-1-git-send-email-hdoyu@nvidia.com>
Message-ID: <1373021097-32420-10-git-send-email-hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move AHB to core_initcall in order to instanciate this device earlier
than others since IOMMU depends on AHB and then IOMMU driver needs to
reigster other platform devices as IOMMU'able.

Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
---
 drivers/amba/tegra-ahb.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/amba/tegra-ahb.c b/drivers/amba/tegra-ahb.c
index 1f44e56..08e898d 100644
--- a/drivers/amba/tegra-ahb.c
+++ b/drivers/amba/tegra-ahb.c
@@ -283,7 +283,12 @@ static struct platform_driver tegra_ahb_driver = {
 		.pm = &tegra_ahb_pm,
 	},
 };
-module_platform_driver(tegra_ahb_driver);
+
+static int tegra_ahb_init(void)
+{
+	return platform_driver_register(&tegra_ahb_driver);
+}
+core_initcall(tegra_ahb_init);
 
 MODULE_AUTHOR("Hiroshi DOYU <hdoyu@nvidia.com>");
 MODULE_DESCRIPTION("Tegra AHB driver");
-- 
1.7.9.5
