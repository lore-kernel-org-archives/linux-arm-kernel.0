From: jorge.ramirez-ortiz@linaro.org (Jorge Ramirez-Ortiz)
Date: Wed, 25 Feb 2015 19:31:01 -0500
Subject: [PATCH v3] drivers/tty: amba: defer probing DMA availability until
 hw_init
Message-ID: <1424910661-26474-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix a race condition that happens when device_initcall(pl011_dma_initicall)
is executed before all the devices have been probed - this issue was observed on
an hisi_6220 SoC (HiKey board from Linaro).

The deferred driver probing framework relies on late_initcall to trigger
deferred probes so it is just possible that, even with a valid DMA driver ready
to be loaded, we fail to synchronize with it.

The proposed implementation delays probing of the DMA until the uart device is
opened. As hw_init is invoked on port startup and port resume - but the DMA
probe is only required once - we avoid calling multiple times using a new field
in uart_amba_port to track this scenario.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 drivers/tty/serial/amba-pl011.c | 66 ++++++++++-------------------------------
 1 file changed, 16 insertions(+), 50 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 8d94c19..3501ccc 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -29,6 +29,7 @@
  * and hooked into this driver.
  */
 
+#define pr_fmt(fmt) "amba-pl011: "fmt
 
 #if defined(CONFIG_SERIAL_AMBA_PL011_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
 #define SUPPORT_SYSRQ
@@ -164,6 +165,7 @@ struct uart_amba_port {
 	bool			using_rx_dma;
 	struct pl011_dmarx_data dmarx;
 	struct pl011_dmatx_data	dmatx;
+	bool			dma_probed;
 #endif
 };
 
@@ -261,7 +263,7 @@ static void pl011_sgbuf_free(struct dma_chan *chan, struct pl011_sgbuf *sg,
 	}
 }
 
-static void pl011_dma_probe_initcall(struct device *dev, struct uart_amba_port *uap)
+static void pl011_dma_probe(struct device *dev, struct uart_amba_port *uap)
 {
 	/* DMA is the sole user of the platform data right now */
 	struct amba_pl011_data *plat = dev_get_platdata(uap->port.dev);
@@ -275,9 +277,16 @@ static void pl011_dma_probe_initcall(struct device *dev, struct uart_amba_port *
 	struct dma_chan *chan;
 	dma_cap_mask_t mask;
 
-	chan = dma_request_slave_channel(dev, "tx");
+	uap->dma_probed = true;
+
+	chan = dma_request_slave_channel_reason(dev, "tx");
+	if (IS_ERR(chan)) {
+		if (PTR_ERR(chan) == -EPROBE_DEFER) {
+			dev_warn(uap->port.dev, "DMA driver not ready\n");
+			return;
+		}
+		dev_info(uap->port.dev, "no OF or ACPI DMA data\n");
 
-	if (!chan) {
 		/* We need platform data */
 		if (!plat || !plat->dma_filter) {
 			dev_info(uap->port.dev, "no DMA platform data\n");
@@ -383,54 +392,9 @@ static void pl011_dma_probe_initcall(struct device *dev, struct uart_amba_port *
 		dev_info(uap->port.dev, "DMA channel RX %s\n",
 			 dma_chan_name(uap->dmarx.chan));
 	}
-}
-
-#ifndef MODULE
-/*
- * Stack up the UARTs and let the above initcall be done at device
- * initcall time, because the serial driver is called as an arch
- * initcall, and at this time the DMA subsystem is not yet registered.
- * At this point the driver will switch over to using DMA where desired.
- */
-struct dma_uap {
-	struct list_head node;
-	struct uart_amba_port *uap;
-	struct device *dev;
-};
-
-static LIST_HEAD(pl011_dma_uarts);
-
-static int __init pl011_dma_initcall(void)
-{
-	struct list_head *node, *tmp;
-
-	list_for_each_safe(node, tmp, &pl011_dma_uarts) {
-		struct dma_uap *dmau = list_entry(node, struct dma_uap, node);
-		pl011_dma_probe_initcall(dmau->dev, dmau->uap);
-		list_del(node);
-		kfree(dmau);
-	}
-	return 0;
-}
-
-device_initcall(pl011_dma_initcall);
 
-static void pl011_dma_probe(struct device *dev, struct uart_amba_port *uap)
-{
-	struct dma_uap *dmau = kzalloc(sizeof(struct dma_uap), GFP_KERNEL);
-	if (dmau) {
-		dmau->uap = uap;
-		dmau->dev = dev;
-		list_add_tail(&dmau->node, &pl011_dma_uarts);
-	}
+	return;
 }
-#else
-static void pl011_dma_probe(struct device *dev, struct uart_amba_port *uap)
-{
-	pl011_dma_probe_initcall(dev, uap);
-}
-#endif
-
 static void pl011_dma_remove(struct uart_amba_port *uap)
 {
 	/* TODO: remove the initcall if it has not yet executed */
@@ -1548,6 +1512,9 @@ static int pl011_hwinit(struct uart_port *port)
 	uap->im = readw(uap->port.membase + UART011_IMSC);
 	writew(UART011_RTIM | UART011_RXIM, uap->port.membase + UART011_IMSC);
 
+	if (!uap->dma_probed)
+		pl011_dma_probe(uap->port.dev, uap);
+
 	if (dev_get_platdata(uap->port.dev)) {
 		struct amba_pl011_data *plat;
 
@@ -2218,7 +2185,6 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
 	uap->port.ops = &amba_pl011_pops;
 	uap->port.flags = UPF_BOOT_AUTOCONF;
 	uap->port.line = i;
-	pl011_dma_probe(&dev->dev, uap);
 
 	/* Ensure interrupts from this UART are masked and cleared */
 	writew(0, uap->port.membase + UART011_IMSC);
-- 
1.9.1
