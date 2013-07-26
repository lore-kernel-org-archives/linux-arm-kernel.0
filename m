From: vijay.kilari@gmail.com (vijay.kilari at gmail.com)
Date: Fri, 26 Jul 2013 11:11:27 +0530
Subject: [PATCH] ARM: kexec: offline non panic CPUs on Kdump panic
Message-ID: <1374817287-27952-1-git-send-email-vijay.kilari@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vijaya Kumar K <Vijaya.Kumar@caviumnetworks.com>

In case of normal kexec kernel load, all cpu's are offlined
before calling machine_kexec() under kernel_kexec() function.
But in case crash panic cpus are relaxed in
machine_crash_nonpanic_core() SMP function but not offlined.

When crash kernel is loaded with kexec and on panic trigger
machine_kexec() checks for number of cpus online.
If more than one cpu is online machine_kexec() fails to load
with below error

kexec: error: multiple CPUs still online

In machine_crash_nonpanic_core() SMP function, offline CPU
before cpu_relax

Signed-off-by: Vijaya Kumar K <Vijaya.Kumar@caviumnetworks.com>
---
 arch/arm/kernel/machine_kexec.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
index 4fb074c..163b160 100644
--- a/arch/arm/kernel/machine_kexec.c
+++ b/arch/arm/kernel/machine_kexec.c
@@ -73,6 +73,7 @@ void machine_crash_nonpanic_core(void *unused)
 	crash_save_cpu(&regs, smp_processor_id());
 	flush_cache_all();
 
+	set_cpu_online(smp_processor_id(), false);
 	atomic_dec(&waiting_for_crash_ipi);
 	while (1)
 		cpu_relax();
-- 
1.7.9.5
