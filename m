From: yuanzhichang@hisilicon.com (Zhichang Yuan)
Date: Wed, 7 Sep 2016 21:33:53 +0800
Subject: [PATCH V2 4/4] ARM64 LPC: support earlycon for UART connected to LPC
In-Reply-To: <1473255233-154297-1-git-send-email-yuanzhichang@hisilicon.com>
References: <1473255233-154297-1-git-send-email-yuanzhichang@hisilicon.com>
Message-ID: <1473255233-154297-5-git-send-email-yuanzhichang@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "zhichang.yuan" <yuanzhichang@hisilicon.com>

This patch support the earlycon for UART connected to LPC on Hip06.
This patch is depended on the LPC driver.

Signed-off-by: zhichang.yuan <yuanzhichang@hisilicon.com>
---
 drivers/bus/hisi_lpc.c | 129 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 129 insertions(+)

diff --git a/drivers/bus/hisi_lpc.c b/drivers/bus/hisi_lpc.c
index 7ac0551..1cc5581 100644
--- a/drivers/bus/hisi_lpc.c
+++ b/drivers/bus/hisi_lpc.c
@@ -374,6 +374,135 @@ void hisilpc_comm_outb(void *devobj, unsigned long ptaddr,
 }
 
 
+static struct extio_ops hisilpc_earlyop __initdata;
+
+/**
+ * hisilpc_early_in - read/input operation specific for hisi LPC earlycon.
+ * @devobj: pointer to device relevant information of the caller.
+ * @inbuf: the buffer where the read back data is populated.
+ * @ptaddr: the io address where read operation targets to.
+ * @dlen: data length in byte to be read each IO operation.
+ * @count: how many IO operations expected.
+ * for earlycon, dlen and count should be one.
+ *
+ * Returns 0 on success, non-zero on fail.
+ *
+ */
+static u64 __init hisilpc_early_in(void *devobj, unsigned long ptaddr,
+				void *inbuf, size_t dlen,unsigned int count)
+{
+	unsigned int ret = 0;
+	struct lpc_cycle_para para;
+	struct hisilpc_dev lpcdev;
+	struct uart_port *port;
+	unsigned int rd_data;
+
+	port = (struct uart_port *)devobj;
+	if (!port->mapbase || !port->membase || inbuf ||
+			count != 1 || dlen !=1)
+		return -EINVAL;
+
+	para.opflags = FG_EARLYCON_LPC;
+	para.csize = dlen;
+	lpcdev.membase = port->membase;
+
+	ret = hisilpc_target_in(&lpcdev, &para, ptaddr,
+				(unsigned char *)&rd_data, count);
+
+	return (ret) ? : rd_data;
+}
+
+/**
+ * hisilpc_early_out - write/output operation specific for hisi LPC earlycon.
+ * @devobj: pointer to device relevant information of the caller.
+ * @outbuf: the buffer where the data to be written is stored.
+ * @ptaddr: the io address where write operation targets to.
+ * @dlen: data length in byte to be written each IO operation.
+ * @count: how many IO operations expected.
+ * for earlycon, dlen and count must be one.
+ *
+ */
+static void __init hisilpc_early_out(void *devobj, unsigned long ptaddr,
+				const void *outbuf, size_t dlen,
+				unsigned int count)
+{
+	struct lpc_cycle_para para;
+	struct hisilpc_dev lpcdev;
+	struct uart_port *port;
+
+	port = (struct uart_port *)devobj;
+	if (!port->mapbase || !port->membase || !outbuf ||
+			dlen != 1 || count != 1)
+		return;
+
+	para.opflags = FG_EARLYCON_LPC;
+	para.csize = dlen;
+	lpcdev.membase = port->membase;
+
+	(void)hisilpc_target_out(&lpcdev, &para, ptaddr, outbuf, count);
+}
+
+
+/**
+ * early_hisilpc8250_setup - initilize the lpc earlycon
+ * @device: pointer to the elarycon device
+ * @options: a option string from earlycon kernel-parameter
+ *
+ * Returns 0 on success, non-zero on fail.
+ *
+ */
+static int __init early_hisilpc8250_setup(struct earlycon_device *device,
+						const char *options)
+{
+	char *p;
+	int ret;
+
+	if (!device->port.membase)
+		return -ENODEV;
+
+	if (device->port.iotype != UPIO_MEM)
+		return -EINVAL;
+
+	if (device->options) {
+		p = strchr(device->options, ',');
+		if (p && (p + 1) != '\0') {
+			ret = kstrtoul(++p, 0,
+				(unsigned long *)&device->port.iobase);
+			if (ret || device->port.iobase == 0)
+				return ret ?: -EFAULT;
+		} else
+			device->port.iobase = 0x2f8;
+	} else {
+		device->port.iobase = 0x2f8;
+		device->baud = 0;
+	}
+
+	/* must set iotype as UPIO_PORT for Hip06 indirect-io */
+	device->port.iotype = UPIO_PORT;
+
+	hisilpc_earlyop.pfin = hisilpc_early_in;
+	hisilpc_earlyop.pfout = hisilpc_early_out;
+	hisilpc_earlyop.devpara = &device->port;
+
+
+	/* disable interrupts from LPC */
+	writel(LPC_IRQ_CLEAR, device->port.membase + LPC_REG_IRQ_ST);
+	/* ensure the LPC is available */
+	while (!(readl(device->port.membase + LPC_REG_OP_STATUS) &
+			LPC_STATUS_IDLE))
+		cpu_relax();
+
+	arm64_set_simops(&hisilpc_earlyop);
+
+	return early_serial8250_setup(device, options);
+}
+
+
+
+EARLYCON_DECLARE(hisilpcuart, early_hisilpc8250_setup);
+OF_EARLYCON_DECLARE(hisilpcuart, "hisi,rawlpc-uart",
+					early_hisilpc8250_setup);
+
 /**
  * hisilpc_probe - the probe callback function for hisi lpc device,
  *		will finish all the intialization.
-- 
1.9.1
