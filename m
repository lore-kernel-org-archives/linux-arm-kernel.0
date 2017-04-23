From: cdall@linaro.org (Christoffer Dall)
Date: Sun, 23 Apr 2017 19:09:03 +0200
Subject: [PULL 53/79] ARM: hyp-stub: Define a return value for failed stub
 calls
In-Reply-To: <20170423170929.27334-1-cdall@linaro.org>
References: <20170423170929.27334-1-cdall@linaro.org>
Message-ID: <20170423170929.27334-54-cdall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

Define a standard return value to be returned when a hyp stub
call fails.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <cdall@linaro.org>
---
 arch/arm/include/asm/virt.h | 2 ++
 arch/arm/kernel/hyp-stub.S  | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/virt.h b/arch/arm/include/asm/virt.h
index 4ea16fc..c16f70d 100644
--- a/arch/arm/include/asm/virt.h
+++ b/arch/arm/include/asm/virt.h
@@ -104,4 +104,6 @@ extern char __hyp_text_end[];
 
 #endif /* __ASSEMBLY__ */
 
+#define HVC_STUB_ERR	0xbadca11
+
 #endif /* ! VIRT_H */
diff --git a/arch/arm/kernel/hyp-stub.S b/arch/arm/kernel/hyp-stub.S
index 15eaa14..b20ca88 100644
--- a/arch/arm/kernel/hyp-stub.S
+++ b/arch/arm/kernel/hyp-stub.S
@@ -216,7 +216,7 @@ __hyp_stub_do_trap:
 	bne	1f
 	bx	r1
 
-1:	mov	r0, #-1
+1:	ldr	r0, =HVC_STUB_ERR
 
 __hyp_stub_exit:
 	__ERET
-- 
2.9.0
