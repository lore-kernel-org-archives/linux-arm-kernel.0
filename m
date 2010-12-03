From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 03 Dec 2010 20:23:00 +0000
Subject: [PATCH 12/22] ARM: SMP: ensure smp_send_stop() waits for CPUs to stop
In-Reply-To: <20101203200746.GA10245@n2100.arm.linux.org.uk>
References: <20101203200746.GA10245@n2100.arm.linux.org.uk>
Message-ID: <E1POc9k-0007rl-5d@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wait for CPUs to indicate that they've stopped, after sending the
stop IPI, rather than blindly continuing on and hoping that they've
stopped in time.  Print a warning if we fail to stop the other CPUs.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/smp.c |   18 +++++++++++++++---
 1 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index aa1c6f5..48bccf3 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -583,10 +583,22 @@ void smp_send_reschedule(int cpu)
 
 void smp_send_stop(void)
 {
-	cpumask_t mask = cpu_online_map;
-	cpu_clear(smp_processor_id(), mask);
-	if (!cpus_empty(mask))
+	unsigned long timeout;
+
+	if (num_online_cpus() > 1) {
+		cpumask_t mask = cpu_online_map;
+		cpu_clear(smp_processor_id(), mask);
+
 		send_ipi_message(&mask, IPI_CPU_STOP);
+	}
+
+	/* Wait up to one second for other CPUs to stop */
+	timeout = USEC_PER_SEC;
+	while (num_online_cpus() > 1 && timeout--)
+		udelay(1);
+
+	if (num_online_cpus() > 1)
+		pr_warning("SMP: failed to stop secondary CPUs\n");
 }
 
 /*
-- 
1.6.2.5
