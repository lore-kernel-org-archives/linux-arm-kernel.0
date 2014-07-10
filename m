From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Thu, 10 Jul 2014 10:04:10 +0800
Subject: [PATCH v10 11/11] virt: arm: support hip04 gic
In-Reply-To: <1404957850-13340-1-git-send-email-haojian.zhuang@linaro.org>
References: <1404957850-13340-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1404957850-13340-12-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In ARM standard GIC, GICH_APR offset is 0xf0 & GICH_LR0 offset is 0x100.
In HiP04 GIC, GICH_APR offset is 0x70 & GICH_LR0 offset is 0x80.

Now reuse the nr_lr field in struct vgic_cpu. Bit[31:16] is used to store
GICH_APR offset in HiP04, and bit[15:0] is used to store real nr_lr
variable. In ARM standard GIC, don't set bit[31:16]. So we could avoid
to change the VGIC implementation in arm64.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 arch/arm/kernel/asm-offsets.c   |  2 +-
 arch/arm/kvm/interrupts_head.S  | 29 +++++++++++++++++++++++------
 arch/arm64/kernel/asm-offsets.c |  2 +-
 arch/arm64/kvm/hyp.S            |  4 ++--
 include/kvm/arm_vgic.h          |  7 +++++--
 include/linux/irqchip/arm-gic.h |  6 ++++++
 virt/kvm/arm/vgic.c             | 37 ++++++++++++++++++++++++++-----------
 7 files changed, 64 insertions(+), 23 deletions(-)

diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
index 85598b5..166cc98 100644
--- a/arch/arm/kernel/asm-offsets.c
+++ b/arch/arm/kernel/asm-offsets.c
@@ -189,7 +189,7 @@ int main(void)
   DEFINE(VGIC_CPU_ELRSR,	offsetof(struct vgic_cpu, vgic_elrsr));
   DEFINE(VGIC_CPU_APR,		offsetof(struct vgic_cpu, vgic_apr));
   DEFINE(VGIC_CPU_LR,		offsetof(struct vgic_cpu, vgic_lr));
-  DEFINE(VGIC_CPU_NR_LR,	offsetof(struct vgic_cpu, nr_lr));
+  DEFINE(VGIC_CPU_HW_CFG,	offsetof(struct vgic_cpu, hw_cfg));
 #ifdef CONFIG_KVM_ARM_TIMER
   DEFINE(VCPU_TIMER_CNTV_CTL,	offsetof(struct kvm_vcpu, arch.timer_cpu.cntv_ctl));
   DEFINE(VCPU_TIMER_CNTV_CVAL,	offsetof(struct kvm_vcpu, arch.timer_cpu.cntv_cval));
