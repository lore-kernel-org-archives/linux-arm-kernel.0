From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 16 Mar 2010 18:42:29 +0530
Subject: [PATCH] ARM: Fix "BUG: scheduling while atomic: swapper/0/0x00000002"
Message-ID: <1268745149-8685-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the preempt leak in the cpuidle path invoked from
cpu-hotplug
log:
BUG: scheduling while atomic: swapper/0/0x00000002
<d>Modules linked in:
Backtrace:
[<c0024f90>] (dump_backtrace+0x0/0x110) from [<c01762c4>] (dump_stack+0x18/0x1c)
 r7:c0218cc4 r6:c0341f00 r5:c7836000 r4:00000000
[<c01762ac>] (dump_stack+0x0/0x1c) from [<c003d94c>] (__schedule_bug+0x60/0x70)
[<c003d8ec>] (__schedule_bug+0x0/0x70) from [<c0176914>] (schedule+0x98/0x7b8)
 r5:c7836000 r4:c7836000
[<c017687c>] (schedule+0x0/0x7b8) from [<c00228c4>] (cpu_idle+0xb4/0xd4)
# [<c0022810>] (cpu_idle+0x0/0xd4) from [<c01744e8>] (secondary_start_kernel+0xe0/0xf0)
 r5:c7836000 r4:c020a220
[<c0174408>] (secondary_start_kernel+0x0/0xf0) from [<c0031150>] (set_cpu_power_state+0x40/0x44)
 r7:c0218cc4 r6:00000001 r5:00000001 r4:c7836000
Backtrace aborted due to bad frame pointer <c7837fbc>

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/smp.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 57162af..2a42d22 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -226,6 +226,7 @@ void __ref cpu_die(void)
 	 * actual CPU shutdown procedure is at least platform (if not
 	 * CPU) specific
 	 */
+	preempt_enable_no_resched();
 	platform_cpu_die(cpu);
 
 	/*
-- 
1.6.0.4
