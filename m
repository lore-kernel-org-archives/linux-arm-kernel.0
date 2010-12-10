From: stepanm@codeaurora.org (Stepan Moskovchenko)
Date: Fri, 10 Dec 2010 14:12:03 -0800
Subject: [PATCH] msm: iommu: Use the correct memory allocation flag
Message-ID: <1292019123-6044-1-git-send-email-stepanm@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change msm_iommu_map to use GFP_ATOMIC instead of
GFP_KERNEL due to the fact that the call occurs within
a spinlock-protected region.

Change-Id: I7e9345a9a58811c421f9e7fae0c1ec5a759c6178
Signed-off-by: Stepan Moskovchenko <stepanm@codeaurora.org>
---
 arch/arm/mach-msm/iommu.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-msm/iommu.c b/arch/arm/mach-msm/iommu.c
index f651017..e2d58e4 100644
--- a/arch/arm/mach-msm/iommu.c
+++ b/arch/arm/mach-msm/iommu.c
@@ -386,7 +386,7 @@ static int msm_iommu_map(struct iommu_domain *domain, unsigned long va,
 	/* Need a 2nd level table */
 	if ((len == SZ_4K || len == SZ_64K) && (*fl_pte) == 0) {
 		unsigned long *sl;
-		sl = (unsigned long *) __get_free_pages(GFP_KERNEL,
+		sl = (unsigned long *) __get_free_pages(GFP_ATOMIC,
 							get_order(SZ_4K));

 		if (!sl) {
--
1.7.0.2
 Sent by an employee of the Qualcomm Innovation Center, Inc.
 The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
