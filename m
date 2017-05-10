From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 10 May 2017 21:16:12 +0200
Subject: [PATCH v2 3/3] ARM: at91: pm: fallback to slowclock when backup mode
 fails
In-Reply-To: <20170510191612.24364-1-alexandre.belloni@free-electrons.com>
References: <20170510191612.24364-1-alexandre.belloni@free-electrons.com>
Message-ID: <20170510191612.24364-3-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the backup sram allocation fails, ensure we can suspend by falling back
to the usual slow clock mode.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Acked-by: Wenyou Yang <wenyou.yang@atmel.com>
---
 arch/arm/mach-at91/pm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index ef9c1d29cc67..fc4026478579 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -544,6 +544,11 @@ static void __init at91_pm_backup_init(void)
 securam_fail:
 	iounmap(pm_data.sfrbu);
 	pm_data.sfrbu = NULL;
+
+	if (pm_data.standby_mode == AT91_PM_BACKUP)
+		pm_data.standby_mode = AT91_PM_SLOW_CLOCK;
+	if (pm_data.suspend_mode == AT91_PM_BACKUP)
+		pm_data.suspend_mode = AT91_PM_SLOW_CLOCK;
 }
 
 struct pmc_info {
-- 
2.11.0
