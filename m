From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Fri, 26 Jun 2015 16:33:04 +0800
Subject: [PATCH 8/8] iommu/arm-smmu: suppress fault information about
 CMD_PREFETCH_CONFIG execution
In-Reply-To: <1435307584-9812-1-git-send-email-thunder.leizhen@huawei.com>
References: <1435307584-9812-1-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <1435307584-9812-9-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some broken SMMUv3 devices treat CMD_PREFETCH_CONFIG as illegal command,
it's ugly to print error information. CMD_PREFETCH_CONFIG is just used to
prefetch the configuration for a specified StreamID, without this command
will not impact SMMUv3 function.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm-smmu-v3.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index d799feb..3971aef 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -813,6 +813,7 @@ static void arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu)
 	};

 	int i;
+	u32 opcode;
 	u64 cmd[CMDQ_ENT_DWORDS];
 	struct arm_smmu_queue *q = &smmu->cmdq.q;
 	u32 cons = readl_relaxed(q->cons_reg);
@@ -821,15 +822,14 @@ static void arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu)
 		.opcode = CMDQ_OP_CMD_SYNC,
 	};

-	dev_err(smmu->dev, "CMDQ error (cons 0x%08x): %s\n", cons,
-		cerror_str[idx]);
-
 	switch (idx) {
 	case CMDQ_ERR_CERROR_ILL_IDX:
 		break;
 	case CMDQ_ERR_CERROR_ABT_IDX:
-		dev_err(smmu->dev, "retrying command fetch\n");
 	case CMDQ_ERR_CERROR_NONE_IDX:
+		dev_err(smmu->dev, "CMDQ error (cons 0x%08x): %s\n", cons,
+			cerror_str[idx]);
+		dev_err(smmu->dev, "retrying command execution\n");
 		return;
 	}

@@ -838,10 +838,20 @@ static void arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu)
 	 * not to touch any of the shadow cmdq state.
 	 */
 	queue_read(cmd, Q_ENT(q, idx), q->ent_dwords);
+
+	/*
+	 * Some broken SMMUv3 devices treat CMD_PREFETCH_CONFIG as illegal
+	 * command, it's ugly to print error information.
+	 */
+	opcode = (cmd[0] >> CMDQ_0_OP_SHIFT) & CMDQ_0_OP_MASK;
+	if (opcode == CMDQ_OP_PREFETCH_CFG)
+		goto skip_error_command;
+
 	dev_err(smmu->dev, "skipping command in error state:\n");
 	for (i = 0; i < ARRAY_SIZE(cmd); ++i)
 		dev_err(smmu->dev, "\t0x%016llx\n", (unsigned long long)cmd[i]);

+skip_error_command:
 	/* Convert the erroneous command into a CMD_SYNC */
 	if (arm_smmu_cmdq_build_cmd(cmd, &cmd_sync)) {
 		dev_err(smmu->dev, "failed to convert to CMD_SYNC\n");
--
1.8.0
