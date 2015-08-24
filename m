From: dianders@chromium.org (Douglas Anderson)
Date: Mon, 24 Aug 2015 16:58:59 -0700
Subject: [PATCH] ARM: probes: Don't stop the machine if we're in the debugger
Message-ID: <1440460739-19522-1-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we're in kgdb then the machine is already stopped.  Trying to stop
it again will cause us to try to sleep, which is not allowed while in
kgdb.  To avoid this problem, only stop the machine when we're not in
kgdb.

Reported-by: Aapo Vienamo <avienamo@nvidia.com>
Suggested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
 arch/arm/kernel/patch.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/patch.c b/arch/arm/kernel/patch.c
index 69bda1a..abf30ec 100644
--- a/arch/arm/kernel/patch.c
+++ b/arch/arm/kernel/patch.c
@@ -1,5 +1,6 @@
 #include <linux/kernel.h>
 #include <linux/spinlock.h>
+#include <linux/kgdb.h>
 #include <linux/kprobes.h>
 #include <linux/mm.h>
 #include <linux/stop_machine.h>
@@ -124,6 +125,9 @@ void __kprobes patch_text(void *addr, unsigned int insn)
 		.insn = insn,
 	};
 
-	stop_machine(patch_text_stop_machine, &patch, NULL);
+	/* Stop machine before patching; but not if in the debugger */
+	if (unlikely(in_dbg_master()))
+		patch_text_stop_machine(&patch);
+	else
+		stop_machine(patch_text_stop_machine, &patch, NULL);
 }
-- 
2.5.0.457.gab17608
