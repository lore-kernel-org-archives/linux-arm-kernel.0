From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Tue, 18 Oct 2016 18:01:48 -0300
Subject: [PATCH 4/4] i2c: digicolor: Fix module autoload
In-Reply-To: <1476824508-4679-1-git-send-email-javier@osg.samsung.com>
References: <1476824508-4679-1-git-send-email-javier@osg.samsung.com>
Message-ID: <1476824508-4679-5-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the driver is built as a module, autoload won't work because the module
alias information is not filled. So user-space can't match the registered
device with the corresponding module.

Export the module alias information using the MODULE_DEVICE_TABLE() macro.

Before this patch:

$ modinfo drivers/i2c/busses/i2c-digicolor.ko | grep alias
$

After this patch:

$ modinfo drivers/i2c/busses/i2c-digicolor.ko | grep alias
alias:          of:N*T*Ccnxt,cx92755-i2cC*
alias:          of:N*T*Ccnxt,cx92755-i2c

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 drivers/i2c/busses/i2c-digicolor.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-digicolor.c b/drivers/i2c/busses/i2c-digicolor.c
index 9604024e0eb0..49f2084f7bb5 100644
--- a/drivers/i2c/busses/i2c-digicolor.c
+++ b/drivers/i2c/busses/i2c-digicolor.c
@@ -368,6 +368,7 @@ static const struct of_device_id dc_i2c_match[] = {
 	{ .compatible = "cnxt,cx92755-i2c" },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, dc_i2c_match);
 
 static struct platform_driver dc_i2c_driver = {
 	.probe   = dc_i2c_probe,
-- 
2.7.4
