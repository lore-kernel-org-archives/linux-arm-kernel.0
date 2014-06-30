From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 30 Jun 2014 19:05:47 +0200
Subject: [PATCH v5 4/5] ARM: EXYNOS: Add platform driver support for Exynos
 PMU
In-Reply-To: <1403705032-14835-5-git-send-email-pankaj.dubey@samsung.com>
References: <1403705032-14835-1-git-send-email-pankaj.dubey@samsung.com>
 <1403705032-14835-5-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <53B198EB.80502@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pankaj,

Please see my comments inline.

On 25.06.2014 16:03, Pankaj Dubey wrote:
> This patch modifies Exynos Power Management Unit (PMU) initialization
> implementation in following way:
> 
> - Added platform driver support and probe function where Exynos PMU
>   driver will register itself as syscon provider with syscon framework.
> - Added platform struct exynos_pmu_data to hold platform specific data.
> - For each SoC's PMU support now we can add platform data and statically
>   bind PMU configuration and SoC specific initialization function.
> - Separate each SoC's PMU initialization function and make it as part of
>   platform data.
> - It also removes uses of soc_is_exynosXYZ().

[snip]

> @@ -93,7 +112,7 @@ static const struct exynos_pmu_conf exynos4210_pmu_config[] = {
>  	{ PMU_TABLE_END,},
>  };
>  
> -static const struct exynos_pmu_conf exynos4x12_pmu_config[] = {
> +static const struct exynos_pmu_conf exynos4212_pmu_config[] = {

Why the name change?

>  	{ S5P_ARM_CORE0_LOWPWR,			{ 0x0, 0x0, 0x2 } },
>  	{ S5P_DIS_IRQ_CORE0,			{ 0x0, 0x0, 0x0 } },
>  	{ S5P_DIS_IRQ_CENTRAL0,			{ 0x0, 0x0, 0x0 } },
> @@ -335,7 +354,7 @@ static unsigned int const exynos5_list_diable_wfi_wfe[] = {
>  	EXYNOS5_ISP_ARM_OPTION,
>  };
>  
> -static void exynos5_init_pmu(void)
> +static void exynos5_powerdown_conf(enum sys_powerdown mode)
>  {
>  	unsigned int i;
>  	unsigned int tmp;
> @@ -372,51 +391,151 @@ void exynos_sys_powerdown_conf(enum sys_powerdown mode)
>  {
>  	unsigned int i;
>  
> -	if (soc_is_exynos5250())
> -		exynos5_init_pmu();
> +	struct exynos_pmu_data *pmu_data = pmu_context->pmu_data;
> +
> +	if (!pmu_data)
> +		return;
>  
> -	for (i = 0; (exynos_pmu_config[i].offset != PMU_TABLE_END) ; i++)
> -		__raw_writel(exynos_pmu_config[i].val[mode],
> -				pmu_base_addr + exynos_pmu_config[i].offset);
> +	if (pmu_data->powerdown_conf)
> +		pmu_data->powerdown_conf(mode);
>  
> -	if (soc_is_exynos4412()) {
> -		for (i = 0; exynos4412_pmu_config[i].offset != PMU_TABLE_END ; i++)
> -			__raw_writel(exynos4412_pmu_config[i].val[mode],
> -				pmu_base_addr + exynos4412_pmu_config[i].offset);
> +	if (pmu_data->pmu_config) {
> +		for (i = 0; (pmu_data->pmu_config[i].offset != PMU_TABLE_END) ; i++)
> +			__raw_writel(pmu_data->pmu_config[i].val[mode],
> +					pmu_base_addr + pmu_data->pmu_config[i].offset);

Analogically to patch 2/5, you could add static inline accessors and use
them instead of adding pmu_base_addr every time.

> +	}
> +
> +	if (pmu_data->pmu_config_extra) {
> +		for (i = 0; pmu_data->pmu_config_extra[i].offset != PMU_TABLE_END; i++)
> +			__raw_writel(pmu_data->pmu_config_extra[i].val[mode],
> +					pmu_base_addr + pmu_data->pmu_config_extra[i].offset);
>  	}
>  }
>  
> -static int __init exynos_pmu_init(void)
> +static void exynos5250_pmu_init(void)
>  {
>  	unsigned int value;
> +	/*
> +	 * When SYS_WDTRESET is set, watchdog timer reset request
> +	 * is ignored by power management unit.
> +	 */
> +	value = __raw_readl(pmu_base_addr + EXYNOS5_AUTO_WDTRESET_DISABLE);
> +	value &= ~EXYNOS5_SYS_WDTRESET;
> +	__raw_writel(value, pmu_base_addr + EXYNOS5_AUTO_WDTRESET_DISABLE);
> +
> +	value = __raw_readl(pmu_base_addr + EXYNOS5_MASK_WDTRESET_REQUEST);
> +	value &= ~EXYNOS5_SYS_WDTRESET;
> +	__raw_writel(value, pmu_base_addr + EXYNOS5_MASK_WDTRESET_REQUEST);
> +}
> +
> +static struct exynos_pmu_data exynos4210_pmu_data = {

static const struct

> +	.pmu_config	= exynos4210_pmu_config,
> +};
> +
> +static struct exynos_pmu_data exynos4212_pmu_data = {

static const struct

> +	.pmu_config	= exynos4212_pmu_config,
> +};
> +
> +static struct exynos_pmu_data exynos4412_pmu_data = {

static const struct

> +	.pmu_config		= exynos4212_pmu_config,
> +	.pmu_config_extra	= exynos4412_pmu_config,
> +};
> +
> +static struct exynos_pmu_data exynos5250_pmu_data = {

static const struct

> +	.pmu_config	= exynos5250_pmu_config,
> +	.pmu_init	= exynos5250_pmu_init,
> +	.powerdown_conf	= exynos5_powerdown_conf,
> +};
>  
> -	exynos_pmu_config = exynos4210_pmu_config;
> -
> -	if (soc_is_exynos4210()) {
> -		exynos_pmu_config = exynos4210_pmu_config;
> -		pr_info("EXYNOS4210 PMU Initialize\n");
> -	} else if (soc_is_exynos4212() || soc_is_exynos4412()) {
> -		exynos_pmu_config = exynos4x12_pmu_config;
> -		pr_info("EXYNOS4x12 PMU Initialize\n");
> -	} else if (soc_is_exynos5250()) {
> -		/*
> -		 * When SYS_WDTRESET is set, watchdog timer reset request
> -		 * is ignored by power management unit.
> -		 */
> -		value = __raw_readl(pmu_base_addr + EXYNOS5_AUTO_WDTRESET_DISABLE);
> -		value &= ~EXYNOS5_SYS_WDTRESET;
> -		__raw_writel(value, pmu_base_addr + EXYNOS5_AUTO_WDTRESET_DISABLE);
> -
> -		value = __raw_readl(pmu_base_addr + EXYNOS5_MASK_WDTRESET_REQUEST);
> -		value &= ~EXYNOS5_SYS_WDTRESET;
> -		__raw_writel(value, pmu_base_addr + EXYNOS5_MASK_WDTRESET_REQUEST);
> -
> -		exynos_pmu_config = exynos5250_pmu_config;
> -		pr_info("EXYNOS5250 PMU Initialize\n");
> -	} else {
> -		pr_info("EXYNOS: PMU not supported\n");
> +static struct regmap_config pmu_regmap_config = {

static const struct

> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +};
> +
> +/*
> + * PMU platform driver and devicetree bindings.
> + */
> +static struct of_device_id exynos_pmu_of_device_ids[] = {

static const struct

> +	{
> +		.compatible = "samsung,exynos4210-pmu",
> +		.data = (void *)&exynos4210_pmu_data,

No need for the cast.

> +	},
> +	{

nit: You could place both parentheses in the same line, i.e.

	}, {

> +		.compatible = "samsung,exynos4212-pmu",
> +		.data = (void *)&exynos4212_pmu_data,

Ditto.

> +	},
> +	{
> +		.compatible = "samsung,exynos4412-pmu",
> +		.data = (void *)&exynos4412_pmu_data,

Ditto.

> +	},
> +	{
> +		.compatible = "samsung,exynos5250-pmu",
> +		.data = (void *)&exynos5250_pmu_data,

Ditto.

> +	},
> +	{},

It is a good practice to put a comment inside the sentinel, e.g.

	{ /* sentinel */ }

> +};
> +
> +static int exynos_pmu_probe(struct platform_device *pdev)
> +{
> +	const struct of_device_id *match;
> +	struct device *dev = &pdev->dev;
> +	struct regmap *regmap;
> +	struct resource *res;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -ENOENT;

No need to check this here, if you use devm_ioremap_resource() instead.

> +
> +	pmu_base_addr = devm_ioremap(dev, res->start, resource_size(res));

You could use devm_ioremap_resource() instead. In addition to handling
the resource directly without the need to access its internals here, it
also checks the validity of the resource pointer.

> +	if (IS_ERR(pmu_base_addr))
> +		return PTR_ERR(pmu_base_addr);
> +
> +	pmu_context = devm_kzalloc(&pdev->dev,
> +			sizeof(struct exynos_pmu_context),
> +			GFP_KERNEL);
> +
> +	if (pmu_context == NULL) {

nit: Extraneous blank line.
nit: Inconsistent pointer check (!res above, but == NULL here), just use
!ptr everywhere, please.

> +		dev_err(dev, "Cannot allocate memory.\n");
> +		return -ENOMEM;
> +	}
> +
> +	regmap = devm_regmap_init_mmio(dev, pmu_base_addr,
> +					&pmu_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		dev_err(dev, "regmap init failed\n");
> +		return PTR_ERR(regmap);
>  	}
>  
> +	devm_syscon_register(dev, regmap);
> +
> +	match = of_match_node(exynos_pmu_of_device_ids, pdev->dev.of_node);
> +
> +	pmu_context->pmu_data = (struct exynos_pmu_data *) match->data;

No need to cast if you change all affected pointers to const.

> +
> +	if (pmu_context->pmu_data && pmu_context->pmu_data->pmu_init)

In what conditions pmu_data will be NULL?

> +		pmu_context->pmu_data->pmu_init();
> +
> +	pmu_context->dev = dev;

I believe this should be set before calling pmu_init().

> +
> +	platform_set_drvdata(pdev, pmu_context);
> +
> +	pr_info("Exynos PMU Driver probe done!!!\n");

Hurrah, the driver probed! The users won't care, though, and they might
find those exclamation marks scary. ;)

dev_dbg() without those exclamation marks would be more appropriate.

Best regards,
Tomasz
