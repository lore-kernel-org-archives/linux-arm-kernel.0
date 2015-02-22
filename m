From: joe@perches.com (Joe Perches)
Date: Sat, 21 Feb 2015 18:53:37 -0800
Subject: [PATCH 10/27] pxa27x_udc: Remove use of seq_printf return value
In-Reply-To: <cover.1424573328.git.joe@perches.com>
References: <cover.1424573328.git.joe@perches.com>
Message-ID: <2c9adbd539f0d96028b9dfe1caec0829c9feacf5.1424573328.git.joe@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The seq_printf return value, because it's frequently misused,
will eventually be converted to void.

See: commit 1f33c41c03da ("seq_file: Rename seq_overflow() to
     seq_has_overflowed() and make public")

While there, simplify the error handler logic by returning
immediately and remove the unnecessary labels.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/usb/gadget/udc/pxa27x_udc.c | 132 ++++++++++++++++--------------------
 1 file changed, 60 insertions(+), 72 deletions(-)

diff --git a/drivers/usb/gadget/udc/pxa27x_udc.c b/drivers/usb/gadget/udc/pxa27x_udc.c
index 6a855fc..486f754 100644
--- a/drivers/usb/gadget/udc/pxa27x_udc.c
+++ b/drivers/usb/gadget/udc/pxa27x_udc.c
@@ -93,50 +93,46 @@ static void handle_ep(struct pxa_ep *ep);
 static int state_dbg_show(struct seq_file *s, void *p)
 {
 	struct pxa_udc *udc = s->private;
-	int pos = 0, ret;
 	u32 tmp;
 
-	ret = -ENODEV;
 	if (!udc->driver)
-		goto out;
+		return -ENODEV;
 
 	/* basic device status */
-	pos += seq_printf(s, DRIVER_DESC "\n"
-			 "%s version: %s\nGadget driver: %s\n",
-			 driver_name, DRIVER_VERSION,
-			 udc->driver ? udc->driver->driver.name : "(none)");
+	seq_printf(s, DRIVER_DESC "\n"
+		   "%s version: %s\n"
+		   "Gadget driver: %s\n",
+		   driver_name, DRIVER_VERSION,
+		   udc->driver ? udc->driver->driver.name : "(none)");
 
 	tmp = udc_readl(udc, UDCCR);
-	pos += seq_printf(s,
-			 "udccr=0x%0x(%s%s%s%s%s%s%s%s%s%s), "
-			 "con=%d,inter=%d,altinter=%d\n", tmp,
-			 (tmp & UDCCR_OEN) ? " oen":"",
-			 (tmp & UDCCR_AALTHNP) ? " aalthnp":"",
-			 (tmp & UDCCR_AHNP) ? " rem" : "",
-			 (tmp & UDCCR_BHNP) ? " rstir" : "",
-			 (tmp & UDCCR_DWRE) ? " dwre" : "",
-			 (tmp & UDCCR_SMAC) ? " smac" : "",
-			 (tmp & UDCCR_EMCE) ? " emce" : "",
-			 (tmp & UDCCR_UDR) ? " udr" : "",
-			 (tmp & UDCCR_UDA) ? " uda" : "",
-			 (tmp & UDCCR_UDE) ? " ude" : "",
-			 (tmp & UDCCR_ACN) >> UDCCR_ACN_S,
-			 (tmp & UDCCR_AIN) >> UDCCR_AIN_S,
-			 (tmp & UDCCR_AAISN) >> UDCCR_AAISN_S);
+	seq_printf(s,
+		   "udccr=0x%0x(%s%s%s%s%s%s%s%s%s%s), con=%d,inter=%d,altinter=%d\n",
+		   tmp,
+		   (tmp & UDCCR_OEN) ? " oen":"",
+		   (tmp & UDCCR_AALTHNP) ? " aalthnp":"",
+		   (tmp & UDCCR_AHNP) ? " rem" : "",
+		   (tmp & UDCCR_BHNP) ? " rstir" : "",
+		   (tmp & UDCCR_DWRE) ? " dwre" : "",
+		   (tmp & UDCCR_SMAC) ? " smac" : "",
+		   (tmp & UDCCR_EMCE) ? " emce" : "",
+		   (tmp & UDCCR_UDR) ? " udr" : "",
+		   (tmp & UDCCR_UDA) ? " uda" : "",
+		   (tmp & UDCCR_UDE) ? " ude" : "",
+		   (tmp & UDCCR_ACN) >> UDCCR_ACN_S,
+		   (tmp & UDCCR_AIN) >> UDCCR_AIN_S,
+		   (tmp & UDCCR_AAISN) >> UDCCR_AAISN_S);
 	/* registers for device and ep0 */
-	pos += seq_printf(s, "udcicr0=0x%08x udcicr1=0x%08x\n",
-			udc_readl(udc, UDCICR0), udc_readl(udc, UDCICR1));
-	pos += seq_printf(s, "udcisr0=0x%08x udcisr1=0x%08x\n",
-			udc_readl(udc, UDCISR0), udc_readl(udc, UDCISR1));
-	pos += seq_printf(s, "udcfnr=%d\n", udc_readl(udc, UDCFNR));
-	pos += seq_printf(s, "irqs: reset=%lu, suspend=%lu, resume=%lu, "
-			"reconfig=%lu\n",
-			udc->stats.irqs_reset, udc->stats.irqs_suspend,
-			udc->stats.irqs_resume, udc->stats.irqs_reconfig);
-
-	ret = 0;
-out:
-	return ret;
+	seq_printf(s, "udcicr0=0x%08x udcicr1=0x%08x\n",
+		   udc_readl(udc, UDCICR0), udc_readl(udc, UDCICR1));
+	seq_printf(s, "udcisr0=0x%08x udcisr1=0x%08x\n",
+		   udc_readl(udc, UDCISR0), udc_readl(udc, UDCISR1));
+	seq_printf(s, "udcfnr=%d\n", udc_readl(udc, UDCFNR));
+	seq_printf(s, "irqs: reset=%lu, suspend=%lu, resume=%lu, reconfig=%lu\n",
+		   udc->stats.irqs_reset, udc->stats.irqs_suspend,
+		   udc->stats.irqs_resume, udc->stats.irqs_reconfig);
+
+	return 0;
 }
 
 static int queues_dbg_show(struct seq_file *s, void *p)
@@ -144,75 +140,67 @@ static int queues_dbg_show(struct seq_file *s, void *p)
 	struct pxa_udc *udc = s->private;
 	struct pxa_ep *ep;
 	struct pxa27x_request *req;
-	int pos = 0, i, maxpkt, ret;
+	int i, maxpkt;
 
-	ret = -ENODEV;
 	if (!udc->driver)
-		goto out;
+		return -ENODEV;
 
 	/* dump endpoint queues */
 	for (i = 0; i < NR_PXA_ENDPOINTS; i++) {
 		ep = &udc->pxa_ep[i];
 		maxpkt = ep->fifo_size;
-		pos += seq_printf(s,  "%-12s max_pkt=%d %s\n",
-				EPNAME(ep), maxpkt, "pio");
+		seq_printf(s,  "%-12s max_pkt=%d %s\n",
+			   EPNAME(ep), maxpkt, "pio");
 
 		if (list_empty(&ep->queue)) {
-			pos += seq_printf(s, "\t(nothing queued)\n");
+			seq_puts(s, "\t(nothing queued)\n");
 			continue;
 		}
 
 		list_for_each_entry(req, &ep->queue, queue) {
-			pos += seq_printf(s,  "\treq %p len %d/%d buf %p\n",
-					&req->req, req->req.actual,
-					req->req.length, req->req.buf);
+			seq_printf(s,  "\treq %p len %d/%d buf %p\n",
+				   &req->req, req->req.actual,
+				   req->req.length, req->req.buf);
 		}
 	}
 
-	ret = 0;
-out:
-	return ret;
+	return 0;
 }
 
 static int eps_dbg_show(struct seq_file *s, void *p)
 {
 	struct pxa_udc *udc = s->private;
 	struct pxa_ep *ep;
-	int pos = 0, i, ret;
+	int i;
 	u32 tmp;
 
-	ret = -ENODEV;
 	if (!udc->driver)
-		goto out;
+		return -ENODEV;
 
 	ep = &udc->pxa_ep[0];
 	tmp = udc_ep_readl(ep, UDCCSR);
-	pos += seq_printf(s, "udccsr0=0x%03x(%s%s%s%s%s%s%s)\n", tmp,
-			 (tmp & UDCCSR0_SA) ? " sa" : "",
-			 (tmp & UDCCSR0_RNE) ? " rne" : "",
-			 (tmp & UDCCSR0_FST) ? " fst" : "",
-			 (tmp & UDCCSR0_SST) ? " sst" : "",
-			 (tmp & UDCCSR0_DME) ? " dme" : "",
-			 (tmp & UDCCSR0_IPR) ? " ipr" : "",
-			 (tmp & UDCCSR0_OPC) ? " opc" : "");
+	seq_printf(s, "udccsr0=0x%03x(%s%s%s%s%s%s%s)\n",
+		   tmp,
+		   (tmp & UDCCSR0_SA) ? " sa" : "",
+		   (tmp & UDCCSR0_RNE) ? " rne" : "",
+		   (tmp & UDCCSR0_FST) ? " fst" : "",
+		   (tmp & UDCCSR0_SST) ? " sst" : "",
+		   (tmp & UDCCSR0_DME) ? " dme" : "",
+		   (tmp & UDCCSR0_IPR) ? " ipr" : "",
+		   (tmp & UDCCSR0_OPC) ? " opc" : "");
 	for (i = 0; i < NR_PXA_ENDPOINTS; i++) {
 		ep = &udc->pxa_ep[i];
 		tmp = i? udc_ep_readl(ep, UDCCR) : udc_readl(udc, UDCCR);
-		pos += seq_printf(s, "%-12s: "
-				"IN %lu(%lu reqs), OUT %lu(%lu reqs), "
-				"irqs=%lu, udccr=0x%08x, udccsr=0x%03x, "
-				"udcbcr=%d\n",
-				EPNAME(ep),
-				ep->stats.in_bytes, ep->stats.in_ops,
-				ep->stats.out_bytes, ep->stats.out_ops,
-				ep->stats.irqs,
-				tmp, udc_ep_readl(ep, UDCCSR),
-				udc_ep_readl(ep, UDCBCR));
+		seq_printf(s, "%-12s: IN %lu(%lu reqs), OUT %lu(%lu reqs), irqs=%lu, udccr=0x%08x, udccsr=0x%03x, udcbcr=%d\n",
+			   EPNAME(ep),
+			   ep->stats.in_bytes, ep->stats.in_ops,
+			   ep->stats.out_bytes, ep->stats.out_ops,
+			   ep->stats.irqs,
+			   tmp, udc_ep_readl(ep, UDCCSR),
+			   udc_ep_readl(ep, UDCBCR));
 	}
 
-	ret = 0;
-out:
-	return ret;
+	return 0;
 }
 
 static int eps_dbg_open(struct inode *inode, struct file *file)
-- 
2.1.2
