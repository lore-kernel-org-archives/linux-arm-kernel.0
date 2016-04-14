From: t-kristo@ti.com (Tero Kristo)
Date: Thu, 14 Apr 2016 14:08:10 +0300
Subject: [PATCHv2 21/28] clk: ti: am33xx: fix timer3/6 init time setup for
 module clocks
In-Reply-To: <1460632097-25727-1-git-send-email-t-kristo@ti.com>
References: <1460632097-25727-1-git-send-email-t-kristo@ti.com>
Message-ID: <1460632097-25727-22-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

timer*_fck are going to be renamed as timer*_mod_ck:s. Fix the init
time configuration of timer3/timer6 to take this into account, and
lookup for the module clock in case the lookup for fck fails.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/ti/clk-33xx.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/ti/clk-33xx.c b/drivers/clk/ti/clk-33xx.c
index 43847bc..2343a22 100644
--- a/drivers/clk/ti/clk-33xx.c
+++ b/drivers/clk/ti/clk-33xx.c
@@ -66,9 +66,15 @@ int __init am33xx_dt_clk_init(void)
 
 	clk1 = ti_clk_get("sys_clkin_ck");
 	clk2 = ti_clk_get("timer3_fck");
+	if (IS_ERR(clk2))
+		clk2 = ti_clk_get("timer3_mod_ck");
+
 	clk_set_parent(clk2, clk1);
 
 	clk2 = ti_clk_get("timer6_fck");
+	if (IS_ERR(clk2))
+		clk2 = ti_clk_get("timer6_mod_ck");
+
 	clk_set_parent(clk2, clk1);
 	/*
 	 * The On-Chip 32K RC Osc clock is not an accurate clock-source as per
-- 
1.7.9.5
