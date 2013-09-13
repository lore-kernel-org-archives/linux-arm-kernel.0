From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 13 Sep 2013 12:27:08 -0600
Subject: [PATCH] ARM: tegra: add fuses as device randomness
Message-ID: <1379096828-27644-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Various fuses on Tegra include information that's unique to an individual
chip, or a subset of chips. Call add_device_randomness() with this data
to perturb the initial state of the random pool.

Suggested-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/fuse.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm/mach-tegra/fuse.c b/arch/arm/mach-tegra/fuse.c
index fef1dc8..9a4e910 100644
--- a/arch/arm/mach-tegra/fuse.c
+++ b/arch/arm/mach-tegra/fuse.c
@@ -21,14 +21,26 @@
 #include <linux/kernel.h>
 #include <linux/io.h>
 #include <linux/export.h>
+#include <linux/random.h>
 #include <linux/tegra-soc.h>
 
 #include "fuse.h"
 #include "iomap.h"
 #include "apbio.h"
 
+/* Tegra20 only */
 #define FUSE_UID_LOW		0x108
 #define FUSE_UID_HIGH		0x10c
+
+/* Tegra30 and later */
+#define FUSE_VENDOR_CODE	0x200
+#define FUSE_FAB_CODE		0x204
+#define FUSE_LOT_CODE_0		0x208
+#define FUSE_LOT_CODE_1		0x20c
+#define FUSE_WAFER_ID		0x210
+#define FUSE_X_COORDINATE	0x214
+#define FUSE_Y_COORDINATE	0x218
+
 #define FUSE_SKU_INFO		0x110
 
 #define TEGRA20_FUSE_SPARE_BIT		0x200
@@ -112,21 +124,51 @@ u32 tegra_read_chipid(void)
 	return readl_relaxed(IO_ADDRESS(TEGRA_APB_MISC_BASE) + 0x804);
 }
 
+static void __init tegra20_fuse_init_randomness(void)
+{
+	u32 randomness[2];
+
+	randomness[0] = tegra_fuse_readl(FUSE_UID_LOW);
+	randomness[1] = tegra_fuse_readl(FUSE_UID_HIGH);
+
+	add_device_randomness(randomness, sizeof(randomness));
+}
+
+/* Applies to Tegra30 or later */
+static void __init tegra30_fuse_init_randomness(void)
+{
+	u32 randomness[7];
+
+	randomness[0] = tegra_fuse_readl(FUSE_VENDOR_CODE);
+	randomness[1] = tegra_fuse_readl(FUSE_FAB_CODE);
+	randomness[2] = tegra_fuse_readl(FUSE_LOT_CODE_0);
+	randomness[3] = tegra_fuse_readl(FUSE_LOT_CODE_1);
+	randomness[4] = tegra_fuse_readl(FUSE_WAFER_ID);
+	randomness[5] = tegra_fuse_readl(FUSE_X_COORDINATE);
+	randomness[6] = tegra_fuse_readl(FUSE_Y_COORDINATE);
+
+	add_device_randomness(randomness, sizeof(randomness));
+}
+
 void __init tegra_init_fuse(void)
 {
 	u32 id;
+	u32 randomness[5];
 
 	u32 reg = readl(IO_ADDRESS(TEGRA_CLK_RESET_BASE + 0x48));
 	reg |= 1 << 28;
 	writel(reg, IO_ADDRESS(TEGRA_CLK_RESET_BASE + 0x48));
 
 	reg = tegra_fuse_readl(FUSE_SKU_INFO);
+	randomness[0] = reg;
 	tegra_sku_id = reg & 0xFF;
 
 	reg = tegra_apb_readl(TEGRA_APB_MISC_BASE + STRAP_OPT);
+	randomness[1] = reg;
 	tegra_bct_strapping = (reg & RAM_ID_MASK) >> RAM_CODE_SHIFT;
 
 	id = tegra_read_chipid();
+	randomness[2] = id;
 	tegra_chip_id = (id >> 8) & 0xff;
 
 	switch (tegra_chip_id) {
@@ -149,6 +191,18 @@ void __init tegra_init_fuse(void)
 
 	tegra_revision = tegra_get_revision(id);
 	tegra_init_speedo_data();
+	randomness[3] = (tegra_cpu_process_id << 16) | tegra_core_process_id;
+	randomness[4] = (tegra_cpu_speedo_id << 16) | tegra_soc_speedo_id;
+
+	add_device_randomness(randomness, sizeof(randomness));
+	switch (tegra_chip_id) {
+	case TEGRA20:
+		tegra20_fuse_init_randomness();
+	case TEGRA30:
+	case TEGRA114:
+	default:
+		tegra30_fuse_init_randomness();
+	}
 
 	pr_info("Tegra Revision: %s SKU: %d CPU Process: %d Core Process: %d\n",
 		tegra_revision_name[tegra_revision],
-- 
1.8.1.5
