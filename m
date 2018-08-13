From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 13 Aug 2018 15:57:51 +0100
Subject: [PATCH 33/37] KVM: arm/arm64: vgic: Move DEBUG_SPINLOCK_BUG_ON to
 vgic.h
In-Reply-To: <20180813145755.16566-1-marc.zyngier@arm.com>
References: <20180813145755.16566-1-marc.zyngier@arm.com>
Message-ID: <20180813145755.16566-34-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jia He <hejianet@gmail.com>

DEBUG_SPINLOCK_BUG_ON can be used with both vgic-v2 and vgic-v3,
so let's move it to vgic.h

Signed-off-by: Jia He <jia.he@hxt-semitech.com>
[maz: commit message tidy-up]
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 virt/kvm/arm/vgic/vgic.c | 6 ------
 virt/kvm/arm/vgic/vgic.h | 6 ++++++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic.c b/virt/kvm/arm/vgic/vgic.c
index 33c8325c8f35..c22cea678a66 100644
--- a/virt/kvm/arm/vgic/vgic.c
+++ b/virt/kvm/arm/vgic/vgic.c
@@ -28,12 +28,6 @@
 #define CREATE_TRACE_POINTS
 #include "trace.h"
 
-#ifdef CONFIG_DEBUG_SPINLOCK
-#define DEBUG_SPINLOCK_BUG_ON(p) BUG_ON(p)
-#else
-#define DEBUG_SPINLOCK_BUG_ON(p)
-#endif
-
 struct vgic_global kvm_vgic_global_state __ro_after_init = {
 	.gicv3_cpuif = STATIC_KEY_FALSE_INIT,
 };
diff --git a/virt/kvm/arm/vgic/vgic.h b/virt/kvm/arm/vgic/vgic.h
index ed9d9d9e2fc5..a90024718ca4 100644
--- a/virt/kvm/arm/vgic/vgic.h
+++ b/virt/kvm/arm/vgic/vgic.h
@@ -103,6 +103,12 @@
 #define KVM_VGIC_V3_RDIST_COUNT_MASK	GENMASK_ULL(63, 52)
 #define KVM_VGIC_V3_RDIST_COUNT_SHIFT	52
 
+#ifdef CONFIG_DEBUG_SPINLOCK
+#define DEBUG_SPINLOCK_BUG_ON(p) BUG_ON(p)
+#else
+#define DEBUG_SPINLOCK_BUG_ON(p)
+#endif
+
 /* Requires the irq_lock to be held by the caller. */
 static inline bool irq_is_pending(struct vgic_irq *irq)
 {
-- 
2.18.0
