From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 17 Jul 2018 18:01:21 +0100
Subject: [PATCH v3 5/7] arm64: smp: remove cpu and numa topology
 information when hotplugging out CPU
In-Reply-To: <5a23f1c8-27cb-b09c-90fc-edab3eec99f9@arm.com>
References: <1530874968-5960-1-git-send-email-sudeep.holla@arm.com>
 <1530874968-5960-6-git-send-email-sudeep.holla@arm.com>
 <CAMuHMdXw9My+P1UCJ19Qdjq4O9gY_0QVFZaw6C5Ytmpyac59Vw@mail.gmail.com>
 <20180717140536.GA27323@e107155-lin>
 <CAMuHMdUnL=XyoSfRU+ebVUjsiP89V4vcoN=O4xc0VwHmLP72HA@mail.gmail.com>
 <1c47b3fd-59ba-aba4-43b2-ed98e750887b@arm.com>
 <5a23f1c8-27cb-b09c-90fc-edab3eec99f9@arm.com>
Message-ID: <20180717170121.GA14049@e107155-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 17, 2018 at 04:55:22PM +0100, Sudeep Holla wrote:

[..]

> Going through the code again, I think I understand the problem here.
> We use the topology_core_mask pointers which are stashed in cpu_groups[]
> But, the cpumask themselves will be getting modified as the cpus go up
> and down, so we need to make a copy instead of just using the pointer.
> I will see what we can do to fix that.

This is what I could come up with. I haven't tested this but just compiled
it. Let me know if this resolves the issue.

-->8

From: Sudeep Holla <sudeep.holla@arm.com>
Date: Tue, 17 Jul 2018 17:45:20 +0100
Subject: [PATCH] drivers/firmware: psci_checker: stash and use topology_core_cpumask for hotplug tests

Commit 7f9545aa1a91 ("arm64: smp: remove cpu and numa topology information
when hotplugging out CPU") updates the cpu topology when the CPU is
hotplugged out. However the PSCI checker code uses the topology_core_cpumask
pointers for some of the cpu hotplug testing. Since the pointer to the
core_cpumask of the first CPU in the group is used, which when that CPU
itself is hotpugged out is just set to itself, the testing terminates
after that particular CPU is tested out. But the intention of this tests
is to cover all the CPU in the group.

In order to support that, we need to stash the topology_core_cpumask
before the start of the test and use that value instead of pointer to a
cpumask which will be updated on CPU hotplug.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/psci_checker.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/psci_checker.c b/drivers/firmware/psci_checker.c
index bb1c068bff19..dcace6fa17b6 100644
--- a/drivers/firmware/psci_checker.c
+++ b/drivers/firmware/psci_checker.c
@@ -77,21 +77,20 @@ static int psci_ops_check(void)
 	return 0;
 }
 
-static int find_cpu_groups(const struct cpumask *cpus,
-			   const struct cpumask **cpu_groups)
+static int find_cpu_groups(cpumask_var_t *cpu_groups)
 {
 	unsigned int nb = 0;
 	cpumask_var_t tmp;
 
 	if (!alloc_cpumask_var(&tmp, GFP_KERNEL))
 		return -ENOMEM;
-	cpumask_copy(tmp, cpus);
+	cpumask_copy(tmp, cpu_online_mask);
 
 	while (!cpumask_empty(tmp)) {
 		const struct cpumask *cpu_group =
 			topology_core_cpumask(cpumask_any(tmp));
 
-		cpu_groups[nb++] = cpu_group;
+		cpumask_copy(cpu_groups[nb++], cpu_group);
 		cpumask_andnot(tmp, tmp, cpu_group);
 	}
 
@@ -169,16 +168,15 @@ static unsigned int down_and_up_cpus(const struct cpumask *cpus,
 static int hotplug_tests(void)
 {
 	int err;
-	cpumask_var_t offlined_cpus;
+	cpumask_var_t offlined_cpus, *cpu_groups;
 	int i, nb_cpu_group;
-	const struct cpumask **cpu_groups;
 	char *page_buf;
 
 	err = -ENOMEM;
 	if (!alloc_cpumask_var(&offlined_cpus, GFP_KERNEL))
 		return err;
 	/* We may have up to nb_available_cpus cpu_groups. */
-	cpu_groups = kmalloc_array(nb_available_cpus, sizeof(*cpu_groups),
+	cpu_groups = kmalloc_array(nb_available_cpus, sizeof(cpu_groups),
 				   GFP_KERNEL);
 	if (!cpu_groups)
 		goto out_free_cpus;
@@ -186,8 +184,12 @@ static int hotplug_tests(void)
 	if (!page_buf)
 		goto out_free_cpu_groups;
 
+	for (i = 0; i < nb_available_cpus; ++i)
+		if (!alloc_cpumask_var(&cpu_groups[i], GFP_KERNEL))
+			goto out_free_cpu_groups_var;
+
 	err = 0;
-	nb_cpu_group = find_cpu_groups(cpu_online_mask, cpu_groups);
+	nb_cpu_group = find_cpu_groups(cpu_groups);
 
 	/*
 	 * Of course the last CPU cannot be powered down and cpu_down() should
@@ -211,6 +213,9 @@ static int hotplug_tests(void)
 	}
 
 	free_page((unsigned long)page_buf);
+out_free_cpu_groups_var:
+	for (i = 0; i < nb_available_cpus; ++i)
+		free_cpumask_var(cpu_groups[i]);
 out_free_cpu_groups:
 	kfree(cpu_groups);
 out_free_cpus:
-- 
2.7.4
