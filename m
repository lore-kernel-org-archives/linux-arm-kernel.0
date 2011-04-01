From: will.deacon@arm.com (Will Deacon)
Date: Fri,  1 Apr 2011 12:24:16 +0100
Subject: [PATCH] ARM: hw_breakpoint: clear DBGVCR out of reset
Message-ID: <1301657056-30065-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DBGVCR, used for configuring vector catch debug events, is UNKNOWN
out of reset on ARMv7. When enabling monitor mode, this must be zeroed
to avoid UNPREDICTABLE behaviour.

This patch adds the zeroing code to the debug reset path.

Reported-by: Stepan Moskovchenko <stepanm@codeaurora.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/hw_breakpoint.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
index 8dbc126..87acc25 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -868,6 +868,13 @@ static void reset_ctrl_regs(void *info)
 		 */
 		asm volatile("mcr p14, 0, %0, c1, c0, 4" : : "r" (0));
 		isb();
+
+		/*
+		 * Clear any configured vector-catch events before
+		 * enabling monitor mode.
+		 */
+		asm volatile("mcr p14, 0, %0, c0, c7, 0" : : "r" (0));
+		isb();
 	}
 
 	if (enable_monitor_mode())
-- 
1.7.0.4
