From: vivek.gautam@codeaurora.org (Vivek Gautam)
Date: Thu,  6 Jul 2017 15:06:59 +0530
Subject: [PATCH V4 0/6] iommu/arm-smmu: Add runtime pm/sleep support
Message-ID: <1499333825-7658-1-git-send-email-vivek.gautam@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series provides the support for turning on the arm-smmu's
clocks/power domains using runtime pm. This is done using the
recently introduced device links patches, which lets the symmu's
runtime to follow the master's runtime pm, so the smmu remains
powered only when the masters use it.

Took some reference from the exynos runtime patches [2].
Tested this with MDP, GPU, and VENUS devices on apq8096-db820c board.

Previous version of the patchset [1].

[V4]
   * Reworked the clock handling part. We now take clock names as data
     in the driver for supported compatible versions, and loop over them
     to get, enable, and disable the clocks.
   * Using qcom,msm8996 based compatibles for bindings instead of a generic
     qcom compatible.
   * Refactor MMU500 patch to just add the necessary clock names data and
     corresponding bindings.
   * Added the pm_runtime_get/put() calls in .unmap iommu op (fix added by
     Stanimir on top of previous patch version.
   * Added a patch to fix error path in arm_smmu_add_device()
   * Removed patch 3/5 of V3 patch series that added qcom,smmu-v2 bindings.

[V3]
   * Reworked the patches to keep the clocks init/enabling function
     separately for each compatible.

   * Added clocks bindings for MMU40x/500.

   * Added a new compatible for qcom,smmu-v2 implementation and
     the clock bindings for the same.

   * Rebased on top of 4.11-rc1

[V2]
   * Split the patches little differently.

   * Addressed comments.

   * Removed the patch #4 [3] from previous post
     for arm-smmu context save restore. Planning to
     post this separately after reworking/addressing Robin's
     feedback.

   * Reversed the sequence to disable clocks than enabling.
     This was required for those cases where the
     clocks are populated in a dependent order from DT.

[1] https://www.spinics.net/lists/arm-kernel/msg567488.html
[2] https://lkml.org/lkml/2016/10/20/70
[3] https://patchwork.kernel.org/patch/9389717/

Sricharan R (4):
  iommu/arm-smmu: Add pm_runtime/sleep ops
  iommu/arm-smmu: Invoke pm_runtime during probe, add/remove device
  iommu/arm-smmu: Add the device_link between masters and smmu
  iommu/arm-smmu: Add support for MMU40x/500 clocks

Vivek Gautam (2):
  iommu/arm-smmu: Fix the error path in arm_smmu_add_device
  iommu/arm-smmu: Add support for qcom,msm8996-smmu-v2 clocks

 .../devicetree/bindings/iommu/arm,smmu.txt         |  42 +++++
 drivers/iommu/arm-smmu.c                           | 191 +++++++++++++++++++--
 2 files changed, 222 insertions(+), 11 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
