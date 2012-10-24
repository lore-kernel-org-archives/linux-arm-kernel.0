From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Wed, 24 Oct 2012 16:26:08 +0100
Subject: [PATCH RESEND] xen/arm: use the __HVC macro
In-Reply-To: <alpine.DEB.2.02.1208161618550.4850@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1208161618550.4850@kaball.uk.xensource.com>
Message-ID: <alpine.DEB.2.02.1210241624400.2689@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the new __HVC macro in hypercall.S.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>

---
 arch/arm/xen/hypercall.S |   14 +++++---------
 1 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/arm/xen/hypercall.S b/arch/arm/xen/hypercall.S
index 074f5ed..71f7239 100644
--- a/arch/arm/xen/hypercall.S
+++ b/arch/arm/xen/hypercall.S
@@ -48,20 +48,16 @@
 
 #include <linux/linkage.h>
 #include <asm/assembler.h>
+#include <asm/opcodes-virt.h>
 #include <xen/interface/xen.h>
 
 
-/* HVC 0xEA1 */
-#ifdef CONFIG_THUMB2_KERNEL
-#define xen_hvc .word 0xf7e08ea1
-#else
-#define xen_hvc .word 0xe140ea71
-#endif
+#define XEN_IMM 0xEA1
 
 #define HYPERCALL_SIMPLE(hypercall)		\
 ENTRY(HYPERVISOR_##hypercall)			\
 	mov r12, #__HYPERVISOR_##hypercall;	\
-	xen_hvc;							\
+	__HVC(XEN_IMM);						\
 	mov pc, lr;							\
 ENDPROC(HYPERVISOR_##hypercall)
 
@@ -76,7 +72,7 @@ ENTRY(HYPERVISOR_##hypercall)			\
 	stmdb sp!, {r4}						\
 	ldr r4, [sp, #4]					\
 	mov r12, #__HYPERVISOR_##hypercall;	\
-	xen_hvc								\
+	__HVC(XEN_IMM);						\
 	ldm sp!, {r4}						\
 	mov pc, lr							\
 ENDPROC(HYPERVISOR_##hypercall)
@@ -100,7 +96,7 @@ ENTRY(privcmd_call)
 	mov r2, r3
 	ldr r3, [sp, #8]
 	ldr r4, [sp, #4]
-	xen_hvc
+	__HVC(XEN_IMM)
 	ldm sp!, {r4}
 	mov pc, lr
 ENDPROC(privcmd_call);
-- 
1.7.2.5
