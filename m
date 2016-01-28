From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 28 Jan 2016 17:17:04 +0100
Subject: [PATCH 3/7] usb: gadget: pxa25x_udc: use readl/writel for mmio
In-Reply-To: <1453997843-3489728-1-git-send-email-arnd@arndb.de>
References: <1453997722-3489596-1-git-send-email-arnd@arndb.de>
 <1453997843-3489728-1-git-send-email-arnd@arndb.de>
Message-ID: <1453997843-3489728-3-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This converts the pxa25x udc driver to use readl/writel as normal
driver should do, rather than dereferencing __iomem pointers
themselves.

Based on the earlier preparation work, we can now also pass
the register start in the device pointer so we no longer need
the global variable.

The unclear part here is for IXP4xx, which supports both big-endian
and little-endian configurations. So far, the driver has done
no byteswap in either case. I suspect that is wrong and it would
actually need to swap in one or the other case, but I don't know
which. It's also possible that there is some magic setting in
the chip that makes the endianess of the MMIO register match the
CPU, and in that case, the code actually does the right thing
for all configurations, both before and after this patch.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/usb/gadget/udc/pxa25x_udc.c | 61 ++++++++++++++++++++++++-------------
 drivers/usb/gadget/udc/pxa25x_udc.h |  1 +
 2 files changed, 40 insertions(+), 22 deletions(-)

diff --git a/drivers/usb/gadget/udc/pxa25x_udc.c b/drivers/usb/gadget/udc/pxa25x_udc.c
index 5db429f3cfb2..6d3acbf3b311 100644
--- a/drivers/usb/gadget/udc/pxa25x_udc.c
+++ b/drivers/usb/gadget/udc/pxa25x_udc.c
@@ -52,9 +52,6 @@
 #include <mach/lubbock.h>
 #endif
 
-static void __iomem *pxa25x_udc_reg_base;
-#define __UDC_REG(x) (*((volatile u32 *)(pxa25x_udc_reg_base + (x))))
-
 #define UDCCR	 0x0000 /* UDC Control Register */
 #define UDC_RES1 0x0004 /* UDC Undocumented - Reserved1 */
 #define UDC_RES2 0x0008 /* UDC Undocumented - Reserved2 */
@@ -292,16 +289,36 @@ static void pullup_on(void)
 		mach->udc_command(PXA2XX_UDC_CMD_CONNECT);
 }
 
-static inline void udc_set_reg(struct pxa25x_udc *dev, u32 reg, u32 uicr)
+#if defined(CONFIG_ARCH_IXP4XX) && defined(CONFIG_CPU_BIG_ENDIAN)
+/*
+ * not sure if this is the correct behavior on ixp4xx in both
+ * bit-endian and little-endian modes, but it's what the driver
+ * has always done using direct pointer dereferences:
+ * We assume that there is a byteswap done in hardware at the
+ * MMIO register that matches what the CPU setting is, so we
+ * never swap in software.
+ */
+static inline void udc_set_reg(struct pxa25x_udc *dev, u32 reg, u32 val)
 {
-	__UDC_REG(reg) = uicr;
+	iowrite32be(val, dev->regs + reg);
 }
 
 static inline u32 udc_get_reg(struct pxa25x_udc *dev, u32 reg)
 {
-	return __UDC_REG(reg);
+	return ioread32be(dev->regs + reg);
+}
+#else
+static inline void udc_set_reg(struct pxa25x_udc *dev, u32 reg, u32 val)
+{
+	writel(val, dev->regs + reg);
 }
 
