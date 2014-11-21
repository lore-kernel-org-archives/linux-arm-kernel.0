From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Nov 2014 11:52:51 +0100
Subject: [PATCH] ARM: common: edma: edma_pm_resume may be unused
Message-ID: <4363971.teBOlf16kG@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The recently introduced resume hook in the edma driver
is not referenced when CONFIG_PM_SLEEP is not set, which
results in a compile warning in keystone_defconfig builds.

This adds an appropriate #ifdef.

Cc: Nishanth Menon <nm@ti.com>
Cc: Daniel Mack <zonque@gmail.com>
Cc: Joel Fernandes <joelf@ti.com>
Cc: Sekhar Nori <nsekhar@ti.com>
Fixes: a2b1175131: ("ARM: common: edma: add suspend resume hook")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I'm applying this as the obvious fixup on top of the next/drivers
branch.

diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
index 24a2857f2285..5662a872689b 100644
--- a/arch/arm/common/edma.c
+++ b/arch/arm/common/edma.c
@@ -1810,6 +1810,7 @@ static int edma_probe(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
 static int edma_pm_resume(struct device *dev)
 {
 	int i, j;
@@ -1849,6 +1850,7 @@ static int edma_pm_resume(struct device *dev)
 
 	return 0;
 }
+#endif
 
 static const struct dev_pm_ops edma_pm_ops = {
 	SET_LATE_SYSTEM_SLEEP_PM_OPS(NULL, edma_pm_resume)
