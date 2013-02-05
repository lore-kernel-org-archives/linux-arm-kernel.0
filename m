From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Feb 2013 00:22:09 -0500
Subject: [PATCH v4 12/15] ARM: CCI: ensure powerdown-time data is flushed from
 cache
In-Reply-To: <1360041732-17936-1-git-send-email-nicolas.pitre@linaro.org>
References: <1360041732-17936-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1360041732-17936-13-git-send-email-nicolas.pitre@linaro.org>
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
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 drivers/bus/Kconfig   |  1 +
 drivers/bus/arm-cci.c | 13 +++++++++++++
 2 files changed, 14 insertions(+)

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
index 11c1513440..3bdab2c135 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -21,6 +21,10 @@
 #include <linux/slab.h>
 #include <linux/arm-cci.h>
 
+#include <asm/cacheflush.h>
+#include <asm/memory.h>
+#include <asm/outercache.h>
+
 
 #define CCI_STATUS_OFFSET	0xc
 #define STATUS_CHANGE_PENDING	(1 << 0)
@@ -78,6 +82,15 @@ static int cci_driver_probe(struct platform_device *pdev)
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
 
 	pr_info("CCI loaded@%p\n", info->baseaddr);
-- 
1.8.1.2
