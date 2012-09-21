From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Fri, 21 Sep 2012 15:19:09 +0800
Subject: [PATCH] ARM: pxa: fix return value check in pxa2xx_drv_pcmcia_probe()
Message-ID: <CAPgLHd8ZQr2-1B2QcwO83gJNBrzw-WY1WWgWQJJCQYxirVAC2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In case of error, the function clk_get() returns ERR_PTR()
and never returns NULL pointer. The NULL test in the error
handling should be replaced with IS_ERR().

dpatch engine is used to auto generated this patch.
(https://github.com/weiyj/dpatch)

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/pcmcia/pxa2xx_base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pcmcia/pxa2xx_base.c b/drivers/pcmcia/pxa2xx_base.c
index 490bb82..cfec9dd 100644
--- a/drivers/pcmcia/pxa2xx_base.c
+++ b/drivers/pcmcia/pxa2xx_base.c
@@ -297,7 +297,7 @@ static int pxa2xx_drv_pcmcia_probe(struct platform_device *dev)
 	}
 
 	clk = clk_get(&dev->dev, NULL);
-	if (!clk)
+	if (IS_ERR(clk))
 		return -ENODEV;
 
 	pxa2xx_drv_pcmcia_ops(ops);
