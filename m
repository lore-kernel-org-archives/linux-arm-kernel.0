From: lauraa@codeaurora.org (Laura Abbott)
Date: Mon,  2 Jun 2014 13:57:37 -0700
Subject: [PATCHv2 3/4] arm64: Switch to ldr for loading the stub vectors
In-Reply-To: <1401742658-11841-1-git-send-email-lauraa@codeaurora.org>
References: <1401742658-11841-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <1401742658-11841-4-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The hyp stub vectors are currently loaded using adr. This
instruction has a +/- 1MB range for the loading address. If
the alignment for sections is changed. the address may be more
than 1MB away, resulting in reclocation errors. Switch to using
ldr for getting the address to ensure we aren't affected by the
location of the __hyp_stub_vectors.

Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
 arch/arm64/kernel/head.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 0fd5650..07574f4 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -208,7 +208,7 @@ CPU_LE(	movk	x0, #0x30d0, lsl #16	)	// Clear EE and E0E on LE systems
 	msr	vttbr_el2, xzr
 
 	/* Hypervisor stub */
-	adr	x0, __hyp_stub_vectors
+	ldr	x0, =__hyp_stub_vectors
 	msr	vbar_el2, x0
 
 	/* spsr */
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
