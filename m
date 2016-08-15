From: peter.chen@nxp.com (Peter Chen)
Date: Mon, 15 Aug 2016 11:37:16 +0800
Subject: [PATCH 1/1] ARM: mach-imx: imx6ul: populates platform device at
 .init_machine
Message-ID: <1471232236-12635-1-git-send-email-peter.chen@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At imx6ul_init_machine, it calls imx6ul_pm_init which needs to find
platform device for ocram, but the default populate platform device is at
of_platform_default_populate_init, which is located at arch_initcall_sync,
and called later than arch_initcall (.init_machine is located at that).
So below warning message will be showed during boots up:

	imx6q_suspend_init: failed to find ocram device!
	imx6_pm_common_init: No DDR LPM support with suspend -19!

Due to lack of ocram device, the suspend mode "mem" which needs ocram to
store suspend routine code is invalid.

This commit populates platform device before imx6ul_pm_init like other
imx6 platforms do, and the suspend mode "mem" can work successfully.

Cc: Anson Huang <anson.huang@nxp.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: <stable@vger.kernel.org>
Fixes: ee4a5f838c84 ("ARM: imx: add suspend/resume support for i.mx6ul")

Signed-off-by: Peter Chen <peter.chen@nxp.com>
---
 arch/arm/mach-imx/mach-imx6ul.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/mach-imx6ul.c b/arch/arm/mach-imx/mach-imx6ul.c
index 5d9bfab..6bb7d9c 100644
--- a/arch/arm/mach-imx/mach-imx6ul.c
+++ b/arch/arm/mach-imx/mach-imx6ul.c
@@ -64,6 +64,7 @@ static void __init imx6ul_init_machine(void)
 	if (parent == NULL)
 		pr_warn("failed to initialize soc device\n");
 
+	of_platform_default_populate(NULL, NULL, parent);
 	imx6ul_enet_init();
 	imx_anatop_init();
 	imx6ul_pm_init();
-- 
1.9.1
