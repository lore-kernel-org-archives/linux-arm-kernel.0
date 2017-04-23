From: cdall@linaro.org (Christoffer Dall)
Date: Sun, 23 Apr 2017 19:09:18 +0200
Subject: [PULL 68/79] ARM: hyp-stub: Zero r0 on successful stub handling
In-Reply-To: <20170423170929.27334-1-cdall@linaro.org>
References: <20170423170929.27334-1-cdall@linaro.org>
Message-ID: <20170423170929.27334-69-cdall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

We now return HVC_STUB_ERR when a stub hypercall fails, but we
leave whatever was in r0 on success. Zeroing it on return seems
like a good idea.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <cdall@linaro.org>
---
 arch/arm/kernel/hyp-stub.S | 2 ++
 arch/arm/kvm/init.S        | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/kernel/hyp-stub.S b/arch/arm/kernel/hyp-stub.S
index 918c64f..d8523cc 100644
--- a/arch/arm/kernel/hyp-stub.S
+++ b/arch/arm/kernel/hyp-stub.S
@@ -215,8 +215,10 @@ __hyp_stub_do_trap:
 	beq	__hyp_stub_exit
 
 	ldr	r0, =HVC_STUB_ERR
+	__ERET
 
 __hyp_stub_exit:
+	mov	r0, #0
 	__ERET
 ENDPROC(__hyp_stub_do_trap)
 
diff --git a/arch/arm/kvm/init.S b/arch/arm/kvm/init.S
index 87bcd7a..570ed4a 100644
--- a/arch/arm/kvm/init.S
+++ b/arch/arm/kvm/init.S
@@ -155,8 +155,10 @@ reset:
 	b	exit
 
 1:	ldr	r0, =HVC_STUB_ERR
+	eret
 
 exit:
+	mov	r0, #0
 	eret
 ENDPROC(__kvm_handle_stub_hvc)
 
-- 
2.9.0
