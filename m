From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Fri, 12 May 2017 20:38:06 +0800
Subject: [PATCH 5/5] pinctrl: imx: fix debug message for SHARE_MUX_CONF_REG
 case
In-Reply-To: <1494592686-30967-1-git-send-email-aisheng.dong@nxp.com>
References: <1494592686-30967-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1494592686-30967-7-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The original implemented debug message does not work for
SHARE_MUX_CONF_REG case. This patch fixes it.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Fixes: bf5a530971af ("pinctrl: imx: add VF610 support to imx pinctrl framework")
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/pinctrl/freescale/pinctrl-imx.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/freescale/pinctrl-imx.c b/drivers/pinctrl/freescale/pinctrl-imx.c
index 8347197..57e1f7a 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx.c
@@ -200,11 +200,13 @@ static int imx_pmx_set(struct pinctrl_dev *pctldev, unsigned selector,
 			reg &= ~info->mux_mask;
 			reg |= (pin->mux_mode << info->mux_shift);
 			writel(reg, ipctl->base + pin_reg->mux_reg);
+			dev_dbg(ipctl->dev, "write: offset 0x%x val 0x%x\n",
+				pin_reg->mux_reg, reg);
 		} else {
 			writel(pin->mux_mode, ipctl->base + pin_reg->mux_reg);
+			dev_dbg(ipctl->dev, "write: offset 0x%x val 0x%x\n",
+				pin_reg->mux_reg, pin->mux_mode);
 		}
-		dev_dbg(ipctl->dev, "write: offset 0x%x val 0x%x\n",
-			pin_reg->mux_reg, pin->mux_mode);
 
 		/*
 		 * If the select input value begins with 0xff, it's a quirky
@@ -462,11 +464,13 @@ static int imx_pinconf_set(struct pinctrl_dev *pctldev,
 			reg &= info->mux_mask;
 			reg |= configs[i];
 			writel(reg, ipctl->base + pin_reg->conf_reg);
+			dev_dbg(ipctl->dev, "write: offset 0x%x val 0x%x\n",
+				pin_reg->conf_reg, reg);
 		} else {
 			writel(configs[i], ipctl->base + pin_reg->conf_reg);
+			dev_dbg(ipctl->dev, "write: offset 0x%x val 0x%lx\n",
+				pin_reg->conf_reg, configs[i]);
 		}
-		dev_dbg(ipctl->dev, "write: offset 0x%x val 0x%lx\n",
-			pin_reg->conf_reg, configs[i]);
 	} /* for each config */
 
 	return 0;
-- 
2.7.4
