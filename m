From: okaya@codeaurora.org (Sinan Kaya)
Date: Sun, 25 Mar 2018 10:39:15 -0400
Subject: [PATCH v7 1/7] net: qla3xxx: Eliminate duplicate barriers on
 weakly-ordered archs
In-Reply-To: <1521988761-30344-1-git-send-email-okaya@codeaurora.org>
References: <1521988761-30344-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1521988761-30344-2-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Code includes wmb() followed by writel(). writel() already has a
barrier on some architectures like arm64.

This ends up CPU observing two barriers back to back before executing
the register write.

Since code already has an explicit barrier call, changing code to

wmb()
writel_relaxed()
mmiowb()

for multi-arch support.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/net/ethernet/qlogic/qla3xxx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qla3xxx.c b/drivers/net/ethernet/qlogic/qla3xxx.c
index 9e5264d..b48f761 100644
--- a/drivers/net/ethernet/qlogic/qla3xxx.c
+++ b/drivers/net/ethernet/qlogic/qla3xxx.c
@@ -1858,8 +1858,9 @@ static void ql_update_small_bufq_prod_index(struct ql3_adapter *qdev)
 			qdev->small_buf_release_cnt -= 8;
 		}
 		wmb();
-		writel(qdev->small_buf_q_producer_index,
-			&port_regs->CommonRegs.rxSmallQProducerIndex);
+		writel_relaxed(qdev->small_buf_q_producer_index,
+			       &port_regs->CommonRegs.rxSmallQProducerIndex);
+		mmiowb();
 	}
 }
 
-- 
2.7.4
