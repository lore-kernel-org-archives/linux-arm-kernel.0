From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 11 Jul 2014 14:16:10 +0200
Subject: [PATCH 11/12] soc/tegra: fuse: Set up in early initcall
In-Reply-To: <1405080971-7609-1-git-send-email-thierry.reding@gmail.com>
References: <1405080971-7609-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1405080971-7609-12-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Rather than rely on explicit initialization order called from SoC setup
code, use a plain initcall and rely on initcall ordering to take care of
dependencies.

This driver exposes some functionality (querying the chip ID) needed at
very early stages of the boot process. An early initcall is good enough
provided that some of the dependencies are deferred to later stages. To
make sure any abuses are easily caught, output a warning message if the
chip ID is queried while it can't be read yet.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm/mach-tegra/tegra.c            | 1 -
 drivers/soc/tegra/fuse/fuse-tegra.c    | 7 +++++--
 drivers/soc/tegra/fuse/tegra-apbmisc.c | 7 +++++--
 include/linux/tegra-soc.h              | 1 -
 4 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
index b7d57027ae67..f05c4a648370 100644
--- a/arch/arm/mach-tegra/tegra.c
+++ b/arch/arm/mach-tegra/tegra.c
@@ -72,7 +72,6 @@ u32 tegra_uart_config[3] = {
 static void __init tegra_init_early(void)
 {
 	of_register_trusted_foundations();
-	tegra_init_fuse();
 	tegra_cpu_reset_handler_init();
 	tegra_powergate_init();
 }
diff --git a/drivers/soc/tegra/fuse/fuse-tegra.c b/drivers/soc/tegra/fuse/fuse-tegra.c
index 6a6dac1754b1..7cf83ddb7643 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra.c
@@ -124,7 +124,7 @@ int tegra_fuse_create_sysfs(struct device *dev, int size,
 	return device_create_bin_file(dev, &fuse_bin_attr);
 }
 
-void __init tegra_init_fuse(void)
+static int __init tegra_init_fuse(void)
 {
 	struct device_node *np;
 	void __iomem *car_base;
@@ -138,7 +138,7 @@ void __init tegra_init_fuse(void)
 		iounmap(car_base);
 	} else {
 		pr_err("Could not enable fuse clk. ioremap tegra car failed.\n");
-		return;
+		return -ENXIO;
 	}
 
 	if (tegra_get_chip_id() == TEGRA20)
@@ -152,4 +152,7 @@ void __init tegra_init_fuse(void)
 		tegra_sku_info.core_process_id);
 	pr_debug("Tegra CPU Speedo ID %d, Soc Speedo ID %d\n",
 		tegra_sku_info.cpu_speedo_id, tegra_sku_info.soc_speedo_id);
+
+	return 0;
 }
+early_initcall(tegra_init_fuse);
diff --git a/drivers/soc/tegra/fuse/tegra-apbmisc.c b/drivers/soc/tegra/fuse/tegra-apbmisc.c
index d51d8159a3f8..30126e6ac68e 100644
--- a/drivers/soc/tegra/fuse/tegra-apbmisc.c
+++ b/drivers/soc/tegra/fuse/tegra-apbmisc.c
@@ -37,9 +37,12 @@ u32 tegra_read_chipid(void)
 
 u8 tegra_get_chip_id(void)
 {
-	u32 id = tegra_read_chipid();
+	if (!apbmisc_base) {
+		WARN(1, "Tegra Chip ID not yet available\n");
+		return 0;
+	}
 
-	return (id >> 8) & 0xff;
+	return (tegra_read_chipid() >> 8) & 0xff;
 }
 
 u32 tegra_read_straps(void)
diff --git a/include/linux/tegra-soc.h b/include/linux/tegra-soc.h
index 7e8a33a88545..f50416851fa9 100644
--- a/include/linux/tegra-soc.h
+++ b/include/linux/tegra-soc.h
@@ -56,7 +56,6 @@ struct tegra_sku_info {
 
 u32 tegra_read_straps(void);
 u32 tegra_read_chipid(void);
-void tegra_init_fuse(void);
 int tegra_fuse_readl(unsigned long offset, u32 *value);
 
 extern struct tegra_sku_info tegra_sku_info;
-- 
2.0.1
