From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Thu, 17 Mar 2011 12:55:56 -0300
Subject: [PATCH v2 1/4] ARM: mx5/babbage: Use gpio_request_one in
	babbage_fec_reset
Message-ID: <1300377359-23212-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current code inside babbage_fec_reset uses gpio_direction_output with initial value of the GPIO and also sets 
the GPIO value via gpio_set_value to the same level right after. This is not needed. 

By using gpio_request_one it is possible to set the direction and initial value in one shot.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
Acked-by: Uwe Kleine-K??nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx5/board-mx51_babbage.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
index b2ecd19..ff79395 100644
--- a/arch/arm/mach-mx5/board-mx51_babbage.c
+++ b/arch/arm/mach-mx5/board-mx51_babbage.c
@@ -228,13 +228,12 @@ static inline void babbage_fec_reset(void)
 	int ret;
 
 	/* reset FEC PHY */
-	ret = gpio_request(BABBAGE_FEC_PHY_RESET, "fec-phy-reset");
+	ret = gpio_request_one(BABBAGE_FEC_PHY_RESET,
+					GPIOF_OUT_INIT_LOW, "fec-phy-reset");
 	if (ret) {
 		printk(KERN_ERR"failed to get GPIO_FEC_PHY_RESET: %d\n", ret);
 		return;
 	}
-	gpio_direction_output(BABBAGE_FEC_PHY_RESET, 0);
-	gpio_set_value(BABBAGE_FEC_PHY_RESET, 0);
 	msleep(1);
 	gpio_set_value(BABBAGE_FEC_PHY_RESET, 1);
 }
-- 
1.6.0.4
