From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon,  6 Mar 2017 14:24:56 +0000
Subject: [PATCH v3 23/25] ARM: hyp-stub/KVM: Kill __hyp_get_vectors
In-Reply-To: <20170306142458.8875-1-marc.zyngier@arm.com>
References: <20170306142458.8875-1-marc.zyngier@arm.com>
Message-ID: <20170306142458.8875-24-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nobody is using __hyp_get_vectors anymore, so let's remove both
implementations (hyp-stub and KVM).

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/virt.h | 10 ++++------
 arch/arm/kernel/hyp-stub.S  | 13 +------------
 arch/arm/kvm/init.S         |  7 +------
 arch/arm/kvm/interrupts.S   |  4 ----
 4 files changed, 6 insertions(+), 28 deletions(-)

diff --git a/arch/arm/include/asm/virt.h b/arch/arm/include/asm/virt.h
index 8d5625b790b5..5f45969d4063 100644
--- a/arch/arm/include/asm/virt.h
+++ b/arch/arm/include/asm/virt.h
@@ -53,7 +53,6 @@ static inline void sync_boot_mode(void)
 }
 
 void __hyp_set_vectors(unsigned long phys_vector_base);
-unsigned long __hyp_get_vectors(void);
 void __hyp_reset_vectors(void);
 #else
 #define __boot_cpu_mode	(SVC_MODE)
@@ -99,12 +98,11 @@ extern char __hyp_text_end[];
 
 /* Only assembly code should need those */
 
-#define HVC_GET_VECTORS 0
-#define HVC_SET_VECTORS 1
-#define HVC_SOFT_RESTART 2
-#define HVC_RESET_VECTORS 3
+#define HVC_SET_VECTORS 0
+#define HVC_SOFT_RESTART 1
+#define HVC_RESET_VECTORS 2
 
-#define HVC_STUB_HCALL_NR 4
+#define HVC_STUB_HCALL_NR 3
 
 #endif /* __ASSEMBLY__ */
 
diff --git a/arch/arm/kernel/hyp-stub.S b/arch/arm/kernel/hyp-stub.S
index 3cb01e8a291d..68bf72777ac7 100644
--- a/arch/arm/kernel/hyp-stub.S
+++ b/arch/arm/kernel/hyp-stub.S
@@ -202,12 +202,7 @@ ARM_BE8(orr	r7, r7, #(1 << 25))     @ HSCTLR.EE
 ENDPROC(__hyp_stub_install_secondary)
 
 __hyp_stub_do_trap:
-	teq	r0, #HVC_GET_VECTORS
-	bne	1f
-	mrc	p15, 4, r0, c12, c0, 0	@ get HVBAR
-	b	__hyp_stub_exit
-
-1:	teq	r0, #HVC_SET_VECTORS
+	teq	r0, #HVC_SET_VECTORS
 	bne	1f
 	mcr	p15, 4, r1, c12, c0, 0	@ set HVBAR
 	b	__hyp_stub_exit
@@ -247,12 +242,6 @@ ENDPROC(__hyp_stub_do_trap)
  * so you will need to set that to something sensible@the new hypervisor's
  * initialisation entry point.
  */
-ENTRY(__hyp_get_vectors)
-	mov	r0, #HVC_GET_VECTORS
-	__HVC(0)
-	ret	lr
-ENDPROC(__hyp_get_vectors)
-
 ENTRY(__hyp_set_vectors)
 	mov	r1, r0
 	mov	r0, #HVC_SET_VECTORS
diff --git a/arch/arm/kvm/init.S b/arch/arm/kvm/init.S
index c92e092103b2..3cff15152800 100644
--- a/arch/arm/kvm/init.S
+++ b/arch/arm/kvm/init.S
@@ -122,12 +122,7 @@ __do_hyp_init:
 	eret
 
 ENTRY(__kvm_handle_stub_hvc)
-	cmp	r0, #HVC_GET_VECTORS
-	bne	1f
-	mrc	p15, 4, r0, c12, c0, 0	@ get HVBAR
-	b	exit
-
-1:	cmp	r0, #HVC_SOFT_RESTART
+	cmp	r0, #HVC_SOFT_RESTART
 	bne	1f
 
 	/* The target is expected in r1 */
diff --git a/arch/arm/kvm/interrupts.S b/arch/arm/kvm/interrupts.S
index b1bd316f14c0..80a1d6cd261c 100644
--- a/arch/arm/kvm/interrupts.S
+++ b/arch/arm/kvm/interrupts.S
@@ -37,10 +37,6 @@
  * in Hyp mode (see init_hyp_mode in arch/arm/kvm/arm.c).  Return values are
  * passed in r0 (strictly 32bit).
  *
- * A function pointer with a value of 0xffffffff has a special meaning,
- * and is used to implement __hyp_get_vectors in the same way as in
- * arch/arm/kernel/hyp_stub.S.
- *
  * The calling convention follows the standard AAPCS:
  *   r0 - r3: caller save
  *   r12:     caller save
-- 
2.11.0
