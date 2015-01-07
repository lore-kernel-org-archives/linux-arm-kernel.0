From: tom.leiming@gmail.com (Ming Lei)
Date: Wed,  7 Jan 2015 11:25:41 +0800
Subject: [PATCH] ARM: EXYNOS: fix booting oops on exynos5440
Message-ID: <1420601141-20566-1-git-send-email-tom.leiming@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is based on previous one(ARM: EXYNOS: enable all
secondary cores for exynos5440) in below link:

	http://marc.info/?l=linux-arm-kernel&m=136299947514599&w=2

Without this patch, the following kernel oops is triggered:

[    0.171477] CPU1: Booted secondary processor
[    0.182685] pgd = c0003000
[    0.185444] [00002084] *pgd=80000080004003, *pmd=00000000
[    0.190917] Internal error: Oops: 206 [#1] PREEMPT SMP ARM
[    0.196468] Modules linked in:
[    0.199596] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.18.0-00005-g3b10a366-dirty #27
[    0.207579] task: eb098000 ti: eb046000 task.ti: eb046000
[    0.213049] PC is at exynos_boot_secondary+0x4c/0x2a0
[    0.218169] LR is at write_pen_release+0x2c/0x70
[    0.222856] pc : [<c00316e0>]    lr : [<c0031618>]    psr: 60000113
[    0.222856] sp : eb047e80  ip : 00000000  fp : eb047ebc
[    0.234486] r10: c07bda8c  r9 : 00000000  r8 : c07bdc78
[    0.239781] r7 : 00002084  r6 : 00000001  r5 : 00000001  r4 : 807bda8c
[    0.246378] r3 : 00002084  r2 : 00002080  r1 : c07664cc  r0 : c076b600
[    0.252976] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
[    0.260354] Control: 30c5387d  Table: 80003000  DAC: fffffffd
[    0.266168] Process swapper/0 (pid: 1, stack limit = 0xeb046238)
[    0.272245] Stack: (0xeb047e80 to 0xeb048000)
[    0.276674] 7e80: eb047eb4 eb047e90 c004fda0 c00576c4 ffffffff 807bda8c 00000000 c07bda6c
[    0.284919] 7ea0: 00000001 eb09ad00 00000000 c07bda8c eb047ee4 eb047ec0 c002775c c00316a0
[    0.293165] 7ec0: 00000001 00000000 00000001 00000000 c0766508 eb09ad00 eb047f14 eb047ee8
[    0.301411] 7ee0: c0034ffc c00276b8 c04c5ef0 00000017 00000001 c0766508 c076650c c07665e8
[    0.309657] 7f00: c0774ef4 c04cd7f8 eb047f2c eb047f18 c00350e4 c0034f34 00000001 00000001
[    0.317903] 7f20: eb047f54 eb047f30 c06fccf8 c0035084 c07595ac 00000000 00000000 00000000
[    0.326149] 7f40: 00000000 00000000 eb047f94 eb047f58 c06eddb0 c06fcc80 c04c7c00 c0054c00
[    0.334395] 7f60: eb047f94 eb047f70 c0054a78 c07bd580 c04bcce4 00000000 00000000 00000000
[    0.342641] 7f80: 00000000 00000000 eb047fac eb047f98 c04bcd00 c06edd40 eb046000 00000000
[    0.350886] 7fa0: 00000000 eb047fb0 c0021808 c04bccf0 00000000 00000000 00000000 00000000
[    0.359133] 7fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    0.367379] 7fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
[    0.375636] [<c00316e0>] (exynos_boot_secondary) from [<c002775c>] (__cpu_up+0xb0/0x160)
[    0.383789] [<c002775c>] (__cpu_up) from [<c0034ffc>] (_cpu_up+0xd4/0x150)
[    0.390731] [<c0034ffc>] (_cpu_up) from [<c00350e4>] (cpu_up+0x6c/0x94)
[    0.397415] [<c00350e4>] (cpu_up) from [<c06fccf8>] (smp_init+0x84/0xb8)
[    0.404186] [<c06fccf8>] (smp_init) from [<c06eddb0>] (kernel_init_freeable+0x7c/0x1d0)
[    0.412258] [<c06eddb0>] (kernel_init_freeable) from [<c04bcd00>] (kernel_init+0x1c/0xfc)
[    0.420504] [<c04bcd00>] (kernel_init) from [<c0021808>] (ret_from_fork+0x14/0x20)
[    0.428141] Code: e5983000 e1a02382 e2827004 e0833007 (e5931000)
[    0.434335] ---[ end trace 1400ecdd391c2ea1 ]---
[    0.438988] Kernel panic - not syncing: Fatal exception
[    0.444286] ---[ end Kernel panic - not syncing: Fatal exception

Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Amit Daniel Kachhap <amit.daniel@samsung.com>
Cc: linux-samsung-soc at vger.kernel.org
Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 arch/arm/mach-exynos/platsmp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index 41ae28d..61cb7a3 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -103,6 +103,8 @@ static inline void __iomem *cpu_boot_reg_base(void)
 {
 	if (soc_is_exynos4210() && samsung_rev() == EXYNOS4210_REV_1_1)
 		return pmu_base_addr + S5P_INFORM5;
+	else if (soc_is_exynos5440())
+		return S5P_VA_CHIPID + 0x560;
 	return sysram_base_addr;
 }
 
@@ -177,7 +179,7 @@ static int exynos_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 */
 	write_pen_release(core_id);
 
-	if (!exynos_cpu_power_state(core_id)) {
+	if (!soc_is_exynos5440() && !exynos_cpu_power_state(core_id)) {
 		exynos_cpu_power_up(core_id);
 		timeout = 10;
 
-- 
1.9.1
