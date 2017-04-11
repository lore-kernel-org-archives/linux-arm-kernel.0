From: sre@kernel.org (Sebastian Reichel)
Date: Tue, 11 Apr 2017 18:02:05 +0200
Subject: [PATCH 2/3] power: supply: New driver for LEGO MINDSTORMS EV3
 battery
In-Reply-To: <1491251029-23256-3-git-send-email-david@lechnology.com>
References: <1491251029-23256-1-git-send-email-david@lechnology.com>
 <1491251029-23256-3-git-send-email-david@lechnology.com>
Message-ID: <20170411160205.yqr6z5nwh5xn5zdb@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Driver looks fine. One minor thing, though:

On Mon, Apr 03, 2017 at 03:23:48PM -0500, David Lechner wrote:
> [...]
>
> +	batt->psy = power_supply_register(dev, &lego_ev3_battery_desc, &psy_cfg);
> +	err = PTR_ERR_OR_ZERO(batt->psy);
> +	if (err) {
> +		dev_err(dev, "failed to register power supply\n");
> +		return err;
> +	}

There is devm_power_supply_register() and it makes sense to use it,
since that means you can drop the remove function completly :)

> +	return 0;
> +}
> +
> +static int lego_ev3_battery_remove(struct platform_device *pdev)
> +{
> +	struct lego_ev3_battery *batt = platform_get_drvdata(pdev);
> +
> +	power_supply_unregister(batt->psy);
> +
> +	return 0;
> +}

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170411/5eecb7ba/attachment.sig>
