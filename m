From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 28 Mar 2017 13:19:37 +0200
Subject: [PATCH v2 10/11] ARM: at91: pm: Remove at91_pm_set_standby
In-Reply-To: <20170328111938.21297-1-alexandre.belloni@free-electrons.com>
References: <20170328111938.21297-1-alexandre.belloni@free-electrons.com>
Message-ID: <20170328111938.21297-11-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Merge at91_pm_set_standby() in at91_dt_ramc as this is the only callsite.
That moves it to the init section.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/pm.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index dedfe9038336..2cd27c830ab6 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -205,12 +205,6 @@ static struct platform_device at91_cpuidle_device = {
 	.name = "cpuidle-at91",
 };
 
-static void at91_pm_set_standby(void (*at91_standby)(void))
-{
-	if (at91_standby)
-		at91_cpuidle_device.dev.platform_data = at91_standby;
-}
-
 /*
  * The AT91RM9200 goes into self-refresh mode with this command, and will
  * terminate self-refresh automatically on the next SDRAM access.
@@ -354,7 +348,7 @@ static __init void at91_dt_ramc(void)
 	struct device_node *np;
 	const struct of_device_id *of_id;
 	int idx = 0;
-	const void *standby = NULL;
+	void *standby = NULL;
 	const struct ramc_info *ramc;
 
 	for_each_matching_node_and_match(np, ramc_ids, &of_id) {
@@ -378,7 +372,7 @@ static __init void at91_dt_ramc(void)
 		return;
 	}
 
-	at91_pm_set_standby(standby);
+	at91_cpuidle_device.dev.platform_data = standby;
 }
 
 static void at91rm9200_idle(void)
-- 
2.11.0
