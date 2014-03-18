From: sebastian.capella@linaro.org (Sebastian Capella)
Date: Tue, 18 Mar 2014 14:40:57 -0700
Subject: [PATCH v9 1/2] ARM: avoid tracers in soft_restart
In-Reply-To: <1395178858-27343-1-git-send-email-sebastian.capella@linaro.org>
References: <1395178858-27343-1-git-send-email-sebastian.capella@linaro.org>
Message-ID: <1395178858-27343-2-git-send-email-sebastian.capella@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use of tracers in local_irq_disable is causes abort loops when called
with irqs disabled using a temporary stack.  Replace local_irq_disable
with raw_local_irq_disable instead to avoid tracers.

Signed-off-by: Sebastian Capella <sebastian.capella@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Robin Holt <holt@sgi.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Konstantin Khlebnikov <k.khlebnikov@samsung.com>
Cc: Steven Capper <steve.capper@linaro.org>
Cc: Stephen Warren <swarren@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>
---
 arch/arm/kernel/process.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 92f7b15..f58b723 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -100,7 +100,7 @@ void soft_restart(unsigned long addr)
 	u64 *stack = soft_restart_stack + ARRAY_SIZE(soft_restart_stack);
 
 	/* Disable interrupts first */
-	local_irq_disable();
+	raw_local_irq_disable();
 	local_fiq_disable();
 
 	/* Disable the L2 if we're the last man standing. */
-- 
1.7.9.5
