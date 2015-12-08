From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 08 Dec 2015 16:21:05 +0100
Subject: [PATCH] mfd: as3722: mark PM functions as __maybe_unused
Message-ID: <2162790.qeSmLiztNV@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The newly introduced as3722_i2c_suspend/resume functions are built
unconditionally, but only used when power management is enabled,
so we get a warning otherwise:

drivers/mfd/as3722.c:427:12: warning: 'as3722_i2c_suspend' defined but not used [-Wunused-function]
drivers/mfd/as3722.c:438:12: warning: 'as3722_i2c_resume' defined but not used [-Wunused-function]

This marks them both as __maybe_unused, which avoids an ugly #ifdef
and gives us best compile-time coverage. When they are unused, the
compiler will silently drop the functions from its output.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 35deff7eb212 ("mfd: as3722: Handle interrupts on suspend")
---
 drivers/mfd/as3722.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/as3722.c b/drivers/mfd/as3722.c
index 3b21eb4bc480..e1f597f97f86 100644
--- a/drivers/mfd/as3722.c
+++ b/drivers/mfd/as3722.c
@@ -424,7 +424,7 @@ static int as3722_i2c_remove(struct i2c_client *i2c)
 	return 0;
 }
 
-static int as3722_i2c_suspend(struct device *dev)
+static int __maybe_unused as3722_i2c_suspend(struct device *dev)
 {
 	struct as3722 *as3722 = dev_get_drvdata(dev);
 
@@ -435,7 +435,7 @@ static int as3722_i2c_suspend(struct device *dev)
 	return 0;
 }
 
-static int as3722_i2c_resume(struct device *dev)
+static int __maybe_unused as3722_i2c_resume(struct device *dev)
 {
 	struct as3722 *as3722 = dev_get_drvdata(dev);
 
-- 
2.1.0.rc2
