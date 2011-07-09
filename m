From: tixy@yxit.co.uk (Tixy)
Date: Sat,  9 Jul 2011 11:57:03 +0100
Subject: [PATCH 16/51] ARM: kprobes: Use conditional breakpoints for ARM probes
In-Reply-To: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
References: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1310209058-20980-17-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

Now we no longer trigger probes on conditional instructions when the
condition is false, we can make use of conditional instructions as
breakpoints in ARM code to avoid taking unnecessary exceptions.

Note, we can't rely on not getting an exception when the condition check
fails, as that is Implementation Defined on newer ARM architectures. We
therefore still need to perform manual condition checks as well.

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/kprobes.h |    2 +-
 arch/arm/kernel/kprobes.c |   10 ++++++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/kprobes.h b/arch/arm/kernel/kprobes.h
index 5e2485c..e3803c6 100644
--- a/arch/arm/kernel/kprobes.h
+++ b/arch/arm/kernel/kprobes.h
@@ -21,7 +21,7 @@
  * These undefined instructions must be unique and
  * reserved solely for kprobes' use.
  */
-#define KPROBE_ARM_BREAKPOINT_INSTRUCTION	0xe7f001f8
+#define KPROBE_ARM_BREAKPOINT_INSTRUCTION	0x07f001f8
 #define KPROBE_THUMB16_BREAKPOINT_INSTRUCTION	0xde18
 #define KPROBE_THUMB32_BREAKPOINT_INSTRUCTION	0xf7f0a018
 
diff --git a/arch/arm/kernel/kprobes.c b/arch/arm/kernel/kprobes.c
index 7a9be60..9104b03 100644
--- a/arch/arm/kernel/kprobes.c
+++ b/arch/arm/kernel/kprobes.c
@@ -138,7 +138,13 @@ void __kprobes arch_arm_kprobe(struct kprobe *p)
 
 void __kprobes arch_arm_kprobe(struct kprobe *p)
 {
-	*p->addr = KPROBE_ARM_BREAKPOINT_INSTRUCTION;
+	kprobe_opcode_t insn = p->opcode;
+	kprobe_opcode_t brkp = KPROBE_ARM_BREAKPOINT_INSTRUCTION;
+	if (insn >= 0xe0000000)
+		brkp |= 0xe0000000;  /* Unconditional instruction */
+	else
+		brkp |= insn & 0xf0000000;  /* Copy condition from insn */
+	*p->addr = brkp;
 	flush_insns(p->addr, sizeof(p->addr[0]));
 }
 
@@ -625,7 +631,7 @@ static struct undef_hook kprobes_thumb32_break_hook = {
 #else  /* !CONFIG_THUMB2_KERNEL */
 
 static struct undef_hook kprobes_arm_break_hook = {
-	.instr_mask	= 0xffffffff,
+	.instr_mask	= 0x0fffffff,
 	.instr_val	= KPROBE_ARM_BREAKPOINT_INSTRUCTION,
 	.cpsr_mask	= MODE_MASK,
 	.cpsr_val	= SVC_MODE,
-- 
1.7.2.5
