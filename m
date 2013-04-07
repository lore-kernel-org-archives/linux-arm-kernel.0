From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 7 Apr 2013 15:10:30 +0800
Subject: [PATCH v2 0/3] Get rid of big array from imx pinctrl driver
In-Reply-To: <CAOMZO5D1+baoM0vMdPW9bAd4DX8C82BF9H87igFNo78+8D_N3Q@mail.gmail.com>
References: <1361533888-18073-1-git-send-email-shawn.guo@linaro.org>
 <CAOMZO5D1+baoM0vMdPW9bAd4DX8C82BF9H87igFNo78+8D_N3Q@mail.gmail.com>
Message-ID: <20130407071028.GD11898@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 06, 2013 at 05:21:37PM -0300, Fabio Estevam wrote:
> Hi Shawn,
> 
> On Fri, Feb 22, 2013 at 8:51 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> > Changes since v1:
> >  * Remove the absolute path of imxXX-pinfunc.h in binding doc
> >  * Remove the pin id from PIN_FUNC_ID/macro
> >
> > Shawn Guo (3):
> >   ARM: dts: imx: use pre-processor for device trees
> >   ARM: dts: imx: replace magic number with pin function name
> >   pinctrl: imx: move hard-coding data into device tree
> 
> The last patch breaks audio on mx6qsabrelite: after a aplay command
> the processor hangs.

Thanks for spotting it, Fabio.

There is indeed a bug with the patch.  The select input register should
not be defined in imx_pin_reg, because the same pad may have multiple
select input registers for different mux setting values.  So it should
be something defined with pin group.  The following code change should
fix the problem.

I just rebuilt imx/dt branch with the problem fixed and also had the
branch based on Stephen Warren's for-3.10/dtc-cpp-chroot-std-headers
branch so avoid all those dts files renaming.

Shawn

--8<----

diff --git a/drivers/pinctrl/pinctrl-imx.c b/drivers/pinctrl/pinctrl-imx.c
index 479ceb6..b83be7c 100644
--- a/drivers/pinctrl/pinctrl-imx.c
+++ b/drivers/pinctrl/pinctrl-imx.c
@@ -198,6 +198,7 @@ static int imx_pmx_enable(struct pinctrl_dev *pctldev, unsigned selector,
 	const struct imx_pinctrl_soc_info *info = ipctl->info;
 	const struct imx_pin_reg *pin_reg;
 	const unsigned *pins, *mux, *input_val;
+	u16 *input_reg;
 	unsigned int npins, pin_id;
 	int i;
 
@@ -209,6 +210,7 @@ static int imx_pmx_enable(struct pinctrl_dev *pctldev, unsigned selector,
 	npins = info->groups[group].npins;
 	mux = info->groups[group].mux_mode;
 	input_val = info->groups[group].input_val;
+	input_reg = info->groups[group].input_reg;
 
 	WARN_ON(!pins || !npins || !mux || !input_val);
 
@@ -230,11 +232,11 @@ static int imx_pmx_enable(struct pinctrl_dev *pctldev, unsigned selector,
 			pin_reg->mux_reg, mux[i]);
 
 		/* some pins also need select input setting, set it if found */
-		if (pin_reg->input_reg) {
-			writel(input_val[i], ipctl->base + pin_reg->input_reg);
+		if (input_reg[i]) {
+			writel(input_val[i], ipctl->base + input_reg[i]);
 			dev_dbg(ipctl->dev,
 				"==>select_input: offset 0x%x val 0x%x\n",
-				pin_reg->input_reg, input_val[i]);
+				input_reg[i], input_val[i]);
 		}
 	}
 
@@ -411,6 +413,8 @@ static int imx_pinctrl_parse_groups(struct device_node *np,
 				GFP_KERNEL);
 	grp->mux_mode = devm_kzalloc(info->dev, grp->npins * sizeof(unsigned int),
 				GFP_KERNEL);
+	grp->input_reg = devm_kzalloc(info->dev, grp->npins * sizeof(u16),
+				GFP_KERNEL);
 	grp->input_val = devm_kzalloc(info->dev, grp->npins * sizeof(unsigned int),
 				GFP_KERNEL);
 	grp->configs = devm_kzalloc(info->dev, grp->npins * sizeof(unsigned long),
@@ -424,7 +428,7 @@ static int imx_pinctrl_parse_groups(struct device_node *np,
 		grp->pins[i] = pin_id;
 		pin_reg->mux_reg = mux_reg;
 		pin_reg->conf_reg = conf_reg;
-		pin_reg->input_reg = be32_to_cpu(*list++);
+		grp->input_reg[i] = be32_to_cpu(*list++);
 		grp->mux_mode[i] = be32_to_cpu(*list++);
 		grp->input_val[i] = be32_to_cpu(*list++);
 
diff --git a/drivers/pinctrl/pinctrl-imx.h b/drivers/pinctrl/pinctrl-imx.h
index 4749b0a..1f27f24 100644
--- a/drivers/pinctrl/pinctrl-imx.h
+++ b/drivers/pinctrl/pinctrl-imx.h
@@ -26,6 +26,8 @@ struct platform_device;
  *	elements in .pins so we can iterate over that array
  * @mux_mode: the mux mode for each pin in this group. The size of this
  *	array is the same as pins.
+ * @input_reg: select input register offset for this mux if any
+ *	0 if no select input setting needed.
  * @input_val: the select input value for each pin in this group. The size of
  *	this array is the same as pins.
  * @configs: the config for each pin in this group. The size of this
@@ -36,6 +38,7 @@ struct imx_pin_group {
 	unsigned int *pins;
 	unsigned npins;
 	unsigned int *mux_mode;
+	u16 *input_reg;
 	unsigned int *input_val;
 	unsigned long *configs;
 };
@@ -56,13 +59,10 @@ struct imx_pmx_func {
  * struct imx_pin_reg - describe a pin reg map
  * @mux_reg: mux register offset
  * @conf_reg: config register offset
- * @input_reg: select input register offset for this mux if any
- *  0 if no select input setting needed.
  */
 struct imx_pin_reg {
 	u16 mux_reg;
 	u16 conf_reg;
-	u16 input_reg;
 };
 
 struct imx_pinctrl_soc_info {
-- 
1.7.9.5
