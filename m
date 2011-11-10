From: richard.zhao@linaro.org (Richard Zhao)
Date: Thu, 10 Nov 2011 12:59:18 +0800
Subject: [PATCH 1/1] serial: imx: convert to clk_prepare/clk_unprepare
Message-ID: <1320901158-13103-1-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
---
 drivers/tty/serial/imx.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 163fc90..22fd9c8 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1390,6 +1390,7 @@ static int serial_imx_probe(struct platform_device *pdev)
 		ret = PTR_ERR(sport->clk);
 		goto unmap;
 	}
+	clk_prepare(sport->clk);
 	clk_enable(sport->clk);
 
 	sport->port.uartclk = clk_get_rate(sport->clk);
@@ -1415,6 +1416,7 @@ deinit:
 clkput:
 	clk_put(sport->clk);
 	clk_disable(sport->clk);
+	clk_unprepare(sport->clk);
 unmap:
 	iounmap(sport->port.membase);
 free:
@@ -1438,6 +1440,7 @@ static int serial_imx_remove(struct platform_device *pdev)
 	}
 
 	clk_disable(sport->clk);
+	clk_unprepare(sport->clk);
 
 	if (pdata && pdata->exit)
 		pdata->exit(pdev);
-- 
1.7.5.4
