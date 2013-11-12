From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 12 Nov 2013 13:03:16 -0700
Subject: [PATCH] ARM: tegra: init fuse before setting reset handler
Message-ID: <1384286596-13761-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alexandre Courbot <acourbot@nvidia.com>

CPU reset handler was set before fuse is initialized, but
tegra_cpu_reset_handler_enable() uses tegra_chip_id, which is set by
tegra_init_fuse(). This patch reorders the calls so the CPU reset
handler code does not read an uninitialized variable.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
arm-soc, if you could apply this as a fix for 3.13, that'd be great.
Thanks.

 arch/arm/mach-tegra/tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
index ce553d557c31..73368176c6e8 100644
--- a/arch/arm/mach-tegra/tegra.c
+++ b/arch/arm/mach-tegra/tegra.c
@@ -90,9 +90,9 @@ static void __init tegra_init_cache(void)
 
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
1.8.1.5
