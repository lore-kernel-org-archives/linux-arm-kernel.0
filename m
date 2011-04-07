From: tixy@yxit.co.uk (Tixy)
Date: Thu,  7 Apr 2011 13:25:15 +0100
Subject: [PATCH 1/5] ARM: kprobes: Reject probing MRS instructions which read
	SPSR
In-Reply-To: <1302179119-17573-1-git-send-email-tixy@yxit.co.uk>
References: <1302179119-17573-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1302179119-17573-2-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

We need to reject probing of instructions which read SPSR because
we can't handle this as the value in SPSR is lost when the exception
handler for the probe breakpoint first runs.

This patch also fixes the bitmask for MRS instructions decoding to
include checking bits 5-7.

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-decode.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kernel/kprobes-decode.c b/arch/arm/kernel/kprobes-decode.c
index a2240a5..c0a4807 100644
--- a/arch/arm/kernel/kprobes-decode.c
+++ b/arch/arm/kernel/kprobes-decode.c
@@ -1026,14 +1026,16 @@ space_cccc_000x(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 	/* cccc 0001 0xx0 xxxx xxxx xxxx xxxx xxx0 xxxx */
 	if ((insn & 0x0f900010) == 0x01000000) {
 
-		/* BXJ  : cccc 0001 0010 xxxx xxxx xxxx 0010 xxxx */
-		/* MSR  : cccc 0001 0x10 xxxx xxxx xxxx 0000 xxxx */
+		/* BXJ      : cccc 0001 0010 xxxx xxxx xxxx 0010 xxxx */
+		/* MSR      : cccc 0001 0x10 xxxx xxxx xxxx 0000 xxxx */
+		/* MRS spsr : cccc 0001 0100 xxxx xxxx xxxx 0000 xxxx */
 		if ((insn & 0x0ff000f0) == 0x01200020 ||
-		    (insn & 0x0fb000f0) == 0x01200000)
+		    (insn & 0x0fb000f0) == 0x01200000 ||
+		    (insn & 0x0ff000f0) == 0x01400000)
 			return INSN_REJECTED;
 
-		/* MRS : cccc 0001 0x00 xxxx xxxx xxxx 0000 xxxx */
-		if ((insn & 0x0fb00010) == 0x01000000)
+		/* MRS cpsr : cccc 0001 0000 xxxx xxxx xxxx 0000 xxxx */
+		if ((insn & 0x0ff000f0) == 0x01000000)
 			return prep_emulate_rd12(insn, asi);
 
 		/* SMLALxy : cccc 0001 0100 xxxx xxxx xxxx 1xx0 xxxx */
-- 
1.7.2.5
