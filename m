From: t-kristo@ti.com (Tero Kristo)
Date: Thu, 31 May 2012 16:55:44 +0300
Subject: [PATCHv6 08/14] ARM: OMAP3+: vp: use new vp_params for calculating
 vddmin and vddmax
In-Reply-To: <1338472550-20743-1-git-send-email-t-kristo@ti.com>
References: <1338472550-20743-1-git-send-email-t-kristo@ti.com>
Message-ID: <1338472550-20743-9-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now we select the vddmin and vddmax values based on both pmic and
voltage processor data, this allows usage of different power ICs.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/vp.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/vp.c b/arch/arm/mach-omap2/vp.c
index c585dfb..c9277c3 100644
--- a/arch/arm/mach-omap2/vp.c
+++ b/arch/arm/mach-omap2/vp.c
@@ -58,8 +58,10 @@ void __init omap_vp_init(struct voltagedomain *voltdm)
 	sys_clk_rate = voltdm->sys_clk.rate / 1000;
 
 	timeout = (sys_clk_rate * voltdm->pmic->vp_timeout_us) / 1000;
-	vddmin = voltdm->pmic->uv_to_vsel(voltdm->pmic->vddmin);
-	vddmax = voltdm->pmic->uv_to_vsel(voltdm->pmic->vddmax);
+	vddmin = max(voltdm->vp_param->vddmin, voltdm->pmic->vddmin);
+	vddmax = min(voltdm->vp_param->vddmax, voltdm->pmic->vddmax);
+	vddmin = voltdm->pmic->uv_to_vsel(vddmin);
+	vddmax = voltdm->pmic->uv_to_vsel(vddmax);
 
 	waittime = DIV_ROUND_UP(voltdm->pmic->step_size * sys_clk_rate,
 				1000 * voltdm->pmic->slew_rate);
-- 
1.7.4.1
