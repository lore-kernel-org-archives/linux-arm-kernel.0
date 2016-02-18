From: zhizhou.zh@gmail.com (Zhi-zhou Zhang)
Date: Thu, 18 Feb 2016 19:48:35 +0800
Subject: [PATCH] arm64: add architecture specified current_pt_regs
Message-ID: <1455796115-7844-1-git-send-email-zhizhou.zh@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: zhizhou <zhizhou.zh@gmail.com>

This patch is based on the implementation of arm. The generic
current_pt_regs is implemented with current->stack. It need to access
memory that would be too expensive.

Signed-off-by: zhizhou <zhizhou.zh@gmail.com>
---
 arch/arm64/include/asm/ptrace.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index e9e5467..1865d54 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -185,5 +185,9 @@ static inline int valid_user_regs(struct user_pt_regs *regs)
 
 extern unsigned long profile_pc(struct pt_regs *regs);
 
+#define current_pt_regs(void) ({ (struct pt_regs *)			\
+	((current_stack_pointer | (THREAD_SIZE - 1)) - 0xf) - 1;	\
+})
+
 #endif /* __ASSEMBLY__ */
 #endif
-- 
2.5.0
