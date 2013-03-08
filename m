From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  8 Mar 2013 09:20:18 +0100
Subject: [PATCH 2/4] clocksource: sh_tmu: Set initcall level to subsys
In-Reply-To: <1362730820-25417-1-git-send-email-horms+renesas@verge.net.au>
References: <1362730820-25417-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1362730820-25417-3-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The reason for this is to ensure that TMU is probed earlier
than with its previous initcall level, module init.

This came up as a problem with using CMT as a clock source kzm9g-reference
which does not make use of early timers or devices. In that scenario
initialisation of SDHI and MMCIF both stall on msleep() calls due to the
absence of a initialised clock source.

The purpose of this change is to keep the TMU code in sync with the CMT code
which has been modified in a similar manner..

Boot tested on: mackerel.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/clocksource/sh_tmu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/sh_tmu.c b/drivers/clocksource/sh_tmu.c
index b4502edc..78b8dae 100644
--- a/drivers/clocksource/sh_tmu.c
+++ b/drivers/clocksource/sh_tmu.c
@@ -549,7 +549,7 @@ static void __exit sh_tmu_exit(void)
 }
 
 early_platform_init("earlytimer", &sh_tmu_device_driver);
-module_init(sh_tmu_init);
+subsys_initcall(sh_tmu_init);
 module_exit(sh_tmu_exit);
 
 MODULE_AUTHOR("Magnus Damm");
-- 
1.7.10.4
