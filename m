From: zhangwm@marvell.com (Neil Zhang)
Date: Thu, 19 Jun 2014 18:54:56 +0800
Subject: [PATCH] arm64: add the ability to hook the fault code
Message-ID: <1403175296-25181-1-git-send-email-zhangwm@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the ability to hook the fault code for future use.

Signed-off-by: Neil Zhang <zhangwm@marvell.com>
---
 arch/arm64/include/asm/system_misc.h |    4 ++++
 arch/arm64/mm/fault.c                |   12 ++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm64/include/asm/system_misc.h b/arch/arm64/include/asm/system_misc.h
index 7a18fab..a8c19dd 100644
--- a/arch/arm64/include/asm/system_misc.h
+++ b/arch/arm64/include/asm/system_misc.h
@@ -37,6 +37,10 @@ void hook_debug_fault_code(int nr, int (*fn)(unsigned long, unsigned int,
 					     struct pt_regs *),
 			   int sig, int code, const char *name);
 
+void hook_fault_code(int nr,
+		int (*fn)(unsigned long, unsigned int, struct pt_regs *),
+		int sig, int code, const char *name);
+
 struct mm_struct;
 extern void show_pte(struct mm_struct *mm, unsigned long addr);
 extern void __show_regs(struct pt_regs *);
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index bcc965e..7902fb6 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -447,6 +447,18 @@ static const char *fault_name(unsigned int esr)
 	return inf->name;
 }
 
+void __init hook_fault_code(int nr,
+		int (*fn)(unsigned long, unsigned int, struct pt_regs *),
+		int sig, int code, const char *name)
+{
+	BUG_ON(nr < 0 || nr >= ARRAY_SIZE(fault_info));
+
+	fault_info[nr].fn   = fn;
+	fault_info[nr].sig  = sig;
+	fault_info[nr].code = code;
+	fault_info[nr].name = name;
+}
+
 /*
  * Dispatch a data abort to the relevant handler.
  */
-- 
1.7.9.5
