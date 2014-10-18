From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 18 Oct 2014 12:57:02 +0100
Subject: [PATCH 12/12] arm/arm64: KVM: Fix BE accesses to GICv2 EISR and ELRSR
 regs
In-Reply-To: <1413633422-14907-1-git-send-email-marc.zyngier@arm.com>
References: <1413633422-14907-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1413633422-14907-13-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christoffer Dall <christoffer.dall@linaro.org>

The EIRSR and ELRSR registers are 32-bit registers on GICv2, and we
store these as an array of two such registers on the vgic vcpu struct.
However, we access them as a single 64-bit value or as a bitmap pointer
in the generic vgic code, which breaks BE support.

Instead, store them as u64 values on the vgic structure and do the
word-swapping in the assembly code, which already handles the byte order
for BE systems.

Tested-by: Victor Kamensky <victor.kamensky@linaro.org>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/kvm/interrupts_head.S  |  7 +++++++
 arch/arm64/kvm/vgic-v2-switch.S | 12 ++++++++----
 include/kvm/arm_vgic.h          |  4 ++--
 virt/kvm/arm/vgic-v2.c          | 24 +++---------------------
 virt/kvm/arm/vgic.c             | 18 ++++++++++++++++--
 5 files changed, 36 insertions(+), 29 deletions(-)

