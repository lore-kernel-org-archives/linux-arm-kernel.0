From: rnayak@ti.com (Rajendra Nayak)
Date: Thu, 3 Nov 2011 16:24:25 +0530
Subject: [PATCH 3/3] ARM: OMAP: hwmod: Look for hwmod/module level context
	lost count if supported
In-Reply-To: <1320317665-6381-1-git-send-email-rnayak@ti.com>
References: <1320317665-6381-1-git-send-email-rnayak@ti.com>
Message-ID: <1320317665-6381-4-git-send-email-rnayak@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that OMAP4 has hwmod/module level context lost counters, make
omap_hwmod_get_context_loss_count() return them on platforms where they
exist, else fall back on the pwrdm level counters for older platforms.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index ac17748..9d140c4 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2658,9 +2658,14 @@ u32 omap_hwmod_get_context_loss_count(struct omap_hwmod *oh)
 	struct powerdomain *pwrdm;
 	int ret = 0;
 
-	pwrdm = omap_hwmod_get_pwrdm(oh);
-	if (pwrdm)
-		ret = pwrdm_get_context_loss_count(pwrdm);
+	if (oh->prcm.omap4.context_offs) {
+		/* Support for per-hwmod context register */
+		ret = oh->prcm.omap4.context_lost_counter;
+	} else {
+		pwrdm = omap_hwmod_get_pwrdm(oh);
+		if (pwrdm)
+			ret = pwrdm_get_context_loss_count(pwrdm);
+	}
 
 	return ret;
 }
-- 
1.7.1
