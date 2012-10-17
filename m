From: will.deacon@arm.com (Will Deacon)
Date: Wed, 17 Oct 2012 16:31:38 +0100
Subject: [PATCH 4/7] ARM: hw_breakpoint: don't try to clear v6 debug registers
 during boot
In-Reply-To: <1350487901-3108-1-git-send-email-will.deacon@arm.com>
References: <1350487901-3108-1-git-send-email-will.deacon@arm.com>
Message-ID: <1350487901-3108-5-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v6 cores do not provide a way to clear the debug registers without first
enabling monitor mode, meaning that we could take spurious debug
exceptions. Instead, rely on the registers being in a sane state when we
boot as they are defined to be disabled out of reset anyway.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/hw_breakpoint.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
index e76cf1a..b6f4aec 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -912,8 +912,8 @@ static void reset_ctrl_regs(void *unused)
 	switch (debug_arch) {
 	case ARM_DEBUG_ARCH_V6:
 	case ARM_DEBUG_ARCH_V6_1:
-		/* ARMv6 cores just need to reset the registers. */
-		goto reset_regs;
+		/* ARMv6 cores clear the registers out of reset. */
+		goto out_mdbgen;
 	case ARM_DEBUG_ARCH_V7_ECP14:
 		/*
 		 * Ensure sticky power-down is clear (i.e. debug logic is
@@ -966,7 +966,6 @@ clear_vcr:
 		return;
 	}
 
-reset_regs:
 	/*
 	 * The control/value register pairs are UNKNOWN out of reset so
 	 * clear them to avoid spurious debug events.
@@ -991,6 +990,7 @@ reset_regs:
 	 * Have a crack at enabling monitor mode. We don't actually need
 	 * it yet, but reporting an error early is useful if it fails.
 	 */
+out_mdbgen:
 	if (enable_monitor_mode())
 		cpumask_or(&debug_err_mask, &debug_err_mask, cpumask_of(cpu));
 }
-- 
1.7.4.1
