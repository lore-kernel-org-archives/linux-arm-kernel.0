From: tixy@yxit.co.uk (Tixy)
Date: Mon, 18 Apr 2011 08:53:56 +0100
Subject: [PATCH 3/5] ARM: kprobes: Reject probing of SETEND instructions
In-Reply-To: <1303113238-23920-1-git-send-email-tixy@yxit.co.uk>
References: <1303113238-23920-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1303113238-23920-4-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

The emulation of SETEND was broken as it changed the endianess for
the running kprobes handling code. Rather than adding a new simulation
routine to fix this we'll just reject probing of SETEND as these should
be very rare in the kernel.

Note, the function emulate_none is now unused but it is left in the
source code as future patches will use it.

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-decode.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kernel/kprobes-decode.c b/arch/arm/kernel/kprobes-decode.c
index 35dd112..c68b26d 100644
--- a/arch/arm/kernel/kprobes-decode.c
+++ b/arch/arm/kernel/kprobes-decode.c
@@ -956,11 +956,6 @@ space_1111(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 	}
 
 	/* SETEND : 1111 0001 0000 0001 xxxx xxxx 0000 xxxx */
-	if ((insn & 0xffff00f0) == 0xf1010000) {
-		asi->insn[0] = insn;
-		asi->insn_handler = emulate_none;
-		return INSN_GOOD;
-	}
 
 	/* Coprocessor instructions... */
 	/* MCRR2 : 1111 1100 0100 xxxx xxxx xxxx xxxx xxxx : (Rd != Rn) */
-- 
1.7.2.5
