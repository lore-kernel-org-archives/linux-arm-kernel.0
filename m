From: cdall@linaro.org (Christoffer Dall)
Date: Wed,  7 Jun 2017 19:11:50 +0200
Subject: [PULL v2 4/6] arm64: KVM: Preserve RES1 bits in SCTLR_EL2
In-Reply-To: <20170607171152.21874-1-cdall@linaro.org>
References: <20170607171152.21874-1-cdall@linaro.org>
Message-ID: <20170607171152.21874-5-cdall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

__do_hyp_init has the rather bad habit of ignoring RES1 bits and
writing them back as zero. On a v8.0-8.2 CPU, this doesn't do anything
bad, but may end-up being pretty nasty on future revisions of the
architecture.

Let's preserve those bits so that we don't have to fix this later on.

Cc: stable at vger.kernel.org
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <cdall@linaro.org>
---
 arch/arm64/include/asm/sysreg.h |  4 ++++
 arch/arm64/kvm/hyp-init.S       | 10 ++++++----
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 15c142c..b4d13d9 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -286,6 +286,10 @@
 #define SCTLR_ELx_A	(1 << 1)
 #define SCTLR_ELx_M	1
 
+#define SCTLR_EL2_RES1	((1 << 4)  | (1 << 5)  | (1 << 11) | (1 << 16) | \
+			 (1 << 16) | (1 << 18) | (1 << 22) | (1 << 23) | \
+			 (1 << 28) | (1 << 29))
+
 #define SCTLR_ELx_FLAGS	(SCTLR_ELx_M | SCTLR_ELx_A | SCTLR_ELx_C | \
 			 SCTLR_ELx_SA | SCTLR_ELx_I)
 
diff --git a/arch/arm64/kvm/hyp-init.S b/arch/arm64/kvm/hyp-init.S
index 839425c..4072d40 100644
--- a/arch/arm64/kvm/hyp-init.S
+++ b/arch/arm64/kvm/hyp-init.S
@@ -106,10 +106,12 @@ __do_hyp_init:
 	tlbi	alle2
 	dsb	sy
 
-	mrs	x4, sctlr_el2
-	and	x4, x4, #SCTLR_ELx_EE	// preserve endianness of EL2
-	ldr	x5, =SCTLR_ELx_FLAGS
-	orr	x4, x4, x5
+	/*
+	 * Preserve all the RES1 bits while setting the default flags,
+	 * as well as the EE bit on BE.
+	 */
+	ldr	x4, =(SCTLR_EL2_RES1 | SCTLR_ELx_FLAGS)
+CPU_BE(	orr	x4, x4, #SCTLR_ELx_EE)
 	msr	sctlr_el2, x4
 	isb
 
-- 
2.9.0
