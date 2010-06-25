From: byang1@marvell.com (Bin Yang)
Date: Fri, 25 Jun 2010 00:35:41 -0700
Subject: kprobe bug. 
In-Reply-To: <20100623195456.GC25070@n2100.arm.linux.org.uk>
Message-ID: <AAD1C6EB06EE3649B35B7E026785068D14FCB58138@SC-VEXCH2.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

	Thanks in advance for your kind to review my question. 
	I met a kprobe bug while I used it to debug my driver. 
	Here is the scenario:
	I add a probe at function xxx(). And the assembly code of xxx() is as following,
=====================
	c035ee48 <xxx >:
c035ee48:       e59f3008        ldr     r3, [pc, #8]    ; c035ee58              <xxx+0x10>
c035ee4c:       e3a02001        mov     r2, #1  ; 0x1
c035ee50:       e5032fff        str     r2, [r3, #-4095]
c035ee54:       e12fff1e        bx      lr
c035ee58:       fe03dfff        .word   0xfe03dfff 
=====================
	The ldr emulate always load e12fff1e to r3 register. 
	After debugging, I found the pc register should be 8 after current instruction. So we should set pc to pc+8 before instruction emulation and set it back to the next instruction after singe step.
	Here is my patch: 
=======================
diff --git a/arch/arm/kernel/kprobes.c b/arch/arm/kernel/kprobes.c
index 60c62c3..6e2567e 100644
--- a/arch/arm/kernel/kprobes.c
+++ b/arch/arm/kernel/kprobes.c
@@ -132,8 +132,9 @@ static void __kprobes set_current_kprobe(struct kprobe *p)
 static void __kprobes singlestep(struct kprobe *p, struct pt_regs *regs,
 				 struct kprobe_ctlblk *kcb)
 {
-	regs->ARM_pc += 4;
+	regs->ARM_pc += 8;
 	p->ainsn.insn_handler(p, regs);
+	regs->ARM_pc -= 4;
 }
 
 /*
========================

	 

Regards,
Bin
