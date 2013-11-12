From: acourbot@nvidia.com (Alexandre Courbot)
Date: Tue, 12 Nov 2013 15:36:26 +0900
Subject: [PATCH] ARM: tegra: init fuse before setting reset handler
Message-ID: <1384238186-8473-1-git-send-email-acourbot@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CPU reset handler was set before fuse is initialized, but
tegra_cpu_reset_handler_enable() uses tegra_chip_id, which is set by
tegra_init_fuse(). This patch reorders the calls so the CPU reset
handler code does not read an uninitialized variable.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 arch/arm/mach-tegra/tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
index 80b801a94677..0fbdadcd96b7 100644
--- a/arch/arm/mach-tegra/tegra.c
+++ b/arch/arm/mach-tegra/tegra.c
@@ -92,9 +92,9 @@ static void __init tegra_init_cache(void)
 
 static void __init tegra_init_early(void)
 {
-	tegra_cpu_reset_handler_init();
 	tegra_apb_io_init();
 	tegra_init_fuse();
+	tegra_cpu_reset_handler_init();
 	tegra_init_cache();
 	tegra_powergate_init();
 	tegra_hotplug_init();
-- 
1.8.4.2
