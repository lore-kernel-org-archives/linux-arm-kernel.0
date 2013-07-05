From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Fri, 5 Jul 2013 13:44:37 +0300
Subject: [PATCH v2 02/22] ARM: tegra: Populate AHB/IOMMU earlier than others
In-Reply-To: <1373021097-32420-1-git-send-email-hdoyu@nvidia.com>
References: <1373021097-32420-1-git-send-email-hdoyu@nvidia.com>
Message-ID: <1373021097-32420-3-git-send-email-hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Populate AHB/IOMMU earlier than others. IOMMU depends on AHB. IOMMU
needs to be instanciated earlier than others so that IOMMU can
register other platform devices as IOMMU'able. Once IOMMU is
populated, IOMMU/AHB nodes are detached to prevent another
registeration.

Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
---
 arch/arm/mach-tegra/tegra.c |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
index 0d1e412..fe432d1 100644
--- a/arch/arm/mach-tegra/tegra.c
+++ b/arch/arm/mach-tegra/tegra.c
@@ -80,6 +80,26 @@ static struct of_dev_auxdata tegra20_auxdata_lookup[] __initdata = {
 	{}
 };
 
+static void tegra_of_platform_populate_iommu(void)
+{
+	int i;
+	struct platform_device *pdev;
+	const char * const path[] = {"/ahb", "/iommu", };
+
+	for (i = 0; i < ARRAY_SIZE(path); i++) {
+		struct device_node *np;
+
+		np  = of_find_node_by_path(path[i]);
+		if (!np)
+			break;
+
+		pdev = of_platform_device_create(np, NULL, NULL);
+		of_node_put(np);
+		if (!pdev)
+			break;
+	}
+}
+
 static void __init tegra_dt_init(void)
 {
 	struct soc_device_attribute *soc_dev_attr;
@@ -107,6 +127,8 @@ static void __init tegra_dt_init(void)
 
 	parent = soc_device_to_device(soc_dev);
 
+	tegra_of_platform_populate_iommu();
+
 	/*
 	 * Finished with the static registrations now; fill in the missing
 	 * devices
-- 
1.7.9.5
