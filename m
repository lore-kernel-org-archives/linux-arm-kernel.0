From: marcin.slusarz@gmail.com (Marcin Slusarz)
Date: Sun, 20 Feb 2011 19:24:37 +0100
Subject: bug in arm_kprobe_decode_insn
Message-ID: <20110220182437.GA24789@joi.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

In arch/arm/kernel/kprobes-decode.c there's a function arm_kprobe_decode_insn
which does:

} else if ((insn & 0x0e000000) == 0x0c400000) {
...

This is always false, so code below is dead.

I'm not sure about what was intended here, but I think this change might be correct:

diff --git a/arch/arm/kernel/kprobes-decode.c b/arch/arm/kernel/kprobes-decode.c
index 2c1f005..8f6ed43 100644
--- a/arch/arm/kernel/kprobes-decode.c
+++ b/arch/arm/kernel/kprobes-decode.c
@@ -1437,7 +1437,7 @@ arm_kprobe_decode_insn(kprobe_opcode_t insn, struct arch_specific_insn *asi)
 
 		return space_cccc_1100_010x(insn, asi);
 
-	} else if ((insn & 0x0e000000) == 0x0c400000) {
+	} else if ((insn & 0x0e000000) == 0x0c000000) {
 
 		return space_cccc_110x(insn, asi);
 
--


I found this bug by coccinelle (http://coccinelle.lip6.fr/).
(The script is ugly, so I'm not attaching it here)


Marcin Slusarz
