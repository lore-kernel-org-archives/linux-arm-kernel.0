From: panand@redhat.com (Pratyush Anand)
Date: Thu, 12 Feb 2015 21:03:39 +0530
Subject: [PATCH] ARM64:ftrace: fix ftrace_modify_graph_caller for branch
 replace
Message-ID: <b86ab19fb587cc7acc94a9b990afe0c33a073170.1423755113.git.panand@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ftrace_enable_ftrace_graph_caller and ftrace_disable_ftrace_graph_caller
should replace B(jmp) instruction and not BL(call) instruction.

patch 9f1ae7596aad71d18c3e88a3927f3f76b037b8fe did a typo and used
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
