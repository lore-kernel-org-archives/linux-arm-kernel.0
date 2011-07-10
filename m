From: grant.likely@secretlab.ca (Grant Likely)
Date: Sun, 10 Jul 2011 16:21:59 +0900
Subject: [PATCH] mfd: convert devicetree to platform on 88pm860x
In-Reply-To: <1310120428-22700-11-git-send-email-haojian.zhuang@marvell.com>
References: <1310120428-22700-2-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-3-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-4-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-5-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-6-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-7-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-8-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-9-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-10-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-11-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <20110710072159.GF10912@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 08, 2011 at 06:20:27PM +0800, Haojian Zhuang wrote:
> Make 88pm860x to support both platform data and device tree. So a translation
> between device tree and platform data is added.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> ---
>  drivers/mfd/88pm860x-i2c.c |  191 +++++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 189 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mfd/88pm860x-i2c.c b/drivers/mfd/88pm860x-i2c.c
> index e017dc8..b017e4a 100644
> --- a/drivers/mfd/88pm860x-i2c.c
> +++ b/drivers/mfd/88pm860x-i2c.c
> @@ -10,6 +10,8 @@
>   */
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_regulator.h>
>  #include <linux/platform_device.h>
>  #include <linux/i2c.h>
>  #include <linux/mfd/88pm860x.h>
> @@ -236,6 +238,187 @@ static const struct i2c_device_id pm860x_id_table[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, pm860x_id_table);
>  
> +#ifdef CONFIG_OF
> +static int __devinit pm860x_parse_irq(struct i2c_client *i2c,
> +				      struct pm860x_platform_data *pdata)
> +{
> +	struct device_node *of_node = i2c->dev.of_node;
> +
> +	pdata->irq_base = irq_alloc_descs(-1, 0, 24, 0);
> +	irq_domain_add_simple(of_node, pdata->irq_base);
> +	return 0;
> +}
> +
> +static void __devinit pm860x_parse_backlight(struct device_node *np,
> +					struct pm860x_platform_data *pdata)
> +{
> +	const __be32 *idx, *iset, *pwm;
> +	int i;
> +
> +	idx = of_get_property(np, "cell-index", NULL);
> +	if (idx == NULL)
> +		return;
> +	iset = of_get_property(np, "iset", NULL);
> +	if (iset == NULL)
> +		return;
> +	pwm = of_get_property(np, "pwm", NULL);
> +
> +	i = be32_to_cpu(*idx);
> +	pdata->backlight[i].iset = be32_to_cpu(*iset);
> +	pdata->backlight[i].flags = i;
> +	if (pwm)
> +		pdata->backlight[i].pwm = be32_to_cpu(*pwm);
> +	pdata->num_backlights++;
> +}
> +
> +static void __devinit pm860x_parse_led(struct device_node *np,
> +					struct pm860x_platform_data *pdata)
> +{
> +	const __be32 *idx, *iset;
> +	int i;
> +
> +	idx = of_get_property(np, "cell-index", NULL);
> +	if (idx == NULL)
> +		return;
> +	iset = of_get_property(np, "iset", NULL);
> +	if (iset == NULL)
> +		return;
> +
> +	i = be32_to_cpu(*idx);
> +	pdata->led[i].iset = be32_to_cpu(*iset);
> +	pdata->led[i].flags = i;
> +	pdata->num_leds++;
> +}
> +
> +static void __devinit pm860x_parse_touch(struct device_node *np,
> +					struct pm860x_platform_data *pdata)
> +{
> +	struct pm860x_touch_pdata *touch;
> +	const __be32 *prebias, *slot, *res, *prechg;
> +
> +	prebias = of_get_property(np, "prebias", NULL);
> +	if (prebias == NULL)
> +		return;
> +	slot = of_get_property(np, "slot-cycle", NULL);
> +	if (slot == NULL)
> +		return;
> +	res = of_get_property(np, "resistor-xplate", NULL);
> +	if (res == NULL)
> +		return;
> +	prechg = of_get_property(np, "pen-prechg", NULL);
> +	if (prechg == NULL)
> +		return;
> +	touch = kzalloc(sizeof(struct pm860x_touch_pdata), GFP_KERNEL);
> +	if (touch == NULL)
> +		return;
> +	touch->gpadc_prebias = be32_to_cpu(*prebias++);
> +	touch->tsi_prebias = be32_to_cpu(*prebias++);
> +	touch->pen_prebias = be32_to_cpu(*prebias);
> +	touch->slot_cycle = be32_to_cpu(*slot);
> +	touch->pen_prechg = be32_to_cpu(*prechg);
> +	pdata->touch = touch;
> +}
> +
> +static int data[PM8607_ID_RG_MAX];
> +
> +static void __devinit pm860x_parse_regulator(struct device_node *np,
> +					struct pm860x_platform_data *pdata)
> +{
> +	const char *name[PM8607_ID_RG_MAX] = {
> +		"BUCK1", "BUCK2", "BUCK3", "LDO1", "LDO2", "LDO3", "LOD4",
> +		"LDO5", "LDO6", "LDO7", "LDO8", "LDO9", "LDO10", "LDO11",
> +		"LDO12", "LDO13", "LDO14", "LDO15"};
> +	const char *cp;
> +	int i;
> +
> +	cp = of_get_property(np, "compatible", NULL);
> +	if (cp == NULL)
> +		return;
> +	for (i = 0; i < PM8607_ID_RG_MAX; i++) {
> +		if (strncmp(cp, name[i], strlen(name[i])))
> +			continue;
> +		of_regulator_init_data(np, &pdata->regulator[i]);
> +		data[i] = i;
> +		pdata->regulator[i].driver_data = &data[i];
> +		pdata->num_regulators++;
> +		break;
> +	}
> +}
> +
> +static struct pm860x_platform_data __devinit
> +*pm860x_get_alt_pdata(struct i2c_client *i2c)
> +{
> +	struct pm860x_platform_data *pdata;
> +	struct device_node *of_node = i2c->dev.of_node;
> +	struct device_node *np, *pp = NULL;
> +	const char *cp;
> +	const __be32 *p;
> +	int ret;
> +
> +	pdata = kzalloc(sizeof(struct pm860x_platform_data), GFP_KERNEL);
> +	if (pdata == NULL)
> +		return NULL;
> +	pdata->regulator = kzalloc(sizeof(struct regulator_init_data)
> +				* PM8607_ID_RG_MAX, GFP_KERNEL);
> +	if (pdata->regulator == NULL)
> +		goto out_reg;
> +	pdata->led = kzalloc(sizeof(struct pm860x_led_pdata) * 3,
> +				GFP_KERNEL);
> +	if (pdata->led == NULL)
> +		goto out_led;
> +	pdata->backlight = kzalloc(sizeof(struct pm860x_backlight_pdata)
> +					* 3, GFP_KERNEL);
> +	if (pdata->backlight == NULL)
> +		goto out_backlight;
> +	p = of_get_property(of_node, "i2c-port", NULL);
> +	if (p)
> +		pdata->i2c_port = be32_to_cpu(*p);
> +	p = of_get_property(of_node, "companion-addr", NULL);
> +	if (p)
> +		pdata->companion_addr = be32_to_cpu(*p);
> +	p = of_get_property(of_node, "irq-mode", NULL);
> +	if (p)
> +		pdata->irq_mode = be32_to_cpu(*p);

As commented earlier, new binding needs to be documented.

> +
> +	ret = pm860x_parse_irq(i2c, pdata);
> +	if (ret < 0)
> +		goto out;
> +
> +	for (; (np = of_get_next_child(of_node, pp)) != NULL; pp = np) {
> +		cp = of_get_property(np, "compatible", NULL);
> +		if (cp == NULL)
> +			continue;
> +		if (!strncmp(cp, "backlight", strlen("backlight")))
> +			pm860x_parse_backlight(np, pdata);
> +		if (!strncmp(cp, "led", strlen("led")))
> +			pm860x_parse_led(np, pdata);
> +		if (!strncmp(cp, "touch", strlen("touch")))
> +			pm860x_parse_touch(np, pdata);
> +		cp = of_get_property(np, "device_type", NULL);
> +		if (cp == NULL)
> +			continue;
> +		if (!strncmp(cp, "regulator", strlen("regulator")))
> +			pm860x_parse_regulator(np, pdata);
> +	}
> +	return pdata;
> +out:
> +	kfree(pdata->backlight);
> +out_backlight:
> +	kfree(pdata->led);
> +out_led:
> +	kfree(pdata->regulator);
> +out_reg:
> +	kfree(pdata);
> +	return NULL;
> +}
> +#else
> +static struct pm860x_platform_data __devinit
> +*pm860x_get_alt_pdata(struct i2c_client *i2c)
> +{
> +	return NULL;
> +}
> +#endif
> +
>  static int verify_addr(struct i2c_client *i2c)
>  {
>  	unsigned short addr_8607[] = {0x30, 0x34};
> @@ -264,8 +447,12 @@ static int __devinit pm860x_probe(struct i2c_client *client,
>  	struct pm860x_chip *chip;
>  
>  	if (!pdata) {
> -		pr_info("No platform data in %s!\n", __func__);
> -		return -EINVAL;
> +		pdata = pm860x_get_alt_pdata(client);
> +		if (!pdata) {
> +			pr_info("No platform data in %s!\n", __func__);
> +			return -EINVAL;
> +		}
> +		client->dev.platform_data = pdata;

Ditto here to comment on last patch.  Don't modify platform_data in a device driver.

>  	}
>  
>  	chip = kzalloc(sizeof(struct pm860x_chip), GFP_KERNEL);
> -- 
> 1.5.6.5
> 
