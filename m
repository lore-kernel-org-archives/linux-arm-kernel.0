From: olof@lixom.net (Olof Johansson)
Date: Wed,  4 Jan 2012 21:50:41 -0800
Subject: [PATCH v2] arm/tegra: fuse: add functions to access chip revision
In-Reply-To: <1324599468-12845-5-git-send-email-olof@lixom.net>
References: <1324599468-12845-5-git-send-email-olof@lixom.net>
Message-ID: <1325742641-384-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add function to get chip revision, and print it out at boot time.

Restructure the fuse access to just use cached variables instead
of always reading the fuses, and export those variables directly
instead of using accessor functions.

Add a SKU ID table of currently known values.

Based on code originally by Colin Cross <ccross@android.com>.

Changes since v1:

* Add A01 minor rev support
* Don't decode for A03p on anything but T2x

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/mach-tegra/fuse.c          |   85 ++++++++++++++++++++++++-----------
 arch/arm/mach-tegra/fuse.h          |   32 +++++++++++--
 arch/arm/mach-tegra/tegra2_clocks.c |    2 +-
 3 files changed, 86 insertions(+), 33 deletions(-)

diff --git a/arch/arm/mach-tegra/fuse.c b/arch/arm/mach-tegra/fuse.c
index daf3f57..b1895c5 100644
--- a/arch/arm/mach-tegra/fuse.c
+++ b/arch/arm/mach-tegra/fuse.c
@@ -30,20 +30,75 @@
 #define FUSE_SKU_INFO		0x110
 #define FUSE_SPARE_BIT		0x200
 
+int tegra_sku_id;
+int tegra_cpu_process_id;
+int tegra_core_process_id;
+enum tegra_revision tegra_revision;
+
+static const char *tegra_revision_name[TEGRA_REVISION_MAX] = {
+	[TEGRA_REVISION_UNKNOWN] = "unknown",
+	[TEGRA_REVISION_A01]     = "A01",
+	[TEGRA_REVISION_A02]     = "A02",
+	[TEGRA_REVISION_A03]     = "A03",
+	[TEGRA_REVISION_A03p]    = "A03 prime",
+	[TEGRA_REVISION_A04]     = "A04",
+};
+
 static inline u32 tegra_fuse_readl(unsigned long offset)
 {
 	return tegra_apb_readl(TEGRA_FUSE_BASE + offset);
 }
 
+static inline bool get_spare_fuse(int bit)
+{
+	return tegra_fuse_readl(FUSE_SPARE_BIT + bit * 4);
+}
+
+static enum tegra_revision tegra_get_revision(void)
+{
+	void __iomem *chip_id = IO_ADDRESS(TEGRA_APB_MISC_BASE) + 0x804;
+	u32 id = readl(chip_id);
+	u32 minor_rev = (id >> 16) & 0xf;
+	u32 chipid = (id >> 8) & 0xff;
+
+	switch (minor_rev) {
+	case 1:
+		return TEGRA_REVISION_A01;
+	case 2:
+		return TEGRA_REVISION_A02;
+	case 3:
+		if (chipid == 0x20 && (get_spare_fuse(18) || get_spare_fuse(19)))
+			return TEGRA_REVISION_A03p;
+		else
+			return TEGRA_REVISION_A03;
+	case 4:
+		return TEGRA_REVISION_A04;
+	default:
+		return TEGRA_REVISION_UNKNOWN;
+	}
+}
+
 void tegra_init_fuse(void)
 {
 	u32 reg = readl(IO_TO_VIRT(TEGRA_CLK_RESET_BASE + 0x48));
 	reg |= 1 << 28;
 	writel(reg, IO_TO_VIRT(TEGRA_CLK_RESET_BASE + 0x48));
 
-	pr_info("Tegra SKU: %d CPU Process: %d Core Process: %d\n",
-		tegra_sku_id(), tegra_cpu_process_id(),
-		tegra_core_process_id());
+	reg = tegra_fuse_readl(FUSE_SKU_INFO);
+	tegra_sku_id = reg & 0xFF;
+
+	reg = tegra_fuse_readl(FUSE_SPARE_BIT);
+	tegra_cpu_process_id = (reg >> 6) & 3;
+
+	reg = tegra_fuse_readl(FUSE_SPARE_BIT);
+	tegra_core_process_id = (reg >> 12) & 3;
+
+	tegra_revision = tegra_get_revision();
+
+	pr_info("Tegra Revision: %s SKU: %d CPU Process: %d Core Process: %d\n",
+		tegra_revision_name[tegra_get_revision()],
+		tegra_sku_id, tegra_cpu_process_id,
+		tegra_core_process_id);
 }
 
 unsigned long long tegra_chip_uid(void)
