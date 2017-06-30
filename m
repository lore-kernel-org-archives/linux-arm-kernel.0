From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 30 Jun 2017 09:44:36 +0100
Subject: [PATCH 20/58] KVM: arm/arm64: Move irq_is_ppi() to header file
In-Reply-To: <20170630084514.6779-1-marc.zyngier@arm.com>
References: <20170630084514.6779-1-marc.zyngier@arm.com>
Message-ID: <20170630084514.6779-21-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christoffer Dall <cdall@linaro.org>

We are about to need this define in the arch timer code as well so move
it to a common location.

Signed-off-by: Christoffer Dall <cdall@linaro.org>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
---
 include/kvm/arm_vgic.h | 2 ++
 virt/kvm/arm/pmu.c     | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index 97b8d3728b31..dde59fbc5f80 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -38,6 +38,8 @@
 #define VGIC_MIN_LPI		8192
 #define KVM_IRQCHIP_NUM_PINS	(1020 - 32)
 
+#define irq_is_ppi(irq) ((irq) >= VGIC_NR_SGIS && (irq) < VGIC_NR_PRIVATE_IRQS)
+
 enum vgic_type {
 	VGIC_V2,		/* Good ol' GICv2 */
 	VGIC_V3,		/* New fancy GICv3 */
diff --git a/virt/kvm/arm/pmu.c b/virt/kvm/arm/pmu.c
index 96a9cab39982..574feff55a6c 100644
--- a/virt/kvm/arm/pmu.c
+++ b/virt/kvm/arm/pmu.c
@@ -496,8 +496,6 @@ static int kvm_arm_pmu_v3_init(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
-#define irq_is_ppi(irq) ((irq) >= VGIC_NR_SGIS && (irq) < VGIC_NR_PRIVATE_IRQS)
-
 /*
  * For one VM the interrupt type must be same for each vcpu.
  * As a PPI, the interrupt number is the same for all vcpus,
-- 
2.11.0
