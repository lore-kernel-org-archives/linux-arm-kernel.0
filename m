From: Baohua.Song@csr.com (Barry Song)
Date: Thu, 16 May 2013 10:50:07 +0800
Subject: [PATCH] i2c: sirf: move driver init from module_init to
 subsys_initcall
Message-ID: <1368672607-5536-1-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Xiaomeng Hou <Xiaomeng.Hou@csr.com>

if we initilize i2c bus by module_init, there are some devices which want
initialization earlier than i2c and could not do that in time, so move i2c
driver initilization to subsys_initcall and make i2c ready before devices
init.

Signed-off-by: Xiaomeng Hou <Xiaomeng.Hou@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/i2c/busses/i2c-sirf.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-sirf.c b/drivers/i2c/busses/i2c-sirf.c
index 5a7ad24..e438f48 100644
--- a/drivers/i2c/busses/i2c-sirf.c
+++ b/drivers/i2c/busses/i2c-sirf.c
@@ -454,7 +454,19 @@ static struct platform_driver i2c_sirfsoc_driver = {
 	.probe = i2c_sirfsoc_probe,
 	.remove = i2c_sirfsoc_remove,
 };
-module_platform_driver(i2c_sirfsoc_driver);
+
+static __init int i2c_sirfsoc_init(void)
+{
+	return platform_driver_register(&i2c_sirfsoc_driver);
+}
+
+static void __exit i2c_sirfsoc_exit(void)
+{
+	platform_driver_unregister(&i2c_sirfsoc_driver);
+}
+
+subsys_initcall(i2c_sirfsoc_init);
+module_exit(i2c_sirfsoc_exit);
 
 MODULE_DESCRIPTION("SiRF SoC I2C master controller driver");
 MODULE_AUTHOR("Zhiwu Song <Zhiwu.Song@csr.com>, "
-- 
1.8.2.3



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
