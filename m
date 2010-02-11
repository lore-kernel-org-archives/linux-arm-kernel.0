From: Bas.Vermeulen@novero.com (Bas Vermeulen)
Date: Thu, 11 Feb 2010 19:02:02 +0100
Subject: [PATCH] imx serial driver: NULL pointer dereference in
	serial_imx_probe/remove
Message-ID: <4B74461A.1050403@novero.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Check for NULL pointer before dereferencing, as it is possible and legal 
to pass in NULL for the platform data for a serial port.

Signed-off-by: Bas Vermeulen <bas.vermeulen@novero.com>

diff --git a/drivers/serial/imx.c b/drivers/serial/imx.c
index 60d665a..d00fcf8 100644
--- a/drivers/serial/imx.c
+++ b/drivers/serial/imx.c
@@ -1279,7 +1279,7 @@ static int serial_imx_probe(struct platform_device 
*pdev)
          sport->use_irda = 1;
  #endif

-    if (pdata->init) {
+    if (pdata && pdata->init) {
          ret = pdata->init(pdev);
          if (ret)
              goto clkput;
@@ -1292,7 +1292,7 @@ static int serial_imx_probe(struct platform_device 
*pdev)

      return 0;
  deinit:
-    if (pdata->exit)
+    if (pdata && pdata->exit)
          pdata->exit(pdev);
  clkput:
      clk_put(sport->clk);
@@ -1321,7 +1321,7 @@ static int serial_imx_remove(struct 
platform_device *pdev)

      clk_disable(sport->clk);

-    if (pdata->exit)
+    if (pdata && pdata->exit)
          pdata->exit(pdev);

      iounmap(sport->port.membase);

-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: drivers-imx-serial-null-dereference.patch
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100211/5064c9a5/attachment.el>
