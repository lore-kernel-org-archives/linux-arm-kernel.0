From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 22:02:35 +0900
Subject: [PATCH 09/12] clocksource: sh_cmt: Set initcall level to subsys
In-Reply-To: <1363611758-6655-1-git-send-email-horms+renesas@verge.net.au>
References: <1363611758-6655-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363611758-6655-10-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The reason for this is to ensure that CMT is probed earlier
than with its previous initcall level, module init.

This came up as a problem with using kzm9g-reference which does
not make use of early timers or devices. In that scenario initialisation
of SDHI and MMCIF both stall on msleep() calls due to the absence
of a initialised clock source.

Boot tested on: armadillo800eva, mackerel and kzm9g

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/clocksource/sh_cmt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index b72b724..08d0c41 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -838,7 +838,7 @@ static void __exit sh_cmt_exit(void)
 }
 
 early_platform_init("earlytimer", &sh_cmt_device_driver);
-module_init(sh_cmt_init);
+subsys_initcall(sh_cmt_init);
 module_exit(sh_cmt_exit);
 
 MODULE_AUTHOR("Magnus Damm");
-- 
1.7.10.4
