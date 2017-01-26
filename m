From: pprakash@codeaurora.org (Prashanth Prakash)
Date: Thu, 26 Jan 2017 11:08:32 -0700
Subject: [PATCH V2] arm64: skip register_cpufreq_notifier on ACPI-based systems
Message-ID: <1485454112-4823-1-git-send-email-pprakash@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ACPI based systems where the topology is setup using the API
store_cpu_topology, at the moment we do not have necessary code
to parse cpu capacity and handle cpufreq notifier, thus
resulting in a kernel panic.

Stack:
        init_cpu_capacity_callback+0xb4/0x1c8
        notifier_call_chain+0x5c/0xa0
        __blocking_notifier_call_chain+0x58/0xa0
        blocking_notifier_call_chain+0x3c/0x50
        cpufreq_set_policy+0xe4/0x328
        cpufreq_init_policy+0x80/0x100
        cpufreq_online+0x418/0x710
        cpufreq_add_dev+0x118/0x180
        subsys_interface_register+0xa4/0xf8
        cpufreq_register_driver+0x1c0/0x298
        cppc_cpufreq_init+0xdc/0x1000 [cppc_cpufreq]
        do_one_initcall+0x5c/0x168
        do_init_module+0x64/0x1e4
        load_module+0x130c/0x14d0
        SyS_finit_module+0x108/0x120
        el0_svc_naked+0x24/0x28

Fixes: 7202bde8b7ae ("arm64: parse cpu capacity-dmips-mhz from DT")
Signed-off-by: Prashanth Prakash <pprakash@codeaurora.org>
---
 arch/arm64/kernel/topology.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 23e9e13..701f7a7 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -11,6 +11,7 @@
  * for more details.
  */
 
+#include <linux/acpi.h>
 #include <linux/cpu.h>
 #include <linux/cpumask.h>
 #include <linux/init.h>
@@ -209,7 +210,12 @@ static void normalize_cpu_capacity(void)
 
 static int __init register_cpufreq_notifier(void)
 {
-	if (cap_parsing_failed)
+	/*
+	 * on ACPI-based systems we need to use the default cpu capacity
+	 * until we have the necessary code to parse the cpu capacity, so
+	 * skip registering cpufreq notifier.
+	 */
+	if (!acpi_disabled || cap_parsing_failed)
 		return -EINVAL;
 
 	if (!alloc_cpumask_var(&cpus_to_visit, GFP_KERNEL)) {
-- 
Qualcomm Datacenter Technologies on behalf of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
