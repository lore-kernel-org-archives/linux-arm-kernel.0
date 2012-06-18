From: monstr@monstr.eu (Michal Simek)
Date: Mon, 18 Jun 2012 13:30:07 +0200
Subject: [RFC PATCH 4/8] ARM: smp: Move cpu initialization directly to
 ipi_cpu_stop
In-Reply-To: <1340019011-18642-1-git-send-email-monstr@monstr.eu>
References: <1340019011-18642-1-git-send-email-monstr@monstr.eu>
Message-ID: <1340019011-18642-5-git-send-email-monstr@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is just preparation patch for dynamic IPI allocation.

Signed-off-by: Michal Simek <monstr@monstr.eu>
---
 arch/arm/kernel/smp.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 2c7217d..47406ee 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -468,8 +468,10 @@ static DEFINE_RAW_SPINLOCK(stop_lock);
 /*
  * ipi_cpu_stop - handle IPI from smp_send_stop()
  */
-static void ipi_cpu_stop(unsigned int cpu)
+static void ipi_cpu_stop(void)
 {
+	unsigned int cpu = smp_processor_id();
+
 	if (system_state == SYSTEM_BOOTING ||
 	    system_state == SYSTEM_RUNNING) {
 		raw_spin_lock(&stop_lock);
@@ -528,7 +530,7 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
 
 	case IPI_CPU_STOP:
 		irq_enter();
-		ipi_cpu_stop(cpu);
+		ipi_cpu_stop();
 		irq_exit();
 		break;
 
-- 
1.7.0.4
