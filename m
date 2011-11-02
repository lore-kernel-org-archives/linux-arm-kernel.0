From: davidb@codeaurora.org (David Brown)
Date: Wed,  2 Nov 2011 11:36:31 -0700
Subject: [RFC PATCH 34/34] msm_serial: fix clock rate on DMA-based uarts
In-Reply-To: <1320258991-22325-1-git-send-email-davidb@codeaurora.org>
References: <1320258991-22325-1-git-send-email-davidb@codeaurora.org>
Message-ID: <1320258991-22325-35-git-send-email-davidb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver explicitly requests a clock rate for the UART, but it is
off by a factor of four from the dividers that it programs into the
UART.  Fix this by setting the rate to 1/4 of the current value.

Signed-off-by: David Brown <davidb@codeaurora.org>
---
 drivers/tty/serial/msm_serial.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index 29cbfd8..b7baceb 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -891,7 +891,7 @@ static int __init msm_serial_probe(struct platform_device *pdev)
 			return PTR_ERR(msm_port->clk);
 
 	if (msm_port->is_uartdm)
-		clk_set_rate(msm_port->clk, 7372800);
+		clk_set_rate(msm_port->clk, 1843200);
 
 	port->uartclk = clk_get_rate(msm_port->clk);
 	printk(KERN_INFO "uartclk = %d\n", port->uartclk);
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
