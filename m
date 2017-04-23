From: cdall@linaro.org (Christoffer Dall)
Date: Sun, 23 Apr 2017 19:09:15 +0200
Subject: [PULL 65/79] ARM: hyp-stub/KVM: Kill __hyp_get_vectors
In-Reply-To: <20170423170929.27334-1-cdall@linaro.org>
References: <20170423170929.27334-1-cdall@linaro.org>
Message-ID: <20170423170929.27334-66-cdall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

Nobody is using __hyp_get_vectors anymore, so let's remove both
implementations (hyp-stub and KVM).

Acked-by: Russell King <rmk+kernel@armlinux.org.uk>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <cdall@linaro.org>
---
 arch/arm/include/asm/virt.h | 10 ++++------
 arch/arm/kernel/hyp-stub.S  | 13 +------------
 arch/arm/kvm/init.S         |  7 +------
 arch/arm/kvm/interrupts.S   |  4 ----
 4 files changed, 6 insertions(+), 28 deletions(-)

diff --git a/arch/arm/include/asm/virt.h b/arch/arm/include/asm/virt.h
index 663adc0..141144f 100644
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
index 675c50f..918c64f 100644
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
index e53360d..87bcd7a 100644
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
index b1bd316..80a1d6c 100644
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
2.9.0
