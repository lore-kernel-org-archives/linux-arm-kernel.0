From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Thu,  6 Jan 2011 14:01:22 +0300
Subject: [PATCH] i2c-pxa: fix unbidding/rebidding of the device
In-Reply-To: <20110105091915.GV27131@trinity.fluff.org>
References: <20110105091915.GV27131@trinity.fluff.org>
Message-ID: <1294311682-13287-1-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When a "pxa2xx-i2c" device was unbound (e.g. via sysfs) the remove
callback was not called because it was discarded when linking the
kernel.  Because of that the resources allocated in probe were not
freed and so a clean unbind/rebind was impossible.

Fix that by moving the remove callback to .devexit.text.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: linux-i2c at vger.kernel.org
Cc: Ben Dooks <ben-linux@fluff.org>
---
 drivers/i2c/busses/i2c-pxa.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index f4c19a9..0f10955 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -1115,7 +1115,7 @@ emalloc:
 	return ret;
 }
 
-static int __exit i2c_pxa_remove(struct platform_device *dev)
+static int __devexit i2c_pxa_remove(struct platform_device *dev)
 {
 	struct pxa_i2c *i2c = platform_get_drvdata(dev);
 
@@ -1169,7 +1169,7 @@ static const struct dev_pm_ops i2c_pxa_dev_pm_ops = {
 
 static struct platform_driver i2c_pxa_driver = {
 	.probe		= i2c_pxa_probe,
-	.remove		= __exit_p(i2c_pxa_remove),
+	.remove		= __devexit_p(i2c_pxa_remove),
 	.driver		= {
 		.name	= "pxa2xx-i2c",
 		.owner	= THIS_MODULE,
-- 
1.7.2.3
