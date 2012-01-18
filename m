From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 18 Jan 2012 14:36:46 +0000
Subject: [RFC PATCH 3/5] ARM: kernel: add logical mappings look-up
In-Reply-To: <1326897408-11204-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1326897408-11204-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1326897408-11204-4-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In ARM SMP systems the MPIDR register ([23:0] bits) is used to uniquely
identify CPUs.

In order to retrieve the logical CPU index corresponding to a given
MPIDR value and guarantee a consistent translation throughout the kernel, this
patch adds a look-up based on the MPIDR so that irq controller drivers and
other kernel subsystems can use it whenever the logical cpu index corresponding
to a given MPIDR value is needed.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
---
 arch/arm/include/asm/smp_plat.h |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/smp_plat.h b/arch/arm/include/asm/smp_plat.h
index 558d6c8..deabc78 100644
--- a/arch/arm/include/asm/smp_plat.h
+++ b/arch/arm/include/asm/smp_plat.h
@@ -5,6 +5,9 @@
 #ifndef __ASMARM_SMP_PLAT_H
 #define __ASMARM_SMP_PLAT_H
 
+#include <linux/cpumask.h>
+#include <linux/err.h>
+
 #include <asm/cputype.h>
 
 /*
@@ -49,4 +52,13 @@ static inline int cache_ops_need_broadcast(void)
 extern int __cpu_logical_map[];
 #define cpu_logical_map(cpu)	__cpu_logical_map[cpu]
 
+static inline int get_logical_index(u32 mpidr)
+{
+	int cpu;
+	for (cpu = 0; cpu < nr_cpu_ids; cpu++)
+		if (cpu_logical_map(cpu) == mpidr)
+			return cpu;
+	return -EINVAL;
+}
+
 #endif
-- 
1.7.4.4
