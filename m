From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 17 Oct 2018 21:32:58 +0100
Subject: [PATCH v2] iommu/arm-smmu-v3: Fix big-endian CMD_SYNC writes
Message-ID: <b8d7b19b5cdf1abb28a00c04d2b778f25e168dd6.1539807887.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When we insert the sync sequence number into the CMD_SYNC.MSIData field,
we do so in CPU-native byte order, before writing out the whole command
as explicitly little-endian dwords. Thus on big-endian systems, the SMMU
will receive and write back a byteswapped version of sync_nr, which would
be perfect if it were targeting a similarly-little-endian ITS, but since
it's actually writing back to memory being polled by the CPUs, they're
going to end up seeing the wrong thing.

Since the SMMU doesn't care what the MSIData actually contains, the
minimal-overhead solution is to simply add an extra byteswap initially,
such that it then writes back the big-endian format directly.

Fixes: 37de98f8f1cf ("iommu/arm-smmu-v3: Use CMD_SYNC completion MSI")
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v2: Actually fix the right thing, and comment it.

 drivers/iommu/arm-smmu-v3.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index db402e8b068b..bff47594856b 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -839,7 +839,13 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
 			cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_SEV);
 		cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSH, ARM_SMMU_SH_ISH);
 		cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSIATTR, ARM_SMMU_MEMATTR_OIWB);
-		cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSIDATA, ent->sync.msidata);
+		/*
+		 * Commands are written little-endian, but we want the SMMU to
+		 * receive MSIData, and thus write it back to memory, in CPU
+		 * byte order, so big-endian needs an extra byteswap here.
+		 */
+		cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSIDATA,
+				     cpu_to_le32(ent->sync.msidata));
 		cmd[1] |= ent->sync.msiaddr & CMDQ_SYNC_1_MSIADDR_MASK;
 		break;
 	default:
-- 
2.19.1.dirty
