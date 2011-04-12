From: tixy@yxit.co.uk (Tixy)
Date: Tue, 12 Apr 2011 07:45:22 +0100
Subject: [PATCH 2/6] ARM: kprobes: Add emulation of RBIT instruction
In-Reply-To: <1302590726-3484-1-git-send-email-tixy@yxit.co.uk>
References: <1302590726-3484-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1302590726-3484-3-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

The v6T2 RBIT instruction was accidentally being emulated correctly,
this patch adds correct decoding for the instruction.

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-decode.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/kprobes-decode.c b/arch/arm/kernel/kprobes-decode.c
index 7cb939a..f6367bf 100644
--- a/arch/arm/kernel/kprobes-decode.c
+++ b/arch/arm/kernel/kprobes-decode.c
@@ -1320,9 +1320,10 @@ space_cccc_0110__1(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 
 	/* REV    : cccc 0110 1011 xxxx xxxx xxxx 0011 xxxx */
 	/* REV16  : cccc 0110 1011 xxxx xxxx xxxx 1011 xxxx */
+	/* RBIT   : cccc 0110 1111 xxxx xxxx xxxx 0011 xxxx */
 	/* REVSH  : cccc 0110 1111 xxxx xxxx xxxx 1011 xxxx */
 	if ((insn & 0x0ff00070) == 0x06b00030 ||
-	    (insn & 0x0ff000f0) == 0x06f000b0)
+	    (insn & 0x0ff00070) == 0x06f00030)
 		return prep_emulate_rd12rm0(insn, asi);
 
 	/* SADD16    : cccc 0110 0001 xxxx xxxx xxxx 0001 xxxx :GE */
-- 
1.7.2.5
