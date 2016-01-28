From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 28 Jan 2016 17:17:03 +0100
Subject: [PATCH 2/7] usb: gadget: pxa25x_udc cleanup
In-Reply-To: <1453997843-3489728-1-git-send-email-arnd@arndb.de>
References: <1453997722-3489596-1-git-send-email-arnd@arndb.de>
 <1453997843-3489728-1-git-send-email-arnd@arndb.de>
Message-ID: <1453997843-3489728-2-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This removes the dependency on the mach/hardware.h header file
from the pxa25x_udc driver after the register definitions were
already unified in the previous patch.

Following the model of pxa27x_udc (and basically all other drivers
in the kernel), we define the register numbers as offsets from
the register base address and use accessor functions to read/write
them.

For the moment, this still leaves the direct pointer dereference
in place, instead of using readl/writel, so this patch should
not be changing the behavior of the driver, other than using
ioremap() on the platform resource to replace the hardcoded
virtual address pointers.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/usb/gadget/udc/pxa25x_udc.c | 468 +++++++++++++++++++++---------------
 drivers/usb/gadget/udc/pxa25x_udc.h |  10 +-
 2 files changed, 275 insertions(+), 203 deletions(-)

diff --git a/drivers/usb/gadget/udc/pxa25x_udc.c b/drivers/usb/gadget/udc/pxa25x_udc.c
index 26537f50374d..5db429f3cfb2 100644
--- a/drivers/usb/gadget/udc/pxa25x_udc.c
+++ b/drivers/usb/gadget/udc/pxa25x_udc.c
@@ -48,70 +48,63 @@
 #include <linux/usb/gadget.h>
 #include <linux/usb/otg.h>
 
-#include <mach/hardware.h>
-
 #ifdef CONFIG_ARCH_LUBBOCK
 #include <mach/lubbock.h>
 #endif
 
-#ifdef CONFIG_ARCH_IXP4XX
-#define __UDC_REG(x) (*((volatile u32 *)(IXP4XX_USB_BASE_VIRT + (x))))
-#endif
-
-#ifdef CONFIG_ARCH_PXA
-#define __UDC_REG(x) __REG(0x40600000 + (x))
-#endif
-
-#define UDCCR		__UDC_REG(0x0000)  /* UDC Control Register */
-#define UDC_RES1	__UDC_REG(0x0004)  /* UDC Undocumented - Reserved1 */
-#define UDC_RES2	__UDC_REG(0x0008)  /* UDC Undocumented - Reserved2 */
-#define UDC_RES3	__UDC_REG(0x000C)  /* UDC Undocumented - Reserved3 */
-#define UDCCS0		__UDC_REG(0x0010)  /* UDC Endpoint 0 Control/Status Register */
-#define UDCCS1		__UDC_REG(0x0014)  /* UDC Endpoint 1 (IN) Control/Status Register */
-#define UDCCS2		__UDC_REG(0x0018)  /* UDC Endpoint 2 (OUT) Control/Status Register */
-#define UDCCS3		__UDC_REG(0x001C)  /* UDC Endpoint 3 (IN) Control/Status Register */
-#define UDCCS4		__UDC_REG(0x0020)  /* UDC Endpoint 4 (OUT) Control/Status Register */
-#define UDCCS5		__UDC_REG(0x0024)  /* UDC Endpoint 5 (Interrupt) Control/Status Register */
-#define UDCCS6		__UDC_REG(0x0028)  /* UDC Endpoint 6 (IN) Control/Status Register */
-#define UDCCS7		__UDC_REG(0x002C)  /* UDC Endpoint 7 (OUT) Control/Status Register */
-#define UDCCS8		__UDC_REG(0x0030)  /* UDC Endpoint 8 (IN) Control/Status Register */
-#define UDCCS9		__UDC_REG(0x0034)  /* UDC Endpoint 9 (OUT) Control/Status Register */
-#define UDCCS10		__UDC_REG(0x0038)  /* UDC Endpoint 10 (Interrupt) Control/Status Register */
-#define UDCCS11		__UDC_REG(0x003C)  /* UDC Endpoint 11 (IN) Control/Status Register */
-#define UDCCS12		__UDC_REG(0x0040)  /* UDC Endpoint 12 (OUT) Control/Status Register */
-#define UDCCS13		__UDC_REG(0x0044)  /* UDC Endpoint 13 (IN) Control/Status Register */
-#define UDCCS14		__UDC_REG(0x0048)  /* UDC Endpoint 14 (OUT) Control/Status Register */
-#define UDCCS15		__UDC_REG(0x004C)  /* UDC Endpoint 15 (Interrupt) Control/Status Register */
-#define UFNRH		__UDC_REG(0x0060)  /* UDC Frame Number Register High */
-#define UFNRL		__UDC_REG(0x0064)  /* UDC Frame Number Register Low */
-#define UBCR2		__UDC_REG(0x0068)  /* UDC Byte Count Reg 2 */
-#define UBCR4		__UDC_REG(0x006c)  /* UDC Byte Count Reg 4 */
-#define UBCR7		__UDC_REG(0x0070)  /* UDC Byte Count Reg 7 */
-#define UBCR9		__UDC_REG(0x0074)  /* UDC Byte Count Reg 9 */
-#define UBCR12		__UDC_REG(0x0078)  /* UDC Byte Count Reg 12 */
-#define UBCR14		__UDC_REG(0x007c)  /* UDC Byte Count Reg 14 */
-#define UDDR0		__UDC_REG(0x0080)  /* UDC Endpoint 0 Data Register */
-#define UDDR1		__UDC_REG(0x0100)  /* UDC Endpoint 1 Data Register */
-#define UDDR2		__UDC_REG(0x0180)  /* UDC Endpoint 2 Data Register */
-#define UDDR3		__UDC_REG(0x0200)  /* UDC Endpoint 3 Data Register */
-#define UDDR4		__UDC_REG(0x0400)  /* UDC Endpoint 4 Data Register */
-#define UDDR5		__UDC_REG(0x00A0)  /* UDC Endpoint 5 Data Register */
-#define UDDR6		__UDC_REG(0x0600)  /* UDC Endpoint 6 Data Register */
-#define UDDR7		__UDC_REG(0x0680)  /* UDC Endpoint 7 Data Register */
-#define UDDR8		__UDC_REG(0x0700)  /* UDC Endpoint 8 Data Register */
-#define UDDR9		__UDC_REG(0x0900)  /* UDC Endpoint 9 Data Register */
-#define UDDR10		__UDC_REG(0x00C0)  /* UDC Endpoint 10 Data Register */
-#define UDDR11		__UDC_REG(0x0B00)  /* UDC Endpoint 11 Data Register */
-#define UDDR12		__UDC_REG(0x0B80)  /* UDC Endpoint 12 Data Register */
-#define UDDR13		__UDC_REG(0x0C00)  /* UDC Endpoint 13 Data Register */
-#define UDDR14		__UDC_REG(0x0E00)  /* UDC Endpoint 14 Data Register */
-#define UDDR15		__UDC_REG(0x00E0)  /* UDC Endpoint 15 Data Register */
-
-#define UICR0		__UDC_REG(0x0050)  /* UDC Interrupt Control Register 0 */
-#define UICR1		__UDC_REG(0x0054)  /* UDC Interrupt Control Register 1 */
-
-#define USIR0		__UDC_REG(0x0058)  /* UDC Status Interrupt Register 0 */
-#define USIR1		__UDC_REG(0x005C)  /* UDC Status Interrupt Register 1 */
+static void __iomem *pxa25x_udc_reg_base;
+#define __UDC_REG(x) (*((volatile u32 *)(pxa25x_udc_reg_base + (x))))
+
+#define UDCCR	 0x0000 /* UDC Control Register */
+#define UDC_RES1 0x0004 /* UDC Undocumented - Reserved1 */
+#define UDC_RES2 0x0008 /* UDC Undocumented - Reserved2 */
+#define UDC_RES3 0x000C /* UDC Undocumented - Reserved3 */
+#define UDCCS0	 0x0010 /* UDC Endpoint 0 Control/Status Register */
+#define UDCCS1	 0x0014 /* UDC Endpoint 1 (IN) Control/Status Register */
+#define UDCCS2	 0x0018 /* UDC Endpoint 2 (OUT) Control/Status Register */
+#define UDCCS3	 0x001C /* UDC Endpoint 3 (IN) Control/Status Register */
+#define UDCCS4	 0x0020 /* UDC Endpoint 4 (OUT) Control/Status Register */
+#define UDCCS5	 0x0024 /* UDC Endpoint 5 (Interrupt) Control/Status Register */
+#define UDCCS6	 0x0028 /* UDC Endpoint 6 (IN) Control/Status Register */
+#define UDCCS7	 0x002C /* UDC Endpoint 7 (OUT) Control/Status Register */
+#define UDCCS8	 0x0030 /* UDC Endpoint 8 (IN) Control/Status Register */
+#define UDCCS9	 0x0034 /* UDC Endpoint 9 (OUT) Control/Status Register */
+#define UDCCS10	 0x0038 /* UDC Endpoint 10 (Interrupt) Control/Status Register */
+#define UDCCS11	 0x003C /* UDC Endpoint 11 (IN) Control/Status Register */
+#define UDCCS12	 0x0040 /* UDC Endpoint 12 (OUT) Control/Status Register */
+#define UDCCS13	 0x0044 /* UDC Endpoint 13 (IN) Control/Status Register */
+#define UDCCS14	 0x0048 /* UDC Endpoint 14 (OUT) Control/Status Register */
+#define UDCCS15	 0x004C /* UDC Endpoint 15 (Interrupt) Control/Status Register */
+#define UFNRH	 0x0060 /* UDC Frame Number Register High */
+#define UFNRL	 0x0064 /* UDC Frame Number Register Low */
+#define UBCR2	 0x0068 /* UDC Byte Count Reg 2 */
+#define UBCR4	 0x006c /* UDC Byte Count Reg 4 */
+#define UBCR7	 0x0070 /* UDC Byte Count Reg 7 */
+#define UBCR9	 0x0074 /* UDC Byte Count Reg 9 */
+#define UBCR12	 0x0078 /* UDC Byte Count Reg 12 */
+#define UBCR14	 0x007c /* UDC Byte Count Reg 14 */
+#define UDDR0	 0x0080 /* UDC Endpoint 0 Data Register */
+#define UDDR1	 0x0100 /* UDC Endpoint 1 Data Register */
+#define UDDR2	 0x0180 /* UDC Endpoint 2 Data Register */
+#define UDDR3	 0x0200 /* UDC Endpoint 3 Data Register */
+#define UDDR4	 0x0400 /* UDC Endpoint 4 Data Register */
+#define UDDR5	 0x00A0 /* UDC Endpoint 5 Data Register */
+#define UDDR6	 0x0600 /* UDC Endpoint 6 Data Register */
+#define UDDR7	 0x0680 /* UDC Endpoint 7 Data Register */
+#define UDDR8	 0x0700 /* UDC Endpoint 8 Data Register */
+#define UDDR9	 0x0900 /* UDC Endpoint 9 Data Register */
+#define UDDR10	 0x00C0 /* UDC Endpoint 10 Data Register */
+#define UDDR11	 0x0B00 /* UDC Endpoint 11 Data Register */
+#define UDDR12	 0x0B80 /* UDC Endpoint 12 Data Register */
+#define UDDR13	 0x0C00 /* UDC Endpoint 13 Data Register */
+#define UDDR14	 0x0E00 /* UDC Endpoint 14 Data Register */
+#define UDDR15	 0x00E0 /* UDC Endpoint 15 Data Register */
+
+#define UICR0	 0x0050 /* UDC Interrupt Control Register 0 */
+#define UICR1	 0x0054 /* UDC Interrupt Control Register 1 */
+
+#define USIR0	 0x0058 /* UDC Status Interrupt Register 0 */
+#define USIR1	 0x005C /* UDC Status Interrupt Register 1 */
 
 #define UDCCR_UDE	(1 << 0)	/* UDC enable */
 #define UDCCR_UDA	(1 << 1)	/* UDC active */
