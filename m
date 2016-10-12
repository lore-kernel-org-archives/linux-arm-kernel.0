From: eric.auger@redhat.com (Eric Auger)
Date: Wed, 12 Oct 2016 13:22:23 +0000
Subject: [PATCH v14 15/16] iommu/arm-smmu: Do not advertise
 IOMMU_CAP_INTR_REMAP
In-Reply-To: <1476278544-3397-1-git-send-email-eric.auger@redhat.com>
References: <1476278544-3397-1-git-send-email-eric.auger@redhat.com>
Message-ID: <1476278544-3397-16-git-send-email-eric.auger@redhat.com>
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
index 572cad8..d71a955 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1371,7 +1371,8 @@ static bool arm_smmu_capable(enum iommu_cap cap)
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
index ae20b9c..becad89 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1361,7 +1361,8 @@ static bool arm_smmu_capable(enum iommu_cap cap)
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
