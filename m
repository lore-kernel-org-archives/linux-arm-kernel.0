From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 26 Aug 2011 09:00:39 +0900
Subject: [PATCH] ARM: EXYNOS4: Fix routing timer interrupt to offline CPU
Message-ID: <1314316839-1242-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The commit 5dfc54e087c15f823ee9b6541d2f0f314e69cbed
("ARM: GIC: avoid routing interrupts to offline CPUs")
prevents routing interrupts to offline CPUs. But in
case of timer on EXYNOS4, the irq_set_affinity() method
is called in percpu_timer_setup() before CPU1 becomes
online. So this patch fixes routing timer interrupt to
offline CPU.

Reported-by: Changhwan Youn <chaos.youn@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
Hi Russell and all,

I'm not sure it's safe to call set_cpu_online() here...

 arch/arm/mach-exynos4/platsmp.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos4/platsmp.c b/arch/arm/mach-exynos4/platsmp.c
index 96cc651..a3346e3 100644
--- a/arch/arm/mach-exynos4/platsmp.c
+++ b/arch/arm/mach-exynos4/platsmp.c
@@ -109,6 +109,8 @@ void __cpuinit platform_secondary_init(unsigned int cpu)
 	 */
 	spin_lock(&boot_lock);
 	spin_unlock(&boot_lock);
+
+	set_cpu_online(cpu, true);
 }
 
 int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
-- 
1.7.1
