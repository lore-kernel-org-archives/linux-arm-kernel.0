From: will.deacon@arm.com (Will Deacon)
Date: Wed,  5 Oct 2011 16:20:58 +0100
Subject: [PATCH] ARM: hw_breakpoint: skip v7-specific reset on v6 cores
Message-ID: <1317828058-4334-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARMv6 cores do not implement the DBGOSLAR register, so we don't need to
try and clear it on boot. Furthermore, the VCR is zeroed out of reset,
so we don't need to zero it explicitly when a CPU comes online.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---

Taken against rmk/devel-stable.

 arch/arm/kernel/hw_breakpoint.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
index 5a46225..814a52a9 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -892,6 +892,10 @@ static void reset_ctrl_regs(void *unused)
 	 * later on.
 	 */
 	switch (debug_arch) {
+	case ARM_DEBUG_ARCH_V6:
+	case ARM_DEBUG_ARCH_V6_1:
+		/* ARMv6 cores just need to reset the registers. */
+		goto reset_regs;
 	case ARM_DEBUG_ARCH_V7_ECP14:
 		/*
 		 * Ensure sticky power-down is clear (i.e. debug logic is
@@ -931,6 +935,7 @@ static void reset_ctrl_regs(void *unused)
 	asm volatile("mcr p14, 0, %0, c0, c7, 0" : : "r" (0));
 	isb();
 
+reset_regs:
 	if (enable_monitor_mode())
 		return;
 
-- 
1.7.4.1
