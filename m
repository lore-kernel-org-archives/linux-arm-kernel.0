From: b35083@freescale.com (Jingchang Lu)
Date: Thu, 2 May 2013 15:48:52 +0800
Subject: [PATCH 2/2] pinctrl/imx: add zero register offset valid for Vybrid
 platform
In-Reply-To: <1367480932-22318-1-git-send-email-b35083@freescale.com>
References: <1367480932-22318-1-git-send-email-b35083@freescale.com>
Message-ID: <1367480932-22318-2-git-send-email-b35083@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On some platform such as Vybrid, offset of mux and pad ctrl register
may be zero. This patch add a platform condition to imx core pinctrl
framework, making zero register offset valid on setting mux_mode and
pad config value.

Signed-off-by: Jingchang Lu <b35083@freescale.com>
---
 drivers/pinctrl/pinctrl-imx.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-imx.c b/drivers/pinctrl/pinctrl-imx.c
index 4fcfff92..b4d7c91 100644
--- a/drivers/pinctrl/pinctrl-imx.c
+++ b/drivers/pinctrl/pinctrl-imx.c
@@ -221,10 +221,14 @@ static int imx_pmx_enable(struct pinctrl_dev *pctldev, unsigned selector,
 		pin_id = pins[i];
 		pin_reg = &info->pin_regs[pin_id];
 
-		if (!pin_reg->mux_reg) {
-			dev_err(ipctl->dev, "Pin(%s) does not support mux function\n",
-				info->pins[pin_id].name);
-			return -EINVAL;
+		/* mux_reg offset maybe zero on some platform such as Vybrid */
+		if (!of_machine_is_compatible("fsl,mvf600")) {
+			if (!pin_reg->mux_reg) {
+				dev_err(ipctl->dev,
+					"Pin(%s) does not support mux function\n",
+					info->pins[pin_id].name);
+				return -EINVAL;
+			}
 		}
 
 		writel(mux[i], ipctl->base + pin_reg->mux_reg);
@@ -287,10 +291,13 @@ static int imx_pinconf_get(struct pinctrl_dev *pctldev,
 	const struct imx_pinctrl_soc_info *info = ipctl->info;
 	const struct imx_pin_reg *pin_reg = &info->pin_regs[pin_id];
 
-	if (!pin_reg->conf_reg) {
-		dev_err(info->dev, "Pin(%s) does not support config function\n",
-			info->pins[pin_id].name);
-		return -EINVAL;
+	if (!of_machine_is_compatible("fsl,mvf600")) {
+		if (!pin_reg->conf_reg) {
+			dev_err(info->dev,
+				"Pin(%s) does not support config function\n",
+				info->pins[pin_id].name);
+			return -EINVAL;
+		}
 	}
 
 	*config = readl(ipctl->base + pin_reg->conf_reg);
@@ -305,10 +312,13 @@ static int imx_pinconf_set(struct pinctrl_dev *pctldev,
 	const struct imx_pinctrl_soc_info *info = ipctl->info;
 	const struct imx_pin_reg *pin_reg = &info->pin_regs[pin_id];
 
-	if (!pin_reg->conf_reg) {
-		dev_err(info->dev, "Pin(%s) does not support config function\n",
-			info->pins[pin_id].name);
-		return -EINVAL;
+	if (!of_machine_is_compatible("fsl,mvf600")) {
+		if (!pin_reg->conf_reg) {
+			dev_err(info->dev,
+				"Pin(%s) does not support config function\n",
+				info->pins[pin_id].name);
+			return -EINVAL;
+		}
 	}
 
 	dev_dbg(ipctl->dev, "pinconf set pin %s\n",
-- 
1.8.0
