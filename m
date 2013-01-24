From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 24 Jan 2013 01:27:57 -0500
Subject: [PATCH v2 14/16] ARM: CCI: ensure powerdown-time data is flushed from
 cache
In-Reply-To: <1359008879-9015-1-git-send-email-nicolas.pitre@linaro.org>
References: <1359008879-9015-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1359008879-9015-15-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dave Martin <dave.martin@linaro.org>

Non-local variables used by the CCI management function called after
disabling the cache must be flushed out to main memory in advance,
otherwise incoherency of those values may occur if they are sitting
in the cache of some other CPU when cci_disable() executes.

This patch adds the appropriate flushing to the CCI driver to ensure
that the relevant data is available in RAM ahead of time.

Because this creates a dependency on arch-specific cacheflushing
functions, this patch also makes ARM_CCI depend on ARM.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 drivers/bus/Kconfig   |  1 +
 drivers/bus/arm-cci.c | 21 +++++++++++++++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index d032f74ff2..cd4ac9f001 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -22,5 +22,6 @@ config OMAP_INTERCONNECT
 
 config ARM_CCI
        bool "ARM CCI driver support"
+	depends on ARM
 
 endmenu
diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
index 5de3aa3d1f..11689f166d 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -21,8 +21,16 @@
 #include <linux/slab.h>
 #include <linux/arm-cci.h>
 
-#define CCI400_EAG_OFFSET       0x4000
-#define CCI400_KF_OFFSET        0x5000
+#include <asm/cacheflush.h>
+#include <asm/memory.h>
+#include <asm/outercache.h>
+
+#include <asm/irq_regs.h>
+#include <asm/pmu.h>
+
+#define CCI400_PMCR                   0x0100
+#define CCI400_EAG_OFFSET             0x4000
+#define CCI400_KF_OFFSET              0x5000
 
 #define DRIVER_NAME	"CCI"
 struct cci_drvdata {
@@ -73,6 +81,15 @@ static int cci_driver_probe(struct platform_device *pdev)
 		goto ioremap_err;
 	}
 
+	/*
+	 * Multi-cluster systems may need this data when non-coherent, during
+	 * cluster power-up/power-down. Make sure it reaches main memory:
+	 */
+	__cpuc_flush_dcache_area(info, sizeof *info);
+	__cpuc_flush_dcache_area(&info, sizeof info);
+	outer_clean_range(virt_to_phys(info), virt_to_phys(info + 1));
+	outer_clean_range(virt_to_phys(&info), virt_to_phys(&info + 1));
+
 	platform_set_drvdata(pdev, info);
 
 	pr_info("CCI loaded at %p\n", info->baseaddr);
-- 
1.8.0
