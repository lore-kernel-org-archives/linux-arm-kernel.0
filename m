From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 13 Jul 2015 09:28:49 +0000
Subject: [PATCH 2/3] hwspinlock: sirf: fix the memory base and move to
 devm_ioremap
In-Reply-To: <1436779729-3052-1-git-send-email-21cnbao@gmail.com>
References: <1436779729-3052-1-git-send-email-21cnbao@gmail.com>
Message-ID: <1436779729-3052-2-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Chen <Wei.Chen@csr.com>

this patch moves to the right base since we fix the dts, then
we can use devm_ioremap now.

Cc: Suman Anna <s-anna@ti.com>
Cc: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Signed-off-by: Wei Chen <Wei.Chen@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/hwspinlock/sirf_hwspinlock.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/hwspinlock/sirf_hwspinlock.c b/drivers/hwspinlock/sirf_hwspinlock.c
index 1601854..692ac41 100644
--- a/drivers/hwspinlock/sirf_hwspinlock.c
+++ b/drivers/hwspinlock/sirf_hwspinlock.c
@@ -29,7 +29,7 @@ struct sirf_hwspinlock {
 #define	HW_SPINLOCK_NUMBER	30
 
 /* Hardware spinlock register offsets */
-#define HW_SPINLOCK_BASE	0x404
+#define HW_SPINLOCK_BASE	0x04
 #define HW_SPINLOCK_OFFSET(x)	(HW_SPINLOCK_BASE + 0x4 * (x))
 
 static int sirf_hwspinlock_trylock(struct hwspinlock *lock)
@@ -57,6 +57,7 @@ static int sirf_hwspinlock_probe(struct platform_device *pdev)
 {
 	struct sirf_hwspinlock *hwspin;
 	struct hwspinlock *hwlock;
+	struct resource *res;
 	int idx, ret;
 
 	if (!pdev->dev.of_node)
@@ -68,7 +69,8 @@ static int sirf_hwspinlock_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	/* retrieve io base */
-	hwspin->io_base = of_iomap(pdev->dev.of_node, 0);
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	hwspin->io_base = devm_ioremap_resource(&pdev->dev, res);
 	if (!hwspin->io_base)
 		return -ENOMEM;
 
@@ -91,7 +93,6 @@ static int sirf_hwspinlock_probe(struct platform_device *pdev)
 
 reg_failed:
 	pm_runtime_disable(&pdev->dev);
-	iounmap(hwspin->io_base);
 
 	return ret;
 }
@@ -109,8 +110,6 @@ static int sirf_hwspinlock_remove(struct platform_device *pdev)
 
 	pm_runtime_disable(&pdev->dev);
 
-	iounmap(hwspin->io_base);
-
 	return 0;
 }
 
-- 
2.3.5
