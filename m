From: orca.chen@gmail.com (Min-Hua Chen)
Date: Tue, 23 Dec 2014 23:15:10 +0800
Subject: [PATCH] arm64: setup return path for el1_undef
Message-ID: <CAHkaATRdNgcZnAvgKFRmiMEhLOPxFEPpjTu+XNkDk9DxG+4Fpg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Setup return path for el1_undef since el1_undef may
be handled by handlers.

asmlinkage void __exception do_undefinstr(struct pt_regs *regs)
{
    siginfo_t info;
    void __user *pc = (void __user *)instruction_pointer(regs);

    /* check for AArch32 breakpoint instructions */
    if (!aarch32_break_handler(regs))
        return;

    if (call_undef_hook(regs) == 0)
        return;

    ...
}

Signed-off-by: Min-Hua Chen <orca.chen@gmail.com>
---
 arch/arm64/kernel/entry.S |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index fd4fa37..86ebec5 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -313,7 +313,8 @@ el1_undef:
      */
     enable_dbg
     mov    x0, sp
-    b    do_undefinstr
+    bl    do_undefinstr
+    kernel_exit 1
 el1_dbg:
     /*
      * Debug exception handling
-- 
1.7.10.4
