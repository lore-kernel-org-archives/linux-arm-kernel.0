From: nikai@nikai.net (Nicolas Kaiser)
Date: Fri, 29 Oct 2010 23:31:09 +0200
Subject: [PATCH] mach-pxa: sharpsl_pm: simplify conditional
Message-ID: <20101029233109.28692cbf@absol.kitzblitz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Simplify: ((a && b) || !a) => (b || !a)

Signed-off-by: Nicolas Kaiser <nikai@nikai.net>
---
 arch/arm/mach-pxa/sharpsl_pm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-pxa/sharpsl_pm.c b/arch/arm/mach-pxa/sharpsl_pm.c
index 8fed027..d08763c 100644
--- a/arch/arm/mach-pxa/sharpsl_pm.c
+++ b/arch/arm/mach-pxa/sharpsl_pm.c
@@ -619,7 +619,7 @@ static void corgi_goto_sleep(unsigned long alarm_time, unsigned int alarm_enable
 	PEDR = 0xffffffff; /* clear it */
 
 	sharpsl_pm.flags &= ~SHARPSL_ALARM_ACTIVE;
-	if ((sharpsl_pm.charge_mode == CHRG_ON) && ((alarm_enable && ((alarm_time - RCNR) > (SHARPSL_BATCHK_TIME_SUSPEND + 30))) || !alarm_enable)) {
+	if ((sharpsl_pm.charge_mode == CHRG_ON) && (((alarm_time - RCNR) > (SHARPSL_BATCHK_TIME_SUSPEND + 30)) || !alarm_enable)) {
 		RTSR &= RTSR_ALE;
 		RTAR = RCNR + SHARPSL_BATCHK_TIME_SUSPEND;
 		dev_dbg(sharpsl_pm.dev, "Charging alarm at: %08x\n", RTAR);
-- 
1.7.2.2
