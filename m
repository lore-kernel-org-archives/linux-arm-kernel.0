From: lauraa@codeaurora.org (Laura Abbott)
Date: Mon, 27 Oct 2014 13:12:29 -0700
Subject: [PATCHv4 4/7] arm64: Move some head.text functions to executable
 section
In-Reply-To: <1414440752-9411-1-git-send-email-lauraa@codeaurora.org>
References: <1414440752-9411-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <1414440752-9411-5-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The head.text section is intended to be run at early bootup
before any of the regular kernel mappings have been setup.
Parts of head.text may be freed back into the buddy allocator
due to TEXT_OFFSET so for security requirements this memory
must not be executable. The suspend/resume/hotplug code path
requires some of these head.S functions to run however which
means they need to be executable. Support these conflicting
requirements by moving the few head.text functions that need
to be executable to the text section which has the appropriate
page table permissions.

Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
v4: New apprach based on discussions with Mark
---
 arch/arm64/kernel/head.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 10f5cc0..dc362da 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -432,12 +432,14 @@ ENTRY(secondary_startup)
 	b	__enable_mmu
 ENDPROC(secondary_startup)
 
+	.pushsection	.text, "ax"
 ENTRY(__secondary_switched)
 	ldr	x0, [x21]			// get secondary_data.stack
 	mov	sp, x0
 	mov	x29, #0
 	b	secondary_start_kernel
 ENDPROC(__secondary_switched)
+	.popsection
 #endif	/* CONFIG_SMP */
 
 /*
@@ -471,11 +473,13 @@ ENDPROC(__enable_mmu)
  * table to map the entire function.
  */
 	.align	4
+	.pushsection	.text, "ax"
 __turn_mmu_on:
 	msr	sctlr_el1, x0
 	isb
 	br	x27
 ENDPROC(__turn_mmu_on)
+	.popsection
 
 /*
  * Calculate the start of physical memory.
-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
