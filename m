From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 14 Oct 2014 06:48:59 -0700
Subject: [PATCH v2 3/3] arm: vfp: Bounce undefined instructions in vectored
 mode
In-Reply-To: <1413294539-22069-1-git-send-email-sboyd@codeaurora.org>
References: <1413294539-22069-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1413294539-22069-4-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stepan Moskovchenko <stepanm@codeaurora.org>

Certain ARM CPU implementations (e.g. Cortex-A15) may not raise a
floating- point exception whenever deprecated short-vector VFP
instructions are executed. Instead these instructions are treated
as UNALLOCATED. Change the VFP exception handling code to emulate
short-vector instructions even if FPEXC exception bits are not
set.

Signed-off-by: Stepan Moskovchenko <stepanm@codeaurora.org>
Tested-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/vfp/vfphw.S | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/vfp/vfphw.S b/arch/arm/vfp/vfphw.S
index cda654cbf2c2..f74a8f7e5f84 100644
--- a/arch/arm/vfp/vfphw.S
+++ b/arch/arm/vfp/vfphw.S
@@ -197,6 +197,12 @@ look_for_VFP_exceptions:
 	tst	r5, #FPSCR_IXE
 	bne	process_exception
 
+	tst	r5, #FPSCR_LENGTH_MASK
+	beq	skip
+	orr	r1, r1, #FPEXC_DEX
+	b	process_exception
+skip:
+
 	@ Fall into hand on to next handler - appropriate coproc instr
 	@ not recognised by VFP
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
