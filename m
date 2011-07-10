From: grant.likely@secretlab.ca (Grant Likely)
Date: Sun, 10 Jul 2011 16:20:27 +0900
Subject: [PATCH] mfd: convert devicetree to platform data on max8925
In-Reply-To: <1310120428-22700-10-git-send-email-haojian.zhuang@marvell.com>
References: <1310120428-22700-1-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-2-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-3-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-4-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-5-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-6-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-7-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-8-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-9-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-10-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <20110710072027.GE10912@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 08, 2011 at 06:20:26PM +0800, Haojian Zhuang wrote:
> Make max8925 to support both platform data and device tree. So a translation
> between device tree and platform data is added.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> ---
>  drivers/mfd/max8925-i2c.c |  159 ++++++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 157 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mfd/max8925-i2c.c b/drivers/mfd/max8925-i2c.c
> index 0219115..fb74554 100644
> --- a/drivers/mfd/max8925-i2c.c
> +++ b/drivers/mfd/max8925-i2c.c
> @@ -10,6 +10,9 @@
>   */
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/irq.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_regulator.h>
>  #include <linux/platform_device.h>
>  #include <linux/i2c.h>
>  #include <linux/mfd/max8925.h>
> @@ -135,6 +138,154 @@ static const struct i2c_device_id max8925_id_table[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, max8925_id_table);
>  
> +#ifdef CONFIG_OF
> +static int __devinit max8925_parse_irq(struct i2c_client *i2c,
> +					struct max8925_platform_data *pdata)
> +{
> +	struct device_node *of_node = i2c->dev.of_node;
> +
> +	pdata->irq_base = irq_alloc_descs(-1, 0, MAX8925_NR_IRQS, 0);
> +	irq_domain_add_simple(of_node, pdata->irq_base);

of_node is only used once.  This could simply be:

	irq_domain_add_simple(i2c->dev.of_node, pdata->irq_base);

> +	return 0;
> +}
> +
> +static void __devinit max8925_parse_backlight(struct device_node *np,
> +					struct max8925_platform_data *pdata)
> +{
> +	struct max8925_backlight_pdata *bk;
> +	const __be32 *p;
> +
> +	bk = kzalloc(sizeof(struct max8925_backlight_pdata), GFP_KERNEL);
> +	if (bk == NULL)
> +		return;
> +	pdata->backlight = bk;
> +	p = of_get_property(np, "lxw-scl", NULL);
> +	if (p)
> +		bk->lxw_scl = be32_to_cpu(*p);
> +	p = of_get_property(np, "lxw-freq", NULL);
> +	if (p)
> +		bk->lxw_freq = be32_to_cpu(*p);
> +	p = of_get_property(np, "dual-string", NULL);
> +	if (p)
> +		bk->dual_string = be32_to_cpu(*p);

of_property_read_u32() and of_property_read_string() would help you here.

This implements a new binding.  Needs to be documented.

> +}
> +
> +static void __devinit max8925_parse_touch(struct device_node *np,
> +					struct max8925_platform_data *pdata)
> +{
> +	struct max8925_touch_pdata *touch;
> +	const __be32 *p;
> +
> +	touch = kzalloc(sizeof(struct max8925_touch_pdata), GFP_KERNEL);
> +	if (touch == NULL)
> +		return;
> +	pdata->touch = touch;
> +	p = of_get_property(np, "flags", NULL);
> +	if (p)
> +		touch->flags = be32_to_cpu(*p);
> +	p = of_get_property(np, "interrupts", NULL);
> +	if (p)
> +		pdata->tsc_irq = irq_of_parse_and_map(np, 0);

irq_of_parse_and_map() can be called directly.  It will return NO_IRQ
if the irq cannot be parsed.

> +}
> +
> +static void __devinit max8925_parse_power(struct device_node *np,
> +					struct max8925_platform_data *pdata)
> +{
> +	struct max8925_power_pdata *power;
> +	const __be32 *p;
> +
> +	power = kzalloc(sizeof(struct max8925_power_pdata), GFP_KERNEL);
> +	if (power == NULL)
> +		return;
> +	pdata->power = power;
> +	p = of_get_property(np, "battery-detect", NULL);
> +	if (p)
> +		power->batt_detect = be32_to_cpu(*p) ? 1 : 0;
> +	p = of_get_property(np, "topoff-threshold", NULL);
> +	if (p)
> +		power->topoff_threshold = be32_to_cpu(*p) & 0x3;
> +	p = of_get_property(np, "fast-charge", NULL);
> +	if (p)
> +		power->fast_charge = be32_to_cpu(*p) & 0x7;

Needs to be documented.

> +}
> +
> +static void __devinit max8925_parse_regulator(struct device_node *np,
> +					struct max8925_platform_data *pdata)
> +{
> +	const char *name[MAX8925_MAX_REGULATOR] = {
> +			"SD1", "SD2", "SD3", "LDO1", "LDO2", "LDO3", "LDO4",
> +			"LDO5", "LDO6", "LDO7", "LDO8", "LDO9", "LDO10",
> +			"LDO11", "LDO12", "LDO13", "LDO14", "LDO15", "LDO16",
> +			"LDO17", "LDO18", "LDO19", "LDO20"};
> +	const char *cp;
> +	int i;
> +
> +	cp = of_get_property(np, "compatible", NULL);
> +	if (cp == NULL)
> +		return;
> +	for (i = 0; i < MAX8925_MAX_REGULATOR; i++) {
> +		if (strncmp(cp, name[i], strlen(name[i])))
> +			continue;
> +		of_regulator_init_data(np, pdata->regulator[i]);
> +		break;

You don't need to open-code the parsing of compatible values.  Use
of_match_node() instead with an of_device_id table.

> +	}
> +}
> +
> +static struct max8925_platform_data __devinit
> +*max8925_get_alt_pdata(struct i2c_client *client)
> +{
> +	struct max8925_platform_data *pdata;
> +	struct device_node *of_node = client->dev.of_node;
> +	struct device_node *np, *pp = NULL;
> +	const char *cp;
> +	int ret, i;
> +
> +	pdata = kzalloc(sizeof(struct max8925_platform_data), GFP_KERNEL);

sizeof(*pdata)

> +	if (pdata == NULL)
> +		return NULL;
> +	pdata->regulator[0] = kzalloc(sizeof(struct regulator_init_data)
> +			* MAX8925_MAX_REGULATOR, GFP_KERNEL);

ditto.

Is it appropriate to allocated the entire table of regulators?  From
the parse_regulator function above, it looks like only one of the
regulators will actually get registered (I've not dug deeply into what
the driver needs here though).

> +	if (pdata->regulator[0] == NULL) {
> +		kfree(pdata);
> +		return NULL;
> +	}
> +	for (i = 1; i < MAX8925_MAX_REGULATOR; i++)
> +		pdata->regulator[i] = pdata->regulator[i - 1] + 1;
> +
> +	ret = max8925_parse_irq(client, pdata);
> +	if (ret < 0)
> +		goto out;
> +
> +	for (; (np = of_get_next_child(of_node, pp)) != NULL; pp = np) {
> +		cp = of_get_property(np, "compatible", NULL);
> +		if (cp == NULL)
> +			continue;
> +		if (!strncmp(cp, "backlight", strlen("backlight")))
> +			max8925_parse_backlight(np, pdata);
> +		if (!strncmp(cp, "power", strlen("power")))
> +			max8925_parse_power(np, pdata);
> +		if (!strncmp(cp, "touch", strlen("touch")))
> +			max8925_parse_touch(np, pdata);
> +		cp = of_get_property(np, "device_type", NULL);
> +		if (cp == NULL)
> +			continue;
> +		if (!strncmp(cp, "regulator", strlen("regulator")))
> +			max8925_parse_regulator(np, pdata);
> +	}
> +	return pdata;
> +out:
> +	kfree(pdata->regulator[0]);
> +	kfree(pdata);
> +	return NULL;
> +}
> +#else
> +static struct max8925_platform_data __devinit
> +*max8925_get_alt_pdata(struct i2c_client *client)
> +{
> +	return NULL;
> +}
> +#endif
> +
>  static int __devinit max8925_probe(struct i2c_client *client,
>  				   const struct i2c_device_id *id)
>  {
> @@ -142,8 +293,12 @@ static int __devinit max8925_probe(struct i2c_client *client,
>  	static struct max8925_chip *chip;
>  
>  	if (!pdata) {
> -		pr_info("%s: platform data is missing\n", __func__);
> -		return -EINVAL;
> +		pdata = max8925_get_alt_pdata(client);
> +		if (!pdata) {
> +			pr_info("%s: platform data is missing\n", __func__);
> +			return -EINVAL;
> +		}
> +		client->dev.platform_data = pdata;

Don't write to dev.platform_data.  Device drivers must treat
platform_data as immutable, and it is illegal to modify it.  If
platform_data is used outside of the probe function, then the driver
needs to be refactored to copy the data out of pdata and into the
driver's private data structure so that the data can be sourced from
either pdata or DT.

g.

>  	}
>  
>  	chip = kzalloc(sizeof(struct max8925_chip), GFP_KERNEL);
> -- 
> 1.5.6.5
> 
