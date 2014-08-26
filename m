From: will.deacon@arm.com (Will Deacon)
Date: Tue, 26 Aug 2014 15:13:28 +0100
Subject: [PATCH 09/11] arm64: ptrace: fix compat hardware watchpoint reporting
In-Reply-To: <1409062410-25891-1-git-send-email-will.deacon@arm.com>
References: <1409062410-25891-1-git-send-email-will.deacon@arm.com>
Message-ID: <1409062410-25891-10-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm not sure what I was on when I wrote this, but when iterating over
the hardware watchpoint array (hbp_watch_array), our index is off by
ARM_MAX_BRP, so we walk off the end of our thread_struct...

... except, a dodgy condition in the loop means that it never executes
at all (bp cannot be NULL).

This patch fixes the code so that we remove the bp check and use the
correct index for accessing the watchpoint structures.

Cc: <stable@vger.kernel.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/hw_breakpoint.h | 1 -
 arch/arm64/kernel/ptrace.c             | 3 ++-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/hw_breakpoint.h b/arch/arm64/include/asm/hw_breakpoint.h
index d064047612b1..52b484b6aa1a 100644
--- a/arch/arm64/include/asm/hw_breakpoint.h
+++ b/arch/arm64/include/asm/hw_breakpoint.h
@@ -79,7 +79,6 @@ static inline void decode_ctrl_reg(u32 reg,
  */
 #define ARM_MAX_BRP		16
 #define ARM_MAX_WRP		16
-#define ARM_MAX_HBP_SLOTS	(ARM_MAX_BRP + ARM_MAX_WRP)
 
 /* Virtual debug register bases. */
 #define AARCH64_DBG_REG_BVR	0
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 70526cfda056..2ac998878001 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -87,7 +87,8 @@ static void ptrace_hbptriggered(struct perf_event *bp,
 			break;
 		}
 	}
-	for (i = ARM_MAX_BRP; i < ARM_MAX_HBP_SLOTS && !bp; ++i) {
+
+	for (i = 0; i < ARM_MAX_WRP; ++i) {
 		if (current->thread.debug.hbp_watch[i] == bp) {
 			info.si_errno = -((i << 1) + 1);
 			break;
-- 
2.1.0.rc1
