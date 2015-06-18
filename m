From: panand@redhat.com (Pratyush Anand)
Date: Thu, 18 Jun 2015 09:28:57 +0530
Subject: [RFC PATCH V2 10/10] arm64: uprobes: check conditions before
 simulating instructions
In-Reply-To: <cover.1434598237.git.panand@redhat.com>
References: <cover.1434598237.git.panand@redhat.com>
Message-ID: <350cf38eb8b9008d14a51ef7e0f8099644c8b97f.1434598237.git.panand@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Steve Capper <steve.capper@linaro.org>

Currently uprobes just simulates any instruction that it can't in
place execute. This can lead to unpredictable behaviour if the
execution condition fails and the instruction wouldn't otherwise
have been executed.

This patch adds the condition check

Signed-off-by: Steve Capper <steve.capper@linaro.org>
---
 arch/arm64/kernel/uprobes.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/uprobes.c b/arch/arm64/kernel/uprobes.c
index 2cc9114deac2..a6d12b81e9ae 100644
--- a/arch/arm64/kernel/uprobes.c
+++ b/arch/arm64/kernel/uprobes.c
@@ -119,15 +119,22 @@ bool arch_uprobe_skip_sstep(struct arch_uprobe *auprobe, struct pt_regs *regs)
 {
 	kprobe_opcode_t insn;
 	unsigned long addr;
+	struct arch_specific_insn *ainsn;
 
 	if (!auprobe->simulate)
 		return false;
 
 	insn = *(kprobe_opcode_t *)(&auprobe->insn[0]);
 	addr = instruction_pointer(regs);
+	ainsn = &auprobe->ainsn;
+
+	if (ainsn->handler) {
+		if (!ainsn->check_condn || ainsn->check_condn(insn, ainsn, regs))
+			ainsn->handler(insn, addr, regs);
+		else
+			instruction_pointer_set(regs, instruction_pointer(regs) + 4);
+	}
 
-	if (auprobe->ainsn.handler)
-		auprobe->ainsn.handler(insn, addr, regs);
 
 	return true;
 }
-- 
2.1.0
