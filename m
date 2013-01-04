From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 4 Jan 2013 11:09:22 +0100
Subject: [PATCH v2 1/2] ARM: OMAP4: clock data: Lock ABE DPLL on all revisions
In-Reply-To: <1357294163-4317-1-git-send-email-peter.ujfalusi@ti.com>
References: <1357294163-4317-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1357294163-4317-2-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To avoid issues with audio caused by non locked ABE DPLL we should
make sure it is locked in all OMAP4 revisions.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

asda d
---
 arch/arm/mach-omap2/cclock44xx_data.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/cclock44xx_data.c b/arch/arm/mach-omap2/cclock44xx_data.c
index 5789a5e..a2cc046 100644
--- a/arch/arm/mach-omap2/cclock44xx_data.c
+++ b/arch/arm/mach-omap2/cclock44xx_data.c
@@ -2026,14 +2026,13 @@ int __init omap4xxx_clk_init(void)
 	 * On OMAP4460 the ABE DPLL fails to turn on if in idle low-power
 	 * state when turning the ABE clock domain. Workaround this by
 	 * locking the ABE DPLL on boot.
+	 * Lock the ABE DPLL in any case to avoid issues with audio.
 	 */
-	if (cpu_is_omap446x()) {
-		rc = clk_set_parent(&abe_dpll_refclk_mux_ck, &sys_32k_ck);
-		if (!rc)
-			rc = clk_set_rate(&dpll_abe_ck, OMAP4_DPLL_ABE_DEFFREQ);
-		if (rc)
-			pr_err("%s: failed to configure ABE DPLL!\n", __func__);
-	}
+	rc = clk_set_parent(&abe_dpll_refclk_mux_ck, &sys_32k_ck);
+	if (!rc)
+		rc = clk_set_rate(&dpll_abe_ck, OMAP4_DPLL_ABE_DEFFREQ);
+	if (rc)
+		pr_err("%s: failed to configure ABE DPLL!\n", __func__);
 
 	return 0;
 }
-- 
1.8.0.2
