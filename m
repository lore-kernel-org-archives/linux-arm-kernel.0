From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon,  3 Apr 2017 19:37:51 +0100
Subject: [PATCH v5 18/34] ARM: hyp-stub: Define a return value for failed stub
 calls
In-Reply-To: <20170403183807.1620-1-marc.zyngier@arm.com>
References: <20170403183807.1620-1-marc.zyngier@arm.com>
Message-ID: <20170403183807.1620-19-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define a standard return value to be returned when a hyp stub
call fails.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/virt.h | 2 ++
 arch/arm/kernel/hyp-stub.S  | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/virt.h b/arch/arm/include/asm/virt.h
index 4ea16fcaf2ed..c16f70d6953f 100644
--- a/arch/arm/include/asm/virt.h
+++ b/arch/arm/include/asm/virt.h
@@ -104,4 +104,6 @@ extern char __hyp_text_end[];
 
 #endif /* __ASSEMBLY__ */
 
+#define HVC_STUB_ERR	0xbadca11
+
 #endif /* ! VIRT_H */
diff --git a/arch/arm/kernel/hyp-stub.S b/arch/arm/kernel/hyp-stub.S
index 15eaa14322a7..b20ca8815911 100644
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
2.11.0
