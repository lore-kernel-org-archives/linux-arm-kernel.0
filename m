From: eric.auger@redhat.com (Eric Auger)
Date: Tue,  2 Aug 2016 17:30:10 +0000
Subject: [PATCH v12 7/8] iommu/arm-smmu: do not advertise IOMMU_CAP_INTR_REMAP
In-Reply-To: <1470159012-7110-1-git-send-email-eric.auger@redhat.com>
References: <1470159012-7110-1-git-send-email-eric.auger@redhat.com>
Message-ID: <1470159012-7110-8-git-send-email-eric.auger@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Do not advertise IOMMU_CAP_INTR_REMAP for arm-smmu(-v3). Indeed the
irq_remapping capability is abstracted on irqchip side for ARM as
opposed to Intel IOMMU featuring IRQ remapping HW.

So to check IRQ remapping capability, the msi domain needs to be
checked instead.

This commit affects platform and PCIe device assignment use cases
on any platform featuring an unsafe MSI controller (currently the
ARM GICv2m). For those platforms the VFIO module must be loaded with
allow_unsafe_interrupts set to 1.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v9 -> v10:
- reword the commit message (allow_unsafe_interrupts)
---
 drivers/iommu/arm-smmu-v3.c | 3 ++-
 drivers/iommu/arm-smmu.c    | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 960d377..a011eba 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1387,7 +1387,8 @@ static bool arm_smmu_capable(enum iommu_cap cap)
 	case IOMMU_CAP_CACHE_COHERENCY:
 		return true;
 	case IOMMU_CAP_INTR_REMAP:
-		return true; /* MSIs are just memory writes */
+		/* interrupt translation handled at MSI controller level */
+		return false;
 	case IOMMU_CAP_NOEXEC:
 		return true;
 	default:
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 867910b..b03a89b 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1380,7 +1380,8 @@ static bool arm_smmu_capable(enum iommu_cap cap)
 		 */
 		return true;
 	case IOMMU_CAP_INTR_REMAP:
-		return true; /* MSIs are just memory writes */
+		/* interrupt translation handled at MSI controller level */
+		return false;
 	case IOMMU_CAP_NOEXEC:
 		return true;
 	default:
-- 
1.9.1
