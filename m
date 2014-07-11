From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 11 Jul 2014 14:16:03 +0200
Subject: [PATCH 04/12] ARM: tegra: move fuse exports to tegra-soc.h
In-Reply-To: <1405080971-7609-1-git-send-email-thierry.reding@gmail.com>
References: <1405080971-7609-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1405080971-7609-5-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Peter De Schrijver <pdeschrijver@nvidia.com>

All fuse related functionality will move to a driver in the following
patches. To prepare for this, export all the required functionality in a
global header file and move all users of fuse.h to tegra-soc.h. While
we're at it, remove tegra_bct_strapping, as its only user was removed in
Commit a7cbe92cef27 ("ARM: tegra: remove tegra EMC scaling driver").

Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Signed-off-by: Stephen Warren <swarren@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm/mach-tegra/fuse.h            | 13 -------------
 arch/arm/mach-tegra/tegra.c           |  1 -
 arch/arm/mach-tegra/tegra114_speedo.c |  1 +
 arch/arm/mach-tegra/tegra20_speedo.c  |  1 +
 arch/arm/mach-tegra/tegra30_speedo.c  |  1 +
 include/linux/tegra-soc.h             | 16 ++++++++++++++++
 6 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-tegra/fuse.h b/arch/arm/mach-tegra/fuse.h
index 7a08b4b70c8d..48a48861c19b 100644
--- a/arch/arm/mach-tegra/fuse.h
+++ b/arch/arm/mach-tegra/fuse.h
@@ -27,27 +27,14 @@
 #define SKU_ID_T25E	28
 
 #ifndef __ASSEMBLY__
-enum tegra_revision {
-	TEGRA_REVISION_UNKNOWN = 0,
-	TEGRA_REVISION_A01,
-	TEGRA_REVISION_A02,
-	TEGRA_REVISION_A03,
-	TEGRA_REVISION_A03p,
-	TEGRA_REVISION_A04,
-	TEGRA_REVISION_MAX,
-};
 
 extern int tegra_sku_id;
 extern int tegra_cpu_process_id;
 extern int tegra_core_process_id;
 extern int tegra_cpu_speedo_id;		/* only exist in Tegra30 and later */
 extern int tegra_soc_speedo_id;
-extern enum tegra_revision tegra_revision;
-
-extern int tegra_bct_strapping;
 
 unsigned long long tegra_chip_uid(void);
-void tegra_init_fuse(void);
 bool tegra_spare_fuse(int bit);
 u32 tegra_fuse_readl(unsigned long offset);
 
diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
index e36b81870e66..f4c5f6469ee4 100644
--- a/arch/arm/mach-tegra/tegra.c
+++ b/arch/arm/mach-tegra/tegra.c
@@ -47,7 +47,6 @@
 #include "board.h"
 #include "common.h"
 #include "cpuidle.h"
-#include "fuse.h"
 #include "iomap.h"
 #include "irq.h"
 #include "pmc.h"
diff --git a/arch/arm/mach-tegra/tegra114_speedo.c b/arch/arm/mach-tegra/tegra114_speedo.c
index 86eca17e5286..f086a3ea291e 100644
--- a/arch/arm/mach-tegra/tegra114_speedo.c
+++ b/arch/arm/mach-tegra/tegra114_speedo.c
@@ -16,6 +16,7 @@
 
 #include <linux/bug.h>
 #include <linux/kernel.h>
+#include <linux/tegra-soc.h>
 
 #include "fuse.h"
 
diff --git a/arch/arm/mach-tegra/tegra20_speedo.c b/arch/arm/mach-tegra/tegra20_speedo.c
index dcd29a0b0187..83431011a23c 100644
--- a/arch/arm/mach-tegra/tegra20_speedo.c
+++ b/arch/arm/mach-tegra/tegra20_speedo.c
@@ -16,6 +16,7 @@
 
 #include <linux/bug.h>
 #include <linux/kernel.h>
+#include <linux/tegra-soc.h>
 
 #include "fuse.h"
 
diff --git a/arch/arm/mach-tegra/tegra30_speedo.c b/arch/arm/mach-tegra/tegra30_speedo.c
index 7c0038326cf5..4dda681bdaf9 100644
--- a/arch/arm/mach-tegra/tegra30_speedo.c
+++ b/arch/arm/mach-tegra/tegra30_speedo.c
@@ -16,6 +16,7 @@
 
 #include <linux/bug.h>
 #include <linux/kernel.h>
+#include <linux/tegra-soc.h>
 
 #include "fuse.h"
 
diff --git a/include/linux/tegra-soc.h b/include/linux/tegra-soc.h
index 5b419760ff5f..3a00b3419594 100644
--- a/include/linux/tegra-soc.h
+++ b/include/linux/tegra-soc.h
@@ -27,6 +27,22 @@
 u32 tegra_read_chipid(void);
 u8 tegra_get_chip_id(void);
 
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
+u32 tegra_read_straps(void);
+u32 tegra_read_chipid(void);
+void tegra_init_fuse(void);
+
+extern enum tegra_revision tegra_revision;
+
 #if defined(CONFIG_TEGRA20_APB_DMA)
 int tegra_apb_readl_using_dma(unsigned long offset, u32 *value);
 int tegra_apb_writel_using_dma(u32 value, unsigned long offset);
-- 
2.0.1
