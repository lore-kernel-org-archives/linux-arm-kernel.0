From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Fri, 19 May 2017 15:05:43 +0800
Subject: [PATCH V2 3/5] pinctrl: imx: add soc specific mux_mode mask and shift
 property
In-Reply-To: <1495177545-23006-1-git-send-email-aisheng.dong@nxp.com>
References: <1495177545-23006-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1495177545-23006-4-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MX7ULP MUX mode mask and shift bit is different from VF610.
Let's make it a platform specific property for the later easy of
adding MX7ULP support.

One trick in exist code that Vybrid hardcoded the config part
as 0xffff because its mux_config register BIT[15-0] are all configs
part. But it's not true in ULP, so use mux_mask instead to address
the difference.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Stefan Agner <stefan@agner.ch>
Cc: Bai Ping <ping.bai@nxp.com>
Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

---
ChangeLog:
v1->v2:
 Minor changes:
 * add more explanation about Vybrid trick in commit message.
---
 drivers/pinctrl/freescale/pinctrl-imx.c   | 10 +++++-----
 drivers/pinctrl/freescale/pinctrl-imx.h   |  4 ++++
 drivers/pinctrl/freescale/pinctrl-vf610.c |  2 ++
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/freescale/pinctrl-imx.c b/drivers/pinctrl/freescale/pinctrl-imx.c
index 6d5a517..bb7c625 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx.c
@@ -197,8 +197,8 @@ static int imx_pmx_set(struct pinctrl_dev *pctldev, unsigned selector,
 		if (info->flags & SHARE_MUX_CONF_REG) {
 			u32 reg;
 			reg = readl(ipctl->base + pin_reg->mux_reg);
-			reg &= ~(0x7 << 20);
-			reg |= (pin->mux_mode << 20);
+			reg &= ~info->mux_mask;
+			reg |= (pin->mux_mode << info->mux_shift);
 			writel(reg, ipctl->base + pin_reg->mux_reg);
 			dev_dbg(ipctl->dev, "write: offset 0x%x val 0x%x\n",
 				pin_reg->mux_reg, reg);
@@ -290,7 +290,7 @@ static int imx_pmx_gpio_request_enable(struct pinctrl_dev *pctldev,
 
 mux_pin:
 	reg = readl(ipctl->base + pin_reg->mux_reg);
-	reg &= ~(0x7 << 20);
+	reg &= ~info->mux_mask;
 	reg |= imx_pin->config;
 	writel(reg, ipctl->base + pin_reg->mux_reg);
 
@@ -434,7 +434,7 @@ static int imx_pinconf_get(struct pinctrl_dev *pctldev,
 	*config = readl(ipctl->base + pin_reg->conf_reg);
 
 	if (info->flags & SHARE_MUX_CONF_REG)
-		*config &= 0xffff;
+		*config &= ~info->mux_mask;
 
 	return 0;
 }
@@ -461,7 +461,7 @@ static int imx_pinconf_set(struct pinctrl_dev *pctldev,
 		if (info->flags & SHARE_MUX_CONF_REG) {
 			u32 reg;
 			reg = readl(ipctl->base + pin_reg->conf_reg);
-			reg &= ~0xffff;
+			reg &= info->mux_mask;
 			reg |= configs[i];
 			writel(reg, ipctl->base + pin_reg->conf_reg);
 			dev_dbg(ipctl->dev, "write: offset 0x%x val 0x%x\n",
diff --git a/drivers/pinctrl/freescale/pinctrl-imx.h b/drivers/pinctrl/freescale/pinctrl-imx.h
index 38aa53c..880bba7 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx.h
+++ b/drivers/pinctrl/freescale/pinctrl-imx.h
@@ -64,6 +64,10 @@ struct imx_pinctrl_soc_info {
 	const char *gpr_compatible;
 	struct mutex mutex;
 
+	/* MUX_MODE shift and mask in case SHARE_MUX_CONF_REG */
+	unsigned int mux_mask;
+	u8 mux_shift;
+
 	/* generic pinconf */
 	bool generic_pinconf;
 	const struct pinconf_generic_params *custom_params;
diff --git a/drivers/pinctrl/freescale/pinctrl-vf610.c b/drivers/pinctrl/freescale/pinctrl-vf610.c
index 2b1e198..3bd8556 100644
--- a/drivers/pinctrl/freescale/pinctrl-vf610.c
+++ b/drivers/pinctrl/freescale/pinctrl-vf610.c
@@ -299,6 +299,8 @@ static struct imx_pinctrl_soc_info vf610_pinctrl_info = {
 	.pins = vf610_pinctrl_pads,
 	.npins = ARRAY_SIZE(vf610_pinctrl_pads),
 	.flags = SHARE_MUX_CONF_REG | ZERO_OFFSET_VALID,
+	.mux_mask = 0x700000,
+	.mux_shift = 20,
 };
 
 static const struct of_device_id vf610_pinctrl_of_match[] = {
-- 
2.7.4
