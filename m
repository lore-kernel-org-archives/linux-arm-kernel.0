From: xieyisheng1@huawei.com (Yisheng Xie)
Date: Mon, 23 Apr 2018 19:45:57 +0800
Subject: [RFC 0/2] iommu/arm-smmu-v3: Support software retention for pm_resume
Message-ID: <1524483959-54940-1-git-send-email-xieyisheng1@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- Backgroud:
 Hisilicon's implement of smmuv3 do not support hardware retention if system
 do power gating when system suspend, however for embed system, we do need
 to do power gating at trust zone for lower power comsume. So software
 retention is need.

- Implement:
 From the process of smmu probe, it will get the feature of smmu from IDR
 registers and keep the status in struct arm_smmu_device, then
 arm_smmu_device_reset() will initial(set) most of the registers according
 to it. So we can use arm_smmu_device_reset() to re-initial the smmuv3
 device to make it can works again.
 
 To achieve this, patch 1 move the bypass parameter from arm_smmu_device_reset()
 to struct arm_smmu_device to make arm_smmu_device_reset() re-usable. Patch 2
 introduces probed parameter for struct arm_smmu_device, so once smmuv3 is probed
 we can avoid request irqs once more. It also introduce a struct arm_smmu_msi_val
 to keep the value of smmuv3's msi register which can be restore when reset device
 after probed.

Yisheng Xie (2):
  iommu/arm-smmu-v3: Remove bypass in arm_smmu_reset_device
  iommu/arm-smmu-v3: Support software retention for pm_resume

 drivers/iommu/arm-smmu-v3.c | 80 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 72 insertions(+), 8 deletions(-)

-- 
1.7.12.4
