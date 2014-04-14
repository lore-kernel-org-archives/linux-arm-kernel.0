From: xypron.glpk@gmx.de (Heinrich Schuchardt)
Date: Mon, 14 Apr 2014 09:42:01 +0200
Subject: [PATCH 1/1] arm/mach-vexpress: array accessed out of bounds
In-Reply-To: <alpine.LFD.2.11.1404131337580.980@knanqh.ubzr>
References: <alpine.LFD.2.11.1404131337580.980@knanqh.ubzr>
Message-ID: <1397461321-7108-1-git-send-email-xypron.glpk@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(Forwarding to arm at kernel.org)

dcscb_allcpus_mask is an array of size 2.

The index variable cluster has to be checked against this limit
before accessing the array.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Acked-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/mach-vexpress/dcscb.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-vexpress/dcscb.c b/arch/arm/mach-vexpress/dcscb.c
index 16d57a8..a76b44c 100644
--- a/arch/arm/mach-vexpress/dcscb.c
+++ b/arch/arm/mach-vexpress/dcscb.c
@@ -51,12 +51,14 @@ static int dcscb_allcpus_mask[2];
 static int dcscb_power_up(unsigned int cpu, unsigned int cluster)
 {
 	unsigned int rst_hold, cpumask = (1 << cpu);
-	unsigned int all_mask = dcscb_allcpus_mask[cluster];
+	unsigned int all_mask;
 
 	pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
 	if (cpu >= 4 || cluster >= 2)
 		return -EINVAL;
 
+	all_mask = dcscb_allcpus_mask[cluster];
+
 	/*
 	 * Since this is called with IRQs enabled, and no arch_spin_lock_irq
 	 * variant exists, we need to disable IRQs manually here.
@@ -101,11 +103,12 @@ static void dcscb_power_down(void)
 	cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
 	cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
 	cpumask = (1 << cpu);
-	all_mask = dcscb_allcpus_mask[cluster];
 
 	pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
 	BUG_ON(cpu >= 4 || cluster >= 2);
 
+	all_mask = dcscb_allcpus_mask[cluster];
+
 	__mcpm_cpu_going_down(cpu, cluster);
 
 	arch_spin_lock(&dcscb_lock);
-- 
1.7.10.4
