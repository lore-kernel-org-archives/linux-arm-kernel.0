From: olof@lixom.net (Olof Johansson)
Date: Thu, 22 Dec 2011 16:17:44 -0800
Subject: [PATCH 5/9] arm/tegra: fuse: add bct strapping reading
In-Reply-To: <1324599468-12845-1-git-send-email-olof@lixom.net>
References: <1324599468-12845-1-git-send-email-olof@lixom.net>
Message-ID: <1324599468-12845-6-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is used by the memory setup code to pick the right memory
timing table, if needed.

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/mach-tegra/fuse.c |   14 ++++++++++++++
 arch/arm/mach-tegra/fuse.h |    2 ++
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-tegra/fuse.c b/arch/arm/mach-tegra/fuse.c
index 2ddede9..7fa8eb1 100644
--- a/arch/arm/mach-tegra/fuse.c
+++ b/arch/arm/mach-tegra/fuse.c
@@ -35,6 +35,17 @@ int tegra_cpu_process_id;
 int tegra_core_process_id;
 enum tegra_revision tegra_revision;
 
+/* The BCT to use at boot is specified by board straps that can be read
+ * through a APB misc register and decoded. 2 bits, i.e. 4 possible BCTs.
+ */
+int tegra_bct_strapping;
+
+#define STRAP_OPT 0x008
+#define GMI_AD0 (1 << 4)
+#define GMI_AD1 (1 << 5)
+#define RAM_ID_MASK (GMI_AD0 | GMI_AD1)
+#define RAM_CODE_SHIFT 4
+
 static const char *tegra_revision_name[TEGRA_REVISION_MAX] = {
 	[TEGRA_REVISION_UNKNOWN] = "unknown",
 	[TEGRA_REVISION_A02]     = "A02",
@@ -88,6 +99,9 @@ void tegra_init_fuse(void)
 	reg = tegra_fuse_readl(FUSE_SPARE_BIT);
 	tegra_core_process_id = (reg >> 12) & 3;
 
+	reg = tegra_apb_readl(TEGRA_APB_MISC_BASE + STRAP_OPT);
+	tegra_bct_strapping = (reg & RAM_ID_MASK) >> RAM_CODE_SHIFT;
+
 	tegra_revision = tegra_get_revision();
 
 	pr_info("Tegra Revision: %s SKU: %d CPU Process: %d Core Process: %d\n",
diff --git a/arch/arm/mach-tegra/fuse.h b/arch/arm/mach-tegra/fuse.h
index e418d40..e0cc4bc 100644
--- a/arch/arm/mach-tegra/fuse.h
+++ b/arch/arm/mach-tegra/fuse.h
@@ -39,6 +39,8 @@ extern int tegra_cpu_process_id;
 extern int tegra_core_process_id;
 extern enum tegra_revision tegra_revision;
 
+extern int tegra_bct_strapping;
+
 unsigned long long tegra_chip_uid(void);
 void tegra_init_fuse(void);
 
-- 
1.7.8.GIT
