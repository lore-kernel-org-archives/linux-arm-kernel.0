From: mpa@pengutronix.de (Markus Pargmann)
Date: Fri, 29 Mar 2013 16:20:09 +0100
Subject: [PATCH v2 1/2] ARM: clk-imx35: Bugfix iomux clock
In-Reply-To: <1364570410-32755-1-git-send-email-mpa@pengutronix.de>
References: <1364570410-32755-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1364570410-32755-2-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables iomuxc_gate clock. It is necessary to be able to
reconfigure iomux pads. Without this clock enabled, the
clk_disable_unused function will disable this clock and the iomux pads
are not configurable anymore. This happens at every boot. After a reboot
(watchdog system reset) the clock is not enabled again, so all iomux pad
reconfigurations in boot code are without effect.

The iomux pads should be always configurable, so this patch always
enables it.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
Cc: stable at vger.kernel.org
---
 arch/arm/mach-imx/clk-imx35.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/clk-imx35.c b/arch/arm/mach-imx/clk-imx35.c
index e13a8fa..b95898a 100644
--- a/arch/arm/mach-imx/clk-imx35.c
+++ b/arch/arm/mach-imx/clk-imx35.c
@@ -265,6 +265,7 @@ int __init mx35_clocks_init(void)
 	clk_prepare_enable(clk[iim_gate]);
 	clk_prepare_enable(clk[emi_gate]);
 	clk_prepare_enable(clk[max_gate]);
+	clk_prepare_enable(clk[iomuxc_gate]);
 
 	/*
 	 * SCC is needed to boot via mmc after a watchdog reset. The clock code
-- 
1.8.2.rc2
