From: davidb@codeaurora.org (David Brown)
Date: Fri,  7 Sep 2012 14:45:03 -0700
Subject: [PATCH] msm_serial: fix clock rate on DMA-based uarts
Message-ID: <1347054303-5643-1-git-send-email-davidb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver explicitly requests a clock rate for the UART, but it is
off by a factor of four from the dividers that it programs into the
UART.  Fix this by setting the rate to 1/4 of the current value.

Signed-off-by: David Brown <davidb@codeaurora.org>
---
 drivers/tty/serial/msm_serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index 8131e2c..033e0bc 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -896,7 +896,7 @@ static int __init msm_serial_probe(struct platform_device *pdev)
 			return PTR_ERR(msm_port->clk);
 
 	if (msm_port->is_uartdm)
-		clk_set_rate(msm_port->clk, 7372800);
+		clk_set_rate(msm_port->clk, 1843200);
 
 	port->uartclk = clk_get_rate(msm_port->clk);
 	printk(KERN_INFO "uartclk = %d\n", port->uartclk);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
