From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 27 Sep 2011 13:10:04 +0100
Subject: [PATCH 2/9] regulator: helper routine to extract
	regulator_init_data
In-Reply-To: <1317118372-17052-3-git-send-email-rnayak@ti.com>
References: <1317118372-17052-1-git-send-email-rnayak@ti.com>
	<1317118372-17052-3-git-send-email-rnayak@ti.com>
Message-ID: <20110927121003.GB4289@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 27, 2011 at 03:42:45PM +0530, Rajendra Nayak wrote:

> +	init_data = devm_kzalloc(dev, sizeof(struct regulator_init_data),
> +						 GFP_KERNEL);
> +	if (!init_data)
> +		return NULL; /* Out of memory? */

This means that the init data will be kept around for the entire
lifetime of the device rather than being discarded.

> +	init_data->supply_regulator = (char *)of_get_property(dev->of_node,
> +						"regulator-supplies", NULL);

I'd expect that in the device tree world the supply regulator would
reference the node for that regulator.

>  	/* voltage output range (inclusive) - for voltage control */
> -	int min_uV;
> -	int max_uV;
> +	u32 min_uV;
> +	u32 max_uV;
>  
> -	int uV_offset;
> +	u32 uV_offset;
>  
>  	/* current output range (inclusive) - for current control */
> -	int min_uA;
> -	int max_uA;
> +	u32 min_uA;
> +	u32 max_uA;

Hrm, I think loosing the signs here is bad karma - negative voltages do
exist after all.
