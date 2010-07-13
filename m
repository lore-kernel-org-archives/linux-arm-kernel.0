From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Tue, 13 Jul 2010 22:27:06 +0400
Subject: [PATCH v2 2/3] Add s3c-adc-battery driver
In-Reply-To: <1278781069-30521-3-git-send-email-anarsoul@gmail.com>
References: <1278781069-30521-1-git-send-email-anarsoul@gmail.com>
	<1278781069-30521-3-git-send-email-anarsoul@gmail.com>
Message-ID: <20100713182706.GB12234@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 10, 2010 at 07:57:48PM +0300, Vasily Khoruzhick wrote:
> s3c-adc-battery is driver for monitoring
> and charging battery on iPAQ H1930/H1940/RX1950.
> It depends on s3c-adc driver to get battery voltage and current.
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
[...]
> +static enum power_supply_property s3c_adc_backup_bat_props[] = {
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +	POWER_SUPPLY_PROP_VOLTAGE_MIN,
> +	POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
> +};
> +
> +static int s3c_adc_backup_bat_get_property(struct power_supply *psy,
> +				enum power_supply_property psp,
> +				union power_supply_propval *val);

Do you really need this forward decl? I think you can just rearrange
the code to avoid it.

> +static struct s3c_adc_bat backup_bat = {
> +	.psy = {
> +		.name		= "backup-battery",
> +		.type		= POWER_SUPPLY_TYPE_BATTERY,
> +		.properties	= s3c_adc_backup_bat_props,
> +		.num_properties = ARRAY_SIZE(s3c_adc_backup_bat_props),
> +		.get_property	= s3c_adc_backup_bat_get_property,
> +		.use_for_apm	= 1,
> +	},
> +};
> +
> +static enum power_supply_property s3c_adc_main_bat_props[] = {
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
> +	POWER_SUPPLY_PROP_CHARGE_EMPTY_DESIGN,
> +	POWER_SUPPLY_PROP_CHARGE_NOW,
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +	POWER_SUPPLY_PROP_CURRENT_NOW,
> +};
> +
> +static int s3c_adc_bat_get_property(struct power_supply *psy,
> +				enum power_supply_property psp,
> +				union power_supply_propval *val);

Ditto.

[...]
> +static void s3c_adc_bat_work(struct work_struct *work)
> +{
> +	struct s3c_adc_bat *bat = &main_bat;
> +	int is_charged;
> +	int is_plugged;
> +	static int was_plugged;
> +
> +	is_plugged = power_supply_am_i_supplied(&bat->psy);

Nice, isn't it? :-)

-- 
Anton Vorontsov
email: cbouatmailru at gmail.com
irc://irc.freenode.net/bd2
