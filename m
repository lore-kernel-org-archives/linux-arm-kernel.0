From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon,  4 May 2015 13:46:43 +0200
Subject: [PATCH 5/8] soc/tegra: fuse: Restrict legacy code to 32-bit ARM
In-Reply-To: <1430740006-29539-1-git-send-email-thierry.reding@gmail.com>
References: <1430740006-29539-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1430740006-29539-6-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

For backwards-compatibility with old device trees, if no APBMISC node
exists this driver hard-codes the I/O memory region. All 64-bit ARM
device tree files are recent enough that they can be required to have
this node, and therefore the legacy code path is not required.

Based on work done by Paul Walmsley <pwalmsley@nvidia.com>.

Cc: Paul Walmsley <pwalmsley@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/soc/tegra/fuse/tegra-apbmisc.c | 67 +++++++++++++++++++++++++++++-----
 1 file changed, 58 insertions(+), 9 deletions(-)

diff --git a/drivers/soc/tegra/fuse/tegra-apbmisc.c b/drivers/soc/tegra/fuse/tegra-apbmisc.c
index 3bf5aba4caaa..ab2df9373308 100644
--- a/drivers/soc/tegra/fuse/tegra-apbmisc.c
+++ b/drivers/soc/tegra/fuse/tegra-apbmisc.c
@@ -21,11 +21,10 @@
 #include <linux/io.h>
 
 #include <soc/tegra/fuse.h>
+#include <soc/tegra/common.h>
 
 #include "fuse.h"
 
-#define APBMISC_BASE	0x70000800
-#define APBMISC_SIZE	0x64
 #define FUSE_SKU_INFO	0x10
 
 static void __iomem *apbmisc_base;
@@ -99,17 +98,67 @@ void __init tegra_init_revision(void)
 
 void __init tegra_init_apbmisc(void)
 {
+	struct resource apbmisc, straps;
 	struct device_node *np;
 
 	np = of_find_matching_node(NULL, apbmisc_match);
-	apbmisc_base = of_iomap(np, 0);
-	if (!apbmisc_base) {
-		pr_warn("ioremap tegra apbmisc failed. using %08x instead\n",
-			APBMISC_BASE);
-		apbmisc_base = ioremap(APBMISC_BASE, APBMISC_SIZE);
+	if (!np) {
+		/*
+		 * Fall back to legacy initialization for 32-bit ARM only. All
+		 * 64-bit ARM device tree files for Tegra are required to have
+		 * an APBMISC node.
+		 *
+		 * This is for backwards-compatibility with old device trees
+		 * that didn't contain an APBMISC node.
+		 */
+		if (IS_ENABLED(CONFIG_ARM) && soc_is_tegra()) {
+			/* APBMISC registers (chip revision, ...) */
+			apbmisc.start = 0x70000800;
+			apbmisc.end = 0x70000863;
+			apbmisc.flags = IORESOURCE_MEM;
+
+			/* strapping options */
+			if (tegra_get_chip_id() == TEGRA124) {
+				straps.start = 0x7000e864;
+				straps.end = 0x7000e867;
+			} else {
+				straps.start = 0x70000008;
+				straps.end = 0x7000000b;
+			}
+
+			straps.flags = IORESOURCE_MEM;
+
+			pr_warn("Using APBMISC region %pR\n", &apbmisc);
+			pr_warn("Using strapping options registers %pR\n",
+				&straps);
+		} else {
+			/*
+			 * At this point we're not running on Tegra, so play
+			 * nice with multi-platform kernels.
+			 */
+			return;
+		}
+	} else {
+		/*
+		 * Extract information from the device tree if we've found a
+		 * matching node.
+		 */
+		if (of_address_to_resource(np, 0, &apbmisc) < 0) {
+			pr_err("failed to get APBMISC registers\n");
+			return;
+		}
+
+		if (of_address_to_resource(np, 1, &straps) < 0) {
+			pr_err("failed to get strapping options registers\n");
+			return;
+		}
 	}
 
-	strapping_base = of_iomap(np, 1);
+	apbmisc_base = ioremap_nocache(apbmisc.start, resource_size(&apbmisc));
+	if (!apbmisc_base)
+		pr_err("failed to map APBMISC registers\n");
+
+	strapping_base = ioremap_nocache(straps.start, resource_size(&straps));
 	if (!strapping_base)
-		pr_err("ioremap tegra strapping_base failed\n");
+		pr_err("failed to map strapping options registers\n");
 }
-- 
2.3.5
