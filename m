From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 26 Apr 2017 18:04:19 +0200
Subject: [PATCH 3/3] ARM: at91: pm: fallback to slowclock when backup mode
 fails
In-Reply-To: <20170426160419.22401-1-alexandre.belloni@free-electrons.com>
References: <20170426160419.22401-1-alexandre.belloni@free-electrons.com>
Message-ID: <20170426160419.22401-3-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the backup sram allocation fails, ensure we can suspend by falling back
to the usual slow clock mode.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/pm.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index d08f032f9d94..02823d8f3ada 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -519,24 +519,30 @@ static void __init at91_pm_bu_sram_init(void)
 
 	if (!pdev) {
 		pr_warn("%s: failed to find securam device!\n", __func__);
-		return;
+		goto fallback;
 	}
 
 	sram_pool = gen_pool_get(&pdev->dev, NULL);
 	if (!sram_pool) {
 		pr_warn("%s: securam pool unavailable!\n", __func__);
-		return;
+		goto fallback;
 	}
 
 	pm_bu = (void *)gen_pool_alloc(sram_pool, sizeof(struct at91_pm_bu));
 	if (!pm_bu) {
 		pr_warn("%s: unable to alloc securam!\n", __func__);
-		return;
+		goto fallback;
 	}
 
 	pm_bu->suspended = 0;
 	pm_bu->canary = virt_to_phys(&canary);
 	pm_bu->resume = virt_to_phys(cpu_resume);
+
+fallback:
+	if (pm_data.standby_mode == AT91_PM_BACKUP)
+		pm_data.standby_mode = AT91_PM_SLOW_CLOCK;
+	if (pm_data.suspend_mode != AT91_PM_BACKUP)
+		pm_data.suspend_mode = AT91_PM_SLOW_CLOCK;
 }
 
 struct pmc_info {
-- 
2.11.0
