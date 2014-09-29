From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Mon, 29 Sep 2014 14:00:16 +0800
Subject: [PATCH] [media] rc: fix hix5hd2 compile-test issue
In-Reply-To: <1411736250-29252-1-git-send-email-zhangfei.gao@linaro.org>
References: <1411736250-29252-1-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <1411970416-13110-1-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 4c255791ffd6410f ("asm-generic: io: implement relaxed accessor
macros as conditional wrappers") adds wrappers to asm-generic of
{read,write}{b,w,l,q}_relaxed.

Change CONFIG_PM to CONFIG_PM_SLEEP to solve
warning: 'hix5hd2_ir_suspend' & 'hix5hd2_ir_resume' defined but not used

Reported-by: Fengguang Wu <fengguang.wu@intel.com>
Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/media/rc/ir-hix5hd2.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/media/rc/ir-hix5hd2.c b/drivers/media/rc/ir-hix5hd2.c
index c555ca2aed0e..58ec5986274e 100644
--- a/drivers/media/rc/ir-hix5hd2.c
+++ b/drivers/media/rc/ir-hix5hd2.c
@@ -16,11 +16,6 @@
 #include <linux/regmap.h>
 #include <media/rc-core.h>
 
-/* Allow the driver to compile on all architectures */
-#ifndef writel_relaxed
-# define writel_relaxed writel
-#endif
-
 #define IR_ENABLE		0x00
 #define IR_CONFIG		0x04
 #define CNT_LEADS		0x08
@@ -294,7 +289,7 @@ static int hix5hd2_ir_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 static int hix5hd2_ir_suspend(struct device *dev)
 {
 	struct hix5hd2_ir_priv *priv = dev_get_drvdata(dev);
-- 
1.7.9.5
