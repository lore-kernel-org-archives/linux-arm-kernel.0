From: okaya@codeaurora.org (Sinan Kaya)
Date: Fri, 16 Mar 2018 12:16:22 -0400
Subject: [PATCH v3 09/18] fm10k: Eliminate duplicate barriers on
 weakly-ordered archs
In-Reply-To: <1521216991-28706-1-git-send-email-okaya@codeaurora.org>
References: <1521216991-28706-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1521216991-28706-10-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Code includes wmb() followed by writel(). writel() already has a
barrier on some architectures like arm64.

This ends up CPU observing two barriers back to back before executing
the register write.

Since code already has an explicit barrier call, changing writel() to
writel_relaxed().

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/net/ethernet/intel/fm10k/fm10k_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_main.c b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
index 8e12aae..8d04e26 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_main.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
@@ -179,7 +179,7 @@ void fm10k_alloc_rx_buffers(struct fm10k_ring *rx_ring, u16 cleaned_count)
 		wmb();
 
 		/* notify hardware of new descriptors */
-		writel(i, rx_ring->tail);
+		writel_relaxed(i, rx_ring->tail);
 	}
 }
 
-- 
2.7.4
