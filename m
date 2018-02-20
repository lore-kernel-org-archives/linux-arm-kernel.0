From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 20 Feb 2018 10:40:23 +0100
Subject: [PATCH 8/9] serial: sirf: Fix out-of-bounds access through DT alias
In-Reply-To: <1519119624-1268-1-git-send-email-geert+renesas@glider.be>
References: <1519119624-1268-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1519119624-1268-9-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sirf_ports[] array is indexed using a value derived from the
"serialN" alias in DT, which may lead to an out-of-bounds access.

Fix this by adding a range check.

Fixes: 66c7ab1120585d18 ("serial: sirf: Fix out-of-bounds access through DT alias")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/sirfsoc_uart.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/tty/serial/sirfsoc_uart.c b/drivers/tty/serial/sirfsoc_uart.c
index 9925b00a97772a1b..701df3319ff7579d 100644
--- a/drivers/tty/serial/sirfsoc_uart.c
+++ b/drivers/tty/serial/sirfsoc_uart.c
@@ -1283,6 +1283,11 @@ static int sirfsoc_uart_probe(struct platform_device *pdev)
 		goto err;
 	}
 	sirfport->port.line = of_alias_get_id(np, "serial");
+	if (sirfport->port.line >= SIRFSOC_UART_NR) {
+		dev_err(&pdev->dev, "serial%d out of range\n",
+			sirfport->port.line);
+		return -EINVAL;
+	}
 	sirf_ports[sirfport->port.line] = sirfport;
 	sirfport->port.iotype = UPIO_MEM;
 	sirfport->port.flags = UPF_BOOT_AUTOCONF;
-- 
2.7.4
