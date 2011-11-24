From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 24 Nov 2011 17:05:19 +0100
Subject: [PATCH] ARM : fix /proc/interrupts per online cpu
Message-ID: <1322150719-28243-1-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The loop should look at the online cpus instead of the present cpus
in order to hide the offline cpus in procfs like it is done on the
other architectures.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/kernel/smp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index ef5640b..050f826 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -444,7 +444,7 @@ void show_ipi_list(struct seq_file *p, int prec)
 	for (i = 0; i < NR_IPI; i++) {
 		seq_printf(p, "%*s%u: ", prec - 1, "IPI", i);
 
-		for_each_present_cpu(cpu)
+		for_each_online_cpu(cpu)
 			seq_printf(p, "%10u ",
 				   __get_irq_stat(cpu, ipi_irqs[i]));
 
-- 
1.7.4.1
