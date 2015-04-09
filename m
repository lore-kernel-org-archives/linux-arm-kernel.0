From: andre.przywara@arm.com (Andre Przywara)
Date: Thu,  9 Apr 2015 12:29:20 +0100
Subject: [PATCH v3 09/10] drivers: PL011: allow to supply fixed option string
In-Reply-To: <1428578961-6896-1-git-send-email-andre.przywara@arm.com>
References: <1428578961-6896-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1428578961-6896-10-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SBSA UART has a fixed baud rate and flow control setting, which
cannot be changed or queried by software.
Add a vendor specific property to always return fixed values when
trying to read the console options.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/tty/serial/amba-pl011.c |   17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 98cb889..fcb95bd 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -79,6 +79,7 @@ struct vendor_data {
 	bool			dma_threshold;
 	bool			cts_event_workaround;
 	bool			always_enabled;
+	bool			fixed_options;
 
 	unsigned int (*get_fifosize)(struct amba_device *dev);
 };
@@ -96,6 +97,7 @@ static struct vendor_data vendor_arm = {
 	.dma_threshold		= false,
 	.cts_event_workaround	= false,
 	.always_enabled		= false,
+	.fixed_options		= false,
 	.get_fifosize		= get_fifosize_arm,
 };
 
@@ -112,6 +114,7 @@ static struct vendor_data vendor_st = {
 	.dma_threshold		= true,
 	.cts_event_workaround	= true,
 	.always_enabled		= false,
+	.fixed_options		= false,
 	.get_fifosize		= get_fifosize_st,
 };
 
@@ -160,6 +163,7 @@ struct uart_amba_port {
 	unsigned int		lcrh_rx;	/* vendor-specific */
 	unsigned int		old_cr;		/* state during shutdown */
 	bool			autorts;
+	unsigned int		fixed_baud;	/* vendor-set fixed baud rate */
 	char			type[12];
 #ifdef CONFIG_DMA_ENGINE
 	/* DMA stuff */
@@ -2077,10 +2081,15 @@ static int __init pl011_console_setup(struct console *co, char *options)
 
 	uap->port.uartclk = clk_get_rate(uap->clk);
 
-	if (options)
-		uart_parse_options(options, &baud, &parity, &bits, &flow);
-	else
-		pl011_console_get_options(uap, &baud, &parity, &bits);
+	if (uap->vendor->fixed_options) {
+		baud = uap->fixed_baud;
+	} else {
+		if (options)
+			uart_parse_options(options,
+					   &baud, &parity, &bits, &flow);
+		else
+			pl011_console_get_options(uap, &baud, &parity, &bits);
+	}
 
 	return uart_set_options(&uap->port, co, baud, parity, bits, flow);
 }
-- 
1.7.9.5
