From: s-anna@ti.com (Suman Anna)
Date: Tue, 5 Apr 2016 16:44:12 -0500
Subject: [PATCH 4/4] ARM: DRA7: clockdomain: Implement timer workaround for
 errata i874
In-Reply-To: <1459892652-47845-1-git-send-email-s-anna@ti.com>
References: <1459892652-47845-1-git-send-email-s-anna@ti.com>
Message-ID: <1459892652-47845-5-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Keerthy <j-keerthy@ti.com>

Errata Title:
i874: TIMER5/6/7/8 interrupts not propagated

Description:
When TIMER5, TIMER6, TIMER7, or TIMER8 clocks are enabled
(CM_IPU_TIMER5/6/7/8_CLKCTRL[0:1]MODULEMODE=0x2:ENABLE) and the CD-IPU
is in HW_AUTO mode (CM_IPU_CLKSTCTRL[0:1]CLKTRCTRL=0x3:HW_AUTO) the
corresponding TIMER will continue counting, but enabled interrupts
will not be propagated to the destinations (MPU, DSP, etc) in the
SoC until the TIMER registers are accessed from the CPUs (MPU, DSP
etc.). This can result in missed timer interrupts.

Workaround:
In order for TIMER5/6/7/8 interrupts to be propagated and serviced
correctly the CD_IPU domain should be set to SW_WKUP mode
(CM_IPU_CLKSTCTRL[0:1]CLKTRCTRL=0x2:SW_WKUP).

The above workaround is achieved by switching the IPU clockdomain
flags from HWSUP_SWSUP to SWSUP only.

Signed-off-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/mach-omap2/clockdomains7xx_data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/clockdomains7xx_data.c b/arch/arm/mach-omap2/clockdomains7xx_data.c
index 7581e036bda6..ef9ed36e8a61 100644
--- a/arch/arm/mach-omap2/clockdomains7xx_data.c
+++ b/arch/arm/mach-omap2/clockdomains7xx_data.c
@@ -461,7 +461,7 @@ static struct clockdomain ipu_7xx_clkdm = {
 	.cm_inst	  = DRA7XX_CM_CORE_AON_IPU_INST,
 	.clkdm_offs	  = DRA7XX_CM_CORE_AON_IPU_IPU_CDOFFS,
 	.dep_bit	  = DRA7XX_IPU_STATDEP_SHIFT,
-	.flags		  = CLKDM_CAN_HWSUP_SWSUP,
+	.flags		  = CLKDM_CAN_SWSUP,
 };
 
 static struct clockdomain mpu1_7xx_clkdm = {
-- 
2.7.4
