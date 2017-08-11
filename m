From: alex.g@adaptrum.com (Alexandru Gagniuc)
Date: Fri, 11 Aug 2017 09:28:44 -0700
Subject: [PATCH v2 2/5] reset: socfpga: use the reset-simple driver
In-Reply-To: <20170811130618.3676-3-p.zabel@pengutronix.de>
References: <20170811130618.3676-1-p.zabel@pengutronix.de>
 <20170811130618.3676-3-p.zabel@pengutronix.de>
Message-ID: <d1d06519-f676-5d36-2f82-e9537cef4f74@adaptrum.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Phillip,

On 08/11/2017 06:06 AM, Philipp Zabel wrote:
[snip]

> @@ -113,8 +137,33 @@ static int reset_simple_probe(struct platform_device *pdev)
>  	data->rcdev.ops = &reset_simple_ops;
>  	data->rcdev.of_node = dev->of_node;
>
> -	if (devdata)
> +	if (devdata == &reset_simple_socfpga) {

This sort of special-case handling opens the gate to adding special-case 
handling for any new device, which somewhat defeats the purpose of a 
generic driver.

> +		u32 modrst_offset;
> +
> +		/*
> +		 * The binding was mainlined without the required property.
> +		 * Do not continue, when we encounter an old DT.
> +		 */
> +		if (!of_find_property(dev->of_node, "#reset-cells", NULL)) {
> +			dev_err(dev, "%pOF missing #reset-cells property\n",
> +				dev->of_node);
> +			return -EINVAL;
> +		}

Is the check still required in this context, since 
(devm_)reset_control_get() complains really loudly if #reset-cells is 
missing?

> +
> +		if (of_property_read_u32(dev->of_node, "altr,modrst-offset",
> +					 &modrst_offset)) {
> +			dev_warn(dev, "missing altr,modrst-offset property, assuming 0x10!\n");
> +			modrst_offset = 0x10;
> +		}

This can be a generic "reg-offset" property. If and until the 
devicetrees are updated, "altr,modrst-offset" would also have to be read 
as an alternative. Since a platform data already exists, 
reset_simple_devdata could be a better place to store the default offset 
of 0x10 for socfpga.

Alex
