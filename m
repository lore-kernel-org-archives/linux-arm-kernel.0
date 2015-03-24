From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue, 24 Mar 2015 16:26:18 +0100
Subject: [PATCH] pinctrl: fsl: imx: Check for 0 config register
Message-ID: <1427210778-28037-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

0 is used in all pinfunction definitions when a config register is not
available, for example imx25-pinfunc.h. If a configuration value is used
for such a pinfunction the driver will always write it to the
configuration register if it is not -1. For a 0 configuration register
the configuration value is written to offset 0x0. This can lead to a
crashing/hanging system without any warning message.

This patch checks for 0 config register and sets the internal value to
-1. If the configuration value is not NO_PADCTL this leads to an error
message that applying the configuration failed.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/pinctrl/freescale/pinctrl-imx.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/freescale/pinctrl-imx.c b/drivers/pinctrl/freescale/pinctrl-imx.c
index 448f10986c28..2cc400b0a26b 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx.c
@@ -542,10 +542,13 @@ static int imx_pinctrl_parse_groups(struct device_node *np,
 		struct imx_pin_reg *pin_reg;
 		struct imx_pin *pin = &grp->pins[i];
 
-		if (info->flags & SHARE_MUX_CONF_REG)
+		if (info->flags & SHARE_MUX_CONF_REG) {
 			conf_reg = mux_reg;
-		else
+		} else {
 			conf_reg = be32_to_cpu(*list++);
+			if (!conf_reg)
+				conf_reg = -1;
+		}
 
 		pin_id = mux_reg ? mux_reg / 4 : conf_reg / 4;
 		pin_reg = &info->pin_regs[pin_id];
-- 
2.1.4
