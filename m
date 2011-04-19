From: tixy@yxit.co.uk (Tixy)
Date: Tue, 19 Apr 2011 10:52:19 +0100
Subject: [PATCH 4/5] ARM: kprobes: Add emulation of hint instructions like NOP
	and WFI
In-Reply-To: <1303206740-10101-1-git-send-email-tixy@yxit.co.uk>
References: <1303206740-10101-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1303206740-10101-5-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

Being able to probe NOP instructions is useful for hard-coding probeable
locations and is used by the kprobes test code.

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-decode.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/kprobes-decode.c b/arch/arm/kernel/kprobes-decode.c
index 25d4a04..c573b85 100644
--- a/arch/arm/kernel/kprobes-decode.c
+++ b/arch/arm/kernel/kprobes-decode.c
@@ -1225,6 +1225,30 @@ space_cccc_001x(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 	if ((insn & 0x0fb00000) == 0x03000000)
 		return prep_emulate_rd12_modify(insn, asi);
 
+	/* hints : cccc 0011 0010 0000 xxxx xxxx xxxx xxxx */
+	if ((insn & 0x0fff0000) == 0x03200000) {
+		unsigned op2 = insn & 0x000000ff;
+		if (op2 == 0x01 || op2 == 0x04) {
+			/* YIELD : cccc 0011 0010 0000 xxxx xxxx 0000 0001 */
+			/* SEV   : cccc 0011 0010 0000 xxxx xxxx 0000 0100 */
+			asi->insn[0] = insn;
+			asi->insn_handler = emulate_none;
+			return INSN_GOOD;
+		} else if (op2 <= 0x03) {
+			/* NOP   : cccc 0011 0010 0000 xxxx xxxx 0000 0000 */
+			/* WFE   : cccc 0011 0010 0000 xxxx xxxx 0000 0010 */
+			/* WFI   : cccc 0011 0010 0000 xxxx xxxx 0000 0011 */
+			/*
+			 * We make WFE and WFI true NOPs to avoid stalls due
+			 * to missing events whilst processing the probe.
+			 */
+			asi->insn_handler = emulate_nop;
+			return INSN_GOOD_NO_SLOT;
+		}
+		/* For DBG and unallocated hints it's safest to reject them */
+		return INSN_REJECTED;
+	}
+
 	/*
 	 * MSR   : cccc 0011 0x10 xxxx xxxx xxxx xxxx xxxx
 	 * ALU op with S bit and Rd == 15 :
-- 
1.7.2.5
