From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 06 Nov 2009 15:15:39 +0000
Subject: [PATCH] Do not allow the probing of the local timer
Message-ID: <20091106151539.18033.27393.stgit@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Varun Swara <Varun.Swara@arm.com>

Since this IRQ descriptor doesn't have an action registered, it is
allowed for probing via probe_irq_on/off() and it will be disabled by
the latter function. This patch sets the IRQ_NOPROBE status bit for the
local timer descriptor.

Signed-off-by: Varun Swara <Varun.Swara@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/kernel/smp_twd.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index a73a34d..ea02a7b 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -160,6 +160,7 @@ void __cpuinit twd_timer_setup(struct clock_event_device *clk)
 
 	/* Make sure our local interrupt controller has this enabled */
 	local_irq_save(flags);
+	irq_to_desc(clk->irq)->status |= IRQ_NOPROBE;
 	get_irq_chip(clk->irq)->unmask(clk->irq);
 	local_irq_restore(flags);
 
