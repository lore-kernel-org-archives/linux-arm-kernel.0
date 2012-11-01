From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Thu, 1 Nov 2012 13:33:55 +0800
Subject: [PATCH -next] CLK: clk-twl6040: fix return value check in
 twl6040_clk_probe()
Message-ID: <CAPgLHd-LVhPkOHUWOwjmcsDA-4spfQMTxW9z2tB7fnEuS_5OOw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In case of error, the function clk_register() returns ERR_PTR()
and never returns NULL. The NULL test in the return value check
should be replaced with IS_ERR().

dpatch engine is used to auto generate this patch.
(https://github.com/weiyj/dpatch)

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/clk/clk-twl6040.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-twl6040.c b/drivers/clk/clk-twl6040.c
index f4a3389..bc1e713 100644
--- a/drivers/clk/clk-twl6040.c
+++ b/drivers/clk/clk-twl6040.c
@@ -92,8 +92,8 @@ static int __devinit twl6040_clk_probe(struct platform_device *pdev)
 
 	clkdata->mcpdm_fclk.init = &wm831x_clkout_init;
 	clkdata->clk = clk_register(&pdev->dev, &clkdata->mcpdm_fclk);
-	if (!clkdata->clk)
-		return -EINVAL;
+	if (IS_ERR(clkdata->clk))
+		return PTR_ERR(clkdata->clk);
 
 	dev_set_drvdata(&pdev->dev, clkdata);
 
