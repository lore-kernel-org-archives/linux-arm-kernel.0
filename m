From: mhiramat@kernel.org (Masami Hiramatsu)
Date: Wed, 20 Jun 2018 01:11:53 +0900
Subject: [PATCH -tip v6 16/27] ARM: kprobes: Don't call the ->break_handler()
 in arm kprobes code
In-Reply-To: <152942424698.15209.15245996287444292393.stgit@devbox>
References: <152942424698.15209.15245996287444292393.stgit@devbox>
Message-ID: <152942471328.15209.10625693210204476080.stgit@devbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Don't call the ->break_handler() from the arm kprobes code,
because it was only used by jprobes which got removed.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/probes/kprobes/core.c |   11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/arm/probes/kprobes/core.c b/arch/arm/probes/kprobes/core.c
index 23562111c511..3192350f389d 100644
--- a/arch/arm/probes/kprobes/core.c
+++ b/arch/arm/probes/kprobes/core.c
@@ -315,17 +315,6 @@ void __kprobes kprobe_handler(struct pt_regs *regs)
 				reset_current_kprobe();
 			}
 		}
-	} else if (cur) {
-		/* We probably hit a jprobe.  Call its break handler. */
-		if (cur->break_handler && cur->break_handler(cur, regs)) {
-			kcb->kprobe_status = KPROBE_HIT_SS;
-			singlestep(cur, regs, kcb);
-			if (cur->post_handler) {
-				kcb->kprobe_status = KPROBE_HIT_SSDONE;
-				cur->post_handler(cur, regs, 0);
-			}
-		}
-		reset_current_kprobe();
 	} else {
 		/*
 		 * The probe was removed and a race is in progress.
