From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 1 Sep 2010 18:56:08 +0100
Subject: [PATCH v3] ux500: add ab8500-regulators machine specific data
In-Reply-To: <1283330411-3784-1-git-send-email-sundar.iyer@stericsson.com>
References: <1283330411-3784-1-git-send-email-sundar.iyer@stericsson.com>
Message-ID: <20100901175608.GF22444@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 01, 2010 at 02:10:11PM +0530, Sundar Iyer wrote:

> +#define AB8500_VAUXN_LDO_MIN_VOLTAGE    (1100000)
> +#define AB8500_VAUXN_LDO_MAX_VOLTAGE    (3300000)

> +struct regulator_init_data ab8500_vaux1_regulator = {

All these should be static.

> +	.supply_regulator_dev = NULL,

No need to assign to NULL, that's the default value.

> +	.constraints = {
> +		.name = "ab8500-vaux1",
> +		.min_uV = AB8500_VAUXN_LDO_MIN_VOLTAGE,
> +		.max_uV = AB8500_VAUXN_LDO_MAX_VOLTAGE,
> +		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE|
> +					REGULATOR_CHANGE_STATUS,
> +	},
> +};

Having operations for regulators with no consumers seems a bit strange.

> +/* supply for tvout, gpadc, TVOUT LDO */
> +#define AB8500_VTVOUT_LDO_MIN_VOLTAGE        (1900000)
> +#define AB8500_VTVOUT_LDO_MAX_VOLTAGE        (2100000)
> +
> +struct regulator_init_data ab8500_vtvout_init = {
> +	.supply_regulator_dev = NULL,
> +	.constraints = {
> +		.name = "ab8500-vtvout",
> +		.min_uV = AB8500_VTVOUT_LDO_MIN_VOLTAGE,
> +		.max_uV = AB8500_VTVOUT_LDO_MAX_VOLTAGE,
> +		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
> +	},
> +};

As does having voltage ranges for regulators without voltage change
permission.  Given that half the #defines you're using are only used for
one regulator it'd probably also be better to just use the values
directly.
