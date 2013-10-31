From: joelf@ti.com (Joel Fernandes)
Date: Thu, 31 Oct 2013 18:44:59 -0500
Subject: [RFC] ARM: OMAP: DRA7xx: Make L4SEC clock domain SWSUP only
Message-ID: <1383263099-3315-1-git-send-email-joelf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using HWSUP for l4sec clock domain is causing warnings in HWMOD code for DRA7.
Based on some observations, once the clock domain goes into an IDLE state
(because of no activity etc), the IDLEST for the module goes to '0x2' value
which means Interface IDLE condition. So far so go, however once the MODULEMODE
is set to disabled for the particular IP, the IDLEST for the module should go
to '0x3', per the HW AUTO IDLE protocol. However this is not observed and there
is no reason per the protocl for the transition to not happen. This could
potentially be a bug in the HW AUTO state-machine.

Work around for this is to use SWSUP only for the particular clockdomain. With
this all the transitions of IDLEST happen correctly and warnings don't occur.

Signed-off-by: Joel Fernandes <joelf@ti.com>
--
 arch/arm/mach-omap2/clockdomains7xx_data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/clockdomains7xx_data.c b/arch/arm/mach-omap2/clockdomains7xx_data.c
index 57d5df0..13bda1b1 100644
--- a/arch/arm/mach-omap2/clockdomains7xx_data.c
+++ b/arch/arm/mach-omap2/clockdomains7xx_data.c
@@ -409,7 +409,7 @@ static struct clockdomain l4sec_7xx_clkdm = {
 	.dep_bit	  = DRA7XX_L4SEC_STATDEP_SHIFT,
 	.wkdep_srcs	  = l4sec_wkup_sleep_deps,
 	.sleepdep_srcs	  = l4sec_wkup_sleep_deps,
-	.flags		  = CLKDM_CAN_HWSUP_SWSUP,
+	.flags		  = CLKDM_CAN_SWSUP,
 };
 
 static struct clockdomain l3main1_7xx_clkdm = {
-- 
1.8.1.2
