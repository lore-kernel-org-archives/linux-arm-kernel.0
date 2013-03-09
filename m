From: linux@prisktech.co.nz (Tony Prisk)
Date: Sat,  9 Mar 2013 18:44:37 +1300
Subject: [PATCH] tty: serial: vt8500: Unneccessary duplicated clock code
 removed
In-Reply-To: <1362807877-23263-1-git-send-email-linux@prisktech.co.nz>
References: <1362807877-23263-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <1362807877-23263-2-git-send-email-linux@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the extra code left over when the serial driver was changed
to require a clock. There is no fallback to 24Mhz as a clock is
now required.

Also remove a second call to of_clk_get which is unnecessary.

Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
---
 drivers/tty/serial/vt8500_serial.c |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/tty/serial/vt8500_serial.c b/drivers/tty/serial/vt8500_serial.c
index a3f9dd5..705240e 100644
--- a/drivers/tty/serial/vt8500_serial.c
+++ b/drivers/tty/serial/vt8500_serial.c
@@ -611,14 +611,7 @@ static int vt8500_serial_probe(struct platform_device *pdev)
 	vt8500_port->uart.dev = &pdev->dev;
 	vt8500_port->uart.flags = UPF_IOREMAP | UPF_BOOT_AUTOCONF;
 
-	vt8500_port->clk = of_clk_get(pdev->dev.of_node, 0);
-	if (!IS_ERR(vt8500_port->clk)) {
-		vt8500_port->uart.uartclk = clk_get_rate(vt8500_port->clk);
-	} else {
-		/* use the default of 24Mhz if not specified and warn */
-		pr_warn("%s: serial clock source not specified\n", __func__);
-		vt8500_port->uart.uartclk = 24000000;
-	}
+	vt8500_port->uart.uartclk = clk_get_rate(vt8500_port->clk);
 
 	snprintf(vt8500_port->name, sizeof(vt8500_port->name),
 		 "VT8500 UART%d", pdev->id);
-- 
1.7.9.5
