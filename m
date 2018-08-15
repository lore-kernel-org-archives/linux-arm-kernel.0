From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 15 Aug 2018 15:45:47 +0100
Subject: [PATCH] iommu/arm-smmu-v3: Inline arm_smmu_cmdq_build_cmd()
Message-ID: <141de3c3278e280712d16d9ac9ab305c3b80a810.1534344167.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Outside arm_smmu_cmdq_issue_cmd(), the only places we build a command
are those in which we are generating a sync for various reasons. Given
the circumstances, one might hope GCC to be clever enough to emit a
specialisation which avoids running through the switch statement with a
known constant opcode just to copy two dwords of mostly-static data, but
apparently it needs a little more help.

Explicitly marking arm_smmu_cmdq_build_cmd() as inline reduces these
sync special cases from an out-of-line call to a neat handful of ALU
instructions at the couple of relevant sites, yet squashing the full
switch statement into arm_smmu_cmdq_issue_cmd() somehow has a knock-on
effect across various other areas of the driver for a surprising overall
code size reduction:

   text	   data	    bss	    dec	    hex	filename
  16951	    648	      8	  17607	   44c7	arm-smmu-v3.o.new
  17199	    648	      8	  17855	   45bf	arm-smmu-v3.o.old

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

Having distilled this out of my pile of hacks, I'm fairly confident that
it's a reasonable change. Nothing in the latest SVA branch seems to have
any adverse effect either, which is reassuring.

 drivers/iommu/arm-smmu-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 1d647104bccc..94544cd9d929 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -776,7 +776,7 @@ static int queue_remove_raw(struct arm_smmu_queue *q, u64 *ent)
 }
 
 /* High-level queue accessors */
-static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
+static inline int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
 {
 	memset(cmd, 0, CMDQ_ENT_DWORDS << 3);
 	cmd[0] |= FIELD_PREP(CMDQ_0_OP, ent->opcode);
-- 
2.17.1.dirty
