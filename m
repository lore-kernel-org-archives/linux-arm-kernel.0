From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Thu, 17 Mar 2011 12:55:58 -0300
Subject: [PATCH v2 3/4] ARM: mx5/mx53_evk: Use gpio_request_one in
	mx53_evk_fec_reset
In-Reply-To: <1300377359-23212-2-git-send-email-fabio.estevam@freescale.com>
References: <1300377359-23212-1-git-send-email-fabio.estevam@freescale.com>
	<1300377359-23212-2-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1300377359-23212-3-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current code inside mx53_evk_fec_reset uses gpio_direction_output with initial value of the GPIO and also sets 
the GPIO value via gpio_set_value right after. This is not needed. 

By using gpio_request_one it is possible to set the direction and initial value in one shot.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
Acked-by: Uwe Kleine-K??nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx5/board-mx53_evk.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx53_evk.c b/arch/arm/mach-mx5/board-mx53_evk.c
index 7b5735c..8ca55c0 100644
--- a/arch/arm/mach-mx5/board-mx53_evk.c
+++ b/arch/arm/mach-mx5/board-mx53_evk.c
@@ -82,13 +82,12 @@ static inline void mx53_evk_fec_reset(void)
 	int ret;
 
 	/* reset FEC PHY */
-	ret = gpio_request(SMD_FEC_PHY_RST, "fec-phy-reset");
+	ret = gpio_request_one(SMD_FEC_PHY_RST, GPIOF_OUT_INIT_LOW,
+							"fec-phy-reset");
 	if (ret) {
 		printk(KERN_ERR"failed to get GPIO_FEC_PHY_RESET: %d\n", ret);
 		return;
 	}
-	gpio_direction_output(SMD_FEC_PHY_RST, 0);
-	gpio_set_value(SMD_FEC_PHY_RST, 0);
 	msleep(1);
 	gpio_set_value(SMD_FEC_PHY_RST, 1);
 }
-- 
1.6.0.4
