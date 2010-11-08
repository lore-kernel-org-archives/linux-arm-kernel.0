From: timo.lindfors@iki.fi (Timo Juhani Lindfors)
Date: Mon,  8 Nov 2010 11:44:12 +0200
Subject: [PATCH] ptrace: make PTRACE_SINGLESTEP work with user helpers
In-Reply-To: <20101107180523.GB2862@n2100.arm.linux.org.uk>
References: <20101107180523.GB2862@n2100.arm.linux.org.uk>
Message-ID: <1289209452-23920-1-git-send-email-timo.lindfors@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When userland jumps to the kernel provided user helper page to perform
operations like __kernel_cmpxchg trace_set_bpt() is unable to add
breakpoints. Since single stepping is implemented with breakpoints on
ARM this means that a process can effectively escape tracing
completely. This patch treats jumps to user helper page as
instructions that branch to LR since all user helpers return to LR.

Tested on S3C2410 (ARM920T, ARMv4T) with 2.6.34.

Reference: https://bugzilla.kernel.org/show_bug.cgi?id=20412
Signed-off-by: Timo Juhani Lindfors <timo.lindfors@iki.fi>
---
 arch/arm/kernel/ptrace.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index 3e97483..383a4a3 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -28,6 +28,7 @@
 
 #include "ptrace.h"
 
+#define REG_LR	14
 #define REG_PC	15
 #define REG_PSR	16
 /*
@@ -427,6 +428,9 @@ get_branch_address(struct task_struct *child, unsigned long pc, unsigned long in
 	    break;
 	}
 
+	if (alt >= CONFIG_VECTORS_BASE && alt < CONFIG_VECTORS_BASE + PAGE_SIZE)
+	    alt = get_user_reg(child, REG_LR);
+
 	return alt;
 }
 
-- 
1.7.2.3