@@ -299,25 +292,41 @@ static void pullup_on(void)
 		mach->udc_command(PXA2XX_UDC_CMD_CONNECT);
 }
 
-static void pio_irq_enable(int bEndpointAddress)
+static inline void udc_set_reg(struct pxa25x_udc *dev, u32 reg, u32 uicr)
+{
+	__UDC_REG(reg) = uicr;
+}
+
+static inline u32 udc_get_reg(struct pxa25x_udc *dev, u32 reg)
 {
-        bEndpointAddress &= 0xf;
+	return __UDC_REG(reg);
+}
+
+static void pio_irq_enable(struct pxa25x_ep *ep)
+{
+	u32 bEndpointAddress = ep->bEndpointAddress & 0xf;
+
         if (bEndpointAddress < 8)
-                UICR0 &= ~(1 << bEndpointAddress);
+		udc_set_reg(ep->dev, UICR0, udc_get_reg(ep->dev, UICR0) &
+						~(1 << bEndpointAddress));
         else {
                 bEndpointAddress -= 8;
-                UICR1 &= ~(1 << bEndpointAddress);
+		udc_set_reg(ep->dev, UICR1, udc_get_reg(ep->dev, UICR1) &
+						~(1 << bEndpointAddress));
 	}
 }
 
-static void pio_irq_disable(int bEndpointAddress)
+static void pio_irq_disable(struct pxa25x_ep *ep)
 {
-        bEndpointAddress &= 0xf;
+	u32 bEndpointAddress = ep->bEndpointAddress & 0xf;
+
         if (bEndpointAddress < 8)
-                UICR0 |= 1 << bEndpointAddress;
+                udc_set_reg(ep->dev, UICR0, udc_get_reg(ep->dev, UICR0) |
+						(1 << bEndpointAddress));
         else {
                 bEndpointAddress -= 8;
-                UICR1 |= 1 << bEndpointAddress;
+                udc_set_reg(ep->dev, UICR1, udc_get_reg(ep->dev, UICR1) |
+						(1 << bEndpointAddress));
         }
 }
 
@@ -326,22 +335,61 @@ static void pio_irq_disable(int bEndpointAddress)
  */
 #define UDCCR_MASK_BITS         (UDCCR_REM | UDCCR_SRM | UDCCR_UDE)
 
-static inline void udc_set_mask_UDCCR(int mask)
+static inline void udc_set_mask_UDCCR(struct pxa25x_udc *dev, int mask)
 {
-	UDCCR = (UDCCR & UDCCR_MASK_BITS) | (mask & UDCCR_MASK_BITS);
+	u32 udccr = __UDC_REG(UDCCR);
+
+	__UDC_REG(UDCCR) = (udccr & UDCCR_MASK_BITS) | (mask & UDCCR_MASK_BITS);
 }
 
