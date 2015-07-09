From: julien.grall@citrix.com (Julien Grall)
Date: Thu, 9 Jul 2015 21:42:20 +0100
Subject: [PATCH v2 08/20] net/xen-netback: xenvif_gop_frag_copy: move GSO
 check out of the loop
In-Reply-To: <1436474552-31789-1-git-send-email-julien.grall@citrix.com>
References: <1436474552-31789-1-git-send-email-julien.grall@citrix.com>
Message-ID: <1436474552-31789-9-git-send-email-julien.grall@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The skb doesn't change within the function. Therefore it's only
necessary to check if we need GSO once at the beginning.

Signed-off-by: Julien Grall <julien.grall@citrix.com>
Cc: Ian Campbell <ian.campbell@citrix.com>
Cc: Wei Liu <wei.liu2@citrix.com>
Cc: netdev at vger.kernel.org
---
    Changes in v2:
        - Patch added
---
 drivers/net/xen-netback/netback.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/xen-netback/netback.c b/drivers/net/xen-netback/netback.c
index 880d0d6..3f77030 100644
--- a/drivers/net/xen-netback/netback.c
+++ b/drivers/net/xen-netback/netback.c
@@ -277,6 +277,13 @@ static void xenvif_gop_frag_copy(struct xenvif_queue *queue, struct sk_buff *skb
 	unsigned long bytes;
 	int gso_type = XEN_NETIF_GSO_TYPE_NONE;
 
+	if (skb_is_gso(skb)) {
+		if (skb_shinfo(skb)->gso_type & SKB_GSO_TCPV4)
+			gso_type = XEN_NETIF_GSO_TYPE_TCPV4;
+		else if (skb_shinfo(skb)->gso_type & SKB_GSO_TCPV6)
+			gso_type = XEN_NETIF_GSO_TYPE_TCPV6;
+	}
+
 	/* Data must not cross a page boundary. */
 	BUG_ON(size + offset > PAGE_SIZE<<compound_order(page));
 
@@ -336,13 +343,6 @@ static void xenvif_gop_frag_copy(struct xenvif_queue *queue, struct sk_buff *skb
 		}
 
 		/* Leave a gap for the GSO descriptor. */
-		if (skb_is_gso(skb)) {
-			if (skb_shinfo(skb)->gso_type & SKB_GSO_TCPV4)
-				gso_type = XEN_NETIF_GSO_TYPE_TCPV4;
-			else if (skb_shinfo(skb)->gso_type & SKB_GSO_TCPV6)
-				gso_type = XEN_NETIF_GSO_TYPE_TCPV6;
-		}
-
 		if (*head && ((1 << gso_type) & queue->vif->gso_mask))
 			queue->rx.req_cons++;
 
-- 
2.1.4
