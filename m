From: rnayak@ti.com (Rajendra Nayak)
Date: Thu, 9 Jun 2011 16:24:10 +0530
Subject: [PATCH 5/8] OMAP4: PM: TEMP: Prevent l3init from idling/force sleep
In-Reply-To: <1307616853-28395-5-git-send-email-rnayak@ti.com>
References: <1307616853-28395-1-git-send-email-rnayak@ti.com>
	<1307616853-28395-2-git-send-email-rnayak@ti.com>
	<1307616853-28395-3-git-send-email-rnayak@ti.com>
	<1307616853-28395-4-git-send-email-rnayak@ti.com>
	<1307616853-28395-5-git-send-email-rnayak@ti.com>
Message-ID: <1307616853-28395-6-git-send-email-rnayak@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since MMC driver is yet to be adapted to
runtime PM and still uses direct clock
calls to enable/disable module, its needed
that the clockdomain (for MMC) is always kept force
enabled since the next few patches move
the clockdomain handling from clock framework
to hwmod framework and break MMC.

This will certainlly gate any CORE low power
transitions.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clockdomains44xx_data.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomains44xx_data.c b/arch/arm/mach-omap2/clockdomains44xx_data.c
index a607ec1..ff38764 100644
--- a/arch/arm/mach-omap2/clockdomains44xx_data.c
+++ b/arch/arm/mach-omap2/clockdomains44xx_data.c
@@ -493,7 +493,7 @@ static struct clockdomain l3_init_44xx_clkdm = {
 	.dep_bit	  = OMAP4430_L3INIT_STATDEP_SHIFT,
 	.wkdep_srcs	  = l3_init_wkup_sleep_deps,
 	.sleepdep_srcs	  = l3_init_wkup_sleep_deps,
-	.flags		  = CLKDM_CAN_HWSUP_SWSUP,
+	.flags		  = CLKDM_CAN_FORCE_WAKEUP,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
-- 
1.7.0.4
