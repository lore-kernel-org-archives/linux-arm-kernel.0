From: nava.manne@xilinx.com (Nava kishore Manne)
Date: Tue, 19 Apr 2016 16:40:48 +0530
Subject: [PATCH v2] Axi-usb: Add support for 64-bit addressing.
Message-ID: <1461064248-31288-1-git-send-email-navam@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates the driver to support 64-bit DMA
addressing.

Signed-off-by: Nava kishore Manne <navam@xilinx.com>
---
Changes for v2:
		-Added dma-ranges property in device tree as suggested by Arnd Bergmann.
                -Modified the driver code based on the xlnx,addrwidth.
 .../devicetree/bindings/usb/udc-xilinx.txt         |  5 ++-
 drivers/usb/gadget/udc/udc-xilinx.c                | 39 ++++++++++++++++++++--
 2 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/udc-xilinx.txt b/Documentation/devicetree/bindings/usb/udc-xilinx.txt
index 47b4e39..850d792 100644
--- a/Documentation/devicetree/bindings/usb/udc-xilinx.txt
+++ b/Documentation/devicetree/bindings/usb/udc-xilinx.txt
@@ -7,12 +7,15 @@ Required properties:
 - interrupts		: Should contain single irq line of USB2 device
 			  controller
 - xlnx,has-builtin-dma	: if DMA is included
-
+- dma-ranges: Should be as the following <dma_addr cpu_addr max_len>.
+- xlnx,addrwidth       : Should be the dma addressing size in bits(ex: 40 bits).
 Example:
  		axi-usb2-device at 42e00000 {
                         compatible = "xlnx,usb2-device-4.00.a";
                         interrupts = <0x0 0x39 0x1>;
                         reg = <0x42e00000 0x10000>;
+			dma-ranges = <0x00000000 0x00000000 0x40000000>;
                         xlnx,has-builtin-dma;
+			xlnx,addrwidth = <0x28>;
                 };
 
diff --git a/drivers/usb/gadget/udc/udc-xilinx.c b/drivers/usb/gadget/udc/udc-xilinx.c
index 1cbb0ac..702ab9e 100644
--- a/drivers/usb/gadget/udc/udc-xilinx.c
+++ b/drivers/usb/gadget/udc/udc-xilinx.c
@@ -28,6 +28,7 @@
 #include <linux/of_irq.h>
 #include <linux/prefetch.h>
 #include <linux/usb/ch9.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/usb/gadget.h>
 
 /* Register offsets for the USB device.*/
@@ -47,6 +48,15 @@
 #define XUSB_DMA_LENGTH_OFFSET		0x0210	/* DMA Length Register */
 #define XUSB_DMA_STATUS_OFFSET		0x0214	/* DMA Status Register */
 
+/* DMA source Address Reg for LSB */
+#define XUSB_DMA_DSAR_ADDR_OFFSET_LSB   0x0308
+/* DMA source Address Reg for MSB */
+#define XUSB_DMA_DSAR_ADDR_OFFSET_MSB   0x030C
+/* DMA destination Addr Reg LSB */
+#define XUSB_DMA_DDAR_ADDR_OFFSET_LSB   0x0310
+/* DMA destination Addr Reg MSB */
+#define XUSB_DMA_DDAR_ADDR_OFFSET_MSB   0x0314
+
 /* Endpoint Configuration Space offsets */
 #define XUSB_EP_CFGSTATUS_OFFSET	0x00	/* Endpoint Config Status  */
 #define XUSB_EP_BUF0COUNT_OFFSET	0x08	/* Buffer 0 Count */
@@ -176,6 +186,7 @@ struct xusb_ep {
  * @addr: the usb device base address
  * @lock: instance of spinlock
  * @dma_enabled: flag indicating whether the dma is included in the system
+ * @dma_addrwidth:Indicate the DMA address width.
  * @read_fn: function pointer to read device registers
  * @write_fn: function pointer to write to device registers
  */
@@ -193,7 +204,7 @@ struct xusb_udc {
 	void __iomem *addr;
 	spinlock_t lock;
 	bool dma_enabled;
-
+	u32 dma_addrwidth;
 	unsigned int (*read_fn)(void __iomem *);
 	void (*write_fn)(void __iomem *, u32, u32);
 };
@@ -215,6 +226,17 @@ static const struct usb_endpoint_descriptor config_bulk_out_desc = {
 };
 
 /**
+ * xudc_write64 - write 64bit value to device registers
+ * @addr: base addr of device registers
+ * @offset: register offset
+ * @val: data to be written
+ **/
+static void xudc_write64(void __iomem *addr, u32 offset, u64 val)
+{
+	lo_hi_writeq(val, addr + offset);
+}
+
+/**
  * xudc_write32 - little endian write to device registers
  * @addr: base addr of device registers
  * @offset: register offset
@@ -330,8 +352,13 @@ static int xudc_start_dma(struct xusb_ep *ep, dma_addr_t src,
 	 * destination registers and then set the length
 	 * into the DMA length register.
 	 */
-	udc->write_fn(udc->addr, XUSB_DMA_DSAR_ADDR_OFFSET, src);
-	udc->write_fn(udc->addr, XUSB_DMA_DDAR_ADDR_OFFSET, dst);
+	if (udc->dma_addrwidth > 32) {
+		xudc_write64(udc->addr, XUSB_DMA_DSAR_ADDR_OFFSET_LSB, src);
+		xudc_write64(udc->addr, XUSB_DMA_DDAR_ADDR_OFFSET_LSB, dst);
+	} else {
+		udc->write_fn(udc->addr, XUSB_DMA_DSAR_ADDR_OFFSET, src);
+		udc->write_fn(udc->addr, XUSB_DMA_DDAR_ADDR_OFFSET, dst);
+	}
 	udc->write_fn(udc->addr, XUSB_DMA_LENGTH_OFFSET, length);
 
 	/*
@@ -2097,6 +2124,12 @@ static int xudc_probe(struct platform_device *pdev)
 
 	udc->dma_enabled = of_property_read_bool(np, "xlnx,has-builtin-dma");
 
+	ret = of_property_read_u32(np, "xlnx,addrwidth", &udc->dma_addrwidth);
+	if (ret < 0)
+		dev_warn(&pdev->dev, "missing xlnx,addrwidth property\n");
+
+	/* Set the dma mask bits */
+	dma_set_mask(&pdev->dev, DMA_BIT_MASK(udc->dma_addrwidth));
 	/* Setup gadget structure */
 	udc->gadget.ops = &xusb_udc_ops;
 	udc->gadget.max_speed = USB_SPEED_HIGH;
-- 
2.1.2
