From: m.grzeschik@pengutronix.de (Michael Grzeschik)
Date: Mon, 16 Aug 2010 15:14:31 +0200
Subject: [PATCH 2/4] clock-imx35: fix divider if ahb is source for ipg_per
In-Reply-To: <1281964473-27484-1-git-send-email-m.grzeschik@pengutronix.de>
References: <1281964473-27484-1-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <1281964473-27484-3-git-send-email-m.grzeschik@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the Datasheet:
"i.MX35 (MCIMX35) Multimedia Applications Processor Reference Manual,
Rev. 2" "Table 14-6. PDR0 Field Descriptions" the divider is
CCM_PER_AHB[3:0] + 1.

This patch adds the missing + 1.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 arch/arm/mach-mx3/clock-imx35.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx3/clock-imx35.c b/arch/arm/mach-mx3/clock-imx35.c
index 4b10f46..f54a82c 100644
--- a/arch/arm/mach-mx3/clock-imx35.c
+++ b/arch/arm/mach-mx3/clock-imx35.c
@@ -296,7 +296,7 @@ static unsigned long get_rate_ipg_per(struct clk *clk)
 		return get_rate_arm() / get_3_3_div(pdr4 >> 16);
 	} else {
 		div1 = (pdr0 >> 12) & 0x7;
-		return get_rate_ahb(NULL) / div1;
+		return get_rate_ahb(NULL) / (div1 + 1);
 	}
 }
 
-- 
1.7.1
