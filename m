From: agust@denx.de (Anatolij Gustschin)
Date: Sat, 25 Jun 2011 23:37:29 +0200
Subject: [PATCH v2] usb: fsl_udc_core: fix build breakage when building for
	ARM arch
In-Reply-To: <20110624095630.GE23234@n2100.arm.linux.org.uk>
References: <20110624095630.GE23234@n2100.arm.linux.org.uk>
Message-ID: <1309037849-4596-1-git-send-email-agust@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 09ba0def (USB: fsl_udc_core: prepare for SoCs with
BE registers and descriptors) introduced build breakage
on ARM arch. Fix it by setting accessors using a static
inline function which is a nop when compiling the driver
for ARM arch.

Commit 2ea6698 (USB: fsl_udc_core: support device mode of
MPC5121E DR USB Controller) caused another breakage on ARM
by using flush_dcache_range(). Don't use it, convert to the
DMA API usage instead. USB2.0CV Halt Endpoint Test succeeds
on PPC. Tested both on ARM i.MX31 and mpc5121 PPC, also with
CONFIG_DMA_API_DEBUG enabled.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
v2:
 - drop virt_to_phys(), use dma_map_singe()
 - tested with CONFIG_DMA_API_DEBUG enabled
 - rework commit description

 drivers/usb/gadget/fsl_udc_core.c |   36 ++++++++++++++++++++++++------------
 1 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/gadget/fsl_udc_core.c b/drivers/usb/gadget/fsl_udc_core.c
index 2cd9a60..4e48331 100644
--- a/drivers/usb/gadget/fsl_udc_core.c
+++ b/drivers/usb/gadget/fsl_udc_core.c
@@ -46,7 +46,6 @@
 #include <asm/system.h>
 #include <asm/unaligned.h>
 #include <asm/dma.h>
-#include <asm/cacheflush.h>
 
 #include "fsl_usb2_udc.h"
 
@@ -118,6 +117,17 @@ static void (*_fsl_writel)(u32 v, unsigned __iomem *p);
 #define fsl_readl(p)		(*_fsl_readl)((p))
 #define fsl_writel(v, p)	(*_fsl_writel)((v), (p))
 
+static inline void fsl_set_accessors(struct fsl_usb2_platform_data *pdata)
+{
+	if (pdata->big_endian_mmio) {
+		_fsl_readl = _fsl_readl_be;
+		_fsl_writel = _fsl_writel_be;
+	} else {
+		_fsl_readl = _fsl_readl_le;
+		_fsl_writel = _fsl_writel_le;
+	}
+}
+
 static inline u32 cpu_to_hc32(const u32 x)
 {
 	return udc_controller->pdata->big_endian_desc
@@ -132,6 +142,8 @@ static inline u32 hc32_to_cpu(const u32 x)
 		: le32_to_cpu((__force __le32)x);
 }
 #else /* !CONFIG_PPC32 */
+static inline void fsl_set_accessors(struct fsl_usb2_platform_data *pdata) {}
+
 #define fsl_readl(addr)		readl(addr)
 #define fsl_writel(val32, addr) writel(val32, addr)
 #define cpu_to_hc32(x)		cpu_to_le32(x)
@@ -1277,6 +1289,11 @@ static int ep0_prime_status(struct fsl_udc *udc, int direction)
 	req->req.complete = NULL;
 	req->dtd_count = 0;
 
+	req->req.dma = dma_map_single(ep->udc->gadget.dev.parent,
+			req->req.buf, req->req.length,
+			ep_is_in(ep) ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
+	req->mapped = 1;
+
 	if (fsl_req_to_dtd(req) == 0)
 		fsl_queue_td(ep, req);
 	else
@@ -1348,9 +1365,6 @@ static void ch9getstatus(struct fsl_udc *udc, u8 request_type, u16 value,
 	/* Fill in the reqest structure */
 	*((u16 *) req->req.buf) = cpu_to_le16(tmp);
 
-	/* flush cache for the req buffer */
-	flush_dcache_range((u32)req->req.buf, (u32)req->req.buf + 8);
-
 	req->ep = ep;
 	req->req.length = 2;
 	req->req.status = -EINPROGRESS;
@@ -1358,6 +1372,11 @@ static void ch9getstatus(struct fsl_udc *udc, u8 request_type, u16 value,
 	req->req.complete = NULL;
 	req->dtd_count = 0;
 
+	req->req.dma = dma_map_single(ep->udc->gadget.dev.parent,
+				req->req.buf, req->req.length,
+				ep_is_in(ep) ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
+	req->mapped = 1;
+
 	/* prime the data phase */
 	if ((fsl_req_to_dtd(req) == 0))
 		fsl_queue_td(ep, req);
@@ -2354,7 +2373,6 @@ static int __init struct_udc_setup(struct fsl_udc *udc,
 			struct fsl_req, req);
 	/* allocate a small amount of memory to get valid address */
 	udc->status_req->req.buf = kmalloc(8, GFP_KERNEL);
-	udc->status_req->req.dma = virt_to_phys(udc->status_req->req.buf);
 
 	udc->resume_state = USB_STATE_NOTATTACHED;
 	udc->usb_state = USB_STATE_POWERED;
@@ -2470,13 +2488,7 @@ static int __init fsl_udc_probe(struct platform_device *pdev)
 	}
 
 	/* Set accessors only after pdata->init() ! */
-	if (pdata->big_endian_mmio) {
-		_fsl_readl = _fsl_readl_be;
-		_fsl_writel = _fsl_writel_be;
-	} else {
-		_fsl_readl = _fsl_readl_le;
-		_fsl_writel = _fsl_writel_le;
-	}
+	fsl_set_accessors(pdata);
 
 #ifndef CONFIG_ARCH_MXC
 	if (pdata->have_sysif_regs)
-- 
1.7.1
