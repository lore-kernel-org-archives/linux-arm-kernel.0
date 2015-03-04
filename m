From: arnd@arndb.de (Arnd Bergmann)
Date: Wed,  4 Mar 2015 20:33:05 +0100
Subject: [RFC PATCH 11/18] clocksource: qcom: make mach-msm and mach-qcom
 coexist
In-Reply-To: <1425497592-1831064-1-git-send-email-arnd@arndb.de>
References: <1425497592-1831064-1-git-send-email-arnd@arndb.de>
Message-ID: <1425497592-1831064-12-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver uses #if/#else to decide which initialization code
should be used, which of course breaks if we have both in
the same kernel.

This changes the #else path to check for ARCH_MSM.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/clocksource/qcom-timer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/qcom-timer.c b/drivers/clocksource/qcom-timer.c
index 098c542e5c53..48c8df62f49a 100644
--- a/drivers/clocksource/qcom-timer.c
+++ b/drivers/clocksource/qcom-timer.c
@@ -285,8 +285,9 @@ static void __init msm_dt_timer_init(struct device_node *np)
 }
 CLOCKSOURCE_OF_DECLARE(kpss_timer, "qcom,kpss-timer", msm_dt_timer_init);
 CLOCKSOURCE_OF_DECLARE(scss_timer, "qcom,scss-timer", msm_dt_timer_init);
-#else
+#endif
 
+#ifdef CONFIG_ARCH_MSM
 static int __init msm_timer_map(phys_addr_t addr, u32 event, u32 source,
 				u32 sts)
 {
-- 
2.1.0.rc2
