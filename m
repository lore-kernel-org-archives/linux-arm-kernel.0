From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 31 Jan 2012 21:11:10 +0900
Subject: [PATCH] ARM: smp: allow get the core count from L2 control on A15
Message-ID: <04be01cce011$6b3b3550$41b19ff0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Actually, the number of A15 CPU core gets from L2 control
register not SCU configuration.

Suggested-by: Changhwan Youn <chaos.youn@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
---

Hi Russell,

As you know, the method of A15 core counting is different with A9.
So the function will be required on that but I'm not sure where the
function should be added at.

 arch/arm/include/asm/smp.h |    5 +++++
 arch/arm/kernel/smp.c      |   16 ++++++++++++++++
 2 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/smp.h b/arch/arm/include/asm/smp.h
index 1e5717a..b67084f 100644
--- a/arch/arm/include/asm/smp.h
+++ b/arch/arm/include/asm/smp.h
@@ -71,6 +71,11 @@ extern void platform_secondary_init(unsigned int cpu);
 extern void platform_smp_prepare_cpus(unsigned int);
 
 /*
+ * Get the number of CPU cores from the L2 control register on A15
+ */
+extern unsigned long a15_get_core_count(void);
+
+/*
  * Logical CPU mapping.
  */
 extern int __cpu_logical_map[NR_CPUS];
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 57db122..be4d31d 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -233,6 +233,22 @@ void __ref cpu_die(void)
 }
 #endif /* CONFIG_HOTPLUG_CPU */
 
+/*
+ * Get the number of CPU cores from the L2 control register on A15
+ */
+unsigned long a15_get_core_count(void)
+{
+	unsigned long val;
+
+	/* Read L2 control register */
+	asm volatile("mrc p15, 1, %0, c9, c0, 2" : "=r"(val));
+
+	/* [25:24] of L2 control register means core count - 1 */
+	val = ((val >> 24) & 0x3) + 1;
+
+	return val;
+}
+
 int __cpu_logical_map[NR_CPUS];
 
 void __init smp_setup_processor_id(void)
-- 
1.7.1
