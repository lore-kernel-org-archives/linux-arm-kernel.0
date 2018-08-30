From: tony@atomide.com (Tony Lindgren)
Date: Thu, 30 Aug 2018 09:40:57 -0700
Subject: [PATCH] leds: add TI LMU backlight driver
In-Reply-To: <20180830082219.GA10133@amd>
References: <20180829212032.GB15786@amd>
 <20180830082219.GA10133@amd>
Message-ID: <20180830164057.GV7523@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Pavel Machek <pavel@ucw.cz> [180830 08:26]:
> This adds backlight support for the following TI LMU
> chips: LM3532, LM3631, LM3632, LM3633, LM3695 and LM3697.
...
> +struct ti_lmu_bank {
> +	struct device *dev;
> +	int bank_id;
> +	const struct ti_lmu_bl_cfg *cfg;
> +	struct ti_lmu *lmu;
> +	const char *label;
> +	int leds;
> +	int current_brightness;
> +	u32 default_brightness;
> +	u32 ramp_up_msec;
> +	u32 ramp_down_msec;
> +
> +	struct notifier_block nb;
> +
> +	struct led_classdev *led;
> +};
> +
> +static int ti_lmu_bl_enable(struct ti_lmu_bank *lmu_bank, bool enable)
> +{
> +	struct regmap *regmap = lmu_bank->lmu->regmap;
> +	unsigned long enable_time = lmu_bank->cfg->reginfo->enable_usec;
> +	u8 *reg = lmu_bank->cfg->reginfo->enable;
> +	u8 mask = BIT(lmu_bank->bank_id);
> +	u8 val = (enable == true) ? mask : 0;
> +	int ret;
> +
> +	if (!reg)
> +		return -EINVAL;
> +
> +	ret = regmap_update_bits(regmap, *reg, mask, val);
> +	if (ret)
> +		return ret;
> +
> +	if (enable_time > 0)
> +		usleep_range(enable_time, enable_time + 100);
> +
> +	return 0;
> +}

If it's a led driver, should you just s/ti_lmu_bl/ti_lmu_led/g?

Regards,

Tony
