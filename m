From: broonie@kernel.org (Mark Brown)
Date: Mon, 23 Dec 2013 11:57:46 +0000
Subject: [PATCH v4 1/3] regulator: act8865: add PMIC act8865 driver
In-Reply-To: <1387776328-23079-1-git-send-email-wenyou.yang@atmel.com>
References: <1387776268-23036-1-git-send-email-wenyou.yang@atmel.com>
 <1387776328-23079-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20131223115746.GR30815@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 23, 2013 at 01:25:28PM +0800, Wenyou Yang wrote:

> +static int act8865_set_suspend_voltage(struct regulator_dev *rdev, int uV)
> +{
> +	u32	selector;
> +
> +	selector = regulator_map_voltage_iterate(rdev, uV, uV);
> +
> +	return regulator_set_voltage_sel_regmap(rdev, selector);
> +}

This looks wrong - it's going to set the normal voltage register that is
set for runtime voltage changes.  The suspend operations are only for
setting separate voltage registers, many PMICs know about system suspend
and provide separate settings for that.  If this one doesn't then it
shouldn't implement this operation.

Otherwise this looked good.
