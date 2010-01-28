From: dan@debian.org (Daniel Jacobowitz)
Date: Thu, 28 Jan 2010 15:21:24 -0500
Subject: 32-bit Thumb-2 breakpoints
In-Reply-To: <20100112142523.GA28804@caradoc.them.org>
References: <20100111215816.GA1068@caradoc.them.org>
	<1263292498.29654.26.camel@pc1117.cambridge.arm.com>
	<20100112142523.GA28804@caradoc.them.org>
Message-ID: <20100128202124.GA29606@caradoc.them.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 12, 2010 at 09:25:23AM -0500, Daniel Jacobowitz wrote:
> I'll plan on 0xf7f0 0xa000.

Like so.  Shall I send this to the patch system?

From: Daniel Jacobowitz <dan@codesourcery.com>

Recognize 0xf7f0 0xa000 as a 32-bit breakpoint instruction for
Thumb-2.

Signed-off-by: Daniel Jacobowitz <dan@codesourcery.com>

diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index a2ea385..bd56673 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -499,10 +499,41 @@ static struct undef_hook thumb_break_hook = {
 	.fn		= break_trap,
 };
 
+static int thumb2_break_trap(struct pt_regs *regs, unsigned int instr)
+{
+	unsigned int instr2;
+	void __user *pc;
+
+	/* Check the second half of the instruction.  */
+	pc = (void __user *)(instruction_pointer(regs) + 2);
+
+	if (processor_mode(regs) == SVC_MODE) {
+		instr2 = *(u16 *) pc;
+	} else {
+		get_user(instr2, (u16 __user *)pc);
+	}
+
+	if (instr2 == 0xa000) {
+		ptrace_break(current, regs);
+		return 0;
+	} else {
+		return 1;
+	}
+}
+
+static struct undef_hook thumb2_break_hook = {
+	.instr_mask	= 0xffff,
+	.instr_val	= 0xf7f0,
+	.cpsr_mask	= PSR_T_BIT,
+	.cpsr_val	= PSR_T_BIT,
+	.fn		= thumb2_break_trap,
+};
+
 static int __init ptrace_break_init(void)
 {
 	register_undef_hook(&arm_break_hook);
 	register_undef_hook(&thumb_break_hook);
+	register_undef_hook(&thumb2_break_hook);
 	return 0;
 }
 


-- 
Daniel Jacobowitz
CodeSourcery
