From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 18 Oct 2017 15:04:28 +0100
Subject: [RFT v3 3/3] iommu/arm-smmu-v3: Use burst-polling for sync completion
In-Reply-To: <cover.1508334262.git.robin.murphy@arm.com>
References: <cover.1508334262.git.robin.murphy@arm.com>
Message-ID: <5e8bbe01a33730541fac122b4b44709a1ca1e8d1.1508334262.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While CMD_SYNC is unlikely to complete immediately such that we never go
round the polling loop, with a lightly-loaded queue it may still do so
long before the delay period is up. If we have no better completion
notifier, use similar logic as we have for SMMUv2 to spin a number of
times before each backoff, so that we have more chance of catching syncs
which complete relatively quickly and avoid delaying unnecessarily.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

I still have no idea whether this patch has any real merit or not.

 drivers/iommu/arm-smmu-v3.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 3130e7182dde..994b3a38f222 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -418,6 +418,7 @@
 /* High-level queue structures */
 #define ARM_SMMU_POLL_TIMEOUT_US	100
 #define ARM_SMMU_SYNC_TIMEOUT_US	1000000 /* 1s! */
+#define ARM_SMMU_SYNC_SPIN_COUNT	10
 
 #define MSI_IOVA_BASE			0x8000000
 #define MSI_IOVA_LENGTH			0x100000
@@ -1013,7 +1014,7 @@ static int arm_smmu_sync_poll_cons(struct arm_smmu_device *smmu, u32 sync_idx,
 	ktime_t timeout = ktime_add_us(ktime_get(), ARM_SMMU_SYNC_TIMEOUT_US);
 	struct arm_smmu_queue *q = &smmu->cmdq.q;
 	bool wfe = !!(smmu->features & ARM_SMMU_FEAT_SEV);
-	unsigned int delay = 1;
+	unsigned int delay = 1, spin_cnt = 0;
 
 	do {
 		queue_sync_cons(q);
@@ -1036,10 +1037,13 @@ static int arm_smmu_sync_poll_cons(struct arm_smmu_device *smmu, u32 sync_idx,
 
 		if (wfe) {
 			wfe();
-		} else {
+		} else if (++spin_cnt < ARM_SMMU_SYNC_SPIN_COUNT) {
 			cpu_relax();
+			continue;
+		} else {
 			udelay(delay);
 			delay *= 2;
+			spin_cnt = 0;
 		}
 	} while (ktime_before(ktime_get(), timeout));
 
-- 
2.13.4.dirty
