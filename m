From: okaya@codeaurora.org (Sinan Kaya)
Date: Fri,  7 Apr 2017 12:41:45 -0400
Subject: [PATCH] scsi: mpt3sas: remove redundant wmb on arm/arm64
Message-ID: <1491583306-20551-1-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Due to relaxed ordering requirements on multiple architectures,
drivers are required to use wmb/rmb/mb combinations when they
need to guarantee observability between the memory and the HW.

The mpt3sas driver is already using wmb() for this purpose.
However, it issues a writel following wmb(). writel() function
on arm/arm64 arhictectures have an embedded wmb() call inside.

This results in unnecessary performance loss and code duplication.

The kernel has been updated to support relaxed read/write
API to be supported across all architectures now.

The right thing was to either call __raw_writel/__raw_readl or
write_relaxed/read_relaxed for multi-arch compatibility.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 5b7aec5..6e42036 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -1026,8 +1026,8 @@ static int mpt3sas_remove_dead_ioc_func(void *arg)
 				ioc->reply_free[ioc->reply_free_host_index] =
 				    cpu_to_le32(reply);
 				wmb();
-				writel(ioc->reply_free_host_index,
-				    &ioc->chip->ReplyFreeHostIndex);
+				writel_relaxed(ioc->reply_free_host_index,
+					       &ioc->chip->ReplyFreeHostIndex);
 			}
 		}
 
@@ -1076,8 +1076,8 @@ static int mpt3sas_remove_dead_ioc_func(void *arg)
 
 	wmb();
 	if (ioc->is_warpdrive) {
-		writel(reply_q->reply_post_host_index,
-		ioc->reply_post_host_index[msix_index]);
+		writel_relaxed(reply_q->reply_post_host_index,
+			       ioc->reply_post_host_index[msix_index]);
 		atomic_dec(&reply_q->busy);
 		return IRQ_HANDLED;
 	}
@@ -1098,13 +1098,14 @@ static int mpt3sas_remove_dead_ioc_func(void *arg)
 	 * value in MSIxIndex field.
 	 */
 	if (ioc->combined_reply_queue)
-		writel(reply_q->reply_post_host_index | ((msix_index  & 7) <<
-			MPI2_RPHI_MSIX_INDEX_SHIFT),
-			ioc->replyPostRegisterIndex[msix_index/8]);
+		writel_relaxed(reply_q->reply_post_host_index |
+			       ((msix_index  & 7) <<
+			       MPI2_RPHI_MSIX_INDEX_SHIFT),
+			       ioc->replyPostRegisterIndex[msix_index/8]);
 	else
-		writel(reply_q->reply_post_host_index | (msix_index <<
-			MPI2_RPHI_MSIX_INDEX_SHIFT),
-			&ioc->chip->ReplyPostHostIndex);
+		writel_relaxed(reply_q->reply_post_host_index |
+			       (msix_index << MPI2_RPHI_MSIX_INDEX_SHIFT),
+			       &ioc->chip->ReplyPostHostIndex);
 	atomic_dec(&reply_q->busy);
 	return IRQ_HANDLED;
 }
-- 
1.9.1
