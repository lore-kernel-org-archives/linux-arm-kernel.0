From: ezequiel@vanguardiasur.com.ar (Ezequiel Garcia)
Date: Thu, 5 Jan 2017 14:34:48 -0300
Subject: [PATCH 17/22] power: supply: add battery driver for AXP20X and
 AXP22X PMICs
In-Reply-To: <20170102163723.7939-18-quentin.schulz@free-electrons.com>
References: <20170102163723.7939-1-quentin.schulz@free-electrons.com>
 <20170102163723.7939-18-quentin.schulz@free-electrons.com>
Message-ID: <CAAEAJfBeu7Z_JeM55Tyj4a2ZOxNWhq7qoPDwFyftoO8sCumVQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2 January 2017 at 13:37, Quentin Schulz
<quentin.schulz@free-electrons.com> wrote:
[...]
> +
> +#define AXP20X_PWR_STATUS_BAT_CHARGING BIT(2)
> +
> +#define AXP20X_PWR_OP_BATT_PRESENT     BIT(5)
> +#define AXP20X_PWR_OP_BATT_ACTIVATED   BIT(3)
> +
> +#define AXP209_FG_PERCENT              GENMASK(6, 0)
> +#define AXP22X_FG_VALID                        BIT(7)
> +
> +#define AXP20X_CHRG_CTRL1_TGT_VOLT     GENMASK(6, 5)
> +#define AXP20X_CHRG_CTRL1_TGT_4_1V     (0 << 5)
> +#define AXP20X_CHRG_CTRL1_TGT_4_15V    BIT(5)

This is just a silly nit, but I would put (1 << 5) here
for readability.

> +#define AXP20X_CHRG_CTRL1_TGT_4_2V     (2 << 5)
> +#define AXP20X_CHRG_CTRL1_TGT_4_36V    (3 << 5)
> +#define AXP20X_CHRG_CTRL1_TGT_CURR     GENMASK(3, 0)
> +
> +#define AXP22X_CHRG_CTRL1_TGT_4_22V    BIT(5)

Ditto.

> +#define AXP22X_CHRG_CTRL1_TGT_4_24V    (3 << 5)
> +
> +#define AXP20X_V_OFF_MASK              GENMASK(2, 0)
> +
> +struct axp20x_batt_ps {
> +       struct regmap *regmap;
> +       struct power_supply *batt;
> +       struct axp20x_dev *axp20x;
> +       struct iio_channel *batt_chrg_i;
> +       struct iio_channel *batt_dischrg_i;
> +       struct iio_channel *batt_v;
> +       u8 axp_id;
> +};
> +
[..]
> +static int axp20x_power_probe(struct platform_device *pdev)
> +{
> +       struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
> +       struct axp20x_batt_ps *axp20x_batt;
> +       struct power_supply_config psy_cfg = {};
> +

To be consistent with the AC power supply and USB power supply,
you might want to call of_device_is_available() here.
Otherwise, the device probes even if "disabled" in the DTS.

> +       axp20x_batt = devm_kzalloc(&pdev->dev, sizeof(*axp20x_batt),
> +                                  GFP_KERNEL);
> +       if (!axp20x_batt)
> +               return -ENOMEM;
> +

Thanks for the good work,
-- 
Ezequiel Garc?a, VanguardiaSur
www.vanguardiasur.com.ar
