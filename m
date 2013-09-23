From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 23 Sep 2013 19:17:47 -0400
Subject: [PATCH 04/13] ARM: bL_switcher: synchronize the outbound with the
 inbound
In-Reply-To: <1379978276-31241-1-git-send-email-nicolas.pitre@linaro.org>
References: <1379978276-31241-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1379978276-31241-5-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let's wait for the inbound CPU to come up and snoop some of the outbound
CPU cache before bringing the outbound CPU down.  That should be more
efficient than going down right away.

Possible improvements might involve some monitoring of the CCI event
counters.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/common/bL_switcher.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/arm/common/bL_switcher.c b/arch/arm/common/bL_switcher.c
index 34316be404..aab7c12748 100644
--- a/arch/arm/common/bL_switcher.c
+++ b/arch/arm/common/bL_switcher.c
@@ -55,9 +55,10 @@ static int read_mpidr(void)
  * bL switcher core code.
  */
 
-static void bL_do_switch(void *_unused)
+static void bL_do_switch(void *_arg)
 {
 	unsigned ib_mpidr, ib_cpu, ib_cluster;
+	long volatile handshake, **handshake_ptr = _arg;
 
 	pr_debug("%s\n", __func__);
 
@@ -65,6 +66,13 @@ static void bL_do_switch(void *_unused)
 	ib_cpu = MPIDR_AFFINITY_LEVEL(ib_mpidr, 0);
 	ib_cluster = MPIDR_AFFINITY_LEVEL(ib_mpidr, 1);
 
+	/* Advertise our handshake location */
+	if (handshake_ptr) {
+		handshake = 0;
+		*handshake_ptr = &handshake;
+	} else
+		handshake = -1;
+
 	/*
 	 * Our state has been saved at this point.  Let's release our
 	 * inbound CPU.
@@ -83,6 +91,14 @@ static void bL_do_switch(void *_unused)
 	 * we have none.
 	 */
 
+	/*
+	 * Let's wait until our inbound is alive.
+	 */
+	while (!handshake) {
+		wfe();
+		smp_mb();
+	}
+
 	/* Let's put ourself down. */
 	mcpm_cpu_power_down();
 
@@ -130,6 +146,7 @@ static int bL_switch_to(unsigned int new_cluster_id)
 	unsigned int ob_mpidr, ob_cpu, ob_cluster, ib_mpidr, ib_cpu, ib_cluster;
 	struct tick_device *tdev;
 	enum clock_event_mode tdev_mode;
+	long volatile *handshake_ptr;
 	int ret;
 
 	this_cpu = smp_processor_id();
@@ -198,7 +215,7 @@ static int bL_switch_to(unsigned int new_cluster_id)
 	cpu_logical_map(that_cpu) = ob_mpidr;
 
 	/* Let's do the actual CPU switch. */
-	ret = cpu_suspend(0, bL_switchpoint);
+	ret = cpu_suspend((unsigned long)&handshake_ptr, bL_switchpoint);
 	if (ret > 0)
 		panic("%s: cpu_suspend() returned %d\n", __func__, ret);
 
@@ -220,6 +237,9 @@ static int bL_switch_to(unsigned int new_cluster_id)
 	local_fiq_enable();
 	local_irq_enable();
 
+	*handshake_ptr = 1;
+	dsb_sev();
+
 	if (ret)
 		pr_err("%s exiting with error %d\n", __func__, ret);
 	return ret;
-- 
1.8.4.98.gb022869
