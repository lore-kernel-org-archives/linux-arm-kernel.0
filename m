From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Fri, 5 Dec 2014 09:37:03 -0800
Subject: [PATCH v2 7/7] pinctrl: qcom-spmi-gpio: Migrate to pinconf-generic
In-Reply-To: <bc08b9044a3f46f5a575dca2fa18a663@BY2FFO11FD057.protection.gbl>
References: <1417137993-8337-1-git-send-email-soren.brinkmann@xilinx.com>
 <1417137993-8337-8-git-send-email-soren.brinkmann@xilinx.com>
 <1417766393.22963.9.camel@mm-sol.com>
 <bc08b9044a3f46f5a575dca2fa18a663@BY2FFO11FD057.protection.gbl>
Message-ID: <40e6a2a0c9f54ba4805871cf33373561@BN1BFFO11FD003.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-12-05 at 09:08AM -0800, S?ren Brinkmann wrote:
> On Fri, 2014-12-05 at 09:59AM +0200, Ivan T. Ivanov wrote:
> > 
> > On Thu, 2014-11-27 at 17:26 -0800, Soren Brinkmann wrote:
> > > 
> > >  static const struct pinconf_ops pmic_gpio_pinconf_ops = {
> > > +       .is_generic= true,
> > >         .pin_config_group_get= pmic_gpio_config_get,
> > >         .pin_config_group_set= pmic_gpio_config_set,
> > >         .pin_config_group_dbg_show= pmic_gpio_config_dbg_show,
> > > @@ -848,6 +742,9 @@ static int pmic_gpio_probe(struct platform_device *pdev)
> > >         pctrldesc->name = dev_name(dev);
> > >         pctrldesc->pins = pindesc;
> > >         pctrldesc->npins = npins;
> > > +       pctrldesc->num_dt_params = ARRAY_SIZE(pmic_gpio_bindings);
> > > +       pctrldesc->params = pmic_gpio_bindings;
> > > +       pctrldesc->conf_items = pmic_conf_items;
> > > 
> > 
> > What will happen if number of conf_items is less than number of params?
> 
> I suppose bad things :) You're right, that should probably be checked
> somewhere. Let me see whether I find a good place to put such a check.

Looking at it, it's not that straight forward. We only pass one size to
the core, so the core cannot really check that the number of entries in
both arrays are equal. And passing the size of both looks a little
redundant to me.
That would put the driver in charge of making sure these arrays are
aligned.

With the change given below, it would at least trigger a compiler
warning. I'll add that to the next iteration of this series.
Longer term, merging those arrays, as you suggested, may be a better
solution.

	Thanks,
	S?ren

-------------8<-------------8<-------------------8<------------------------8<---
diff --git a/drivers/pinctrl/pinctrl-zynq.c b/drivers/pinctrl/pinctrl-zynq.c
index 29b75134771f..5942af4c2e67 100644
--- a/drivers/pinctrl/pinctrl-zynq.c
+++ b/drivers/pinctrl/pinctrl-zynq.c
@@ -924,7 +924,7 @@ static const struct pinconf_generic_dt_params zynq_dt_params[] = {
        { "io-standard", PIN_CONFIG_IOSTANDARD, zynq_iostd_lvcmos18},
 };
 
-static const struct pin_config_item zynq_conf_items[] = {
+static const struct pin_config_item zynq_conf_items[ARRAY_SIZE(zynq_dt_params)] = {
        PCONFDUMP(PIN_CONFIG_IOSTANDARD, "IO-standard", NULL, true),
 };
 
diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
index c612aaa653d5..17f811c9c2c0 100644
--- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
@@ -136,7 +136,7 @@ static const struct pinconf_generic_dt_params pmic_gpio_bindings[] = {
        {"qcom,drive-strength",         PMIC_GPIO_CONF_STRENGTH,        0},
 };
 
-static const struct pin_config_item pmic_conf_items[] = {
+static const struct pin_config_item pmic_conf_items[ARRAY_SIZE(pmic_gpio_bindings)] = {
        PCONFDUMP(PMIC_GPIO_CONF_PULL_UP,  "pull up strength", NULL, true),
        PCONFDUMP(PMIC_GPIO_CONF_STRENGTH, "drive-strength", NULL, true),
 };
