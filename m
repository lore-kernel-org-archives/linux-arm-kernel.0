From: will.deacon@arm.com (Will Deacon)
Date: Wed, 17 Oct 2012 16:31:35 +0100
Subject: [PATCH 1/7] ARM: hw_breakpoint: only clear OS lock when implemented
 on v7
In-Reply-To: <1350487901-3108-1-git-send-email-will.deacon@arm.com>
References: <1350487901-3108-1-git-send-email-will.deacon@arm.com>
Message-ID: <1350487901-3108-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The OS save and restore register are optional in debug architecture v7,
so check the status register before attempting to clear the OS lock.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/hw_breakpoint.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
index 281bf33..ec16ada 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -929,6 +929,13 @@ static void reset_ctrl_regs(void *unused)
 		asm volatile("mrc p14, 0, %0, c1, c5, 4" : "=r" (dbg_power));
 		if ((dbg_power & 0x1) == 0)
 			err = -EPERM;
+
+		/*
+		 * Check whether we implement OS save and restore.
+		 */
+		asm volatile("mrc p14, 0, %0, c1, c1, 4" : "=r" (dbg_power));
+		if ((dbg_power & 0x9) == 0)
+			goto clear_vcr;
 		break;
 	case ARM_DEBUG_ARCH_V7_1:
 		/*
@@ -947,7 +954,7 @@ static void reset_ctrl_regs(void *unused)
 	}
 
 	/*
-	 * Unconditionally clear the lock by writing a value
+	 * Unconditionally clear the OS lock by writing a value
 	 * other than 0xC5ACCE55 to the access register.
 	 */
 	asm volatile("mcr p14, 0, %0, c1, c0, 4" : : "r" (0));
@@ -957,6 +964,7 @@ static void reset_ctrl_regs(void *unused)
 	 * Clear any configured vector-catch events before
 	 * enabling monitor mode.
 	 */
+clear_vcr:
 	asm volatile("mcr p14, 0, %0, c0, c7, 0" : : "r" (0));
 	isb();
 
-- 
1.7.4.1
