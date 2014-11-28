From: long.wanglong@huawei.com (Wang Long)
Date: Fri, 28 Nov 2014 02:15:49 +0000
Subject: [PATCH 6/7] ARM: hisi: rename secondary_startup function
In-Reply-To: <1417140950-67103-1-git-send-email-long.wanglong@huawei.com>
References: <1417140950-67103-1-git-send-email-long.wanglong@huawei.com>
Message-ID: <1417140950-67103-7-git-send-email-long.wanglong@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As hix5hd2 and hip01 has the same secondary_startup
so rename hix5hd2_secondary_startup to
to hisi_secondary_startup.

the hip01 will use hisi_secondary_startup for the
secondary core boot.

Signed-off-by: Wang Long <long.wanglong@huawei.com>
---
 arch/arm/mach-hisi/core.h    | 2 +-
 arch/arm/mach-hisi/headsmp.S | 2 +-
 arch/arm/mach-hisi/platsmp.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-hisi/core.h b/arch/arm/mach-hisi/core.h
index 88b1f48..75520b0 100644
--- a/arch/arm/mach-hisi/core.h
+++ b/arch/arm/mach-hisi/core.h
@@ -12,7 +12,7 @@ extern void hi3xxx_cpu_die(unsigned int cpu);
 extern int hi3xxx_cpu_kill(unsigned int cpu);
 extern void hi3xxx_set_cpu(int cpu, bool enable);
 
-extern void hix5hd2_secondary_startup(void);
+extern void hisi_secondary_startup(void);
 extern struct smp_operations hix5hd2_smp_ops;
 extern void hix5hd2_set_cpu(int cpu, bool enable);
 extern void hix5hd2_cpu_die(unsigned int cpu);
diff --git a/arch/arm/mach-hisi/headsmp.S b/arch/arm/mach-hisi/headsmp.S
index 278889c..81e35b1 100644
--- a/arch/arm/mach-hisi/headsmp.S
+++ b/arch/arm/mach-hisi/headsmp.S
@@ -11,6 +11,6 @@
 
 	__CPUINIT
 
-ENTRY(hix5hd2_secondary_startup)
+ENTRY(hisi_secondary_startup)
 	bl	v7_invalidate_l1
 	b	secondary_startup
diff --git a/arch/arm/mach-hisi/platsmp.c b/arch/arm/mach-hisi/platsmp.c
index b3c3a58..4a70f56 100644
--- a/arch/arm/mach-hisi/platsmp.c
+++ b/arch/arm/mach-hisi/platsmp.c
@@ -116,7 +116,7 @@ static int hix5hd2_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	phys_addr_t jumpaddr;
 
-	jumpaddr = virt_to_phys(hix5hd2_secondary_startup);
+	jumpaddr = virt_to_phys(hisi_secondary_startup);
 	hix5hd2_set_scu_boot_addr(HIX5HD2_BOOT_ADDRESS, jumpaddr);
 	hix5hd2_set_cpu(cpu, true);
 	arch_send_wakeup_ipi_mask(cpumask_of(cpu));
-- 
1.8.3.4
