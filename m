From: l.majewski@samsung.com (Lukasz Majewski)
Date: Thu, 15 May 2014 13:34:06 +0200
Subject: [PATCH] FIX:cache:exynos: Execute the cache reconfiguration
 unconditionally for Exynos4
Message-ID: <1400153646-827-1-git-send-email-l.majewski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The commit 2bf73dd61a84cdf27e49f48e08739af6ba70ace1 has made the cache
configuration depending on definition of CONFIG_S5P_SLEEP Kconfig flag.
It is enabled on various S5PV210 incarnations and not available at Exynos4
family of SoCs.

The problem emerges when one wants to disable/enable core via hotplug - e.g:
echo 0 > /sys/devices/system/cpu/cpu1/online.
When CONFIG_CPU_IDLE is enabled (it is not enabled at default exynos_defconfig).

On Exynos4 based targets (Exynos4412 and Exynos4210, namely trats2 and
trats) board locks up and consumes considerable power.

This patch does nothing more than restoration of the state before the
offending commit.

Tested on top of next-20140514 at Trats board.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
---
 arch/arm/mach-exynos/exynos.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index 1b97b93..5c8b334 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -254,10 +254,9 @@ static int __init exynos4_l2x0_cache_init(void)
 	if (ret)
 		return ret;
 
-	if (IS_ENABLED(CONFIG_S5P_SLEEP)) {
-		l2x0_regs_phys = virt_to_phys(&l2x0_saved_regs);
-		clean_dcache_area(&l2x0_regs_phys, sizeof(unsigned long));
-	}
+	l2x0_regs_phys = virt_to_phys(&l2x0_saved_regs);
+	clean_dcache_area(&l2x0_regs_phys, sizeof(unsigned long));
+
 	return 0;
 }
 early_initcall(exynos4_l2x0_cache_init);
-- 
1.7.10.4
