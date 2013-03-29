From: hvaibhav@ti.com (Vaibhav Hiremath)
Date: Fri, 29 Mar 2013 22:40:17 +0530
Subject: [PATCH 2/2] ARM: OMAP2+: am335x: Change the wdt1 func clk src to
 per_32k clk
In-Reply-To: <1364577017-22562-1-git-send-email-hvaibhav@ti.com>
References: <1364577017-22562-1-git-send-email-hvaibhav@ti.com>
Message-ID: <1364577017-22562-3-git-send-email-hvaibhav@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

WDT1 module can take one of the below clocks as input functional
clock -
     - On-Chip 32K RC Osc [default/reset]
     - 32K from PRCM

The On-Chip 32K RC Osc clock is not an accurate clock-source as per
the design/spec, so as a result, for example, timer which supposed
to get expired @60Sec, but will expire somewhere ~@40Sec, which is
not expected by any use-case.

The solution here is to switch the input clock-source to PRCM
generated 32K clock-source during boot-time itself.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Benoit Cousson <benoit.cousson@linaro.org>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/cclock33xx_data.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/cclock33xx_data.c b/arch/arm/mach-omap2/cclock33xx_data.c
index 8327721..11e07b1 100644
--- a/arch/arm/mach-omap2/cclock33xx_data.c
+++ b/arch/arm/mach-omap2/cclock33xx_data.c
@@ -978,6 +978,14 @@ int __init am33xx_clk_init(void)
 
 	clk_set_parent(&timer3_fck, &sys_clkin_ck);
 	clk_set_parent(&timer6_fck, &sys_clkin_ck);
+	/*
+	 * The On-Chip 32K RC Osc clock is not an accurate clock-source as per
+	 * the design/spec, so as a result, for example, timer which supposed
+	 * to get expired @60Sec, but will expire somewhere ~@40Sec, which is
+	 * not expected by any use-case, so change WDT1 clock source to PRCM
+	 * 32KHz clock.
+	 */
+	clk_set_parent(&wdt1_fck, &clkdiv32k_ick);
 
 	return 0;
 }
-- 
1.7.0.4
