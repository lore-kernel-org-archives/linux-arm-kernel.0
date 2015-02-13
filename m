From: panand@redhat.com (Pratyush Anand)
Date: Fri, 13 Feb 2015 09:36:21 +0530
Subject: [PATCH Resend] ARM64:ftrace: fix ftrace_modify_graph_caller for
 branch replace
Message-ID: <ce66ac4d80d4b200a9dad610d46533bb24934352.1423800192.git.panand@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ftrace_enable_ftrace_graph_caller and ftrace_disable_ftrace_graph_caller
should replace B(jmp) instruction and not BL(call) instruction.

commit 9f1ae7596aad("arm64: Correct ftrace calls to
aarch64_insn_gen_branch_imm()") did a typo and used
AARCH64_INSN_BRANCH_LINK instead of AARCH64_INSN_BRANCH_NOLINK.

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 arch/arm64/kernel/ftrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
index cf8556ae09d0..c851be795080 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -156,7 +156,7 @@ static int ftrace_modify_graph_caller(bool enable)
 
 	branch = aarch64_insn_gen_branch_imm(pc,
 					     (unsigned long)ftrace_graph_caller,
-					     AARCH64_INSN_BRANCH_LINK);
+					     AARCH64_INSN_BRANCH_NOLINK);
 	nop = aarch64_insn_gen_nop();
 
 	if (enable)
-- 
2.1.0
