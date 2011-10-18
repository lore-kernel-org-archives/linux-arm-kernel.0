From: olof@lixom.net (Olof Johansson)
Date: Tue, 18 Oct 2011 11:23:26 -0700
Subject: [PATCH] [3.3] [RESEND] ARM: tegra: fuse: use apbio dma for register
	access
Message-ID: <1318962206-21537-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the apbio dma functions for accessing the fuse registers.

Signed-off-by: Olof Johansson <olof@lixom.net>
---

Resend due to messed up linux-arm-kernel address.

This patch depends on "ARM: tegra: use APB DMA for accessing APB devices",
I forgot to send them as a 2-patch series.


 arch/arm/mach-tegra/fuse.c |   20 ++++++++------------
 1 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-tegra/fuse.c b/arch/arm/mach-tegra/fuse.c
index 1fa26d9..daf3f57 100644
--- a/arch/arm/mach-tegra/fuse.c
+++ b/arch/arm/mach-tegra/fuse.c
@@ -23,20 +23,16 @@
 #include <mach/iomap.h>
 
 #include "fuse.h"
+#include "apbio.h"
 
 #define FUSE_UID_LOW		0x108
 #define FUSE_UID_HIGH		0x10c
 #define FUSE_SKU_INFO		0x110
 #define FUSE_SPARE_BIT		0x200
 
-static inline u32 fuse_readl(unsigned long offset)
+static inline u32 tegra_fuse_readl(unsigned long offset)
 {
-	return readl(IO_TO_VIRT(TEGRA_FUSE_BASE + offset));
-}
-
-static inline void fuse_writel(u32 value, unsigned long offset)
-{
-	writel(value, IO_TO_VIRT(TEGRA_FUSE_BASE + offset));
+	return tegra_apb_readl(TEGRA_FUSE_BASE + offset);
 }
 
 void tegra_init_fuse(void)
@@ -54,15 +50,15 @@ unsigned long long tegra_chip_uid(void)
 {
 	unsigned long long lo, hi;
 
-	lo = fuse_readl(FUSE_UID_LOW);
-	hi = fuse_readl(FUSE_UID_HIGH);
+	lo = tegra_fuse_readl(FUSE_UID_LOW);
+	hi = tegra_fuse_readl(FUSE_UID_HIGH);
 	return (hi << 32ull) | lo;
 }
 
 int tegra_sku_id(void)
 {
 	int sku_id;
-	u32 reg = fuse_readl(FUSE_SKU_INFO);
+	u32 reg = tegra_fuse_readl(FUSE_SKU_INFO);
 	sku_id = reg & 0xFF;
 	return sku_id;
 }
@@ -70,7 +66,7 @@ int tegra_sku_id(void)
 int tegra_cpu_process_id(void)
 {
 	int cpu_process_id;
-	u32 reg = fuse_readl(FUSE_SPARE_BIT);
+	u32 reg = tegra_fuse_readl(FUSE_SPARE_BIT);
 	cpu_process_id = (reg >> 6) & 3;
 	return cpu_process_id;
 }
@@ -78,7 +74,7 @@ int tegra_cpu_process_id(void)
 int tegra_core_process_id(void)
 {
 	int core_process_id;
-	u32 reg = fuse_readl(FUSE_SPARE_BIT);
+	u32 reg = tegra_fuse_readl(FUSE_SPARE_BIT);
 	core_process_id = (reg >> 12) & 3;
 	return core_process_id;
 }
-- 
1.7.4.1
