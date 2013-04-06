From: kevin@bracey.fi (Kevin Bracey)
Date: Sat,  6 Apr 2013 15:37:04 +0300
Subject: [PATCH] ARM: smp: call platform's cpu_die in ipi_cpu_stop
In-Reply-To: <1365251824-4852-1-git-send-email-kevin@bracey.fi>
References: <1365251824-4852-1-git-send-email-kevin@bracey.fi>
Message-ID: <1365251824-4852-2-git-send-email-kevin@bracey.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When hotplugging out, both cpu_kill and cpu_die have always been called.
But when smp_send_stop was used in machine_shutdown or panic, only
cpu_kill was called.

This causes problems for co-ordination between cpu_kill and cpu_die, as
attempted by shmobile. So add cpu_die call to ipi_cpu_stop, to ensure
that cpu_kill and cpu_die calls always occur together.

Signed-off-by: Kevin Bracey <kevin@bracey.fi>
---
 arch/arm/kernel/smp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 84f4cbf..6692bba 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -572,6 +572,9 @@ static void ipi_cpu_stop(unsigned int cpu)
 	local_fiq_disable();
 	local_irq_disable();
 
+	if (smp_ops.cpu_die)
+		smp_ops.cpu_die(cpu);
+
 	while (1)
 		cpu_relax();
 }
-- 
1.8.2.445.gfcda34b
