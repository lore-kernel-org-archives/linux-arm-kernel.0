From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 23 Feb 2017 10:26:48 +0000
Subject: [PATCH v2 13/22] ARM: hyp-stub: Implement HVC_RESET_VECTORS stub
 hypercall
In-Reply-To: <20170223102657.23100-1-marc.zyngier@arm.com>
References: <20170223102657.23100-1-marc.zyngier@arm.com>
Message-ID: <20170223102657.23100-14-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let's define a new stub hypercall that resets the HYP configuration
to its default: hyp-stub vectors, and MMU disabled.

Of course, for the hyp-stub itself, this is a trivial no-op.
Hypervisors will have a bit more work to do.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/virt.h |  3 +++
 arch/arm/kernel/hyp-stub.S  | 11 ++++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/virt.h b/arch/arm/include/asm/virt.h
index 4ea16fcaf2ed..5186718aab68 100644
--- a/arch/arm/include/asm/virt.h
+++ b/arch/arm/include/asm/virt.h
@@ -101,6 +101,9 @@ extern char __hyp_text_end[];
 #define HVC_GET_VECTORS 0
 #define HVC_SET_VECTORS 1
 #define HVC_SOFT_RESTART 2
+#define HVC_RESET_VECTORS 3
+
+#define HVC_STUB_HCALL_NR 4
 
 #endif /* __ASSEMBLY__ */
 
diff --git a/arch/arm/kernel/hyp-stub.S b/arch/arm/kernel/hyp-stub.S
index 15eaa14322a7..21794d4a8f36 100644
--- a/arch/arm/kernel/hyp-stub.S
+++ b/arch/arm/kernel/hyp-stub.S
@@ -216,7 +216,10 @@ __hyp_stub_do_trap:
 	bne	1f
 	bx	r1
 
-1:	mov	r0, #-1
+1:	teq	r0, #HVC_RESET_VECTORS
+	beq	__hyp_stub_exit
+
+	mov	r0, #-1
 
 __hyp_stub_exit:
 	__ERET
@@ -264,6 +267,12 @@ ENTRY(__hyp_soft_restart)
 	ret	lr
 ENDPROC(__hyp_soft_restart)
 
+ENTRY(__hyp_reset_vectors)
+	mov	r0, #HVC_RESET_VECTORS
+	__HVC(0)
+	ret	lr
+ENDPROC(__hyp_reset_vectors)
+
 #ifndef ZIMAGE
 .align 2
 .L__boot_cpu_mode_offset:
-- 
2.11.0
