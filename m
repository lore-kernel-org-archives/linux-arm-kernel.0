From: robherring2@gmail.com (Rob Herring)
Date: Fri, 29 Apr 2011 21:08:11 -0500
Subject: [PATCH 04/10] ARM: add common scu_init_cpus
In-Reply-To: <1304129297-6614-1-git-send-email-robherring2@gmail.com>
References: <1304129297-6614-1-git-send-email-robherring2@gmail.com>
Message-ID: <1304129297-6614-5-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Cortex-A9 SCU based platforms use the same code for smp_init_cpus, so create
a common implementation for systems with an SCU.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/include/asm/smp_scu.h |    1 +
 arch/arm/kernel/smp_scu.c      |   19 +++++++++++++++++++
 2 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/smp_scu.h b/arch/arm/include/asm/smp_scu.h
index 4eb6d00..6b03557 100644
--- a/arch/arm/include/asm/smp_scu.h
+++ b/arch/arm/include/asm/smp_scu.h
@@ -7,6 +7,7 @@
 
 #ifndef __ASSEMBLER__
 unsigned int scu_get_core_count(void __iomem *);
+void scu_init_cpus(void __iomem *);
 void scu_enable(void __iomem *);
 int scu_power_mode(void __iomem *, unsigned int);
 #endif
diff --git a/arch/arm/kernel/smp_scu.c b/arch/arm/kernel/smp_scu.c
index a1e757c..e58b8c4 100644
--- a/arch/arm/kernel/smp_scu.c
+++ b/arch/arm/kernel/smp_scu.c
@@ -29,6 +29,25 @@ unsigned int __init scu_get_core_count(void __iomem *scu_base)
 	return (ncores & 0x03) + 1;
 }
 
+void __init scu_init_cpus(void __iomem *scu_base)
+{
+	unsigned int i, ncores;
+
+	ncores = scu_get_core_count(scu_base);
+
+	/* sanity check */
+	if (ncores > NR_CPUS) {
+		printk(KERN_WARNING
+		       "SCU: No. of cores (%d) greater than configured "
+		       "maximum of %d - clipping\n",
+		       ncores, NR_CPUS);
+		ncores = NR_CPUS;
+	}
+
+	for (i = 0; i < ncores; i++)
+		set_cpu_possible(i, true);
+}
+
 /*
  * Enable the SCU
  */
-- 
1.7.1
