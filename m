From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 25 Jul 2018 11:48:09 +0100
Subject: [PATCH v4] drivers/firmware: psci_checker: stash and use
 topology_core_cpumask for hotplug tests
Message-ID: <1532515689-31806-1-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 7f9545aa1a91 ("arm64: smp: remove cpu and numa topology
information when hotplugging out CPU") updates the cpu topology when
the CPU is hotplugged out. However the PSCI checker code uses the
topology_core_cpumask pointers for some of the cpu hotplug testing.
Since the pointer to the core_cpumask of the first CPU in the group
is used, which when that CPU itself is hotpugged out is just set to
itself, the testing terminates after that particular CPU is tested out.
But the intention of this tests is to cover all the CPU in the group.

In order to support that, we need to stash the topology_core_cpumask
before the start of the test and use that value instead of pointer to
a cpumask which will be updated on CPU hotplug.

Fixes: 7f9545aa1a91a9a4 ("arm64: smp: remove cpu and numa topology
	information when hotplugging out CPU")
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Mark Rutland <mark.rutland@arm.com>
Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/psci_checker.c | 83 ++++++++++++++++++++++++-----------------
 1 file changed, 49 insertions(+), 34 deletions(-)

Hi ARM SoC,

Though the fixes tag points to a commit in arm64/for-next/core,
it shouldn't be any issue to take this via ARM SoC for v4.19
Will suggested the same.

Regards,
Sudeep

v3->v4:
	- Added all tested and acks
	- Resending including arm-soc team
v2->v3:
	- Got rid of find_cpu_groups as suggested by Lorenzo

diff --git a/drivers/firmware/psci_checker.c b/drivers/firmware/psci_checker.c
index bb1c068bff19..346943657962 100644
--- a/drivers/firmware/psci_checker.c
+++ b/drivers/firmware/psci_checker.c
@@ -77,28 +77,6 @@ static int psci_ops_check(void)
 	return 0;
 }

-static int find_cpu_groups(const struct cpumask *cpus,
-			   const struct cpumask **cpu_groups)
-{
-	unsigned int nb = 0;
-	cpumask_var_t tmp;
-
-	if (!alloc_cpumask_var(&tmp, GFP_KERNEL))
-		return -ENOMEM;
-	cpumask_copy(tmp, cpus);
-
-	while (!cpumask_empty(tmp)) {
-		const struct cpumask *cpu_group =
-			topology_core_cpumask(cpumask_any(tmp));
-
-		cpu_groups[nb++] = cpu_group;
-		cpumask_andnot(tmp, tmp, cpu_group);
-	}
-
-	free_cpumask_var(tmp);
-	return nb;
-}
-
 /*
  * offlined_cpus is a temporary array but passing it as an argument avoids
  * multiple allocations.
@@ -166,29 +144,66 @@ static unsigned int down_and_up_cpus(const struct cpumask *cpus,
 	return err;
 }

+static void free_cpu_groups(int num, cpumask_var_t **pcpu_groups)
+{
+	int i;
+	cpumask_var_t *cpu_groups = *pcpu_groups;
+
+	for (i = 0; i < num; ++i)
+		free_cpumask_var(cpu_groups[i]);
+	kfree(cpu_groups);
+}
+
+static int alloc_init_cpu_groups(cpumask_var_t **pcpu_groups)
+{
+	int num_groups = 0;
+	cpumask_var_t tmp, *cpu_groups;
+
+	if (!alloc_cpumask_var(&tmp, GFP_KERNEL))
+		return -ENOMEM;
+
+	cpu_groups = kcalloc(nb_available_cpus, sizeof(cpu_groups),
+			     GFP_KERNEL);
+	if (!cpu_groups)
+		return -ENOMEM;
+
+	cpumask_copy(tmp, cpu_online_mask);
+
+	while (!cpumask_empty(tmp)) {
+		const struct cpumask *cpu_group =
+			topology_core_cpumask(cpumask_any(tmp));
+
+		if (!alloc_cpumask_var(&cpu_groups[num_groups], GFP_KERNEL)) {
+			free_cpu_groups(num_groups, &cpu_groups);
+			return -ENOMEM;
+		}
+		cpumask_copy(cpu_groups[num_groups++], cpu_group);
+		cpumask_andnot(tmp, tmp, cpu_group);
+	}
+
+	free_cpumask_var(tmp);
+	*pcpu_groups = cpu_groups;
+
+	return num_groups;
+}
+
 static int hotplug_tests(void)
 {
-	int err;
-	cpumask_var_t offlined_cpus;
-	int i, nb_cpu_group;
-	const struct cpumask **cpu_groups;
+	int i, nb_cpu_group, err = -ENOMEM;
+	cpumask_var_t offlined_cpus, *cpu_groups;
 	char *page_buf;

-	err = -ENOMEM;
 	if (!alloc_cpumask_var(&offlined_cpus, GFP_KERNEL))
 		return err;
-	/* We may have up to nb_available_cpus cpu_groups. */
-	cpu_groups = kmalloc_array(nb_available_cpus, sizeof(*cpu_groups),
-				   GFP_KERNEL);
-	if (!cpu_groups)
+
+	nb_cpu_group = alloc_init_cpu_groups(&cpu_groups);
+	if (nb_cpu_group < 0)
 		goto out_free_cpus;
 	page_buf = (char *)__get_free_page(GFP_KERNEL);
 	if (!page_buf)
 		goto out_free_cpu_groups;

 	err = 0;
-	nb_cpu_group = find_cpu_groups(cpu_online_mask, cpu_groups);
-
 	/*
 	 * Of course the last CPU cannot be powered down and cpu_down() should
 	 * refuse doing that.
@@ -212,7 +227,7 @@ static int hotplug_tests(void)

 	free_page((unsigned long)page_buf);
 out_free_cpu_groups:
-	kfree(cpu_groups);
+	free_cpu_groups(nb_cpu_group, &cpu_groups);
 out_free_cpus:
 	free_cpumask_var(offlined_cpus);
 	return err;
--
2.7.4
