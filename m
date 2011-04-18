From: tixy@yxit.co.uk (Tixy)
Date: Mon, 18 Apr 2011 08:53:58 +0100
Subject: [PATCH 5/5] ARM: kprobes: Remove redundant code in space_1111
In-Reply-To: <1303113238-23920-1-git-send-email-tixy@yxit.co.uk>
References: <1303113238-23920-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1303113238-23920-6-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

The tests to explicitly reject probing CPS, RFE and SRS instructions
are redundant as the default case is now to reject undecoded patterns.

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-decode.c |   14 +++++---------
 1 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/arm/kernel/kprobes-decode.c b/arch/arm/kernel/kprobes-decode.c
index f36dba2..4c8eda2 100644
--- a/arch/arm/kernel/kprobes-decode.c
+++ b/arch/arm/kernel/kprobes-decode.c
@@ -927,14 +927,6 @@ prep_emulate_rdhi16rdlo12rs8rm0_wflags(kprobe_opcode_t insn,
 static enum kprobe_insn __kprobes
 space_1111(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 {
-	/* CPS mmod == 1 : 1111 0001 0000 xx10 xxxx xxxx xx0x xxxx */
-	/* RFE           : 1111 100x x0x1 xxxx xxxx 1010 xxxx xxxx */
-	/* SRS           : 1111 100x x1x0 1101 xxxx 0101 xxxx xxxx */
-	if ((insn & 0xfff30020) == 0xf1020000 ||
-	    (insn & 0xfe500f00) == 0xf8100a00 ||
-	    (insn & 0xfe5f0f00) == 0xf84d0500)
-		return INSN_REJECTED;
-
 	/* memory hint : 1111 0100 x001 xxxx xxxx xxxx xxxx xxxx : */
 	/* PLDI        : 1111 0100 x101 xxxx xxxx xxxx xxxx xxxx : */
 	/* PLDW        : 1111 0101 x001 xxxx xxxx xxxx xxxx xxxx : */
@@ -950,7 +942,11 @@ space_1111(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 		return INSN_GOOD_NO_SLOT;
 	}
 
-	/* SETEND : 1111 0001 0000 0001 xxxx xxxx 0000 xxxx */
+	/* CPS   : 1111 0001 0000 xxx0 xxxx xxxx xx0x xxxx */
+	/* SETEND: 1111 0001 0000 0001 xxxx xxxx 0000 xxxx */
+
+	/* SRS   : 1111 100x x1x0 xxxx xxxx xxxx xxxx xxxx */
+	/* RFE   : 1111 100x x0x1 xxxx xxxx xxxx xxxx xxxx */
 
 	/* Coprocessor instructions... */
 	/* MCRR2 : 1111 1100 0100 xxxx xxxx xxxx xxxx xxxx : (Rd != Rn) */
-- 
1.7.2.5
