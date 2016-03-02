From: arnd@arndb.de (Arnd Bergmann)
Date: Wed,  2 Mar 2016 16:58:57 +0100
Subject: [PATCH 05/14] mfd: ipaq-micro: use __maybe_unused to hide pm functions
In-Reply-To: <1456934350-1389172-1-git-send-email-arnd@arndb.de>
References: <1456934350-1389172-1-git-send-email-arnd@arndb.de>
Message-ID: <1456934350-1389172-6-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ipaq-micro driver uses SET_SYSTEM_SLEEP_PM_OPS() to
remove the reference to its resume function, but does
not use an #ifdef around the definition, so we get
a build warning:

drivers/mfd/ipaq-micro.c:379:12: error: 'micro_resume' defined but not used [-Werror=unused-function]

This adds a __maybe_unused annotation so the compiler knows
it can silently drop it instead of warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mfd/ipaq-micro.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/ipaq-micro.c b/drivers/mfd/ipaq-micro.c
index a41859c55bda..df16fd1df68b 100644
--- a/drivers/mfd/ipaq-micro.c
+++ b/drivers/mfd/ipaq-micro.c
@@ -376,7 +376,7 @@ static const struct mfd_cell micro_cells[] = {
 	{ .name = "ipaq-micro-leds", },
 };
 
-static int micro_resume(struct device *dev)
+static int __maybe_unused micro_resume(struct device *dev)
 {
 	struct ipaq_micro *micro = dev_get_drvdata(dev);
 
-- 
2.7.0
