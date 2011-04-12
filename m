From: tixy@yxit.co.uk (Tixy)
Date: Tue, 12 Apr 2011 07:45:21 +0100
Subject: [PATCH 1/6] ARM: kprobes: Reject probing of LDRB instructions which
	load PC
In-Reply-To: <1302590726-3484-1-git-send-email-tixy@yxit.co.uk>
References: <1302590726-3484-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1302590726-3484-2-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

These instructions are specified as UNPREDICTABLE.

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes-decode.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/kprobes-decode.c b/arch/arm/kernel/kprobes-decode.c
index bb239f6..7cb939a 100644
--- a/arch/arm/kernel/kprobes-decode.c
+++ b/arch/arm/kernel/kprobes-decode.c
@@ -1416,6 +1416,10 @@ space_cccc_01xx(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 	/* STRB  : cccc 01xx x1x0 xxxx xxxx xxxx xxxx xxxx */
 	/* STRBT : cccc 01x0 x110 xxxx xxxx xxxx xxxx xxxx */
 	/* STRT  : cccc 01x0 x010 xxxx xxxx xxxx xxxx xxxx */
+
+	if ((insn & 0x00500000) == 0x00500000 && is_r15(insn, 12))
+		return INSN_REJECTED;	/* LDRB into PC */
+
 	return prep_emulate_ldr_str(insn, asi);
 }
 
-- 
1.7.2.5
