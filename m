From: robh@kernel.org (Rob Herring)
Date: Wed,  5 Sep 2018 14:37:22 -0500
Subject: [PATCH 05/21] ARM: shmobile: use for_each_of_cpu_node iterator
In-Reply-To: <20180905193738.19325-1-robh@kernel.org>
References: <20180905193738.19325-1-robh@kernel.org>
Message-ID: <20180905193738.19325-6-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the for_each_of_cpu_node iterator to iterate over cpu nodes. This
has the side effect of defaulting to iterating using "cpu" node names in
preference to the deprecated (for FDT) device_type == "cpu".

Cc: Simon Horman <horms@verge.net.au>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-renesas-soc at vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
Please ack and I will take via the DT tree. This is dependent on the
first 2 patches.

 arch/arm/mach-shmobile/pm-rcar-gen2.c |  8 ++------
 arch/arm/mach-shmobile/pm-rmobile.c   |  2 +-
 arch/arm/mach-shmobile/timer.c        | 10 ++--------
 3 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-shmobile/pm-rcar-gen2.c b/arch/arm/mach-shmobile/pm-rcar-gen2.c
index 345af3ebcc3a..7efe95bd584f 100644
--- a/arch/arm/mach-shmobile/pm-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/pm-rcar-gen2.c
@@ -50,7 +50,7 @@ void __init rcar_gen2_pm_init(void)
 	void __iomem *p;
 	u32 bar;
 	static int once;
-	struct device_node *np, *cpus;
+	struct device_node *np;
 	bool has_a7 = false;
 	bool has_a15 = false;
 	struct resource res;
@@ -59,11 +59,7 @@ void __init rcar_gen2_pm_init(void)
 	if (once++)
 		return;

-	cpus = of_find_node_by_path("/cpus");
-	if (!cpus)
-		return;
-
-	for_each_child_of_node(cpus, np) {
+	for_each_of_cpu_node(np) {
 		if (of_device_is_compatible(np, "arm,cortex-a15"))
 			has_a15 = true;
 		else if (of_device_is_compatible(np, "arm,cortex-a7"))
diff --git a/arch/arm/mach-shmobile/pm-rmobile.c b/arch/arm/mach-shmobile/pm-rmobile.c
index e348bcfe389d..94fdeef11b81 100644
--- a/arch/arm/mach-shmobile/pm-rmobile.c
+++ b/arch/arm/mach-shmobile/pm-rmobile.c
@@ -202,7 +202,7 @@ static void __init get_special_pds(void)
 	const struct of_device_id *id;

 	/* PM domains containing CPUs */
-	for_each_node_by_type(np, "cpu")
+	for_each_of_cpu_node(np)
 		add_special_pd(np, PD_CPU);

 	/* PM domain containing console */
diff --git a/arch/arm/mach-shmobile/timer.c b/arch/arm/mach-shmobile/timer.c
index 828e8aea037e..e48b0939693f 100644
--- a/arch/arm/mach-shmobile/timer.c
+++ b/arch/arm/mach-shmobile/timer.c
@@ -22,22 +22,16 @@

 void __init shmobile_init_delay(void)
 {
-	struct device_node *np, *cpus;
+	struct device_node *np;
 	u32 max_freq = 0;

-	cpus = of_find_node_by_path("/cpus");
-	if (!cpus)
-		return;
-
-	for_each_child_of_node(cpus, np) {
+	for_each_of_cpu_node(np) {
 		u32 freq;

 		if (!of_property_read_u32(np, "clock-frequency", &freq))
 			max_freq = max(max_freq, freq);
 	}

-	of_node_put(cpus);
-
 	if (!max_freq)
 		return;

--
2.17.1
