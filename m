From: Barry.Song@csr.com (Barry Song)
Date: Wed, 26 Dec 2012 10:30:16 +0800
Subject: [PATCH 1/2] i2c: sirf: register i2c_client from dt child-nodes in
 probe entry
Message-ID: <1356489017-17737-1-git-send-email-Barry.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

in probe() entry of i2c_driver, set the of node of adapter and
call of_i2c_register_devices to register all i2c_client from
dt child-nodes

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/i2c/busses/i2c-sirf.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sirf.c b/drivers/i2c/busses/i2c-sirf.c
index 5574a47..181d7c2 100644
--- a/drivers/i2c/busses/i2c-sirf.c
+++ b/drivers/i2c/busses/i2c-sirf.c
@@ -12,6 +12,7 @@
 #include <linux/slab.h>
 #include <linux/platform_device.h>
 #include <linux/i2c.h>
+#include <linux/of_i2c.h>
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/io.h>
@@ -328,6 +329,7 @@ static int __devinit i2c_sirfsoc_probe(struct platform_device *pdev)
 	adap->algo = &i2c_sirfsoc_algo;
 	adap->algo_data = siic;
 
+	adap->dev.of_node = pdev->dev.of_node;
 	adap->dev.parent = &pdev->dev;
 	adap->nr = pdev->id;
 
@@ -371,6 +373,8 @@ static int __devinit i2c_sirfsoc_probe(struct platform_device *pdev)
 
 	clk_disable(clk);
 
+	of_i2c_register_devices(adap);
+
 	dev_info(&pdev->dev, " I2C adapter ready to operate\n");
 
 	return 0;
-- 
1.7.5.4



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
