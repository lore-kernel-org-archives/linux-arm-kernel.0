From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Thu, 14 Apr 2016 14:13:21 +0200
Subject: [PATCH 3/5] serial: mxs-auart: Use generic uart-has-rtscts DT property
In-Reply-To: <1460636003-3011-1-git-send-email-geert+renesas@glider.be>
References: <1460636003-3011-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1460636003-3011-4-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert the Freescale MXS AUART driver from using the vendor-specific
"fsl,uart-has-rtscts" to the generic "uart-has-rtscts" DT property, as
documented by the Generic Serial DT Bindings.

The old vendor-specific property is still recognized by the driver for
backwards compatibility, but it is deprecated.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/serial/fsl-mxs-auart.txt | 2 +-
 drivers/tty/serial/mxs-auart.c                             | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/fsl-mxs-auart.txt b/Documentation/devicetree/bindings/serial/fsl-mxs-auart.txt
index 7c408c87e6138979..9ba60c14047a0be8 100644
--- a/Documentation/devicetree/bindings/serial/fsl-mxs-auart.txt
+++ b/Documentation/devicetree/bindings/serial/fsl-mxs-auart.txt
@@ -11,7 +11,7 @@ Required properties:
 - dma-names: "rx" for RX channel, "tx" for TX channel.
 
 Optional properties:
-- fsl,uart-has-rtscts : Indicate the UART has RTS and CTS lines
+- uart-has-rtscts : Indicate the UART has RTS and CTS lines
   for hardware flow control,
 	it also means you enable the DMA support for this UART.
 - {rts,cts,dtr,dsr,rng,dcd}-gpios: specify a GPIO for RTS/CTS/DTR/DSR/RI/DCD
diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index cd0414bbe094898e..c988544f38bbb885 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -1185,7 +1185,8 @@ static int serial_mxs_probe_dt(struct mxs_auart_port *s,
 	}
 	s->port.line = ret;
 
-	if (of_get_property(np, "fsl,uart-has-rtscts", NULL))
+	if (of_get_property(np, "uart-has-rtscts", NULL) ||
+	    of_get_property(np, "fsl,uart-has-rtscts", NULL) /* deprecated */)
 		set_bit(MXS_AUART_RTSCTS, &s->flags);
 
 	return 0;
-- 
1.9.1
