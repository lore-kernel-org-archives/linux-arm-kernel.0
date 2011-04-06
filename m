From: tixy@yxit.co.uk (Tixy)
Date: Wed,  6 Apr 2011 11:17:12 +0100
Subject: [PATCH v2 4/4] ARM: kprobes: Fix emulation of Data-processing
	(immediate) instructions
In-Reply-To: <1302085032-30415-1-git-send-email-tixy@yxit.co.uk>
References: <1302085032-30415-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1302085032-30415-5-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

Emulation of instructions like "ADD rd, rn, #<const>" would result in a
corrupted value for rd.

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-decode.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/kprobes-decode.c b/arch/arm/kernel/kprobes-decode.c
index 98d2f87..a2240a5 100644
--- a/arch/arm/kernel/kprobes-decode.c
+++ b/arch/arm/kernel/kprobes-decode.c
@@ -1207,7 +1207,7 @@ space_cccc_001x(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 	 * *S (bit 20) updates condition codes
 	 * ADC/SBC/RSC reads the C flag
 	 */
-	insn &= 0xffff0fff;	/* Rd = r0 */
+	insn &= 0xfff00fff;	/* Rn = r0 and Rd = r0 */
 	asi->insn[0] = insn;
 
 	if ((insn & 0x0f900000) == 0x03100000) {
-- 
1.7.2.5