@@ -54,27 +109,3 @@ unsigned long long tegra_chip_uid(void)
 	hi = tegra_fuse_readl(FUSE_UID_HIGH);
 	return (hi << 32ull) | lo;
 }
-
-int tegra_sku_id(void)
-{
-	int sku_id;
-	u32 reg = tegra_fuse_readl(FUSE_SKU_INFO);
-	sku_id = reg & 0xFF;
-	return sku_id;
-}
-
-int tegra_cpu_process_id(void)
-{
-	int cpu_process_id;
-	u32 reg = tegra_fuse_readl(FUSE_SPARE_BIT);
-	cpu_process_id = (reg >> 6) & 3;
-	return cpu_process_id;
-}
-
-int tegra_core_process_id(void)
-{
-	int core_process_id;
-	u32 reg = tegra_fuse_readl(FUSE_SPARE_BIT);
-	core_process_id = (reg >> 12) & 3;
-	return core_process_id;
-}
diff --git a/arch/arm/mach-tegra/fuse.h b/arch/arm/mach-tegra/fuse.h
index 584b2e2..7576aaf 100644
--- a/arch/arm/mach-tegra/fuse.h
+++ b/arch/arm/mach-tegra/fuse.h
@@ -1,6 +1,4 @@
 /*
- * arch/arm/mach-tegra/fuse.c
- *
  * Copyright (C) 2010 Google, Inc.
  *
  * Author:
@@ -17,8 +15,32 @@
  *
  */
 
+#ifndef __MACH_TEGRA_FUSE_H
+#define __MACH_TEGRA_FUSE_H
+
+enum tegra_revision {
+	TEGRA_REVISION_UNKNOWN = 0,
+	TEGRA_REVISION_A01,
+	TEGRA_REVISION_A02,
+	TEGRA_REVISION_A03,
+	TEGRA_REVISION_A03p,
+	TEGRA_REVISION_A04,
+	TEGRA_REVISION_MAX,
+};
+
+#define SKU_ID_T20	8
+#define SKU_ID_T25SE	20
+#define SKU_ID_AP25	23
+#define SKU_ID_T25	24
+#define SKU_ID_AP25E	27
+#define SKU_ID_T25E	28
+
+extern int tegra_sku_id;
+extern int tegra_cpu_process_id;
+extern int tegra_core_process_id;
+extern enum tegra_revision tegra_revision;
+
 unsigned long long tegra_chip_uid(void);
-int tegra_sku_id(void);
-int tegra_cpu_process_id(void);
-int tegra_core_process_id(void);
 void tegra_init_fuse(void);
+
+#endif
diff --git a/arch/arm/mach-tegra/tegra2_clocks.c b/arch/arm/mach-tegra/tegra2_clocks.c
index ff9e6b6..74d314fd 100644
--- a/arch/arm/mach-tegra/tegra2_clocks.c
+++ b/arch/arm/mach-tegra/tegra2_clocks.c
@@ -720,7 +720,7 @@ static void tegra2_pllx_clk_init(struct clk *c)
 {
 	tegra2_pll_clk_init(c);
 
-	if (tegra_sku_id() == 7)
+	if (tegra_sku_id == 7)
 		c->max_rate = 750000000;
 }
 
-- 
1.7.8.GIT