-static inline void udc_clear_mask_UDCCR(int mask)
+static inline void udc_clear_mask_UDCCR(struct pxa25x_udc *dev, int mask)
 {
-	UDCCR = (UDCCR & UDCCR_MASK_BITS) & ~(mask & UDCCR_MASK_BITS);
+	u32 udccr = __UDC_REG(UDCCR);
+
+	__UDC_REG(UDCCR) = (udccr & UDCCR_MASK_BITS) & ~(mask & UDCCR_MASK_BITS);
 }
 
-static inline void udc_ack_int_UDCCR(int mask)
+static inline void udc_ack_int_UDCCR(struct pxa25x_udc *dev, int mask)
 {
 	/* udccr contains the bits we dont want to change */
-	__u32 udccr = UDCCR & UDCCR_MASK_BITS;
+	u32 udccr = __UDC_REG(UDCCR) & UDCCR_MASK_BITS;
 
-	UDCCR = udccr | (mask & ~UDCCR_MASK_BITS);
+	__UDC_REG(UDCCR) = udccr | (mask & ~UDCCR_MASK_BITS);
+}
+
+static inline u32 udc_ep_get_UDCCS(struct pxa25x_ep *ep)
+{
+	return __UDC_REG(ep->regoff_udccs);
+}
+
+static inline void udc_ep_set_UDCCS(struct pxa25x_ep *ep, u32 data)
+{
+	__UDC_REG(ep->regoff_udccs) = data;
+}
+
+static inline u32 udc_ep0_get_UDCCS(struct pxa25x_udc *dev)
+{
+	return __UDC_REG(UDCCS0);
+}
+
+static inline void udc_ep0_set_UDCCS(struct pxa25x_udc *dev, u32 data)
+{
+	__UDC_REG(UDCCS0) = data;
+}
+
+static inline u32 udc_ep_get_UDDR(struct pxa25x_ep *ep)
+{
+	return __UDC_REG(ep->regoff_uddr);
+}
+
+static inline void udc_ep_set_UDDR(struct pxa25x_ep *ep, u32 data)
+{
+	__UDC_REG(ep->regoff_uddr) = data;
+}
+
+static inline u32 udc_ep_get_UBCR(struct pxa25x_ep *ep)
+{
+	return __UDC_REG(ep->regoff_ubcr);
 }
 
 /*
@@ -507,7 +555,7 @@ static inline void ep0_idle (struct pxa25x_udc *dev)
 }
 
 static int
-write_packet(volatile u32 *uddr, struct pxa25x_request *req, unsigned max)
+write_packet(struct pxa25x_ep *ep, struct pxa25x_request *req, unsigned max)
 {
 	u8		*buf;
 	unsigned	length, count;
@@ -521,7 +569,7 @@ write_packet(volatile u32 *uddr, struct pxa25x_request *req, unsigned max)
 
 	count = length;
 	while (likely(count--))
-		*uddr = *buf++;
+		udc_ep_set_UDDR(ep, *buf++);
 
 	return length;
 }
@@ -541,7 +589,7 @@ write_fifo (struct pxa25x_ep *ep, struct pxa25x_request *req)
 		unsigned	count;
 		int		is_last, is_short;
 
-		count = write_packet(ep->reg_uddr, req, max);
+		count = write_packet(ep, req, max);
 
 		/* last packet is usually short (or a zlp) */
 		if (unlikely (count != max))
@@ -565,15 +613,15 @@ write_fifo (struct pxa25x_ep *ep, struct pxa25x_request *req)
 		 * double buffering might work.  TSP, TPC, and TFS
 		 * bit values are the same for all normal IN endpoints.
 		 */
-		*ep->reg_udccs = UDCCS_BI_TPC;
+		udc_ep_set_UDCCS(ep, UDCCS_BI_TPC);
 		if (is_short)
-			*ep->reg_udccs = UDCCS_BI_TSP;
+			udc_ep_set_UDCCS(ep, UDCCS_BI_TSP);
 
 		/* requests complete when all IN data is in the FIFO */
 		if (is_last) {
 			done (ep, req, 0);
 			if (list_empty(&ep->queue))
-				pio_irq_disable (ep->bEndpointAddress);
+				pio_irq_disable(ep);
 			return 1;
 		}
 
@@ -581,7 +629,7 @@ write_fifo (struct pxa25x_ep *ep, struct pxa25x_request *req)
 		// double buffering is off in the default fifo mode, which
 		// prevents TFS from being set here.
 
-	} while (*ep->reg_udccs & UDCCS_BI_TFS);
+	} while (udc_ep_get_UDCCS(ep) & UDCCS_BI_TFS);
 	return 0;
 }
 
