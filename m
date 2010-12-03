From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 03 Dec 2010 20:26:03 +0000
Subject: [PATCH 21/22] ARM: CPU hotplug: ensure correct ordering of unplug
In-Reply-To: <20101203200746.GA10245@n2100.arm.linux.org.uk>
References: <20101203200746.GA10245@n2100.arm.linux.org.uk>
Message-ID: <E1POcCh-0007sL-E6@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Don't call idle_task_exit() with interrupts disabled, and ensure
that we have a memory barrier after interrupts are disabled but
before signalling that this CPU has shut down.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/smp.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index bebe3bd..8cc9c03 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -269,9 +269,11 @@ void __ref cpu_die(void)
 {
 	unsigned int cpu = smp_processor_id();
 
-	local_irq_disable();
 	idle_task_exit();
 
+	local_irq_disable();
+	mb();
+
 	/* Tell __cpu_die() that this CPU is now safe to dispose of */
 	complete(&cpu_died);
 
-- 
1.6.2.5
