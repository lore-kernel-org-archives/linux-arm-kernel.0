From: wangyufen@huawei.com (Wang Yufen)
Date: Thu, 1 Nov 2018 19:20:49 +0800
Subject: [PATCH] ARM:kexec:offline panic_smp_self_stop CPU
Message-ID: <1541071249-15660-1-git-send-email-wangyufen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yufen Wang <wangyufen@huawei.com>

In case panic() and panic() called at the same time on different CPUS.
For example:
CPU 0:
  panic()
     __crash_kexec
       machine_crash_shutdown
         crash_smp_send_stop
       machine_kexec
         BUG_ON(num_online_cpus() > 1);

CPU 1:
  panic()
    local_irq_disable
    panic_smp_self_stop

If CPU 1 calls panic_smp_self_stop() before crash_smp_send_stop(), kdump
fails. CPU1 can't receive the ipi irq, CPU1 will be always online.
I changed BUG_ON to WARN in kexec crash as arm64 does, kdump also fails.
Because num_online_cpus() > 1, can't disable the L2 in _soft_restart.
To fix this problem, this patch split out the panic_smp_self_stop()
and add set_cpu_online(smp_processor_id(), false).

Signed-off-by: Yufen Wang <wangyufen@huawei.com>
---
 arch/arm/kernel/setup.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 31940bd..151861f 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -602,6 +602,16 @@ static void __init smp_build_mpidr_hash(void)
 }
 #endif
 
+void panic_smp_self_stop(void)
+{
+	printk(KERN_DEBUG "CPU %u will stop doing anything useful since another CPU has paniced\n",
+			smp_processor_id());
+	set_cpu_online(smp_processor_id(), false);
+	while (1)
+		cpu_relax();
+
+}
+
 static void __init setup_processor(void)
 {
 	struct proc_info_list *list;
-- 
2.7.4
