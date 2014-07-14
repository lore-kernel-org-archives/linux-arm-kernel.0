From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Mon, 14 Jul 2014 16:43:59 +0200
Subject: [PATCH 1/2] ARM: EXYNOS: Fix build with PM_SLEEP=n part #2
In-Reply-To: <1405349040-5265-1-git-send-email-b.zolnierkie@samsung.com>
References: <1405349040-5265-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <1405349040-5265-2-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix building of exynos_defconfig with disabled CONFIG_PM_SLEEP by
adding checking whether Exynos cpuidle support is enabled before
accessing exynos_enter_aftr.

The build error message:
arch/arm/mach-exynos/built-in.o:(.data+0x74): undefined reference to `exynos_enter_aftr'
make: *** [vmlinux] Error 1

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos/exynos.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index 2a43a17..769cecb 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -171,7 +171,9 @@ static void exynos_restart(enum reboot_mode mode, const char *cmd)
 
 static struct platform_device exynos_cpuidle = {
 	.name              = "exynos_cpuidle",
+#ifdef CONFIG_ARM_EXYNOS_CPUIDLE
 	.dev.platform_data = exynos_enter_aftr,
+#endif
 	.id                = -1,
 };
 
-- 
1.8.2.3
