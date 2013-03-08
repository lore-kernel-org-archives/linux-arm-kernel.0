From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  8 Mar 2013 09:20:19 +0100
Subject: [PATCH 3/4] clocksource: em_sti: Set initcall level to subsys
In-Reply-To: <1362730820-25417-1-git-send-email-horms+renesas@verge.net.au>
References: <1362730820-25417-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1362730820-25417-4-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The reason for this is to ensure that STI is probed earlier
than with its previous initcall level, module init.

This came up as a problem with using CMT as a clock source kzm9g-reference
which does not make use of early timers or devices. In that scenario
initialisation of SDHI and MMCIF both stall on msleep() calls due to the
absence of a initialised clock source.

The purpose of this change is to keep the STI code in sync with the CMT code
which has been modified in a similar manner..

Boot tested on: kzm9d.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/clocksource/em_sti.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/em_sti.c b/drivers/clocksource/em_sti.c
index e6a553c..4329a29 100644
--- a/drivers/clocksource/em_sti.c
+++ b/drivers/clocksource/em_sti.c
@@ -399,7 +399,18 @@ static struct platform_driver em_sti_device_driver = {
 	}
 };
 
-module_platform_driver(em_sti_device_driver);
+static int __init em_sti_init(void)
+{
+	return platform_driver_register(&em_sti_device_driver);
+}
+
+static void __exit em_sti_exit(void)
+{
+	platform_driver_unregister(&em_sti_device_driver);
+}
+
+subsys_initcall(em_sti_init);
+module_exit(em_sti_exit);
 
 MODULE_AUTHOR("Magnus Damm");
 MODULE_DESCRIPTION("Renesas Emma Mobile STI Timer Driver");
-- 
1.7.10.4
