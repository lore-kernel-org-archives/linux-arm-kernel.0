From: wolfram@the-dreams.de (Wolfram Sang)
Date: Tue, 10 Jul 2012 00:28:30 +0200
Subject: [PATCH V2] i2c: imx: make bitrate an u32 type
Message-ID: <1341872910-26687-1-git-send-email-wolfram@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sparse found this assignment of u32 to an int. Fix it:

drivers/i2c/busses/i2c-imx.c:540:56: warning: incorrect type in argument 3 (different signedness)

and also fix the type in platform_data. All current users use values
which fit into the old and new type, so it is a safe change.

Signed-off-by: Wolfram Sang <wolfram@the-dreams.de>
Cc: Richard Zhao <richard.zhao@freescale.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---

Changes since V1: also change type in platform_data. Thanks to Richard.

 arch/arm/plat-mxc/include/mach/i2c.h |    2 +-
 drivers/i2c/busses/i2c-imx.c         |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/i2c.h b/arch/arm/plat-mxc/include/mach/i2c.h
index 375cdd0..8289d91 100644
--- a/arch/arm/plat-mxc/include/mach/i2c.h
+++ b/arch/arm/plat-mxc/include/mach/i2c.h
@@ -15,7 +15,7 @@
  *
  **/
 struct imxi2c_platform_data {
-	int bitrate;
+	u32 bitrate;
 };
 
 #endif /* __ASM_ARCH_I2C_H_ */
diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index dd2a083..90460dd 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -471,8 +471,8 @@ static int __init i2c_imx_probe(struct platform_device *pdev)
 	struct imxi2c_platform_data *pdata = pdev->dev.platform_data;
 	struct pinctrl *pinctrl;
 	void __iomem *base;
-	int irq, bitrate;
-	int ret;
+	int irq, ret;
+	u32 bitrate;
 
 	dev_dbg(&pdev->dev, "<%s>\n", __func__);
 
-- 
1.7.10.4
