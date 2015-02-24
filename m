From: jorge.ramirez-ortiz@linaro.org (Jorge Ramirez-Ortiz)
Date: Mon, 23 Feb 2015 22:46:53 -0500
Subject: [PATCH] drivers/tty: amba-pl011: defer driver probing if external dma
 is not ready.
In-Reply-To: <1424749613-24765-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
References: <Re: [PATCH] drivers/tty: amba-pl011: defer driver probing if
 external dma is not ready.>
 <1424749613-24765-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
Message-ID: <1424749613-24765-2-git-send-email-jorge.ramirez-ortiz@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch addresses a race condition that happens when
device_initcall(pl011_dma_initicall) is executed before all the devices have been
probed - this issue was observed on an hisi_6220 SoC (HiKey board from Linaro).

The proposed implementation for OF and ACPI uses deferred driver probing to wait for the DMA
controller to be registered.

It defaults to legacy behaviour when platform data is present.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 drivers/tty/serial/amba-pl011.c | 67 ++++++++++++++++++++++++++---------------
 1 file changed, 43 insertions(+), 24 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 8d94c19..d631a0a 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -29,6 +29,7 @@
  * and hooked into this driver.
  */
 
+#define pr_fmt(fmt) "amba-pl011: "fmt
 
 #if defined(CONFIG_SERIAL_AMBA_PL011_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
 #define SUPPORT_SYSRQ
@@ -261,7 +262,8 @@ static void pl011_sgbuf_free(struct dma_chan *chan, struct pl011_sgbuf *sg,
 	}
 }
 
-static void pl011_dma_probe_initcall(struct device *dev, struct uart_amba_port *uap)
+static int pl011_dma_probe(struct device *dev, struct uart_amba_port *uap,
+	void (*queue_dma_probe)(struct device *, struct uart_amba_port *))
 {
 	/* DMA is the sole user of the platform data right now */
 	struct amba_pl011_data *plat = dev_get_platdata(uap->port.dev);
@@ -275,15 +277,23 @@ static void pl011_dma_probe_initcall(struct device *dev, struct uart_amba_port *
 	struct dma_chan *chan;
 	dma_cap_mask_t mask;
 
-	chan = dma_request_slave_channel(dev, "tx");
+	if (queue_dma_probe && plat && plat->dma_filter) {
+		(*queue_dma_probe)(dev, uap);
+		return 0;
+	}
+
+	chan = dma_request_slave_channel_reason(dev, "tx");
+	if (IS_ERR(chan)) {
+
+		/* the dma driver has not been initialized yet */
+		if (PTR_ERR(chan) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
 
-	if (!chan) {
 		/* We need platform data */
 		if (!plat || !plat->dma_filter) {
 			dev_info(uap->port.dev, "no DMA platform data\n");
-			return;
+			return 0;
 		}
-
 		/* Try to acquire a generic DMA engine slave TX channel */
 		dma_cap_zero(mask);
 		dma_cap_set(DMA_SLAVE, mask);
@@ -292,7 +302,7 @@ static void pl011_dma_probe_initcall(struct device *dev, struct uart_amba_port *
 						plat->dma_tx_param);
 		if (!chan) {
 			dev_err(uap->port.dev, "no TX DMA channel!\n");
-			return;
+			return 0;
 		}
 	}
 
@@ -310,7 +320,7 @@ static void pl011_dma_probe_initcall(struct device *dev, struct uart_amba_port *
 
 		if (!chan) {
 			dev_err(uap->port.dev, "no RX DMA channel!\n");
-			return;
+			return 0;
 		}
 	}
 
@@ -383,14 +393,16 @@ static void pl011_dma_probe_initcall(struct device *dev, struct uart_amba_port *
 		dev_info(uap->port.dev, "DMA channel RX %s\n",
 			 dma_chan_name(uap->dmarx.chan));
 	}
+
+	return 0;
 }
 
-#ifndef MODULE
 /*
- * Stack up the UARTs and let the above initcall be done at device
- * initcall time, because the serial driver is called as an arch
- * initcall, and at this time the DMA subsystem is not yet registered.
- * At this point the driver will switch over to using DMA where desired.
+ * On platforms with no OF or ACPI support, we stack up the UARTs and let the
+ * below initcall be done at late initcall time, because the serial driver is
+ * called as an arch * initcall, and at this time the DMA subsystem is not yet
+ * registered. At this point the driver will switch over to using DMA where
+ * desired.
  */
 struct dma_uap {
 	struct list_head node;
@@ -400,22 +412,23 @@ struct dma_uap {
 
 static LIST_HEAD(pl011_dma_uarts);
 
-static int __init pl011_dma_initcall(void)
+static int __init pl011_dequeue_dma_probe_initcall(void)
 {
 	struct list_head *node, *tmp;
 
 	list_for_each_safe(node, tmp, &pl011_dma_uarts) {
 		struct dma_uap *dmau = list_entry(node, struct dma_uap, node);
-		pl011_dma_probe_initcall(dmau->dev, dmau->uap);
+		pl011_dma_probe(dmau->dev, dmau->uap, NULL);
 		list_del(node);
 		kfree(dmau);
 	}
 	return 0;
 }
 
-device_initcall(pl011_dma_initcall);
+late_initcall_sync(pl011_dequeue_dma_probe_initcall);
 
-static void pl011_dma_probe(struct device *dev, struct uart_amba_port *uap)
+static void pl011_queue_dma_probe(struct device *dev,
+	struct uart_amba_port *uap)
 {
 	struct dma_uap *dmau = kzalloc(sizeof(struct dma_uap), GFP_KERNEL);
 	if (dmau) {
@@ -424,12 +437,6 @@ static void pl011_dma_probe(struct device *dev, struct uart_amba_port *uap)
 		list_add_tail(&dmau->node, &pl011_dma_uarts);
 	}
 }
-#else
-static void pl011_dma_probe(struct device *dev, struct uart_amba_port *uap)
-{
-	pl011_dma_probe_initcall(dev, uap);
-}
-#endif
 
 static void pl011_dma_remove(struct uart_amba_port *uap)
 {
@@ -1142,7 +1149,14 @@ static inline bool pl011_dma_rx_running(struct uart_amba_port *uap)
 
 #else
 /* Blank functions if the DMA engine is not available */
-static inline void pl011_dma_probe(struct device *dev, struct uart_amba_port *uap)
+static int pl011_dma_probe(struct device *dev, struct uart_amba_port *uap,
+	void (*queue_dma_probe)(struct device *, struct uart_amba_port *))
+{
+	return 0;
+}
+
+static void pl011_queue_dma_probe(struct device *dev,
+	struct uart_amba_port *uap)
 {
 }
 
@@ -2218,7 +2232,12 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
 	uap->port.ops = &amba_pl011_pops;
 	uap->port.flags = UPF_BOOT_AUTOCONF;
 	uap->port.line = i;
-	pl011_dma_probe(&dev->dev, uap);
+
+	ret = pl011_dma_probe(&dev->dev, uap, &pl011_queue_dma_probe);
+	if (ret == -EPROBE_DEFER) {
+		devm_kfree(&dev->dev, uap);
+		return ret;
+	}
 
 	/* Ensure interrupts from this UART are masked and cleared */
 	writew(0, uap->port.membase + UART011_IMSC);
-- 
1.9.1
