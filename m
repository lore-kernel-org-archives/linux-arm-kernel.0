From: mhiramat@kernel.org (Masami Hiramatsu)
Date: Tue,  5 Jun 2018 00:56:44 +0900
Subject: [RFC PATCH -tip v5 17/27] arm64: kprobes: Don't call the
 ->break_handler() in arm kprobes code
In-Reply-To: <152812730943.10068.5166429445118734697.stgit@devbox>
References: <152812730943.10068.5166429445118734697.stgit@devbox>
Message-ID: <152812780433.10068.4191004481518140821.stgit@devbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Don't call the ->break_handler() from the arm kprobes code,
because it was only used by jprobes which got removed.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm64/kernel/probes/kprobes.c |    8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index 3ca2351109a6..076c3c0775a6 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -408,14 +408,6 @@ static void __kprobes kprobe_handler(struct pt_regs *regs)
 				return;
 			}
 		}
-	} else if ((le32_to_cpu(*(kprobe_opcode_t *) addr) ==
-	    BRK64_OPCODE_KPROBES) && cur_kprobe) {
-		/* We probably hit a jprobe.  Call its break handler. */
-		if (cur_kprobe->break_handler  &&
-		     cur_kprobe->break_handler(cur_kprobe, regs)) {
-			setup_singlestep(cur_kprobe, regs, kcb, 0);
-			return;
-		}
 	}
 	/*
 	 * The breakpoint instruction was removed right
