From: cdall@linaro.org (Christoffer Dall)
Date: Sun, 23 Apr 2017 19:09:28 +0200
Subject: [PULL 78/79] ARM: hyp-stub: Fix Thumb-2 compilation
In-Reply-To: <20170423170929.27334-1-cdall@linaro.org>
References: <20170423170929.27334-1-cdall@linaro.org>
Message-ID: <20170423170929.27334-79-cdall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

The assembler defaults to emiting the short form of ADR, leading
to an out-of-range immediate. Using the wide version solves this
issue.

Fixes: bc845e4fbbbb ("ARM: KVM: Implement HVC_RESET_VECTORS stub hypercall in the init code")
Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <cdall@linaro.org>
---
 arch/arm/kernel/hyp-stub.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/hyp-stub.S b/arch/arm/kernel/hyp-stub.S
index d8523cc..ec7e737 100644
--- a/arch/arm/kernel/hyp-stub.S
+++ b/arch/arm/kernel/hyp-stub.S
@@ -125,7 +125,7 @@ ENTRY(__hyp_stub_install_secondary)
  * (see safe_svcmode_maskall).
  */
 	@ Now install the hypervisor stub:
-	adr	r7, __hyp_stub_vectors
+	W(adr)	r7, __hyp_stub_vectors
 	mcr	p15, 4, r7, c12, c0, 0	@ set hypervisor vector base (HVBAR)
 
 	@ Disable all traps, so we don't get any nasty surprise
-- 
2.9.0
