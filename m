From: cdall@linaro.org (Christoffer Dall)
Date: Sun, 23 Apr 2017 19:09:04 +0200
Subject: [PULL 54/79] ARM: hyp-stub: Implement HVC_RESET_VECTORS stub hypercall
In-Reply-To: <20170423170929.27334-1-cdall@linaro.org>
References: <20170423170929.27334-1-cdall@linaro.org>
Message-ID: <20170423170929.27334-55-cdall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

Let's define a new stub hypercall that resets the HYP configuration
to its default: hyp-stub vectors, and MMU disabled.

Of course, for the hyp-stub itself, this is a trivial no-op.
Hypervisors will have a bit more work to do.

Tested-by: Keerthy <j-keerthy@ti.com>
Acked-by: Russell King <rmk+kernel@armlinux.org.uk>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <cdall@linaro.org>
---
 arch/arm/include/asm/virt.h |  3 +++
 arch/arm/kernel/hyp-stub.S  | 11 ++++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/virt.h b/arch/arm/include/asm/virt.h
index c16f70d..c5a2757 100644
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
index b20ca88..e637854 100644
--- a/arch/arm/kernel/hyp-stub.S
+++ b/arch/arm/kernel/hyp-stub.S
@@ -216,7 +216,10 @@ __hyp_stub_do_trap:
 	bne	1f
 	bx	r1
 
-1:	ldr	r0, =HVC_STUB_ERR
+1:	teq	r0, #HVC_RESET_VECTORS
+	beq	__hyp_stub_exit
+
+	ldr	r0, =HVC_STUB_ERR
 
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
2.9.0
