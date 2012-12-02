From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Sun, 2 Dec 2012 05:10:44 -0500
Subject: [PATCH] tty: serial: vt8500: fix return value check in
 vt8500_serial_probe()
Message-ID: <CAPgLHd_gx3BmZh+L1k6koa6eH5SKKEVFedSC_M=nju+Dzq=rug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In case of error, function of_clk_get() returns ERR_PTR()
and never returns NULL. The NULL test in the return value
check should be replaced with IS_ERR().

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/tty/serial/vt8500_serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/vt8500_serial.c b/drivers/tty/serial/vt8500_serial.c
index 205d4cf..f528cc2 100644
--- a/drivers/tty/serial/vt8500_serial.c
+++ b/drivers/tty/serial/vt8500_serial.c
@@ -604,7 +604,7 @@ static int __devinit vt8500_serial_probe(struct platform_device *pdev)
 	vt8500_port->uart.flags = UPF_IOREMAP | UPF_BOOT_AUTOCONF;
 
 	vt8500_port->clk = of_clk_get(pdev->dev.of_node, 0);
-	if (vt8500_port->clk) {
+	if (!IS_ERR(vt8500_port->clk)) {
 		vt8500_port->uart.uartclk = clk_get_rate(vt8500_port->clk);
 	} else {
 		/* use the default of 24Mhz if not specified and warn */
