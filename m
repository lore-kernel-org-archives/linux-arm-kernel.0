From: richard.zhao@linaro.org (Richard Zhao)
Date: Fri, 11 Nov 2011 18:50:34 +0800
Subject: [PATCH V3 11/14] serial: imx: add clk_prepare/clk_unprepare
In-Reply-To: <1321008637-19999-1-git-send-email-richard.zhao@linaro.org>
References: <1321008637-19999-1-git-send-email-richard.zhao@linaro.org>
Message-ID: <1321008637-19999-12-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
---
 drivers/tty/serial/imx.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 163fc90..8f3709f 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1390,7 +1390,7 @@ static int serial_imx_probe(struct platform_device *pdev)
 		ret = PTR_ERR(sport->clk);
 		goto unmap;
 	}
-	clk_enable(sport->clk);
+	clk_prepare_enable(sport->clk);
 
 	sport->port.uartclk = clk_get_rate(sport->clk);
 
@@ -1413,8 +1413,8 @@ deinit:
 	if (pdata && pdata->exit)
 		pdata->exit(pdev);
 clkput:
+	clk_disable_unprepare(sport->clk);
 	clk_put(sport->clk);
-	clk_disable(sport->clk);
 unmap:
 	iounmap(sport->port.membase);
 free:
@@ -1434,11 +1434,10 @@ static int serial_imx_remove(struct platform_device *pdev)
 
 	if (sport) {
 		uart_remove_one_port(&imx_reg, &sport->port);
+		clk_disable_unprepare(sport->clk);
 		clk_put(sport->clk);
 	}
 
-	clk_disable(sport->clk);
-
 	if (pdata && pdata->exit)
 		pdata->exit(pdev);
 
-- 
1.7.5.4
