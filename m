From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 17 Jun 2013 10:43:08 -0700
Subject: [PATCH/RESEND 01/12] msm_serial: Convert to clk_prepare/unprepare
In-Reply-To: <1371490999-15501-1-git-send-email-sboyd@codeaurora.org>
References: <1371490999-15501-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1371490999-15501-2-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add calls to clk_prepare and unprepare so that MSM can migrate to
the common clock framework.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/tty/serial/msm_serial.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index b11e997..0149603 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -408,9 +408,9 @@ static void msm_init_clock(struct uart_port *port)
 {
 	struct msm_port *msm_port = UART_TO_MSM(port);
 
-	clk_enable(msm_port->clk);
+	clk_prepare_enable(msm_port->clk);
 	if (!IS_ERR(msm_port->pclk))
-		clk_enable(msm_port->pclk);
+		clk_prepare_enable(msm_port->pclk);
 	msm_serial_set_mnd_regs(port);
 }
 
@@ -486,7 +486,7 @@ static void msm_shutdown(struct uart_port *port)
 	msm_port->imr = 0;
 	msm_write(port, 0, UART_IMR); /* disable interrupts */
 
-	clk_disable(msm_port->clk);
+	clk_disable_unprepare(msm_port->clk);
 
 	free_irq(port->irq, port);
 }
@@ -688,14 +688,14 @@ static void msm_power(struct uart_port *port, unsigned int state,
 
 	switch (state) {
 	case 0:
-		clk_enable(msm_port->clk);
+		clk_prepare_enable(msm_port->clk);
 		if (!IS_ERR(msm_port->pclk))
-			clk_enable(msm_port->pclk);
+			clk_prepare_enable(msm_port->pclk);
 		break;
 	case 3:
-		clk_disable(msm_port->clk);
+		clk_disable_unprepare(msm_port->clk);
 		if (!IS_ERR(msm_port->pclk))
-			clk_disable(msm_port->pclk);
+			clk_disable_unprepare(msm_port->pclk);
 		break;
 	default:
 		printk(KERN_ERR "msm_serial: Unknown PM state %d\n", state);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
