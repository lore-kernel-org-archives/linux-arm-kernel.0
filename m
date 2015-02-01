From: gang.chen@sunrus.com.cn (Chen Gang S)
Date: Sun, 01 Feb 2015 22:42:15 +0800
Subject: [PATCH] rc: st_rc: Use CONFIG_PM_SLEEP instead of CONFIG_PM for
 st_rc_suspend() and st_rc_resume()
Message-ID: <54CE3B47.6050909@sunrus.com.cn>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

st_rc_suspend() and st_rc_resume() depend on CONFIG_PM_SLEEP finally, so
they need CONFIG_PM_SLEEP instead of CONFIG_PM, or they will cause build
warning (with allmodconfig under xtensa):

    CC [M]  drivers/media/pci/smipcie/smipcie.o
  drivers/media/rc/st_rc.c:338:12: warning: 'st_rc_suspend' defined but not used [-Wunused-function]
   static int st_rc_suspend(struct device *dev)
              ^
  drivers/media/rc/st_rc.c:359:12: warning: 'st_rc_resume' defined but not used [-Wunused-function]
   static int st_rc_resume(struct device *dev)
              ^

Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
---
 drivers/media/rc/st_rc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/rc/st_rc.c b/drivers/media/rc/st_rc.c
index 0e758ae..fbfe958 100644
--- a/drivers/media/rc/st_rc.c
+++ b/drivers/media/rc/st_rc.c
@@ -334,7 +334,7 @@ err:
 	return ret;
 }
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 static int st_rc_suspend(struct device *dev)
 {
 	struct st_rc_device *rc_dev = dev_get_drvdata(dev);
-- 
1.9.3
