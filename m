From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 23 Sep 2013 19:17:52 -0400
Subject: [PATCH 09/13] ARM: bL_switcher: wait until inbound is alive before
 performing a switch
In-Reply-To: <1379978276-31241-1-git-send-email-nicolas.pitre@linaro.org>
References: <1379978276-31241-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1379978276-31241-10-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In some cases, a significant delay may be observed between the moment
a request for a CPU to come up is made and the moment it is ready to
start executing kernel code.  This is especially true when a whole
cluster has to be powered up which may take in the order of miliseconds.
It is therefore a good idea to let the outbound CPU continue to execute
code in the mean time, and be notified when the inbound is ready before
performing the actual switch.

This is achieved by registering a completion block with the appropriate
IPI callback, and programming the sending of an IPI by the early assembly
code prior to entering the main kernel code.  Once the IPI is delivered
to the outbound CPU, the completion block is "completed" and the switcher
thread is resumed.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/common/bL_switcher.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/arch/arm/common/bL_switcher.c b/arch/arm/common/bL_switcher.c
index aab7c12748..dc53eb8dcc 100644
--- a/arch/arm/common/bL_switcher.c
+++ b/arch/arm/common/bL_switcher.c
@@ -144,10 +144,11 @@ static int bL_switch_to(unsigned int new_cluster_id)
 {
 	unsigned int mpidr, this_cpu, that_cpu;
 	unsigned int ob_mpidr, ob_cpu, ob_cluster, ib_mpidr, ib_cpu, ib_cluster;
+	struct completion inbound_alive;
 	struct tick_device *tdev;
 	enum clock_event_mode tdev_mode;
 	long volatile *handshake_ptr;
-	int ret;
+	int ipi_nr, ret;
 
 	this_cpu = smp_processor_id();
 	ob_mpidr = read_mpidr();
@@ -166,10 +167,18 @@ static int bL_switch_to(unsigned int new_cluster_id)
 	pr_debug("before switch: CPU %d MPIDR %#x -> %#x\n",
 		 this_cpu, ob_mpidr, ib_mpidr);
 
+	this_cpu = smp_processor_id();
+
 	/* Close the gate for our entry vectors */
 	mcpm_set_entry_vector(ob_cpu, ob_cluster, NULL);
 	mcpm_set_entry_vector(ib_cpu, ib_cluster, NULL);
 
+	/* Install our "inbound alive" notifier. */
+	init_completion(&inbound_alive);
+	ipi_nr = register_ipi_completion(&inbound_alive, this_cpu);
+	ipi_nr |= ((1 << 16) << bL_gic_id[ob_cpu][ob_cluster]);
+	mcpm_set_early_poke(ib_cpu, ib_cluster, gic_get_sgir_physaddr(), ipi_nr);
+
 	/*
 	 * Let's wake up the inbound CPU now in case it requires some delay
 	 * to come online, but leave it gated in our entry vector code.
@@ -181,6 +190,19 @@ static int bL_switch_to(unsigned int new_cluster_id)
 	}
 
 	/*
+	 * Raise a SGI on the inbound CPU to make sure it doesn't stall
+	 * in a possible WFI, such as in bL_power_down().
+	 */
+	gic_send_sgi(bL_gic_id[ib_cpu][ib_cluster], 0);
+
+	/*
+	 * Wait for the inbound to come up.  This allows for other
+	 * tasks to be scheduled in the mean time.
+	 */
+	wait_for_completion(&inbound_alive);
+	mcpm_set_early_poke(ib_cpu, ib_cluster, 0, 0);
+
+	/*
 	 * From this point we are entering the switch critical zone
 	 * and can't take any interrupts anymore.
 	 */
@@ -190,12 +212,6 @@ static int bL_switch_to(unsigned int new_cluster_id)
 	/* redirect GIC's SGIs to our counterpart */
 	gic_migrate_target(bL_gic_id[ib_cpu][ib_cluster]);
 
-	/*
-	 * Raise a SGI on the inbound CPU to make sure it doesn't stall
-	 * in a possible WFI, such as in mcpm_power_down().
-	 */
-	arch_send_wakeup_ipi_mask(cpumask_of(this_cpu));
-
 	tdev = tick_get_device(this_cpu);
 	if (tdev && !cpumask_equal(tdev->evtdev->cpumask, cpumask_of(this_cpu)))
 		tdev = NULL;
-- 
1.8.4.98.gb022869
