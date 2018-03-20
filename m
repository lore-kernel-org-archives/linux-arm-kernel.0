From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 19 Mar 2018 22:42:25 -0400
Subject: [PATCH v4 10/17] qlcnic: Eliminate duplicate barriers on
 weakly-ordered archs
In-Reply-To: <1521513753-7325-1-git-send-email-okaya@codeaurora.org>
References: <1521513753-7325-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1521513753-7325-11-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Code includes wmb() followed by writel(). writel() already has a
barrier on some architectures like arm64.

This ends up CPU observing two barriers back to back before executing
the register write.

Since code already has an explicit barrier call, changing writel() to
writel_relaxed().

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
Acked-by: Manish Chopra <manish.chopra@cavium.com>
---
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c
index 46b0372..97c146e7 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c
@@ -478,7 +478,7 @@ irqreturn_t qlcnic_83xx_clear_legacy_intr(struct qlcnic_adapter *adapter)
 	wmb();
 
 	/* clear the interrupt trigger control register */
-	writel(0, adapter->isr_int_vec);
+	writel_relaxed(0, adapter->isr_int_vec);
 	intr_val = readl(adapter->isr_int_vec);
 	do {
 		intr_val = readl(adapter->tgt_status_reg);
-- 
2.7.4
