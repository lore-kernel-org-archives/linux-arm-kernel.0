From: jamie@jamieiles.com (Jamie Iles)
Date: Tue, 11 Jan 2011 12:43:46 +0000
Subject: [PATCH 09/16] ARM: pxa: don't treat NULL clk as an error
In-Reply-To: <1294749833-32019-1-git-send-email-jamie@jamieiles.com>
References: <1294749833-32019-1-git-send-email-jamie@jamieiles.com>
Message-ID: <1294749833-32019-10-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clk_get() returns a struct clk cookie to the driver and some platforms
may return NULL if they only support a single clock.  clk_get() has only
failed if it returns a ERR_PTR() encoded pointer.

Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 drivers/pcmcia/pxa2xx_base.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pcmcia/pxa2xx_base.c b/drivers/pcmcia/pxa2xx_base.c
index 3755e7c..6e5b55e 100644
--- a/drivers/pcmcia/pxa2xx_base.c
+++ b/drivers/pcmcia/pxa2xx_base.c
@@ -16,6 +16,7 @@
 
   ======================================================================*/
 
+#include <linux/err.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/init.h>
@@ -297,8 +298,8 @@ static int pxa2xx_drv_pcmcia_probe(struct platform_device *dev)
 	}
 
 	clk = clk_get(&dev->dev, NULL);
-	if (!clk)
-		return -ENODEV;
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
 
 	pxa2xx_drv_pcmcia_ops(ops);
 
-- 
1.7.3.4
