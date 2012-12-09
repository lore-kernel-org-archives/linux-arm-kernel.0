From: paul@pwsan.com (Paul Walmsley)
Date: Sun, 09 Dec 2012 13:03:33 -0700
Subject: [PATCH 12/12] ARM: OMAP2xxx: PM: add pwrdm_(pre|post)_transition()
 calls to the 2xxx PM code
In-Reply-To: <20121209200108.3196.12452.stgit@dusk.lan>
References: <20121209200108.3196.12452.stgit@dusk.lan>
Message-ID: <20121209200331.3196.9787.stgit@dusk.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The OMAP2xxx PM code was missing calls to pwrdm_pre_transition() and
pwrdm_post_transition().  This prevented the power state debugging
from working correctly, and also violated some assumptions that are
used in future power state caching patches.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm24xx.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index 99c16c2..896727c 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -98,6 +98,8 @@ static int omap2_enter_full_retention(void)
 
 	omap2_gpio_prepare_for_idle(0);
 
+	pwrdm_pre_transition(NULL);
+
 	/* One last check for pending IRQs to avoid extra latency due
 	 * to sleeping unnecessarily. */
 	if (omap_irq_pending())
@@ -109,6 +111,8 @@ static int omap2_enter_full_retention(void)
 			   OMAP_SDRC_REGADDR(SDRC_POWER));
 
 no_sleep:
+	pwrdm_post_transition(NULL);
+
 	omap2_gpio_resume_after_idle();
 
 	clk_enable(osc_ck);
@@ -191,8 +195,12 @@ static void omap2_enter_mpu_retention(void)
 		WARN_ON(pwrdm_set_next_fpwrst(mpu_pwrdm, PWRDM_FUNC_PWRST_ON));
 	}
 
+	pwrdm_pre_transition(mpu_pwrdm);
+
 	omap2_sram_idle();
 
+	pwrdm_post_transition(mpu_pwrdm);
+
 	WARN_ON(pwrdm_set_next_fpwrst(mpu_pwrdm, PWRDM_FUNC_PWRST_ON));
 }
 
