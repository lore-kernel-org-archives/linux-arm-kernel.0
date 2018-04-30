From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Mon, 30 Apr 2018 15:49:16 +0200
Subject: [PATCH] pinctrl: armada-37xx: add suspend/resume support
In-Reply-To: <20180421141731.25556-1-miquel.raynal@bootlin.com> (Miquel
 Raynal's message of "Sat, 21 Apr 2018 16:17:31 +0200")
References: <20180421141731.25556-1-miquel.raynal@bootlin.com>
Message-ID: <87a7tkby8z.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Miquel,
 
 On sam., avril 21 2018, Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> From: Ken Ma <make@marvell.com>
>
> Add suspend/resume hooks in pinctrl driver to handle S2RAM operations.
>
> Beyond the traditional register save/restore operations, these hooks
> also keep the GPIOs used for both-edge IRQ synchronized between their
> level (low/high) and expected IRQ polarity (falling/rising edge).
>
> Since pinctrl is an infrastructure module, its resume should be issued
> prior to other IO drivers. The pinctrl PM is registered as syscore
> level to make sure of it. A postcore initcall is added to register
> syscore operation. Because of the use of such syscore_ops, the
> suspend/resume hooks do not have access to a device pointer, and thus
> need to use a global list in order to keep track of the probed devices
> for which registers have to be saved/restored.

Did you consider to use SET_LATE_SYSTEM_SLEEP_PM_OPS ?

[...]

> +#if defined(CONFIG_PM)
> +static int armada_3700_pinctrl_suspend(void)
> +{
> +	struct armada_37xx_pinctrl *info;
> +
> +	list_for_each_entry(info, &device_list, node) {
> +		/* Save GPIO state */
> +		regmap_read(info->regmap, OUTPUT_EN, &info->pm.out_en_l);
> +		regmap_read(info->regmap, OUTPUT_EN + sizeof(u32),
> +			    &info->pm.out_en_h);
> +		regmap_read(info->regmap, OUTPUT_VAL, &info->pm.out_val_l);
> +		regmap_read(info->regmap, OUTPUT_VAL + sizeof(u32),
> +			    &info->pm.out_val_h);
> +
> +		info->pm.irq_en_l = readl(info->base + IRQ_EN);
> +		info->pm.irq_en_h = readl(info->base + IRQ_EN + sizeof(u32));
> +		info->pm.irq_pol_l = readl(info->base + IRQ_POL);
> +		info->pm.irq_pol_h = readl(info->base + IRQ_POL + sizeof(u32));
> +
> +		/* Save pinctrl state */
> +		regmap_read(info->regmap, SELECTION, &info->pm.selection);

I thought there was an API with regmap which allow to save all the
register in one call. If it is the case it woudl be nice to use it.


Gregory

-- 
Gregory Clement, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
