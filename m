From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue,  8 Jan 2013 10:33:37 -0700
Subject: [PATCH] ARM: sunxi: fix struct sys_timer removal
Message-ID: <1357666417-8803-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Commit 6bb27d7 "ARM: delete struct sys_timer" removed struct sys_timer,
but didn't update mach-sunxi/sunxi.c for this change, even though the
sunxi timer implementation itself was updated. This caused a build break:

arch/arm/mach-sunxi/sunxi.c:94:2: error: unknown field 'timer' specified in initializer
arch/arm/mach-sunxi/sunxi.c:94:12: error: 'sunxi_timer' undeclared here (not in a function)

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
Ideally, this commit would be squashed into 6bb27d7 in arm-soc's
timer-cleanup branch. However, that would change a few commit IDs, and
I've already pulled that branch into the Tegra and bcm2835 trees. I can
rebase those without issue if we co-ordinate so all the changes go into
the same linux-next version.

However, since sunxi isn't actually enabled in any defconfig until
v3.8-rc2, perhaps it's OK to apply this change as a separate patch on
top of timer-rework, and ignore the bisect issue?

 arch/arm/mach-sunxi/sunxi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
index 9be910f..cba4cd3 100644
--- a/arch/arm/mach-sunxi/sunxi.c
+++ b/arch/arm/mach-sunxi/sunxi.c
@@ -91,6 +91,6 @@ DT_MACHINE_START(SUNXI_DT, "Allwinner A1X (Device Tree)")
 	.init_irq	= sunxi_init_irq,
 	.handle_irq	= sunxi_handle_irq,
 	.restart	= sunxi_restart,
-	.timer		= &sunxi_timer,
+	.init_time	= &sunxi_timer_init,
 	.dt_compat	= sunxi_board_dt_compat,
 MACHINE_END
-- 
1.7.10.4
