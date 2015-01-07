From: leo.yan@linaro.org (Leo Yan)
Date: Wed,  7 Jan 2015 13:52:10 +0800
Subject: [PATCH] arm64: mm: support instruction SETEND
Message-ID: <1420609930-1689-1-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently kernel has set the bit SCTLR_EL1.SED, so the SETEND
instruction will be treated as UNALLOCATED; this error can be
reproduced when ARMv8 cpu runs with EL1/aarch64 and EL0/aarch32
mode, finally kernel will trap the exception if the userspace
libs use SETEND instruction.

So this patch clears bit SCTLR_EL1.SED to support SETEND instruction.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Xiaolong Ye <yexl@marvell.com>
---
 arch/arm64/mm/proc.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 4e778b1..66a7363 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -249,9 +249,9 @@ ENDPROC(__cpu_setup)
 	 *       CE0      XWHW CZ     ME TEEA S
 	 * .... .IEE .... NEAI TE.I ..AD DEN0 ACAM
 	 * 0011 0... 1101 ..0. ..0. 10.. .... .... < hardware reserved
-	 * .... .1.. .... 01.1 11.1 ..01 0001 1101 < software settings
+	 * .... .1.. .... 01.1 11.1 ..00 0001 1101 < software settings
 	 */
 	.type	crval, #object
 crval:
-	.word	0x000802e2			// clear
-	.word	0x0405d11d			// set
+	.word	0x000803e2			// clear
+	.word	0x0405d01d			// set
-- 
1.9.1
