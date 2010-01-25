From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 25 Jan 2010 12:05:43 +0000
Subject: [PATCH 4/4] power_supply: enable power supply of max8925
In-Reply-To: <771cded01001250309k64efaa98n6a68f56678986228@mail.gmail.com>
References: <771cded01001250309k64efaa98n6a68f56678986228@mail.gmail.com>
Message-ID: <20100125120543.GF22909@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 25, 2010 at 06:09:50AM -0500, Haojian Zhuang wrote:

> +	case MAX8925_IRQ_VCHG_DC_R:
> +		info->ac_online = 1;
> +		__set_charger(info, 1);
> +		dev_dbg(chip->dev, "Adapter is insertion\n");

Grammar nit "Adapter inserted".

> +	case MAX8925_IRQ_VCHG_SYSLOW_R:
> +		/* VSYS is low */
> +		dev_dbg(chip->dev, "Sys power is too low\n");
> +		break;

This probably ought to be printed by default - with most PMICs if the
system power rail goes low this is an indication of impending system
power failure so it'd be good to make an effort to get the message out
on the console.  Not much use in production but it can be very helpful
during development.

> +static ssize_t charger_state_show(struct device *dev,
> +				  struct device_attribute *attr, char *buf)
> +{
> +	struct max8925_power_info *info = dev_get_drvdata(dev);
> +	char *charge = NULL;
> +	int ret;
> +
> +	ret = max8925_reg_read(info->gpm, MAX8925_CHG_STATUS);
> +	ret = (ret & MAX8925_CHG_STAT_MODE_MASK) >> 2;
> +	switch (ret) {
> +	case 1:
> +		charge = "Fast charging";
> +		break;

There's now a standard power supply property for this so this sysfs file
could be removed and that used instead - POWER_SUPPLY_PROP_CHARGE_TYPE.
