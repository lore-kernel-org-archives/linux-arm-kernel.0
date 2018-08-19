From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Sun, 19 Aug 2018 15:51:09 +0800
Subject: [PATCH v4 0/2] bugfix and optimization about CMD_SYNC
Message-ID: <1534665071-7976-1-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v3->v4:
1. create a new function arm_smmu_cmdq_build_sync_msi_cmd, it's only used to
build CMD_SYNC for CS=SIG_IRQ mode.
2. In order to observe the optimization effect, I conducted 5 tests for each
case. Although the test result is volatility, but we can still get which case
is good or bad.

Test command: fio -numjobs=8 -rw=randread -runtime=30 ... -bs=4k
Test Result: IOPS

Case 1: (without these patches)
675480
672055
665275
648610
661146

Case 2: (only apply the variant of patch 1, move arm_smmu_cmdq_build_cmd into lock)
688714
697355
632951
700540
678459

Case 3: (only apply patch 1)
721582
729226
689574
679710
727770

Case 4: (apply both patch 1 and patch 2)
734077
742868
738194
682544
740586

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

 drivers/iommu/arm-smmu-v3.c | 44 ++++++++++++++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 12 deletions(-)

-- 
1.8.3
