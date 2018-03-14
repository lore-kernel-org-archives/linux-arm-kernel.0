From: okaya@codeaurora.org (Sinan Kaya)
Date: Tue, 13 Mar 2018 23:20:27 -0400
Subject: [PATCH 6/7] e1000: eliminate duplicate barriers on weakly-ordered
 archs
In-Reply-To: <1520997629-17361-1-git-send-email-okaya@codeaurora.org>
References: <1520997629-17361-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1520997629-17361-6-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Code includes wmb() followed by writel(). writel() already has a barrier
on some architectures like arm64.

This ends up CPU observing two barriers back to back before executing the
register write.

Since code already has an explicit barrier call, changing writel() to
writel_relaxed().

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/net/ethernet/intel/e1000/e1000_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index 3dd4aeb..e0e583a 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -4573,7 +4573,7 @@ e1000_alloc_jumbo_rx_buffers(struct e1000_adapter *adapter,
 		 * such as IA-64).
 		 */
 		wmb();
-		writel(i, adapter->hw.hw_addr + rx_ring->rdt);
+		writel_relaxed(i, adapter->hw.hw_addr + rx_ring->rdt);
 	}
 }
 
@@ -4688,7 +4688,7 @@ static void e1000_alloc_rx_buffers(struct e1000_adapter *adapter,
 		 * such as IA-64).
 		 */
 		wmb();
-		writel(i, hw->hw_addr + rx_ring->rdt);
+		writel_relaxed(i, hw->hw_addr + rx_ring->rdt);
 	}
 }
 
-- 
2.7.4
