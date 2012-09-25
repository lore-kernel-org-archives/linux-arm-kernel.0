From: t-kristo@ti.com (Tero Kristo)
Date: Tue, 25 Sep 2012 19:33:47 +0300
Subject: [PATCHv7 15/21] ARM: OMAP4: vc: fix channel configuration
In-Reply-To: <1348590833-12335-1-git-send-email-t-kristo@ti.com>
References: <1348590833-12335-1-git-send-email-t-kristo@ti.com>
Message-ID: <1348590833-12335-16-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

RACEN bit should only be set if the voltage and command register addresses
are the same.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/vc.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
index 2ca00bc..a63c53a 100644
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -695,9 +695,12 @@ void __init omap_vc_init_channel(struct voltagedomain *voltdm)
 		voltdm->rmw(vc->smps_cmdra_mask,
 			    vc->cmd_reg_addr << __ffs(vc->smps_cmdra_mask),
 			    vc->smps_cmdra_reg);
-		vc->cfg_channel |= vc_cfg_bits->rac | vc_cfg_bits->racen;
+		vc->cfg_channel |= vc_cfg_bits->rac;
 	}
 
+	if (vc->cmd_reg_addr == vc->volt_reg_addr)
+		vc->cfg_channel |= vc_cfg_bits->racen;
+
 	/* Set up the on, inactive, retention and off voltage */
 	on_vsel = omap_vc_calc_vsel(voltdm, voltdm->vc_param->on);
 	onlp_vsel = omap_vc_calc_vsel(voltdm, voltdm->vc_param->onlp);
-- 
1.7.4.1
