From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 23 Jul 2014 23:33:07 +0800
Subject: [PATCH v5 2/2] serial: 8250_dw: Add support for deferred probing
In-Reply-To: <1406129587-24668-1-git-send-email-wens@csie.org>
References: <1406129587-24668-1-git-send-email-wens@csie.org>
Message-ID: <1406129587-24668-3-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 8250_dw driver fails to probe if the specified clock isn't
registered at probe time. Even if a clock frequency is given,
the required clock might be gated because it wasn't properly
enabled.

This happened to me when the device is registered through DT,
and the clock was part of an MFD, the PRCM found on A31 and A23
SoCs. Unlike core clocks that are registered with OF_CLK_DECLARE,
which happen almost immediately after the kernel starts, the
clocks are registered as sub-devices of the PRCM MFD platform
device. Even though devices are registered in the order they are
found in the DT, the drivers are registered in a different,
arbitrary order. It is possible that the 8250_dw driver is
registered, and thus associated with the device and probed, before
the clock driver is registered and probed.

8250_dw then reports unable to get the clock, and fails. Without
a working console, the kernel panics.

This patch adds support for deferred probe handling for the clock
and reset controller. It also fixes the cleanup path if
serial8250_register_8250_port fails.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/tty/serial/8250/8250_dw.c | 41 ++++++++++++++++++++++++++++++++-------
 1 file changed, 34 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 501db2f..4db7987 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -365,8 +365,10 @@ static int dw8250_probe(struct platform_device *pdev)
 
 	data->usr_reg = DW_UART_USR;
 	data->clk = devm_clk_get(&pdev->dev, "baudclk");
-	if (IS_ERR(data->clk))
+	if (IS_ERR(data->clk) && PTR_ERR(data->clk) != -EPROBE_DEFER)
 		data->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(data->clk) && PTR_ERR(data->clk) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
 	if (!IS_ERR(data->clk)) {
 		err = clk_prepare_enable(data->clk);
 		if (err)
@@ -377,15 +379,23 @@ static int dw8250_probe(struct platform_device *pdev)
 	}
 
 	data->pclk = devm_clk_get(&pdev->dev, "apb_pclk");
+	if (IS_ERR(data->clk) && PTR_ERR(data->clk) == -EPROBE_DEFER) {
+		err = -EPROBE_DEFER;
+		goto err_clk;
+	}
 	if (!IS_ERR(data->pclk)) {
 		err = clk_prepare_enable(data->pclk);
 		if (err) {
 			dev_err(&pdev->dev, "could not enable apb_pclk\n");
-			return err;
+			goto err_clk;
 		}
 	}
 
 	data->rst = devm_reset_control_get_optional(&pdev->dev, NULL);
+	if (IS_ERR(data->rst) && PTR_ERR(data->rst) == -EPROBE_DEFER) {
+		err = -EPROBE_DEFER;
+		goto err_pclk;
+	}
 	if (!IS_ERR(data->rst))
 		reset_control_deassert(data->rst);
 
@@ -403,18 +413,21 @@ static int dw8250_probe(struct platform_device *pdev)
 	if (pdev->dev.of_node) {
 		err = dw8250_probe_of(&uart.port, data);
 		if (err)
-			return err;
+			goto err_reset;
 	} else if (ACPI_HANDLE(&pdev->dev)) {
 		err = dw8250_probe_acpi(&uart, data);
 		if (err)
-			return err;
+			goto err_reset;
 	} else {
-		return -ENODEV;
+		err = -ENODEV;
+		goto err_reset;
 	}
 
 	data->line = serial8250_register_8250_port(&uart);
-	if (data->line < 0)
-		return data->line;
+	if (data->line < 0) {
+		err = data->line;
+		goto err_reset;
+	}
 
 	platform_set_drvdata(pdev, data);
 
@@ -422,6 +435,20 @@ static int dw8250_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 
 	return 0;
+
+err_reset:
+	if (!IS_ERR(data->rst))
+		reset_control_assert(data->rst);
+
+err_pclk:
+	if (!IS_ERR(data->pclk))
+		clk_disable_unprepare(data->pclk);
+
+err_clk:
+	if (!IS_ERR(data->clk))
+		clk_disable_unprepare(data->clk);
+
+	return err;
 }
 
 static int dw8250_remove(struct platform_device *pdev)
-- 
2.0.1