@@ -591,20 +639,21 @@ write_fifo (struct pxa25x_ep *ep, struct pxa25x_request *req)
 static inline
 void ep0start(struct pxa25x_udc *dev, u32 flags, const char *tag)
 {
-	UDCCS0 = flags|UDCCS0_SA|UDCCS0_OPR;
-	USIR0 = USIR0_IR0;
+	udc_ep0_set_UDCCS(dev, flags|UDCCS0_SA|UDCCS0_OPR);
+	udc_set_reg(dev, USIR0, USIR0_IR0);
 	dev->req_pending = 0;
 	DBG(DBG_VERY_NOISY, "%s %s, %02x/%02x\n",
-		__func__, tag, UDCCS0, flags);
+		__func__, tag, udc_ep0_get_UDCCS(dev), flags);
 }
 
 static int
 write_ep0_fifo (struct pxa25x_ep *ep, struct pxa25x_request *req)
 {
+	struct pxa25x_udc *dev = ep->dev;
 	unsigned	count;
 	int		is_short;
 
-	count = write_packet(&UDDR0, req, EP0_FIFO_SIZE);
+	count = write_packet(&dev->ep[0], req, EP0_FIFO_SIZE);
 	ep->dev->stats.write.bytes += count;
 
 	/* last packet "must be" short (or a zlp) */
@@ -617,7 +666,7 @@ write_ep0_fifo (struct pxa25x_ep *ep, struct pxa25x_request *req)
 		if (ep->dev->req_pending)
 			ep0start(ep->dev, UDCCS0_IPR, "short IN");
 		else
-			UDCCS0 = UDCCS0_IPR;
+			udc_ep0_set_UDCCS(dev, UDCCS0_IPR);
 
 		count = req->req.length;
 		done (ep, req, 0);
@@ -633,9 +682,9 @@ write_ep0_fifo (struct pxa25x_ep *ep, struct pxa25x_request *req)
 		if (count >= EP0_FIFO_SIZE) {
 			count = 100;
 			do {
-				if ((UDCCS0 & UDCCS0_OPR) != 0) {
+				if ((udc_ep0_get_UDCCS(dev) & UDCCS0_OPR) != 0) {
 					/* clear OPR, generate ack */
-					UDCCS0 = UDCCS0_OPR;
+					udc_ep0_set_UDCCS(dev, UDCCS0_OPR);
 					break;
 				}
 				count--;
@@ -670,7 +719,7 @@ read_fifo (struct pxa25x_ep *ep, struct pxa25x_request *req)
 		 * UDCCS_{BO,IO}_RPC are all the same bit value.
 		 * UDCCS_{BO,IO}_RNE are all the same bit value.
 		 */
-		udccs = *ep->reg_udccs;
+		udccs = udc_ep_get_UDCCS(ep);
 		if (unlikely ((udccs & UDCCS_BO_RPC) == 0))
 			break;
 		buf = req->req.buf + req->req.actual;
@@ -679,7 +728,7 @@ read_fifo (struct pxa25x_ep *ep, struct pxa25x_request *req)
 
 		/* read all bytes from this packet */
 		if (likely (udccs & UDCCS_BO_RNE)) {
-			count = 1 + (0x0ff & *ep->reg_ubcr);
+			count = 1 + (0x0ff & udc_ep_get_UBCR(ep));
 			req->req.actual += min (count, bufferspace);
 		} else /* zlp */
 			count = 0;
@@ -689,7 +738,7 @@ read_fifo (struct pxa25x_ep *ep, struct pxa25x_request *req)
 			is_short ? "/S" : "",
 			req, req->req.actual, req->req.length);
 		while (likely (count-- != 0)) {
-			u8	byte = (u8) *ep->reg_uddr;
+			u8	byte = (u8) udc_ep_get_UDDR(ep);
 
 			if (unlikely (bufferspace == 0)) {
 				/* this happens when the driver's buffer
@@ -705,7 +754,7 @@ read_fifo (struct pxa25x_ep *ep, struct pxa25x_request *req)
 				bufferspace--;
 			}
 		}
-		*ep->reg_udccs =  UDCCS_BO_RPC;
+		udc_ep_set_UDCCS(ep, UDCCS_BO_RPC);
 		/* RPC/RSP/RNE could now reflect the other packet buffer */
 
 		/* iso is one request per packet */
@@ -720,7 +769,7 @@ read_fifo (struct pxa25x_ep *ep, struct pxa25x_request *req)
 		if (is_short || req->req.actual == req->req.length) {
 			done (ep, req, 0);
 			if (list_empty(&ep->queue))
-				pio_irq_disable (ep->bEndpointAddress);
+				pio_irq_disable(ep);
 			return 1;
 		}
 
@@ -744,7 +793,7 @@ read_ep0_fifo (struct pxa25x_ep *ep, struct pxa25x_request *req)
 	buf = req->req.buf + req->req.actual;
 	bufferspace = req->req.length - req->req.actual;
 
-	while (UDCCS0 & UDCCS0_RNE) {
+	while (udc_ep_get_UDCCS(ep) & UDCCS0_RNE) {
 		byte = (u8) UDDR0;
 
 		if (unlikely (bufferspace == 0)) {
@@ -762,7 +811,7 @@ read_ep0_fifo (struct pxa25x_ep *ep, struct pxa25x_request *req)
 		}
 	}
 
-	UDCCS0 = UDCCS0_OPR | UDCCS0_IPR;
+	udc_ep_set_UDCCS(ep, UDCCS0_OPR | UDCCS0_IPR);
 
 	/* completion */
 	if (req->req.actual >= req->req.length)
@@ -836,8 +885,8 @@ pxa25x_ep_queue(struct usb_ep *_ep, struct usb_request *_req, gfp_t gfp_flags)
 					DBG(DBG_VERBOSE, "ep0 config ack%s\n",
 						dev->has_cfr ?  "" : " raced");
 					if (dev->has_cfr)
-						UDCCFR = UDCCFR_AREN|UDCCFR_ACM
-							|UDCCFR_MB1;
+						udc_set_reg(dev, UDCCFR, UDCCFR_AREN |
+							    UDCCFR_ACM | UDCCFR_MB1);
 					done(ep, req, 0);
 					dev->ep0state = EP0_END_XFER;
 					local_irq_restore (flags);
@@ -845,7 +894,7 @@ pxa25x_ep_queue(struct usb_ep *_ep, struct usb_request *_req, gfp_t gfp_flags)
 				}
 				if (dev->req_pending)
 					ep0start(dev, UDCCS0_IPR, "OUT");
-				if (length == 0 || ((UDCCS0 & UDCCS0_RNE) != 0
+				if (length == 0 || ((udc_ep0_get_UDCCS(dev) & UDCCS0_RNE) != 0
 						&& read_ep0_fifo(ep, req))) {
 					ep0_idle(dev);
 					done(ep, req, 0);
@@ -860,16 +909,16 @@ pxa25x_ep_queue(struct usb_ep *_ep, struct usb_request *_req, gfp_t gfp_flags)
 			}
 		/* can the FIFO can satisfy the request immediately? */
 		} else if ((ep->bEndpointAddress & USB_DIR_IN) != 0) {
-			if ((*ep->reg_udccs & UDCCS_BI_TFS) != 0
+			if ((udc_ep_get_UDCCS(ep) & UDCCS_BI_TFS) != 0
 					&& write_fifo(ep, req))
 				req = NULL;
-		} else if ((*ep->reg_udccs & UDCCS_BO_RFS) != 0
+		} else if ((udc_ep_get_UDCCS(ep) & UDCCS_BO_RFS) != 0
 				&& read_fifo(ep, req)) {
 			req = NULL;
 		}
 
 		if (likely(req && ep->ep.desc))
-			pio_irq_enable(ep->bEndpointAddress);
+			pio_irq_enable(ep);
 	}
 
 	/* pio or dma irq handler advances the queue. */
@@ -896,7 +945,7 @@ static void nuke(struct pxa25x_ep *ep, int status)
 		done(ep, req, status);
 	}
 	if (ep->ep.desc)
-		pio_irq_disable (ep->bEndpointAddress);
+		pio_irq_disable(ep);
 }
 
 
@@ -956,14 +1005,14 @@ static int pxa25x_ep_set_halt(struct usb_ep *_ep, int value)
 	local_irq_save(flags);
 
 	if ((ep->bEndpointAddress & USB_DIR_IN) != 0
-			&& ((*ep->reg_udccs & UDCCS_BI_TFS) == 0
+			&& ((udc_ep_get_UDCCS(ep) & UDCCS_BI_TFS) == 0
 			   || !list_empty(&ep->queue))) {
 		local_irq_restore(flags);
 		return -EAGAIN;
 	}
 
 	/* FST bit is the same for control, bulk in, bulk out, interrupt in */
-	*ep->reg_udccs = UDCCS_BI_FST|UDCCS_BI_FTF;
+	udc_ep_set_UDCCS(ep, UDCCS_BI_FST|UDCCS_BI_FTF);
 
 	/* ep0 needs special care */
 	if (!ep->ep.desc) {
@@ -975,7 +1024,7 @@ static int pxa25x_ep_set_halt(struct usb_ep *_ep, int value)
 	} else {
 		unsigned i;
 		for (i = 0; i < 1000; i += 20) {
-			if (*ep->reg_udccs & UDCCS_BI_SST)
+			if (udc_ep_get_UDCCS(ep) & UDCCS_BI_SST)
 				break;
 			udelay(20);
 		}
@@ -999,10 +1048,10 @@ static int pxa25x_ep_fifo_status(struct usb_ep *_ep)
 	if ((ep->bEndpointAddress & USB_DIR_IN) != 0)
 		return -EOPNOTSUPP;
 	if (ep->dev->gadget.speed == USB_SPEED_UNKNOWN
-			|| (*ep->reg_udccs & UDCCS_BO_RFS) == 0)
+			|| (udc_ep_get_UDCCS(ep) & UDCCS_BO_RFS) == 0)
 		return 0;
 	else
-		return (*ep->reg_ubcr & 0xfff) + 1;
+		return (udc_ep_get_UBCR(ep) & 0xfff) + 1;
 }
 
 static void pxa25x_ep_fifo_flush(struct usb_ep *_ep)
@@ -1019,15 +1068,15 @@ static void pxa25x_ep_fifo_flush(struct usb_ep *_ep)
 
 	/* for OUT, just read and discard the FIFO contents. */
 	if ((ep->bEndpointAddress & USB_DIR_IN) == 0) {
-		while (((*ep->reg_udccs) & UDCCS_BO_RNE) != 0)
-			(void) *ep->reg_uddr;
+		while (((udc_ep_get_UDCCS(ep)) & UDCCS_BO_RNE) != 0)
+			(void)udc_ep_get_UDDR(ep);
 		return;
 	}
 
 	/* most IN status is the same, but ISO can't stall */
-	*ep->reg_udccs = UDCCS_BI_TPC|UDCCS_BI_FTF|UDCCS_BI_TUR
+	udc_ep_set_UDCCS(ep, UDCCS_BI_TPC|UDCCS_BI_FTF|UDCCS_BI_TUR
 		| (ep->bmAttributes == USB_ENDPOINT_XFER_ISOC
-			? 0 : UDCCS_BI_SST);
+			? 0 : UDCCS_BI_SST));
 }
 
 
@@ -1054,15 +1103,23 @@ static struct usb_ep_ops pxa25x_ep_ops = {
 
 static int pxa25x_udc_get_frame(struct usb_gadget *_gadget)
 {
-	return ((UFNRH & 0x07) << 8) | (UFNRL & 0xff);
+	struct pxa25x_udc	*dev;
+
+	dev = container_of(_gadget, struct pxa25x_udc, gadget);
+	return ((udc_get_reg(dev, UFNRH) & 0x07) << 8) |
+		(udc_get_reg(dev, UFNRL) & 0xff);
 }
 
 static int pxa25x_udc_wakeup(struct usb_gadget *_gadget)
 {
+	struct pxa25x_udc	*udc;
+
+	udc = container_of(_gadget, struct pxa25x_udc, gadget);
+
 	/* host may not have enabled remote wakeup */
-	if ((UDCCS0 & UDCCS0_DRWF) == 0)
+	if ((udc_ep0_get_UDCCS(udc) & UDCCS0_DRWF) == 0)
 		return -EHOSTUNREACH;
-	udc_set_mask_UDCCR(UDCCR_RSM);
+	udc_set_mask_UDCCR(udc, UDCCR_RSM);
 	return 0;
 }
 
@@ -1183,9 +1240,11 @@ udc_seq_show(struct seq_file *m, void *_d)
 	/* registers for device and ep0 */
 	seq_printf(m,
 		"uicr %02X.%02X, usir %02X.%02x, ufnr %02X.%02X\n",
-		UICR1, UICR0, USIR1, USIR0, UFNRH, UFNRL);
+		udc_get_reg(dev, UICR1), udc_get_reg(dev, UICR0),
+		udc_get_reg(dev, USIR1), udc_get_reg(dev, USIR0),
+		udc_get_reg(dev, UFNRH), udc_get_reg(dev, UFNRL));
 
-	tmp = UDCCR;
+	tmp = udc_get_reg(dev, UDCCR);
 	seq_printf(m,
 		"udccr %02X =%s%s%s%s%s%s%s%s\n", tmp,
 		(tmp & UDCCR_REM) ? " rem" : "",
@@ -1197,7 +1256,7 @@ udc_seq_show(struct seq_file *m, void *_d)
 		(tmp & UDCCR_UDA) ? " uda" : "",
 		(tmp & UDCCR_UDE) ? " ude" : "");
 
-	tmp = UDCCS0;
+	tmp = udc_ep0_get_UDCCS(dev);
 	seq_printf(m,
 		"udccs0 %02X =%s%s%s%s%s%s%s%s\n", tmp,
 		(tmp & UDCCS0_SA) ? " sa" : "",
@@ -1210,7 +1269,7 @@ udc_seq_show(struct seq_file *m, void *_d)
 		(tmp & UDCCS0_OPR) ? " opr" : "");
 
 	if (dev->has_cfr) {
-		tmp = UDCCFR;
+		tmp = udc_get_reg(dev, UDCCFR);
 		seq_printf(m,
 			"udccfr %02X =%s%s\n", tmp,
 			(tmp & UDCCFR_AREN) ? " aren" : "",
@@ -1236,7 +1295,7 @@ udc_seq_show(struct seq_file *m, void *_d)
 			desc = ep->ep.desc;
 			if (!desc)
 				continue;
-			tmp = *dev->ep [i].reg_udccs;
+			tmp = udc_ep_get_UDCCS(&dev->ep[i]);
 			seq_printf(m,
 				"%s max %d %s udccs %02x irqs %lu\n",
 				ep->ep.name, usb_endpoint_maxp(desc),
@@ -1300,14 +1359,15 @@ static const struct file_operations debug_fops = {
 static void udc_disable(struct pxa25x_udc *dev)
 {
 	/* block all irqs */
-	udc_set_mask_UDCCR(UDCCR_SRM|UDCCR_REM);
-	UICR0 = UICR1 = 0xff;
-	UFNRH = UFNRH_SIM;
+	udc_set_mask_UDCCR(dev, UDCCR_SRM|UDCCR_REM);
+	udc_set_reg(dev, UICR0, 0xff);
+	udc_set_reg(dev, UICR1, 0xff);
+	udc_set_reg(dev, UFNRH, UFNRH_SIM);
 
 	/* if hardware supports it, disconnect from usb */
 	pullup_off();
 
-	udc_clear_mask_UDCCR(UDCCR_UDE);
+	udc_clear_mask_UDCCR(dev, UDCCR_UDE);
 
 	ep0_idle (dev);
 	dev->gadget.speed = USB_SPEED_UNKNOWN;
@@ -1349,10 +1409,10 @@ static void udc_reinit(struct pxa25x_udc *dev)
  */
 static void udc_enable (struct pxa25x_udc *dev)
 {
-	udc_clear_mask_UDCCR(UDCCR_UDE);
+	udc_clear_mask_UDCCR(dev, UDCCR_UDE);
 
 	/* try to clear these bits before we enable the udc */
-	udc_ack_int_UDCCR(UDCCR_SUSIR|/*UDCCR_RSTIR|*/UDCCR_RESIR);
+	udc_ack_int_UDCCR(dev, UDCCR_SUSIR|/*UDCCR_RSTIR|*/UDCCR_RESIR);
 
 	ep0_idle(dev);
 	dev->gadget.speed = USB_SPEED_UNKNOWN;
@@ -1364,15 +1424,15 @@ static void udc_enable (struct pxa25x_udc *dev)
 	 * - if RESET is already in progress, ack interrupt
 	 * - unmask reset interrupt
 	 */
-	udc_set_mask_UDCCR(UDCCR_UDE);
-	if (!(UDCCR & UDCCR_UDA))
-		udc_ack_int_UDCCR(UDCCR_RSTIR);
+	udc_set_mask_UDCCR(dev, UDCCR_UDE);
+	if (!(udc_get_reg(dev, UDCCR) & UDCCR_UDA))
+		udc_ack_int_UDCCR(dev, UDCCR_RSTIR);
 
 	if (dev->has_cfr /* UDC_RES2 is defined */) {
 		/* pxa255 (a0+) can avoid a set_config race that could
 		 * prevent gadget drivers from configuring correctly
 		 */
-		UDCCFR = UDCCFR_ACM | UDCCFR_MB1;
+		udc_set_reg(dev, UDCCFR, UDCCFR_ACM | UDCCFR_MB1);
 	} else {
 		/* "USB test mode" for pxa250 errata 40-42 (stepping a0, a1)
 		 * which could result in missing packets and interrupts.
@@ -1380,15 +1440,15 @@ static void udc_enable (struct pxa25x_udc *dev)
 		 * double buffers or not; ACM/AREN bits fit into the holes.
 		 * zero bits (like USIR0_IRx) disable double buffering.
 		 */
-		UDC_RES1 = 0x00;
-		UDC_RES2 = 0x00;
+		udc_set_reg(dev, UDC_RES1, 0x00);
+		udc_set_reg(dev, UDC_RES2, 0x00);
 	}
 
 	/* enable suspend/resume and reset irqs */
-	udc_clear_mask_UDCCR(UDCCR_SRM | UDCCR_REM);
+	udc_clear_mask_UDCCR(dev, UDCCR_SRM | UDCCR_REM);
 
 	/* enable ep0 irqs */
-	UICR0 &= ~UICR0_IM0;
+	udc_set_reg(dev, UICR0, udc_get_reg(dev, UICR0) & ~UICR0_IM0);
 
 	/* if hardware supports it, pullup D+ and wait for reset */
 	pullup_on();
@@ -1557,9 +1617,9 @@ static void udc_watchdog(unsigned long _dev)
 
 	local_irq_disable();
 	if (dev->ep0state == EP0_STALL
-			&& (UDCCS0 & UDCCS0_FST) == 0
-			&& (UDCCS0 & UDCCS0_SST) == 0) {
-		UDCCS0 = UDCCS0_FST|UDCCS0_FTF;
+			&& (udc_ep0_get_UDCCS(dev) & UDCCS0_FST) == 0
+			&& (udc_ep0_get_UDCCS(dev) & UDCCS0_SST) == 0) {
+		udc_ep0_set_UDCCS(dev, UDCCS0_FST|UDCCS0_FTF);
 		DBG(DBG_VERBOSE, "ep0 re-stall\n");
 		start_watchdog(dev);
 	}
@@ -1568,7 +1628,7 @@ static void udc_watchdog(unsigned long _dev)
 
 static void handle_ep0 (struct pxa25x_udc *dev)
 {
-	u32			udccs0 = UDCCS0;
+	u32			udccs0 = udc_ep0_get_UDCCS(dev);
 	struct pxa25x_ep	*ep = &dev->ep [0];
 	struct pxa25x_request	*req;
 	union {
@@ -1585,7 +1645,7 @@ static void handle_ep0 (struct pxa25x_udc *dev)
 	/* clear stall status */
 	if (udccs0 & UDCCS0_SST) {
 		nuke(ep, -EPIPE);
-		UDCCS0 = UDCCS0_SST;
+		udc_ep0_set_UDCCS(dev, UDCCS0_SST);
 		del_timer(&dev->timer);
 		ep0_idle(dev);
 	}
@@ -1600,7 +1660,7 @@ static void handle_ep0 (struct pxa25x_udc *dev)
 	switch (dev->ep0state) {
 	case EP0_IDLE:
 		/* late-breaking status? */
-		udccs0 = UDCCS0;
+		udccs0 = udc_ep0_get_UDCCS(dev);
 
 		/* start control request? */
 		if (likely((udccs0 & (UDCCS0_OPR|UDCCS0_SA|UDCCS0_RNE))
@@ -1611,14 +1671,14 @@ static void handle_ep0 (struct pxa25x_udc *dev)
 
 			/* read SETUP packet */
 			for (i = 0; i < 8; i++) {
-				if (unlikely(!(UDCCS0 & UDCCS0_RNE))) {
+				if (unlikely(!(udc_ep0_get_UDCCS(dev) & UDCCS0_RNE))) {
 bad_setup:
 					DMSG("SETUP %d!\n", i);
 					goto stall;
 				}
 				u.raw [i] = (u8) UDDR0;
 			}
-			if (unlikely((UDCCS0 & UDCCS0_RNE) != 0))
+			if (unlikely((udc_ep0_get_UDCCS(dev) & UDCCS0_RNE) != 0))
 				goto bad_setup;
 
 got_setup:
@@ -1694,7 +1754,7 @@ config_change:
 					 */
 				}
 				DBG(DBG_VERBOSE, "protocol STALL, "
-					"%02x err %d\n", UDCCS0, i);
+					"%02x err %d\n", udc_ep0_get_UDCCS(dev), i);
 stall:
 				/* the watchdog timer helps deal with cases
 				 * where udc seems to clear FST wrongly, and
@@ -1741,12 +1801,12 @@ stall:
 			 * - IPR cleared
 			 * - OPR got set, without SA (likely status stage)
 			 */
-			UDCCS0 = udccs0 & (UDCCS0_SA|UDCCS0_OPR);
+			udc_ep0_set_UDCCS(dev, udccs0 & (UDCCS0_SA|UDCCS0_OPR));
 		}
 		break;
 	case EP0_IN_DATA_PHASE:			/* GET_DESCRIPTOR etc */
 		if (udccs0 & UDCCS0_OPR) {
-			UDCCS0 = UDCCS0_OPR|UDCCS0_FTF;
+			udc_ep0_set_UDCCS(dev, UDCCS0_OPR|UDCCS0_FTF);
 			DBG(DBG_VERBOSE, "ep0in premature status\n");
 			if (req)
 				done(ep, req, 0);
@@ -1780,14 +1840,14 @@ stall:
 		 * also appears after some config change events.
 		 */
 		if (udccs0 & UDCCS0_OPR)
-			UDCCS0 = UDCCS0_OPR;
+			udc_ep0_set_UDCCS(dev, UDCCS0_OPR);
 		ep0_idle(dev);
 		break;
 	case EP0_STALL:
-		UDCCS0 = UDCCS0_FST;
+		udc_ep0_set_UDCCS(dev, UDCCS0_FST);
 		break;
 	}
-	USIR0 = USIR0_IR0;
+	udc_set_reg(dev, USIR0, USIR0_IR0);
 }
 
 static void handle_ep(struct pxa25x_ep *ep)
@@ -1807,14 +1867,14 @@ static void handle_ep(struct pxa25x_ep *ep)
 
 		// TODO check FST handling
 
-		udccs = *ep->reg_udccs;
+		udccs = udc_ep_get_UDCCS(ep);
 		if (unlikely(is_in)) {	/* irq from TPC, SST, or (ISO) TUR */
 			tmp = UDCCS_BI_TUR;
 			if (likely(ep->bmAttributes == USB_ENDPOINT_XFER_BULK))
 				tmp |= UDCCS_BI_SST;
 			tmp &= udccs;
 			if (likely (tmp))
-				*ep->reg_udccs = tmp;
+				udc_ep_set_UDCCS(ep, tmp);
 			if (req && likely ((udccs & UDCCS_BI_TFS) != 0))
 				completed = write_fifo(ep, req);
 
@@ -1825,13 +1885,13 @@ static void handle_ep(struct pxa25x_ep *ep)
 				tmp = UDCCS_IO_ROF | UDCCS_IO_DME;
 			tmp &= udccs;
 			if (likely(tmp))
-				*ep->reg_udccs = tmp;
+				udc_ep_set_UDCCS(ep, tmp);
 
 			/* fifos can hold packets, ready for reading... */
 			if (likely(req)) {
 				completed = read_fifo(ep, req);
 			} else
-				pio_irq_disable (ep->bEndpointAddress);
+				pio_irq_disable(ep);
 		}
 		ep->pio_irqs++;
 	} while (completed);
@@ -1852,13 +1912,13 @@ pxa25x_udc_irq(int irq, void *_dev)
 
 	dev->stats.irqs++;
 	do {
-		u32		udccr = UDCCR;
+		u32		udccr = udc_get_reg(dev, UDCCR);
 
 		handled = 0;
 
 		/* SUSpend Interrupt Request */
 		if (unlikely(udccr & UDCCR_SUSIR)) {
-			udc_ack_int_UDCCR(UDCCR_SUSIR);
+			udc_ack_int_UDCCR(dev, UDCCR_SUSIR);
 			handled = 1;
 			DBG(DBG_VERBOSE, "USB suspend\n");
 
@@ -1871,7 +1931,7 @@ pxa25x_udc_irq(int irq, void *_dev)
 
 		/* RESume Interrupt Request */
 		if (unlikely(udccr & UDCCR_RESIR)) {
-			udc_ack_int_UDCCR(UDCCR_RESIR);
+			udc_ack_int_UDCCR(dev, UDCCR_RESIR);
 			handled = 1;
 			DBG(DBG_VERBOSE, "USB resume\n");
 
@@ -1883,10 +1943,10 @@ pxa25x_udc_irq(int irq, void *_dev)
 
 		/* ReSeT Interrupt Request - USB reset */
 		if (unlikely(udccr & UDCCR_RSTIR)) {
-			udc_ack_int_UDCCR(UDCCR_RSTIR);
+			udc_ack_int_UDCCR(dev, UDCCR_RSTIR);
 			handled = 1;
 
-			if ((UDCCR & UDCCR_UDA) == 0) {
+			if ((udc_get_reg(dev, UDCCR) & UDCCR_UDA) == 0) {
 				DBG(DBG_VERBOSE, "USB reset start\n");
 
 				/* reset driver and endpoints,
@@ -1902,8 +1962,10 @@ pxa25x_udc_irq(int irq, void *_dev)
 			}
 
 		} else {
-			u32	usir0 = USIR0 & ~UICR0;
-			u32	usir1 = USIR1 & ~UICR1;
+			u32	usir0 = udc_get_reg(dev, USIR0) &
+					~udc_get_reg(dev, UICR0);
+			u32	usir1 = udc_get_reg(dev, USIR1) &
+					~udc_get_reg(dev, UICR1);
 			int	i;
 
 			if (unlikely (!usir0 && !usir1))
@@ -1924,13 +1986,15 @@ pxa25x_udc_irq(int irq, void *_dev)
 
 				if (i && (usir0 & tmp)) {
 					handle_ep(&dev->ep[i]);
-					USIR0 |= tmp;
+					udc_set_reg(dev, USIR0,
+						udc_get_reg(dev, USIR0) | tmp);
 					handled = 1;
 				}
 #ifndef	CONFIG_USB_PXA25X_SMALL
 				if (usir1 & tmp) {
 					handle_ep(&dev->ep[i+8]);
-					USIR1 |= tmp;
+					udc_set_reg(dev, USIR1,
+						udc_get_reg(dev, USIR1) | tmp);
 					handled = 1;
 				}
 #endif
@@ -1975,8 +2039,8 @@ static struct pxa25x_udc memory = {
 						USB_EP_CAPS_DIR_ALL),
 		},
 		.dev		= &memory,
-		.reg_udccs	= &UDCCS0,
-		.reg_uddr	= &UDDR0,
+		.regoff_udccs	= UDCCS0,
+		.regoff_uddr	= UDDR0,
 	},
 
 	/* first group of endpoints */
@@ -1992,8 +2056,8 @@ static struct pxa25x_udc memory = {
 		.fifo_size	= BULK_FIFO_SIZE,
 		.bEndpointAddress = USB_DIR_IN | 1,
 		.bmAttributes	= USB_ENDPOINT_XFER_BULK,
-		.reg_udccs	= &UDCCS1,
-		.reg_uddr	= &UDDR1,
+		.regoff_udccs	= UDCCS1,
+		.regoff_uddr	= UDDR1,
 	},
 	.ep[2] = {
 		.ep = {
@@ -2007,9 +2071,9 @@ static struct pxa25x_udc memory = {
 		.fifo_size	= BULK_FIFO_SIZE,
 		.bEndpointAddress = 2,
 		.bmAttributes	= USB_ENDPOINT_XFER_BULK,
-		.reg_udccs	= &UDCCS2,
-		.reg_ubcr	= &UBCR2,
-		.reg_uddr	= &UDDR2,
+		.regoff_udccs	= UDCCS2,
+		.regoff_ubcr	= UBCR2,
+		.regoff_uddr	= UDDR2,
 	},
 #ifndef CONFIG_USB_PXA25X_SMALL
 	.ep[3] = {
@@ -2024,8 +2088,8 @@ static struct pxa25x_udc memory = {
 		.fifo_size	= ISO_FIFO_SIZE,
 		.bEndpointAddress = USB_DIR_IN | 3,
 		.bmAttributes	= USB_ENDPOINT_XFER_ISOC,
-		.reg_udccs	= &UDCCS3,
-		.reg_uddr	= &UDDR3,
+		.regoff_udccs	= UDCCS3,
+		.regoff_uddr	= UDDR3,
 	},
 	.ep[4] = {
 		.ep = {
@@ -2039,9 +2103,9 @@ static struct pxa25x_udc memory = {
 		.fifo_size	= ISO_FIFO_SIZE,
 		.bEndpointAddress = 4,
 		.bmAttributes	= USB_ENDPOINT_XFER_ISOC,
-		.reg_udccs	= &UDCCS4,
-		.reg_ubcr	= &UBCR4,
-		.reg_uddr	= &UDDR4,
+		.regoff_udccs	= UDCCS4,
+		.regoff_ubcr	= UBCR4,
+		.regoff_uddr	= UDDR4,
 	},
 	.ep[5] = {
 		.ep = {
@@ -2054,8 +2118,8 @@ static struct pxa25x_udc memory = {
 		.fifo_size	= INT_FIFO_SIZE,
 		.bEndpointAddress = USB_DIR_IN | 5,
 		.bmAttributes	= USB_ENDPOINT_XFER_INT,
-		.reg_udccs	= &UDCCS5,
-		.reg_uddr	= &UDDR5,
+		.regoff_udccs	= UDCCS5,
+		.regoff_uddr	= UDDR5,
 	},
 
 	/* second group of endpoints */
@@ -2071,8 +2135,8 @@ static struct pxa25x_udc memory = {
 		.fifo_size	= BULK_FIFO_SIZE,
 		.bEndpointAddress = USB_DIR_IN | 6,
 		.bmAttributes	= USB_ENDPOINT_XFER_BULK,
-		.reg_udccs	= &UDCCS6,
-		.reg_uddr	= &UDDR6,
+		.regoff_udccs	= UDCCS6,
+		.regoff_uddr	= UDDR6,
 	},
 	.ep[7] = {
 		.ep = {
@@ -2086,9 +2150,9 @@ static struct pxa25x_udc memory = {
 		.fifo_size	= BULK_FIFO_SIZE,
 		.bEndpointAddress = 7,
 		.bmAttributes	= USB_ENDPOINT_XFER_BULK,
-		.reg_udccs	= &UDCCS7,
-		.reg_ubcr	= &UBCR7,
-		.reg_uddr	= &UDDR7,
+		.regoff_udccs	= UDCCS7,
+		.regoff_ubcr	= UBCR7,
+		.regoff_uddr	= UDDR7,
 	},
 	.ep[8] = {
 		.ep = {
@@ -2102,8 +2166,8 @@ static struct pxa25x_udc memory = {
 		.fifo_size	= ISO_FIFO_SIZE,
 		.bEndpointAddress = USB_DIR_IN | 8,
 		.bmAttributes	= USB_ENDPOINT_XFER_ISOC,
-		.reg_udccs	= &UDCCS8,
-		.reg_uddr	= &UDDR8,
+		.regoff_udccs	= UDCCS8,
+		.regoff_uddr	= UDDR8,
 	},
 	.ep[9] = {
 		.ep = {
@@ -2117,9 +2181,9 @@ static struct pxa25x_udc memory = {
 		.fifo_size	= ISO_FIFO_SIZE,
 		.bEndpointAddress = 9,
 		.bmAttributes	= USB_ENDPOINT_XFER_ISOC,
-		.reg_udccs	= &UDCCS9,
-		.reg_ubcr	= &UBCR9,
-		.reg_uddr	= &UDDR9,
+		.regoff_udccs	= UDCCS9,
+		.regoff_ubcr	= UBCR9,
+		.regoff_uddr	= UDDR9,
 	},
 	.ep[10] = {
 		.ep = {
@@ -2132,8 +2196,8 @@ static struct pxa25x_udc memory = {
 		.fifo_size	= INT_FIFO_SIZE,
 		.bEndpointAddress = USB_DIR_IN | 10,
 		.bmAttributes	= USB_ENDPOINT_XFER_INT,
-		.reg_udccs	= &UDCCS10,
-		.reg_uddr	= &UDDR10,
+		.regoff_udccs	= UDCCS10,
+		.regoff_uddr	= UDDR10,
 	},
 
 	/* third group of endpoints */
@@ -2149,8 +2213,8 @@ static struct pxa25x_udc memory = {
 		.fifo_size	= BULK_FIFO_SIZE,
 		.bEndpointAddress = USB_DIR_IN | 11,
 		.bmAttributes	= USB_ENDPOINT_XFER_BULK,
-		.reg_udccs	= &UDCCS11,
-		.reg_uddr	= &UDDR11,
+		.regoff_udccs	= UDCCS11,
+		.regoff_uddr	= UDDR11,
 	},
 	.ep[12] = {
 		.ep = {
@@ -2164,9 +2228,9 @@ static struct pxa25x_udc memory = {
 		.fifo_size	= BULK_FIFO_SIZE,
 		.bEndpointAddress = 12,
 		.bmAttributes	= USB_ENDPOINT_XFER_BULK,
-		.reg_udccs	= &UDCCS12,
-		.reg_ubcr	= &UBCR12,
-		.reg_uddr	= &UDDR12,
+		.regoff_udccs	= UDCCS12,
+		.regoff_ubcr	= UBCR12,
+		.regoff_uddr	= UDDR12,
 	},
 	.ep[13] = {
 		.ep = {
@@ -2180,8 +2244,8 @@ static struct pxa25x_udc memory = {
 		.fifo_size	= ISO_FIFO_SIZE,
 		.bEndpointAddress = USB_DIR_IN | 13,
 		.bmAttributes	= USB_ENDPOINT_XFER_ISOC,
-		.reg_udccs	= &UDCCS13,
-		.reg_uddr	= &UDDR13,
+		.regoff_udccs	= UDCCS13,
+		.regoff_uddr	= UDDR13,
 	},
 	.ep[14] = {
 		.ep = {
@@ -2195,9 +2259,9 @@ static struct pxa25x_udc memory = {
 		.fifo_size	= ISO_FIFO_SIZE,
 		.bEndpointAddress = 14,
 		.bmAttributes	= USB_ENDPOINT_XFER_ISOC,
-		.reg_udccs	= &UDCCS14,
-		.reg_ubcr	= &UBCR14,
-		.reg_uddr	= &UDDR14,
+		.regoff_udccs	= UDCCS14,
+		.regoff_ubcr	= UBCR14,
+		.regoff_uddr	= UDDR14,
 	},
 	.ep[15] = {
 		.ep = {
@@ -2210,8 +2274,8 @@ static struct pxa25x_udc memory = {
 		.fifo_size	= INT_FIFO_SIZE,
 		.bEndpointAddress = USB_DIR_IN | 15,
 		.bmAttributes	= USB_ENDPOINT_XFER_INT,
-		.reg_udccs	= &UDCCS15,
-		.reg_uddr	= &UDDR15,
+		.regoff_udccs	= UDCCS15,
+		.regoff_uddr	= UDDR15,
 	},
 #endif /* !CONFIG_USB_PXA25X_SMALL */
 };
@@ -2258,6 +2322,7 @@ static int pxa25x_udc_probe(struct platform_device *pdev)
 	struct pxa25x_udc *dev = &memory;
 	int retval, irq;
 	u32 chiprev;
+	struct resource *res;
 
 	pr_info("%s: version %s\n", driver_name, DRIVER_VERSION);
 
@@ -2303,6 +2368,11 @@ static int pxa25x_udc_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return -ENODEV;
 
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	pxa25x_udc_reg_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(pxa25x_udc_reg_base))
+		return PTR_ERR(pxa25x_udc_reg_base);
+
 	dev->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(dev->clk))
 		return PTR_ERR(dev->clk);
diff --git a/drivers/usb/gadget/udc/pxa25x_udc.h b/drivers/usb/gadget/udc/pxa25x_udc.h
index 3fe5931dc21a..f884513f7390 100644
--- a/drivers/usb/gadget/udc/pxa25x_udc.h
+++ b/drivers/usb/gadget/udc/pxa25x_udc.h
@@ -56,9 +56,9 @@ struct pxa25x_ep {
 	 * UDDR = UDC Endpoint Data Register (the fifo)
 	 * DRCM = DMA Request Channel Map
 	 */
-	volatile u32				*reg_udccs;
-	volatile u32				*reg_ubcr;
-	volatile u32				*reg_uddr;
+	u32					regoff_udccs;
+	u32					regoff_ubcr;
+	u32					regoff_uddr;
 };
 
 struct pxa25x_request {
@@ -197,6 +197,8 @@ dump_udccs0(const char *label)
 		(udccs0 & UDCCS0_OPR) ? " opr" : "");
 }
 
+static inline u32 udc_ep_get_UDCCS(struct pxa25x_ep *);
+
 static void __maybe_unused
 dump_state(struct pxa25x_udc *dev)
 {
@@ -228,7 +230,7 @@ dump_state(struct pxa25x_udc *dev)
 	for (i = 1; i < PXA_UDC_NUM_ENDPOINTS; i++) {
 		if (dev->ep[i].ep.desc == NULL)
 			continue;
-		DMSG ("udccs%d = %02x\n", i, *dev->ep->reg_udccs);
+		DMSG ("udccs%d = %02x\n", i, udc_ep_get_UDCCS(&dev->ep[i]));
 	}
 }
 
-- 
2.7.0
