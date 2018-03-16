From: okaya@codeaurora.org (Sinan Kaya)
Date: Fri, 16 Mar 2018 12:16:29 -0400
Subject: [PATCH v3 16/18] IB/mlx4: Eliminate duplicate barriers on
 weakly-ordered archs
In-Reply-To: <1521216991-28706-1-git-send-email-okaya@codeaurora.org>
References: <1521216991-28706-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1521216991-28706-17-git-send-email-okaya@codeaurora.org>
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
 drivers/infiniband/hw/mlx4/qp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4/qp.c
index f045491..74b27b0 100644
--- a/drivers/infiniband/hw/mlx4/qp.c
+++ b/drivers/infiniband/hw/mlx4/qp.c
@@ -3880,8 +3880,8 @@ int mlx4_ib_post_send(struct ib_qp *ibqp, struct ib_send_wr *wr,
 		 */
 		wmb();
 
-		writel(qp->doorbell_qpn,
-		       to_mdev(ibqp->device)->uar_map + MLX4_SEND_DOORBELL);
+		writel_relaxed(qp->doorbell_qpn,
+			to_mdev(ibqp->device)->uar_map + MLX4_SEND_DOORBELL);
 
 		/*
 		 * Make sure doorbells don't leak out of SQ spinlock
-- 
2.7.4
