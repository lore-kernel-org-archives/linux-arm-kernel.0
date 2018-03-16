From: okaya@codeaurora.org (Sinan Kaya)
Date: Thu, 15 Mar 2018 21:04:56 -0400
Subject: [PATCH v2 6/6] ixgbevf: eliminate duplicate barriers on
 weakly-ordered archs
In-Reply-To: <1521162296-19729-1-git-send-email-okaya@codeaurora.org>
References: <1521162296-19729-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1521162296-19729-7-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Code includes wmb() followed by writel() in multiple places. writel()
already has a barrier on some architectures like arm64.

This ends up CPU observing two barriers back to back before executing the
register write.

Since code already has an explicit barrier call, changing writel() to
writel_relaxed().

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index b65f691..9e2e0fd 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -3644,7 +3644,7 @@ static void ixgbevf_tx_map(struct ixgbevf_ring *tx_ring,
 	tx_ring->next_to_use = i;
 
 	/* notify HW of packet */
-	writel(value, tx_ring->tail);
+	writel_relaxed(value, tx_ring->tail);
 
 	return;
 dma_error:
-- 
2.7.4
