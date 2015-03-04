From: alex.bennee@linaro.org (=?UTF-8?q?Alex=20Benn=C3=A9e?=)
Date: Wed,  4 Mar 2015 14:35:49 +0000
Subject: [PATCH v2 2/6] hw/intc: arm_gic_kvm.c restore config first
In-Reply-To: <1425479753-18349-1-git-send-email-alex.bennee@linaro.org>
References: <1425479753-18349-1-git-send-email-alex.bennee@linaro.org>
Message-ID: <1425479753-18349-3-git-send-email-alex.bennee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As there is logic to deal with the difference between edge and level
triggered interrupts in the kernel we must ensure it knows the
configuration of the IRQs before we restore the pending state.

Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>
Acked-by: Christoffer Dall <christoffer.dall@linaro.org>

diff --git a/hw/intc/arm_gic_kvm.c b/hw/intc/arm_gic_kvm.c
index 1ad3eb0..2f21ae7 100644
--- a/hw/intc/arm_gic_kvm.c
+++ b/hw/intc/arm_gic_kvm.c
@@ -370,6 +370,11 @@ static void kvm_arm_gic_put(GICState *s)
      * the appropriate CPU interfaces in the kernel) */
     kvm_dist_put(s, 0x800, 8, s->num_irq, translate_targets);
 
+    /* irq_state[n].trigger -> GICD_ICFGRn
+     * (restore targets before pending IRQs so we treat level/edge
+     * correctly */
+    kvm_dist_put(s, 0xc00, 2, s->num_irq, translate_trigger);
+
     /* irq_state[n].pending + irq_state[n].level -> GICD_ISPENDRn */
     kvm_dist_put(s, 0x280, 1, s->num_irq, translate_clear);
     kvm_dist_put(s, 0x200, 1, s->num_irq, translate_pending);
@@ -378,8 +383,6 @@ static void kvm_arm_gic_put(GICState *s)
     kvm_dist_put(s, 0x380, 1, s->num_irq, translate_clear);
     kvm_dist_put(s, 0x300, 1, s->num_irq, translate_active);
 
-    /* irq_state[n].trigger -> GICD_ICFRn */
-    kvm_dist_put(s, 0xc00, 2, s->num_irq, translate_trigger);
 
     /* s->priorityX[irq] -> ICD_IPRIORITYRn */
     kvm_dist_put(s, 0x400, 8, s->num_irq, translate_priority);
-- 
2.3.1
