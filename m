From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 17 Jan 2017 16:10:56 +0000
Subject: [PATCH 1/3] arm64: head.S: avoid open-coded adr_l
In-Reply-To: <1484669458-31713-1-git-send-email-mark.rutland@arm.com>
References: <1484669458-31713-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1484669458-31713-2-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some places in the kernel open-code sequences using ADRP for a symbol
another instruction using a :lo12: relocation for that same symbol.
These sequences are easy to get wrong, and more painful to read than is
necessary. For these reasons, it is preferable to use the
{adr,ldr,str}_l macros for these cases.

This patch makes use of adr_l these in head.S, removing an open-coded
sequence using adrp.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/head.S | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 4b1abac..9eaeceb 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -613,8 +613,7 @@ CPU_LE(	movk	x0, #0x30d0, lsl #16	)	// Clear EE and E0E on LE systems
 
 install_el2_stub:
 	/* Hypervisor stub */
-	adrp	x0, __hyp_stub_vectors
-	add	x0, x0, #:lo12:__hyp_stub_vectors
+	adr_l	x0, __hyp_stub_vectors
 	msr	vbar_el2, x0
 
 	/* spsr */
-- 
1.9.1
