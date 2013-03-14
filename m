From: gang.chen@asianux.com (Chen Gang)
Date: Thu, 14 Mar 2013 12:21:28 +0800
Subject: [PATCH] ARM:OMAP2: an issue about curr_pwrst, u8 is never < 0
Message-ID: <51415048.6000607@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


  if pwrdm_read_pwrst returns negative number, curr_pwrst can not notice it.
  since really need check curr_pwrst whether is negative,
    need let the check valid in _pwrdm_save_clkdm_state_and_activate.
    and also better to check the return value of pwrdm_read_pwrst, firstly.

Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/arm/mach-omap2/powerdomain.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 43ac20c..876d067 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -233,7 +233,7 @@ static u8 _pwrdm_save_clkdm_state_and_activate(struct powerdomain *pwrdm,
 {
 	u8 sleep_switch;
 
-	if (curr_pwrst < 0) {
+	if ((char)curr_pwrst < 0) {
 		WARN_ON(1);
 		sleep_switch = ERROR_SWITCH;
 	} else if (curr_pwrst < PWRDM_POWER_ON) {
@@ -1106,7 +1106,10 @@ int omap_set_pwrdm_state(struct powerdomain *pwrdm, u8 pwrst)
 
 	pwrdm_lock(pwrdm);
 
-	curr_pwrst = pwrdm_read_pwrst(pwrdm);
+	ret = pwrdm_read_pwrst(pwrdm);
+	if (ret < 0)
+		goto osps_out;
+	curr_pwrst = (u8)(unsigned int)ret;
 	next_pwrst = pwrdm_read_next_pwrst(pwrdm);
 	if (curr_pwrst == pwrst && next_pwrst == pwrst)
 		goto osps_out;
-- 
1.7.7.6
