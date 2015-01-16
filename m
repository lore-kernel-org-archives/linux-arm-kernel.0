From: andre.przywara@arm.com (Andre Przywara)
Date: Fri, 16 Jan 2015 17:23:05 +0000
Subject: [PATCH 09/10] drivers: PL011: allow to supply fixed option string
In-Reply-To: <1421428986-11300-1-git-send-email-andre.przywara@arm.com>
References: <1421428986-11300-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1421428986-11300-10-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SBSA UART has a fixed baud rate and flow control setting, which
cannot be changed or queried by software.
Add a vendor specific property to always return fixed values when
trying to read the console options.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/tty/serial/amba-pl011.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 833c399..a1c929f 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -79,6 +79,7 @@ struct vendor_data {
 	bool			dma_threshold;
 	bool			cts_event_workaround;
 	bool			always_enabled;
+	char			*fixed_options;
 
 	unsigned int (*get_fifosize)(struct amba_device *dev);
 };
@@ -96,6 +97,7 @@ static struct vendor_data vendor_arm = {
 	.dma_threshold		= false,
 	.cts_event_workaround	= false,
 	.always_enabled		= false,
+	.fixed_options		= NULL,
 	.get_fifosize		= get_fifosize_arm,
 };
 
@@ -112,6 +114,7 @@ static struct vendor_data vendor_st = {
 	.dma_threshold		= true,
 	.cts_event_workaround	= true,
 	.always_enabled		= false,
+	.fixed_options		= NULL,
 	.get_fifosize		= get_fifosize_st,
 };
 
@@ -2109,6 +2112,9 @@ static int __init pl011_console_setup(struct console *co, char *options)
 
 	uap->port.uartclk = clk_get_rate(uap->clk);
 
+	if (!options && uap->vendor->fixed_options)
+		options = uap->vendor->fixed_options;
+
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
 	else
-- 
1.7.9.5
