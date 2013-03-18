From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 22:02:38 +0900
Subject: [PATCH 12/12] clocksource: sh_mtu2: Set initcall level to subsys
In-Reply-To: <1363611758-6655-1-git-send-email-horms+renesas@verge.net.au>
References: <1363611758-6655-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363611758-6655-13-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The reason for this is to ensure that MTU2 is probed earlier
than with its previous initcall level, module init.

This came up as a problem with using CMT as a clock source kzm9g-reference
which does not make use of early timers or devices. In that scenario
initialisation of SDHI and MMCIF both stall on msleep() calls due to the
absence of a initialised clock source.

The purpose of this change is to keep the MTU2 code in sync with the CMT code
which has been modified in a similar manner..

Compile tested only using se7206_defconfig.
I do not believe I have any boards that support the MTU2.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/clocksource/sh_mtu2.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/sh_mtu2.c b/drivers/clocksource/sh_mtu2.c
index 83943e2..4aac9ee 100644
--- a/drivers/clocksource/sh_mtu2.c
+++ b/drivers/clocksource/sh_mtu2.c
@@ -386,7 +386,7 @@ static void __exit sh_mtu2_exit(void)
 }
 
 early_platform_init("earlytimer", &sh_mtu2_device_driver);
-module_init(sh_mtu2_init);
+subsys_initcall(sh_mtu2_init);
 module_exit(sh_mtu2_exit);
 
 MODULE_AUTHOR("Magnus Damm");
-- 
1.7.10.4
