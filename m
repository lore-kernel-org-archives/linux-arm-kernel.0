From: will.deacon@arm.com (Will Deacon)
Date: Thu, 18 Aug 2016 14:05:42 +0100
Subject: [PATCH 4/4] iommu/arm-smmu: Don't BUG() if we find aborting STEs with
 disable_bypass
In-Reply-To: <1471525542-14969-1-git-send-email-will.deacon@arm.com>
References: <1471525542-14969-1-git-send-email-will.deacon@arm.com>
Message-ID: <1471525542-14969-5-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The disable_bypass cmdline option changes the SMMUv3 driver to put down
faulting stream table entries by default, as opposed to bypassing
transactions from unconfigured devices.

In this mode of operation, it is entirely expected to see aborting
entries in the stream table if and when we come to installing a valid
translation, so don't trigger a BUG() as a result of misdiagnosing these
entries as stream table corruption.

Tested-by: Robin Murphy <robin.murphy@arm.com>
Reported-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 drivers/iommu/arm-smmu-v3.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 330623f8e344..641e88761319 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1034,6 +1034,9 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_device *smmu, u32 sid,
 		case STRTAB_STE_0_CFG_S2_TRANS:
 			ste_live = true;
 			break;
+		case STRTAB_STE_0_CFG_ABORT:
+			if (disable_bypass)
+				break;
 		default:
 			BUG(); /* STE corruption */
 		}
-- 
2.1.4
