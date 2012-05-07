From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 7 May 2012 18:08:32 +0100
Subject: [PATCH 14/15] drivers/regulators: Enable the ab8500 for Device
 Tree
In-Reply-To: <1336155805-18554-15-git-send-email-lee.jones@linaro.org>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
 <1336155805-18554-15-git-send-email-lee.jones@linaro.org>
Message-ID: <20120507170832.GO17002@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 04, 2012 at 07:23:24PM +0100, Lee Jones wrote:

Once again, please try to make sure your changelog matches the
subsystem.  This also isn't consistent with the other regulator change
further up the series :(

You've also not included any binding documenation here, binding
documentation should be included for new bindings.

>  
> +static __devinit int
> +ab8500_regulator_of_probe(struct platform_device *pdev, struct device_node *np)
> +{
> +	struct regulator_init_data *ab8500_regulator;
> +	struct device_node *child;
> +	int err, value, i, id = 0;
> +
> +	/* Initialise regulator registers to platform specific values. */
> +	for (i = 0; i < ARRAY_SIZE(ab8500_reg_init); i++) {
> +		err = of_property_read_u32(np, ab8500_reg_init[i].of_name, &value);
> +		if (err < 0)
> +			return err;
> +
> +		err = ab8500_regulator_init_registers(pdev, i, value);
> +		if (err < 0)
> +			return err;

You should be using of_regulator_match() for this (I think it's supposed
to do an equivalent job...) rather than open coding.

> +	/* Register each ab8500 regulator found in the Device Tree. */
> +	for_each_child_of_node(np, child) {
> +		ab8500_regulator = of_get_regulator_init_data(&pdev->dev, child);

Definitely don't do this - you should unconditionally register all the
regulators that physically exist, this allows users to inspect their
state even if they aren't used.

It's possible the original driver has this bug (I didn't check but 

> +		if (strcmp(ab8500_regulator->constraints.name, "dummy"))
> +			ab8500_regulator_register(pdev, ab8500_regulator, id, child);

This is really broken - the whole purpose of allowing users to specify a
name in the constraints is to allow them to assign a name that's
meaningful for their board so they can tie the software in with the
schematic which we will display in diagnostics.  Forcing them to specify
magic strings as the supply name defeats this and makes diagnostics from
the kernel more obscure.

>  	pdata = dev_get_platdata(ab8500->dev);
> -	if (!pdata) {
> -		dev_err(&pdev->dev, "null pdata\n");
> +	if (!pdata && !np) {
> +		dev_err(&pdev->dev, "null pdata and no device tree found\n");
>  		return -EINVAL;
>  	}

Neither should be mandatory.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120507/1b7b0ae8/attachment.sig>