diff --git a/arch/arm/kvm/interrupts_head.S b/arch/arm/kvm/interrupts_head.S
index 76af9302..9fbbf99 100644
--- a/arch/arm/kvm/interrupts_head.S
+++ b/arch/arm/kvm/interrupts_head.S
@@ -419,7 +419,9 @@ vcpu	.req	r0		@ vcpu pointer always in r0
 	ldr	r7, [r2, #GICH_EISR1]
 	ldr	r8, [r2, #GICH_ELRSR0]
 	ldr	r9, [r2, #GICH_ELRSR1]
-	ldr	r10, [r2, #GICH_APR]
+	ldr	r10, [r11, #VGIC_CPU_HW_CFG]
+	mov	r10, r10, lsr #HWCFG_APR_SHIFT
+	ldr	r10, [r2, r10]
 
 	str	r3, [r11, #VGIC_CPU_HCR]
 	str	r4, [r11, #VGIC_CPU_VMCR]
@@ -435,9 +437,15 @@ vcpu	.req	r0		@ vcpu pointer always in r0
 	str	r5, [r2, #GICH_HCR]
 
 	/* Save list registers */
-	add	r2, r2, #GICH_LR0
+	ldr	r4, [r11, #VGIC_CPU_HW_CFG]
+	mov	r10, r4, lsr #HWCFG_APR_SHIFT
+	/* the offset between GICH_APR & GICH_LR0 is 0x10 */
+	add	r10, r10, #0x10
+	add	r2, r2, r10
 	add	r3, r11, #VGIC_CPU_LR
-	ldr	r4, [r11, #VGIC_CPU_NR_LR]
+	/* Get NR_LR from VGIC_CPU_HW_CFG */
+	ldr	r6, =HWCFG_NR_LR_MASK
+	and	r4, r4, r6
 1:	ldr	r6, [r2], #4
 	str	r6, [r3], #4
 	subs	r4, r4, #1
@@ -469,12 +477,21 @@ vcpu	.req	r0		@ vcpu pointer always in r0
 
 	str	r3, [r2, #GICH_HCR]
 	str	r4, [r2, #GICH_VMCR]
-	str	r8, [r2, #GICH_APR]
+	ldr	r6, [r11, #VGIC_CPU_HW_CFG]
+	mov	r6, r6, lsr #HWCFG_APR_SHIFT
+	str	r8, [r2, r6]
 
 	/* Restore list registers */
-	add	r2, r2, #GICH_LR0
+	ldr	r4, [r11, #VGIC_CPU_HW_CFG]
+	mov	r6, r4, lsr #HWCFG_APR_SHIFT
+	/* the offset between GICH_APR & GICH_LR0 is 0x10 */
+	add	r6, r6, #0x10
+	/* get offset of GICH_LR0 */
+	add	r2, r2, r6
+	/* Get NR_LR from VGIC_CPU_HW_CFG */
 	add	r3, r11, #VGIC_CPU_LR
-	ldr	r4, [r11, #VGIC_CPU_NR_LR]
+	ldr	r6, =HWCFG_NR_LR_MASK
+	and	r4, r4, r6
 1:	ldr	r6, [r3], #4
 	str	r6, [r2], #4
 	subs	r4, r4, #1
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 646f888..2422358 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -136,7 +136,7 @@ int main(void)
   DEFINE(VGIC_CPU_ELRSR,	offsetof(struct vgic_cpu, vgic_elrsr));
   DEFINE(VGIC_CPU_APR,		offsetof(struct vgic_cpu, vgic_apr));
   DEFINE(VGIC_CPU_LR,		offsetof(struct vgic_cpu, vgic_lr));
-  DEFINE(VGIC_CPU_NR_LR,	offsetof(struct vgic_cpu, nr_lr));
+  DEFINE(VGIC_CPU_HW_CFG,	offsetof(struct vgic_cpu, hw_cfg));
   DEFINE(KVM_VTTBR,		offsetof(struct kvm, arch.vttbr));
   DEFINE(KVM_VGIC_VCTRL,	offsetof(struct kvm, arch.vgic.vctrl_base));
 #endif
diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
index b0d1512..2dbe337 100644
--- a/arch/arm64/kvm/hyp.S
+++ b/arch/arm64/kvm/hyp.S
@@ -426,7 +426,7 @@ CPU_BE(	rev	w11, w11 )
 
 	/* Save list registers */
 	add	x2, x2, #GICH_LR0
-	ldr	w4, [x3, #VGIC_CPU_NR_LR]
+	ldr	w4, [x3, #VGIC_CPU_HW_CFG]
 	add	x3, x3, #VGIC_CPU_LR
 1:	ldr	w5, [x2], #4
 CPU_BE(	rev	w5, w5 )
@@ -465,7 +465,7 @@ CPU_BE(	rev	w6, w6 )
 
 	/* Restore list registers */
 	add	x2, x2, #GICH_LR0
-	ldr	w4, [x3, #VGIC_CPU_NR_LR]
+	ldr	w4, [x3, #VGIC_CPU_HW_CFG]
 	add	x3, x3, #VGIC_CPU_LR
 1:	ldr	w5, [x3], #4
 CPU_BE(	rev	w5, w5 )
diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index f27000f..eba4b51 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -122,8 +122,11 @@ struct vgic_cpu {
 	/* Bitmap of used/free list registers */
 	DECLARE_BITMAP(	lr_used, VGIC_MAX_LRS);
 
-	/* Number of list registers on this CPU */
-	int		nr_lr;
+	/*
+	 * bit[31:16]: GICH_APR offset
+	 * bit[15:0]:  Number of list registers on this CPU
+	 */
+	u32		hw_cfg;
 
 	/* CPU vif control registers for world switch */
 	u32		vgic_hcr;
diff --git a/include/linux/irqchip/arm-gic.h b/include/linux/irqchip/arm-gic.h
index 45e2d8c..b055f92 100644
--- a/include/linux/irqchip/arm-gic.h
+++ b/include/linux/irqchip/arm-gic.h
@@ -49,6 +49,8 @@
 #define GICH_ELRSR1 			0x34
 #define GICH_APR			0xf0
 #define GICH_LR0			0x100
+#define HIP04_GICH_APR			0x70
+/* GICH_LR0 offset in HiP04 is 0x80 */
 
 #define GICH_HCR_EN			(1 << 0)
 #define GICH_HCR_UIE			(1 << 1)
@@ -73,6 +75,10 @@
 #define GICH_MISR_EOI			(1 << 0)
 #define GICH_MISR_U			(1 << 1)
 
+#define HWCFG_NR_LR_MASK	0xffff
+#define HWCFG_APR_SHIFT		16
+#define HWCFG_APR_MASK		(0xffff << HWCFG_APR_SHIFT)
+
 #ifndef __ASSEMBLY__
 
 struct device_node;
diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 56ff9be..6c0ee89 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -97,7 +97,7 @@ static void vgic_retire_disabled_irqs(struct kvm_vcpu *vcpu);
 static void vgic_update_state(struct kvm *kvm);
 static void vgic_kick_vcpus(struct kvm *kvm);
 static void vgic_dispatch_sgi(struct kvm_vcpu *vcpu, u32 reg);
-static u32 vgic_nr_lr;
+static u32 vgic_hw_cfg, vgic_nr_lr;
 
 static unsigned int vgic_maint_irq;
 
@@ -625,7 +625,7 @@ static void vgic_unqueue_irqs(struct kvm_vcpu *vcpu)
 	int i, irq, source_cpu;
 	u32 *lr;
 
-	for_each_set_bit(i, vgic_cpu->lr_used, vgic_cpu->nr_lr) {
+	for_each_set_bit(i, vgic_cpu->lr_used, vgic_nr_lr) {
 		lr = &vgic_cpu->vgic_lr[i];
 		irq = LR_IRQID(*lr);
 		source_cpu = LR_CPUID(*lr);
@@ -1006,7 +1006,7 @@ static void vgic_retire_disabled_irqs(struct kvm_vcpu *vcpu)
 	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
 	int lr;
 
-	for_each_set_bit(lr, vgic_cpu->lr_used, vgic_cpu->nr_lr) {
+	for_each_set_bit(lr, vgic_cpu->lr_used, vgic_nr_lr) {
 		int irq = vgic_cpu->vgic_lr[lr] & GICH_LR_VIRTUALID;
 
 		if (!vgic_irq_is_enabled(vcpu, irq)) {
@@ -1047,8 +1047,8 @@ static bool vgic_queue_irq(struct kvm_vcpu *vcpu, u8 sgi_source_id, int irq)
 
 	/* Try to use another LR for this interrupt */
 	lr = find_first_zero_bit((unsigned long *)vgic_cpu->lr_used,
-			       vgic_cpu->nr_lr);
-	if (lr >= vgic_cpu->nr_lr)
+				 vgic_nr_lr);
+	if (lr >= vgic_nr_lr)
 		return false;
 
 	kvm_debug("LR%d allocated for IRQ%d %x\n", lr, irq, sgi_source_id);
@@ -1183,7 +1183,7 @@ static bool vgic_process_maintenance(struct kvm_vcpu *vcpu)
 		int lr, irq;
 
 		for_each_set_bit(lr, (unsigned long *)vgic_cpu->vgic_eisr,
-				 vgic_cpu->nr_lr) {
+				 vgic_nr_lr) {
 			irq = vgic_cpu->vgic_lr[lr] & GICH_LR_VIRTUALID;
 
 			vgic_irq_clear_active(vcpu, irq);
@@ -1227,7 +1227,7 @@ static void __kvm_vgic_sync_hwstate(struct kvm_vcpu *vcpu)
 
 	/* Clear mappings for empty LRs */
 	for_each_set_bit(lr, (unsigned long *)vgic_cpu->vgic_elrsr,
-			 vgic_cpu->nr_lr) {
+			 vgic_nr_lr) {
 		int irq;
 
 		if (!test_and_clear_bit(lr, vgic_cpu->lr_used))
@@ -1241,8 +1241,8 @@ static void __kvm_vgic_sync_hwstate(struct kvm_vcpu *vcpu)
 
 	/* Check if we still have something up our sleeve... */
 	pending = find_first_zero_bit((unsigned long *)vgic_cpu->vgic_elrsr,
-				      vgic_cpu->nr_lr);
-	if (level_pending || pending < vgic_cpu->nr_lr)
+				      vgic_nr_lr);
+	if (level_pending || pending < vgic_nr_lr)
 		set_bit(vcpu->vcpu_id, &dist->irq_pending_on_cpu);
 }
 
@@ -1438,7 +1438,7 @@ int kvm_vgic_vcpu_init(struct kvm_vcpu *vcpu)
 	 */
 	vgic_cpu->vgic_vmcr = 0;
 
-	vgic_cpu->nr_lr = vgic_nr_lr;
+	vgic_cpu->hw_cfg = vgic_hw_cfg;
 	vgic_cpu->vgic_hcr = GICH_HCR_EN; /* Get the show on the road... */
 
 	return 0;
@@ -1470,17 +1470,31 @@ static struct notifier_block vgic_cpu_nb = {
 	.notifier_call = vgic_cpu_notify,
 };
 
+static const struct of_device_id of_vgic_ids[] = {
+	{
+		.compatible = "arm,cortex-a15-gic",
+		.data = (void *)GICH_APR,
+	}, {
+		.compatible = "hisilicon,hip04-gic",
+		.data = (void *)HIP04_GICH_APR,
+	}, {
+	},
+};
+
 int kvm_vgic_hyp_init(void)
 {
 	int ret;
 	struct resource vctrl_res;
 	struct resource vcpu_res;
+	const struct of_device_id *match;
 
-	vgic_node = of_find_compatible_node(NULL, NULL, "arm,cortex-a15-gic");
+	vgic_node = of_find_matching_node_and_match(NULL, of_vgic_ids, &match);
 	if (!vgic_node) {
 		kvm_err("error: no compatible vgic node in DT\n");
 		return -ENODEV;
 	}
+	/* High word of vgic_hw_cfg is the offset of GICH_APR. */
+	vgic_hw_cfg = (unsigned long)match->data << HWCFG_APR_SHIFT;
 
 	vgic_maint_irq = irq_of_parse_and_map(vgic_node, 0);
 	if (!vgic_maint_irq) {
@@ -1517,6 +1531,7 @@ int kvm_vgic_hyp_init(void)
 
 	vgic_nr_lr = readl_relaxed(vgic_vctrl_base + GICH_VTR);
 	vgic_nr_lr = (vgic_nr_lr & 0x3f) + 1;
+	vgic_hw_cfg |= vgic_nr_lr;
 
 	ret = create_hyp_io_mappings(vgic_vctrl_base,
 				     vgic_vctrl_base + resource_size(&vctrl_res),
-- 
1.9.1
