From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 19 Mar 2018 22:42:23 -0400
Subject: [PATCH v4 08/17] drivers: net: cxgb: Eliminate duplicate barriers on
 weakly-ordered archs
In-Reply-To: <1521513753-7325-1-git-send-email-okaya@codeaurora.org>
References: <1521513753-7325-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1521513753-7325-9-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Code includes wmb() followed by writel(). writel() already has a barrier on
some architectures like arm64.

This ends up CPU observing two barriers back to back before executing the
register write.

Since code already has an explicit barrier call, changing writel() to
writel_relaxed().

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/net/ethernet/chelsio/cxgb/sge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb/sge.c b/drivers/net/ethernet/chelsio/cxgb/sge.c
index 30de26e..57891bd6 100644
--- a/drivers/net/ethernet/chelsio/cxgb/sge.c
+++ b/drivers/net/ethernet/chelsio/cxgb/sge.c
@@ -495,7 +495,7 @@ static struct sk_buff *sched_skb(struct sge *sge, struct sk_buff *skb,
 static inline void doorbell_pio(struct adapter *adapter, u32 val)
 {
 	wmb();
-	writel(val, adapter->regs + A_SG_DOORBELL);
+	writel_relaxed(val, adapter->regs + A_SG_DOORBELL);
 }
 
 /*
-- 
2.7.4
