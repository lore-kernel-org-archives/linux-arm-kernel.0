From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 24 Nov 2015 15:33:06 +0000
Subject: [RFC/PATCH] arm: do not skip SMP init calls on SMP_ON_UP case
In-Reply-To: <5654799E.5080903@dev.rtsoft.ru>
References: <1448279946-19975-1-git-send-email-nyushchenko@dev.rtsoft.ru>
 <20151123120317.GN8644@n2100.arm.linux.org.uk>
 <5653015C.4020405@dev.rtsoft.ru> <56530769.4030403@arm.com>
 <5653099A.7020604@dev.rtsoft.ru> <56530AE6.2060407@dev.rtsoft.ru>
 <20151123130424.GQ8644@n2100.arm.linux.org.uk>
 <5654799E.5080903@dev.rtsoft.ru>
Message-ID: <20151124153305.GD8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 24, 2015 at 05:52:14PM +0300, Nikita Yushchenko wrote:
> I'm still trying to understand what is going on, and my printk()s show
> that this is not entirely true.
> 
> When smp_init() is entered on mainline om imx6s, cpu_possible_mask and
> cpu_present_mask both contain two cpus. These get initialized in
> arm_dt_init_cpu_maps() and stay unmodified since then.
> 
> But cpu_online() returns 1 for cpu0 and 0 from cpu1 - thus it is
> cpu_online() check, not possible_mask or present_mask, that prevents
> cpu1 initialization attempt.

No.  cpu_online() reports whether the CPU is currently online or not.
It's the current state of the system wrt which CPUs are running and
not running.

Initially, only the boot CPU will be marked online, and the code
which brings all CPUs online (see smp_init() in kernel/smp.c) will
check whether the CPU is already online prior to trying to bring it
up.  It will attempt it for any present CPU, up to the maximum number
of online CPUs (set by nosmp or maxcpus kernel options.)

> Not sure I understand logic behind this. With the current code,
> resulting cpu_possible_mask depends on CONFIG_SMP_ON_UP:
> - if it is set, cpu_possible_mask contains (0 1), as initialized in
> arm_dt_init_cpu_maps()
> - if it is not set, cpu_possible_mask contains (0), since
> imx_smp_init_cpus() removes 1 from there.

Right, adding debug to arch/arm/kernel/setup.c, just before the
"if (is_smp())" shows:

is_smp() 0 possible 3 present 1 online 1

which is totally wrong: if is_smp() is false, we should not be setting
up any possible CPUs.  See a patch below to fix that.

However, this doesn't matter much, because the code in setup.c won't
initialise the SMP operations struct:

        if (is_smp()) {
                if (!mdesc->smp_init || !mdesc->smp_init()) {
                        if (psci_smp_available())
                                smp_set_ops(&psci_smp_ops);
                        else if (mdesc->smp)
                                smp_set_ops(mdesc->smp);
                }
                smp_init_cpus();
                smp_build_mpidr_hash();
        }

and this in turn means that __cpu_up() will return -ENOSYS due to this
check:

        if (!smp_ops.smp_boot_secondary)
                return -ENOSYS;

That causes _cpu_up() in kernel/cpu.c to bail out, along with cpu_up().
Notice that the call to smp_init() in kernel/smp.c is silent.

Hence, kernel/smp.c will try to bring CPU 1 online (because it is
marked present), but it'll _silently_ fail with -ENOSYS.

Here's the patch to fix the DT code, which should not be setting
present CPUs when is_smp() is false.

 arch/arm/kernel/devtree.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
index 65addcbf5b30..bd72ce91d7a2 100644
--- a/arch/arm/kernel/devtree.c
+++ b/arch/arm/kernel/devtree.c
@@ -170,15 +170,18 @@ void __init arm_dt_init_cpu_maps(void)
 		return;
 	}
 
-	/*
-	 * Since the boot CPU node contains proper data, and all nodes have
-	 * a reg property, the DT CPU list can be considered valid and the
-	 * logical map created in smp_setup_processor_id() can be overridden
-	 */
-	for (i = 0; i < cpuidx; i++) {
-		set_cpu_possible(i, true);
-		cpu_logical_map(i) = tmp_map[i];
-		pr_debug("cpu logical map 0x%x\n", cpu_logical_map(i));
+	if (is_smp()) {
+		/*
+		 * Since the boot CPU node contains proper data, and all
+		 * nodes have a reg property, the DT CPU list can be
+		 * considered valid and the logical map created in
+		 * smp_setup_processor_id() can be overridden
+		 */
+		for (i = 0; i < cpuidx; i++) {
+			set_cpu_possible(i, true);
+			cpu_logical_map(i) = tmp_map[i];
+			pr_debug("cpu logical map 0x%x\n", cpu_logical_map(i));
+		}
 	}
 }
 

-- 
FTTC broadband for 0.8mile line: currently@9.6Mbps down 400kbps up
according to speedtest.net.
