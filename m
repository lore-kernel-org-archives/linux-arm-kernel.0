From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Wed, 15 Aug 2018 18:23:00 +0800
Subject: [PATCH v3 0/2] bugfix and optimization about CMD_SYNC
Message-ID: <1534328582-17664-1-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v2 -> v3:
Although I have no data to show how many performance will be impacted
because of arm_smmu_cmdq_build_cmd is protected by spinlock. But it's
clear that the performance is bound to drop, a memset operation and 
a complicate switch..case in the function arm_smmu_cmdq_build_cmd.

v1 -> v2:
1. move the call to arm_smmu_cmdq_build_cmd into the critical section,
   and keep itself unchange.
2. Although patch2 can make sure no two CMD_SYNCs will be adjacent,
but patch1 is still needed, see below:

cpu0			cpu1			cpu2
msidata=0
			msidata=1
			insert cmd1
						insert a TLBI command
insert cmd0
			smmu execute cmd1
						smmu execute TLBI
smmu execute cmd0
			poll timeout, because msidata=1 is overridden by
			cmd0, that means VAL=0, sync_idx=1.

Zhen Lei (2):
  iommu/arm-smmu-v3: fix unexpected CMD_SYNC timeout
  iommu/arm-smmu-v3: avoid redundant CMD_SYNCs if possible

 drivers/iommu/arm-smmu-v3.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

-- 
1.8.3
