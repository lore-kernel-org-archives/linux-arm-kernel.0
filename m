From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 24 Feb 2010 11:08:07 +0100
Subject: [PATCH 12/39] arm/imx/gpio: GPIO_INT_{HIGH,
	LOW}_LEV are not necessarily constant
In-Reply-To: <20100224100649.GA6456@pengutronix.de>
References: <20100224100649.GA6456@pengutronix.de>
Message-ID: <1267006114-31743-12-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GPIO_INT_LOW_LEV is defined as

	(cpu_is_mx1_mx2() ? 0x3 : 0x0)

so depending on compiler optimisation and enabled SoCs this doesn't
qualify as a constant expression as needed by a switch statement.
Ditto for GPIO_INT_HIGH_LEV.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-mxc/gpio.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-mxc/gpio.c b/arch/arm/plat-mxc/gpio.c
index d65ebe3..3cba1dd 100644
--- a/arch/arm/plat-mxc/gpio.c
+++ b/arch/arm/plat-mxc/gpio.c
@@ -140,16 +140,13 @@ static void mxc_flip_edge(struct mxc_gpio_port *port, u32 gpio)
 	val = __raw_readl(reg);
 	edge = (val >> (bit << 1)) & 3;
 	val &= ~(0x3 << (bit << 1));
-	switch (edge) {
-	case GPIO_INT_HIGH_LEV:
+	if (edge == GPIO_INT_HIGH_LEV) {
 		edge = GPIO_INT_LOW_LEV;
 		pr_debug("mxc: switch GPIO %d to low trigger\n", gpio);
-		break;
-	case GPIO_INT_LOW_LEV:
+	} else if (edge == GPIO_INT_LOW_LEV) {
 		edge = GPIO_INT_HIGH_LEV;
 		pr_debug("mxc: switch GPIO %d to high trigger\n", gpio);
-		break;
-	default:
+	} else {
 		pr_err("mxc: invalid configuration for GPIO %d: %x\n",
 		       gpio, edge);
 		return;
-- 
1.6.6.2
