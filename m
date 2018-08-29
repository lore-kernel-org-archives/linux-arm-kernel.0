From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Wed, 29 Aug 2018 10:55:14 +0800
Subject: [PATCH 2/6] usb: xhci-mtk: use maximum ESIT payload of endpiont
 context
In-Reply-To: <3bcc220aa54bfebc39cea54cd736388ad37ee0c5.1535510898.git.chunfeng.yun@mediatek.com>
References: <3bcc220aa54bfebc39cea54cd736388ad37ee0c5.1535510898.git.chunfeng.yun@mediatek.com>
Message-ID: <19a0f3e20ba5314112c08307ee39cca603ddf819.1535510898.git.chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make use of maximum ESIT payload of endpoint context to calculate
the number of packets to send in each ESIT

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/host/xhci-mtk-sch.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-mtk-sch.c b/drivers/usb/host/xhci-mtk-sch.c
index fa33d6e..46fe0a2 100644
--- a/drivers/usb/host/xhci-mtk-sch.c
+++ b/drivers/usb/host/xhci-mtk-sch.c
@@ -73,12 +73,17 @@ static void setup_sch_info(struct usb_device *udev,
 	u32 max_burst;
 	u32 mult;
 	u32 esit_pkts;
+	u32 max_esit_payload;
 
 	ep_type = CTX_TO_EP_TYPE(le32_to_cpu(ep_ctx->ep_info2));
 	ep_interval = CTX_TO_EP_INTERVAL(le32_to_cpu(ep_ctx->ep_info));
 	max_packet_size = MAX_PACKET_DECODED(le32_to_cpu(ep_ctx->ep_info2));
 	max_burst = CTX_TO_MAX_BURST(le32_to_cpu(ep_ctx->ep_info2));
 	mult = CTX_TO_EP_MULT(le32_to_cpu(ep_ctx->ep_info));
+	max_esit_payload =
+		(CTX_TO_MAX_ESIT_PAYLOAD_HI(
+			le32_to_cpu(ep_ctx->ep_info)) << 16) |
+		 CTX_TO_MAX_ESIT_PAYLOAD(le32_to_cpu(ep_ctx->tx_info));
 
 	sch_ep->esit = 1 << ep_interval;
 	sch_ep->offset = 0;
@@ -105,7 +110,15 @@ static void setup_sch_info(struct usb_device *udev,
 	} else if (udev->speed == USB_SPEED_SUPER) {
 		/* usb3_r1 spec section4.4.7 & 4.4.8 */
 		sch_ep->cs_count = 0;
-		esit_pkts = (mult + 1) * (max_burst + 1);
+		/*
+		 * some device's (d)wBytesPerInterval is set as 0,
+		 * then max_esit_payload is 0, so evaluate esit_pkts from
+		 * mult and burst
+		 */
+		esit_pkts = DIV_ROUND_UP(max_esit_payload, max_packet_size);
+		if (esit_pkts == 0)
+			esit_pkts = (mult + 1) * (max_burst + 1);
+
 		if (ep_type == INT_IN_EP || ep_type == INT_OUT_EP) {
 			sch_ep->pkts = esit_pkts;
 			sch_ep->num_budget_microframes = 1;
-- 
1.9.1
