From: omar.luna@linaro.org (Omar Ramirez Luna)
Date: Fri, 15 Jun 2012 20:54:40 -0500
Subject: [PATCH 2/3] ARM: OMAP: hwmod: revise deassert sequence
In-Reply-To: <1339811681-5256-1-git-send-email-omar.luna@linaro.org>
References: <1339811681-5256-1-git-send-email-omar.luna@linaro.org>
Message-ID: <1339811681-5256-3-git-send-email-omar.luna@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For a reset sequence to complete cleanly, a module needs its
associated clocks to be enabled, otherwise the timeout check
in prcm code can print a false failure (failed to hardreset)
that occurs because the clocks aren't powered ON and the status
bit checked can't transition without them.

Signed-off-by: Omar Ramirez Luna <omar.luna@linaro.org>
---
 arch/arm/mach-omap2/omap_hwmod.c |   33 ++++++++++++++++++++++++++++++++-
 1 files changed, 32 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 5f0811a..8a7e5bc 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1472,7 +1472,7 @@ static int _assert_hardreset(struct omap_hwmod *oh, const char *name)
 static int _deassert_hardreset(struct omap_hwmod *oh, const char *name)
 {
 	struct omap_hwmod_rst_info ohri;
-	int ret;
+	int ret, hwsup = 0;
 
 	if (!oh)
 		return -EINVAL;
@@ -1481,6 +1481,23 @@ static int _deassert_hardreset(struct omap_hwmod *oh, const char *name)
 	if (IS_ERR_VALUE(ret))
 		return ret;
 
+	if (oh->clkdm) {
+		/*
+		 * A clockdomain must be in SW_SUP otherwise reset
+		 * might not be completed. The clockdomain can be set
+		 * in HW_AUTO only when the module become ready.
+		 */
+		hwsup = clkdm_in_hwsup(oh->clkdm);
+		ret = clkdm_hwmod_enable(oh->clkdm, oh);
+		if (ret) {
+			WARN(1, "omap_hwmod: %s: could not enable clockdomain %s: %d\n",
+			     oh->name, oh->clkdm->name, ret);
+			return ret;
+		}
+	}
+
+	_enable_clocks(oh);
+
 	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
 		ret = omap2_prm_deassert_hardreset(oh->prcm.omap2.module_offs,
 						   ohri.rst_shift,
@@ -1497,9 +1514,23 @@ static int _deassert_hardreset(struct omap_hwmod *oh, const char *name)
 		return -EINVAL;
 	}
 
+	_disable_clocks(oh);
+
 	if (ret == -EBUSY)
 		pr_warning("omap_hwmod: %s: failed to hardreset\n", oh->name);
 
+	if (!ret) {
+		/*
+		 * Set the clockdomain to HW_AUTO, assuming that the
+		 * previous state was HW_AUTO.
+		 */
+		if (oh->clkdm && hwsup)
+			clkdm_allow_idle(oh->clkdm);
+	} else {
+		if (oh->clkdm)
+			clkdm_hwmod_disable(oh->clkdm, oh);
+	}
+
 	return ret;
 }
 
-- 
1.7.4.1
