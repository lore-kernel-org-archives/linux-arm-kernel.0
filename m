From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 19 Mar 2018 22:47:43 -0400
Subject: [PATCH v4 1/6] RDMA/bnxt_re: Eliminate duplicate barriers on
 weakly-ordered archs
In-Reply-To: <1521514068-8856-1-git-send-email-okaya@codeaurora.org>
References: <1521514068-8856-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1521514068-8856-2-git-send-email-okaya@codeaurora.org>
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
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index 8329ec6..4a6b981 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -181,10 +181,10 @@ static int __send_message(struct bnxt_qplib_rcfw *rcfw, struct cmdq_base *req,
 
 	/* ring CMDQ DB */
 	wmb();
-	writel(cmdq_prod, rcfw->cmdq_bar_reg_iomem +
-	       rcfw->cmdq_bar_reg_prod_off);
-	writel(RCFW_CMDQ_TRIG_VAL, rcfw->cmdq_bar_reg_iomem +
-	       rcfw->cmdq_bar_reg_trig_off);
+	writel_relaxed(cmdq_prod, rcfw->cmdq_bar_reg_iomem +
+		       rcfw->cmdq_bar_reg_prod_off);
+	writel_relaxed(RCFW_CMDQ_TRIG_VAL, rcfw->cmdq_bar_reg_iomem +
+		       rcfw->cmdq_bar_reg_trig_off);
 done:
 	spin_unlock_irqrestore(&cmdq->lock, flags);
 	/* Return the CREQ response pointer */
-- 
2.7.4
