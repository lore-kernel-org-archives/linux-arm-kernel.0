From: wens@csie.org (Chen-Yu Tsai)
Date: Thu,  3 Jul 2014 22:55:46 +0800
Subject: [PATCH v3 6/9] serial: 8250_dw: Add support for deferred probing
In-Reply-To: <1404399349-20237-1-git-send-email-wens@csie.org>
References: <1404399349-20237-1-git-send-email-wens@csie.org>
Message-ID: <1404399349-20237-7-git-send-email-wens@csie.org>
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
and reset controller.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/tty/serial/8250/8250_dw.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index cb1b3dc..d9eeed7 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -405,12 +405,16 @@ static int dw8250_probe(struct platform_device *pdev)
 
 	data->usr_reg = DW_UART_USR;
 	data->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(data->clk) && PTR_ERR(data->clk) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
 	if (!IS_ERR(data->clk)) {
 		clk_prepare_enable(data->clk);
 		uart.port.uartclk = clk_get_rate(data->clk);
 	}
 
 	data->rst = devm_reset_control_get_optional(&pdev->dev, NULL);
+	if (IS_ERR(data->rst) && PTR_ERR(data->rst) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
 	if (!IS_ERR(data->rst))
 		reset_control_deassert(data->rst);
 
-- 
2.0.1