+static inline u32 udc_get_reg(struct pxa25x_udc *dev, u32 reg)
+{
+	return readl(dev->regs + reg);
+}
+#endif
+
 static void pio_irq_enable(struct pxa25x_ep *ep)
 {
 	u32 bEndpointAddress = ep->bEndpointAddress & 0xf;
@@ -337,59 +354,59 @@ static void pio_irq_disable(struct pxa25x_ep *ep)
 
 static inline void udc_set_mask_UDCCR(struct pxa25x_udc *dev, int mask)
 {
-	u32 udccr = __UDC_REG(UDCCR);
+	u32 udccr = udc_get_reg(dev, UDCCR);
 
-	__UDC_REG(UDCCR) = (udccr & UDCCR_MASK_BITS) | (mask & UDCCR_MASK_BITS);
+	udc_set_reg(dev, (udccr & UDCCR_MASK_BITS) | (mask & UDCCR_MASK_BITS), UDCCR);
 }
 
 static inline void udc_clear_mask_UDCCR(struct pxa25x_udc *dev, int mask)
 {
-	u32 udccr = __UDC_REG(UDCCR);
+	u32 udccr = udc_get_reg(dev, UDCCR);
 
-	__UDC_REG(UDCCR) = (udccr & UDCCR_MASK_BITS) & ~(mask & UDCCR_MASK_BITS);
+	udc_set_reg(dev, (udccr & UDCCR_MASK_BITS) & ~(mask & UDCCR_MASK_BITS), UDCCR);
 }
 
 static inline void udc_ack_int_UDCCR(struct pxa25x_udc *dev, int mask)
 {
 	/* udccr contains the bits we dont want to change */
-	u32 udccr = __UDC_REG(UDCCR) & UDCCR_MASK_BITS;
+	u32 udccr = udc_get_reg(dev, UDCCR) & UDCCR_MASK_BITS;
 
-	__UDC_REG(UDCCR) = udccr | (mask & ~UDCCR_MASK_BITS);
+	udc_set_reg(dev, udccr | (mask & ~UDCCR_MASK_BITS), UDCCR);
 }
 
 static inline u32 udc_ep_get_UDCCS(struct pxa25x_ep *ep)
 {
-	return __UDC_REG(ep->regoff_udccs);
+	return udc_get_reg(ep->dev, ep->regoff_udccs);
 }
 
 static inline void udc_ep_set_UDCCS(struct pxa25x_ep *ep, u32 data)
 {
-	__UDC_REG(ep->regoff_udccs) = data;
+	udc_set_reg(ep->dev, data, ep->regoff_udccs);
 }
 
 static inline u32 udc_ep0_get_UDCCS(struct pxa25x_udc *dev)
 {
-	return __UDC_REG(UDCCS0);
+	return udc_get_reg(dev, UDCCS0);
 }
 
 static inline void udc_ep0_set_UDCCS(struct pxa25x_udc *dev, u32 data)
 {
-	__UDC_REG(UDCCS0) = data;
+	udc_set_reg(dev, data, UDCCS0);
 }
 
 static inline u32 udc_ep_get_UDDR(struct pxa25x_ep *ep)
 {
-	return __UDC_REG(ep->regoff_uddr);
+	return udc_get_reg(ep->dev, ep->regoff_uddr);
 }
 
 static inline void udc_ep_set_UDDR(struct pxa25x_ep *ep, u32 data)
 {
-	__UDC_REG(ep->regoff_uddr) = data;
+	udc_set_reg(ep->dev, data, ep->regoff_uddr);
 }
 
 static inline u32 udc_ep_get_UBCR(struct pxa25x_ep *ep)
 {
-	return __UDC_REG(ep->regoff_ubcr);
+	return udc_get_reg(ep->dev, ep->regoff_ubcr);
 }
 
 /*
@@ -2369,9 +2386,9 @@ static int pxa25x_udc_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	pxa25x_udc_reg_base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(pxa25x_udc_reg_base))
-		return PTR_ERR(pxa25x_udc_reg_base);
+	dev->regs = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(dev->regs))
+		return PTR_ERR(dev->regs);
 
 	dev->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(dev->clk))
diff --git a/drivers/usb/gadget/udc/pxa25x_udc.h b/drivers/usb/gadget/udc/pxa25x_udc.h
index f884513f7390..4b8b72d7ab37 100644
--- a/drivers/usb/gadget/udc/pxa25x_udc.h
+++ b/drivers/usb/gadget/udc/pxa25x_udc.h
@@ -125,6 +125,7 @@ struct pxa25x_udc {
 #ifdef CONFIG_USB_GADGET_DEBUG_FS
 	struct dentry				*debugfs_udc;
 #endif
+	void __iomem				*regs;
 };
 #define to_pxa25x(g)	(container_of((g), struct pxa25x_udc, gadget))
 
-- 
2.7.0
