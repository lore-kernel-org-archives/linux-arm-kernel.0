From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 19 Mar 2018 22:50:01 -0400
Subject: [PATCH v4 1/7] scsi: hpsa: Eliminate duplicate barriers on
 weakly-ordered archs
In-Reply-To: <1521514207-10695-1-git-send-email-okaya@codeaurora.org>
References: <1521514207-10695-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1521514207-10695-2-git-send-email-okaya@codeaurora.org>
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
 drivers/scsi/hpsa.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/hpsa.h b/drivers/scsi/hpsa.h
index 018f980..c7d7e6a 100644
--- a/drivers/scsi/hpsa.h
+++ b/drivers/scsi/hpsa.h
@@ -599,7 +599,7 @@ static unsigned long SA5_ioaccel_mode1_completed(struct ctlr_info *h, u8 q)
 		 * but with current driver design this is easiest.
 		 */
 		wmb();
-		writel((q << 24) | rq->current_entry, h->vaddr +
+		writel_relaxed((q << 24) | rq->current_entry, h->vaddr +
 				IOACCEL_MODE1_CONSUMER_INDEX);
 		atomic_dec(&h->commands_outstanding);
 	}
-- 
2.7.4
