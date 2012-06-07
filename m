From: jon-hunter@ti.com (Jon Hunter)
Date: Thu, 7 Jun 2012 16:22:10 -0500
Subject: [PATCH V2 08/10] ARM: OMAP4: Prevent EMU power domain transitioning
 to OFF when in-use
In-Reply-To: <1339104132-26885-1-git-send-email-jon-hunter@ti.com>
References: <1339104132-26885-1-git-send-email-jon-hunter@ti.com>
Message-ID: <1339104132-26885-9-git-send-email-jon-hunter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the OMAP4 devices the EMU power domain is configured in hardware so that its
next power state is OFF. This cannot be overriden by software and this means
that when ever the EMU clock domain automatically transitions to the idle
state, the power domain will transition to OFF. Therefore, when the EMU power
domain is in-use, we need to prevent the clock domain from transitioning to
the idle state. This can be accomplished by placing the EMU clock domain in the
SW_WKUP mode versus the HW_AUTO mode.

In the current software configuration of the EMU clock domain the flag
CLKDM_CAN_ENABLE_AUTO is set and this is allowing the clock domain to
automatically transition to the idle state via hardware control (by enabling
the HW_AUTO mode). To avoid this, disable the CLKDM_CAN_ENABLE_AUTO flag for
the EMU clock domain.

By removing the CLKDM_CAN_ENABLE_AUTO flag, the EMU clock domain will always
remain on and hence, this will break low-power modes. The EMU clock domain only
support the SW_WKUP and HW_AUTO transition modes (for more details refer to the
OMAP4430 TRM) and power down the EMU power domain we need to place the EMU
clock domain back into the HW_AUTO mode. This can be accomplished by setting
the CLKDM_CAN_FORCE_SLEEP flag, which for an OMAP4 device will enable the
HW_AUTO mode.

Therefore, set the CLKDM_CAN_SWSUP flag for the EMU clock domain, which defined
as follows.

Cc: Ming Lei <ming.lei@canonical.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/clockdomains44xx_data.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/clockdomains44xx_data.c b/arch/arm/mach-omap2/clockdomains44xx_data.c
index c534258..ba74006 100644
--- a/arch/arm/mach-omap2/clockdomains44xx_data.c
+++ b/arch/arm/mach-omap2/clockdomains44xx_data.c
@@ -390,7 +390,7 @@ static struct clockdomain emu_sys_44xx_clkdm = {
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
 	.cm_inst	  = OMAP4430_PRM_EMU_CM_INST,
 	.clkdm_offs	  = OMAP4430_PRM_EMU_CM_EMU_CDOFFS,
-	.flags		  = CLKDM_CAN_ENABLE_AUTO | CLKDM_CAN_FORCE_WAKEUP,
+	.flags		  = CLKDM_CAN_SWSUP,
 };
 
 static struct clockdomain l3_dma_44xx_clkdm = {
-- 
1.7.9.5