diff --git a/arch/arm/kvm/interrupts_head.S b/arch/arm/kvm/interrupts_head.S
index 98c8c5b..14d4883 100644
--- a/arch/arm/kvm/interrupts_head.S
+++ b/arch/arm/kvm/interrupts_head.S
@@ -433,10 +433,17 @@ ARM_BE8(rev	r10, r10	)
 	str	r3, [r11, #VGIC_V2_CPU_HCR]
 	str	r4, [r11, #VGIC_V2_CPU_VMCR]
 	str	r5, [r11, #VGIC_V2_CPU_MISR]
+#ifdef CONFIG_CPU_ENDIAN_BE8
+	str	r6, [r11, #(VGIC_V2_CPU_EISR + 4)]
+	str	r7, [r11, #VGIC_V2_CPU_EISR]
+	str	r8, [r11, #(VGIC_V2_CPU_ELRSR + 4)]
+	str	r9, [r11, #VGIC_V2_CPU_ELRSR]
+#else
 	str	r6, [r11, #VGIC_V2_CPU_EISR]
 	str	r7, [r11, #(VGIC_V2_CPU_EISR + 4)]
 	str	r8, [r11, #VGIC_V2_CPU_ELRSR]
 	str	r9, [r11, #(VGIC_V2_CPU_ELRSR + 4)]
+#endif
 	str	r10, [r11, #VGIC_V2_CPU_APR]
 
 	/* Clear GICH_HCR */
diff --git a/arch/arm64/kvm/vgic-v2-switch.S b/arch/arm64/kvm/vgic-v2-switch.S
index ae21177..f002fe1 100644
--- a/arch/arm64/kvm/vgic-v2-switch.S
+++ b/arch/arm64/kvm/vgic-v2-switch.S
@@ -67,10 +67,14 @@ CPU_BE(	rev	w11, w11 )
 	str	w4, [x3, #VGIC_V2_CPU_HCR]
 	str	w5, [x3, #VGIC_V2_CPU_VMCR]
 	str	w6, [x3, #VGIC_V2_CPU_MISR]
-	str	w7, [x3, #VGIC_V2_CPU_EISR]
-	str	w8, [x3, #(VGIC_V2_CPU_EISR + 4)]
-	str	w9, [x3, #VGIC_V2_CPU_ELRSR]
-	str	w10, [x3, #(VGIC_V2_CPU_ELRSR + 4)]
+CPU_LE(	str	w7, [x3, #VGIC_V2_CPU_EISR] )
+CPU_LE(	str	w8, [x3, #(VGIC_V2_CPU_EISR + 4)] )
+CPU_LE(	str	w9, [x3, #VGIC_V2_CPU_ELRSR] )
+CPU_LE(	str	w10, [x3, #(VGIC_V2_CPU_ELRSR + 4)] )
+CPU_BE(	str	w7, [x3, #(VGIC_V2_CPU_EISR + 4)] )
+CPU_BE(	str	w8, [x3, #VGIC_V2_CPU_EISR] )
+CPU_BE(	str	w9, [x3, #(VGIC_V2_CPU_ELRSR + 4)] )
+CPU_BE(	str	w10, [x3, #VGIC_V2_CPU_ELRSR] )
 	str	w11, [x3, #VGIC_V2_CPU_APR]
 
 	/* Clear GICH_HCR */
diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index ec559d3..206dcc3 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -219,8 +219,8 @@ struct vgic_v2_cpu_if {
 	u32		vgic_hcr;
 	u32		vgic_vmcr;
 	u32		vgic_misr;	/* Saved only */
-	u32		vgic_eisr[2];	/* Saved only */
-	u32		vgic_elrsr[2];	/* Saved only */
+	u64		vgic_eisr;	/* Saved only */
+	u64		vgic_elrsr;	/* Saved only */
 	u32		vgic_apr;
 	u32		vgic_lr[VGIC_V2_MAX_LRS];
 };
diff --git a/virt/kvm/arm/vgic-v2.c b/virt/kvm/arm/vgic-v2.c
index 01124ef..2935405 100644
--- a/virt/kvm/arm/vgic-v2.c
+++ b/virt/kvm/arm/vgic-v2.c
@@ -71,35 +71,17 @@ static void vgic_v2_sync_lr_elrsr(struct kvm_vcpu *vcpu, int lr,
 				  struct vgic_lr lr_desc)
 {
 	if (!(lr_desc.state & LR_STATE_MASK))
-		set_bit(lr, (unsigned long *)vcpu->arch.vgic_cpu.vgic_v2.vgic_elrsr);
+		vcpu->arch.vgic_cpu.vgic_v2.vgic_elrsr |= (1ULL << lr);
 }
 
 static u64 vgic_v2_get_elrsr(const struct kvm_vcpu *vcpu)
 {
-	u64 val;
-
-#if BITS_PER_LONG == 64
-	val  = vcpu->arch.vgic_cpu.vgic_v2.vgic_elrsr[1];
-	val <<= 32;
-	val |= vcpu->arch.vgic_cpu.vgic_v2.vgic_elrsr[0];
-#else
-	val = *(u64 *)vcpu->arch.vgic_cpu.vgic_v2.vgic_elrsr;
-#endif
-	return val;
+	return vcpu->arch.vgic_cpu.vgic_v2.vgic_elrsr;
 }
 
 static u64 vgic_v2_get_eisr(const struct kvm_vcpu *vcpu)
 {
-	u64 val;
-
-#if BITS_PER_LONG == 64
-	val  = vcpu->arch.vgic_cpu.vgic_v2.vgic_eisr[1];
-	val <<= 32;
-	val |= vcpu->arch.vgic_cpu.vgic_v2.vgic_eisr[0];
-#else
-	val = *(u64 *)vcpu->arch.vgic_cpu.vgic_v2.vgic_eisr;
-#endif
-	return val;
+	return vcpu->arch.vgic_cpu.vgic_v2.vgic_eisr;
 }
 
 static u32 vgic_v2_get_interrupt_status(const struct kvm_vcpu *vcpu)
diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 382fb5a..3aaca49 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -145,6 +145,20 @@ static void vgic_free_bitmap(struct vgic_bitmap *b)
 	b->shared = NULL;
 }
 
+/*
+ * Call this function to convert a u64 value to an unsigned long * bitmask
+ * in a way that works on both 32-bit and 64-bit LE and BE platforms.
+ *
+ * Warning: Calling this function may modify *val.
+ */
+static unsigned long *u64_to_bitmask(u64 *val)
+{
+#if defined(CONFIG_CPU_BIG_ENDIAN) && BITS_PER_LONG == 32
+	*val = (*val >> 32) | (*val << 32);
+#endif
+	return (unsigned long *)val;
+}
+
 static u32 *vgic_bitmap_get_reg(struct vgic_bitmap *x,
 				int cpuid, u32 offset)
 {
@@ -1442,7 +1456,7 @@ static bool vgic_process_maintenance(struct kvm_vcpu *vcpu)
 		 * active bit.
 		 */
 		u64 eisr = vgic_get_eisr(vcpu);
-		unsigned long *eisr_ptr = (unsigned long *)&eisr;
+		unsigned long *eisr_ptr = u64_to_bitmask(&eisr);
 		int lr;
 
 		for_each_set_bit(lr, eisr_ptr, vgic->nr_lr) {
@@ -1505,7 +1519,7 @@ static void __kvm_vgic_sync_hwstate(struct kvm_vcpu *vcpu)
 
 	level_pending = vgic_process_maintenance(vcpu);
 	elrsr = vgic_get_elrsr(vcpu);
-	elrsr_ptr = (unsigned long *)&elrsr;
+	elrsr_ptr = u64_to_bitmask(&elrsr);
 
 	/* Clear mappings for empty LRs */
 	for_each_set_bit(lr, elrsr_ptr, vgic->nr_lr) {
-- 
2.1.1
