From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu,  6 Mar 2014 17:46:27 +0100
Subject: [PATCH 02/10] ARM: mvebu: add a coherency_available() call
In-Reply-To: <1394124395-20030-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1394124395-20030-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1394124395-20030-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit extends the coherency fabric code to provide a
coherency_available()function that the SoC code can call to be told
whether coherency support is available or not. On Armada 370/XP,
coherency support is available as soon as the relevant DT node is
present. On some upcoming SoCs, the DT node needs to be present *and*
the system running with CONFIG_SMP enabled.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/coherency.c | 30 +++++++++++++++++++++++-------
 arch/arm/mach-mvebu/coherency.h |  1 +
 2 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-mvebu/coherency.c b/arch/arm/mach-mvebu/coherency.c
index 72d8d75..0c440c3 100644
--- a/arch/arm/mach-mvebu/coherency.c
+++ b/arch/arm/mach-mvebu/coherency.c
@@ -39,6 +39,7 @@ static void __iomem *coherency_cpu_base;
 #define IO_SYNC_BARRIER_CTL_OFFSET		   0x0
 
 enum {
+	COHERENCY_FABRIC_TYPE_NONE,
 	COHERENCY_FABRIC_TYPE_ARMADA_370_XP,
 };
 
@@ -143,7 +144,7 @@ static void __init armada_370_coherency_init(struct device_node *np)
 	set_cpu_coherent(cpu_logical_map(smp_processor_id()), 0);
 }
 
-int __init coherency_init(void)
+static int coherency_type(void)
 {
 	struct device_node *np;
 
@@ -154,27 +155,42 @@ int __init coherency_init(void)
 		int type;
 
 		type = (int) match->data;
+
 		pr_info("Initializing Coherency fabric\n");
 
+		/* Armada 370/XP coherency works in both UP and SMP */
 		if (type == COHERENCY_FABRIC_TYPE_ARMADA_370_XP)
-			armada_370_coherency_init(np);
+			return type;
 
 		of_node_put(np);
 	}
 
-	return 0;
+	return COHERENCY_FABRIC_TYPE_NONE;
 }
 
-static int __init coherency_late_init(void)
+int coherency_available(void)
 {
+	return coherency_type() != COHERENCY_FABRIC_TYPE_NONE;
+}
+
+int __init coherency_init(void)
+{
+	int type = coherency_type();
 	struct device_node *np;
 
 	np = of_find_matching_node(NULL, of_coherency_table);
-	if (np) {
+
+	if (type == COHERENCY_FABRIC_TYPE_ARMADA_370_XP)
+		armada_370_coherency_init(np);
+
+	return 0;
+}
+
+static int __init coherency_late_init(void)
+{
+	if (coherency_available())
 		bus_register_notifier(&platform_bus_type,
 				      &mvebu_hwcc_platform_nb);
-		of_node_put(np);
-	}
 	return 0;
 }
 
diff --git a/arch/arm/mach-mvebu/coherency.h b/arch/arm/mach-mvebu/coherency.h
index 760226c..02f7ec3 100644
--- a/arch/arm/mach-mvebu/coherency.h
+++ b/arch/arm/mach-mvebu/coherency.h
@@ -18,5 +18,6 @@ extern unsigned long coherency_phys_base;
 
 int set_cpu_coherent(unsigned int cpu_id, int smp_group_id);
 int coherency_init(void);
+int coherency_available(void);
 
 #endif	/* __MACH_370_XP_COHERENCY_H */
-- 
1.8.3.2
