From: olof@lixom.net (Olof Johansson)
Date: Tue, 11 Oct 2011 14:29:15 -0700
Subject: [PATCH v2 3/4] gpio/tegra: Convert to a platform device
In-Reply-To: <1318364638-20191-4-git-send-email-swarren@nvidia.com>
References: <1318364638-20191-1-git-send-email-swarren@nvidia.com>
	<1318364638-20191-4-git-send-email-swarren@nvidia.com>
Message-ID: <20111011212915.GA706@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Some nits below. Overall looks good.

On Tue, Oct 11, 2011 at 02:23:57PM -0600, Stephen Warren wrote:
> @@ -76,16 +75,20 @@ struct tegra_gpio_bank {
>  };
>  
>  
> -static struct tegra_gpio_bank tegra_gpio_banks[] = {
> -	{.bank = 0, .irq = INT_GPIO1},
> -	{.bank = 1, .irq = INT_GPIO2},
> -	{.bank = 2, .irq = INT_GPIO3},
> -	{.bank = 3, .irq = INT_GPIO4},
> -	{.bank = 4, .irq = INT_GPIO5},
> -	{.bank = 5, .irq = INT_GPIO6},
> -	{.bank = 6, .irq = INT_GPIO7},
> +void __iomem *regs;

Should be static.

> +static struct tegra_gpio_bank tegra_gpio_banks[7] = {
>  };

Can be on the same line as the rest, i.e.  ... = { };

> +static inline void tegra_gpio_writel(u32 val, u32 reg)
> +{
> +	__raw_writel(val, regs + reg);
> +}
> +
> +static inline u32 tegra_gpio_readl(u32 reg)
> +{
> +	return __raw_readl(regs + reg);
> +}
> +
>  static int tegra_gpio_compose(int bank, int port, int bit)
>  {
>  	return (bank << 5) | ((port & 0x3) << 3) | (bit & 0x7);

[...]

> @@ -333,28 +336,55 @@ static struct irq_chip tegra_gpio_irq_chip = {
>   */
>  static struct lock_class_key gpio_lock_class;
>  
> -static int __init tegra_gpio_init(void)
> +static int __init tegra_gpio_probe(struct platform_device *pdev)
>  {
> +	struct resource *res;
>  	struct tegra_gpio_bank *bank;
>  	int gpio;
>  	int i;
>  	int j;
>  
> +	for (i = 0; i < ARRAY_SIZE(tegra_gpio_banks); i++) {
> +		res = platform_get_resource(pdev, IORESOURCE_IRQ, i);
> +		if (!res) {
> +			dev_err(&pdev->dev, "Missing IRQ resource\n");
> +			return -ENODEV;
> +		}
> +
> +		bank = &tegra_gpio_banks[i];
> +		bank->bank = i;
> +		bank->irq = res->start;
> +	}
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev, "Missing MEM resource\n");
> +		return -ENODEV;
> +	}
> +
> +	if (!devm_request_mem_region(&pdev->dev, res->start,
> +				     resource_size(res),
> +				     dev_name(&pdev->dev))) {
> +		dev_err(&pdev->dev, "Couldn't request MEM resource\n");
> +		return -ENODEV;
> +	}
> +
> +	regs = devm_ioremap(&pdev->dev, res->start, resource_size(res));
> +	if (!regs) {
> +		dev_err(&pdev->dev, "Couldn't ioremap regs\n");
> +		return -ENODEV;

Should you release the mem region requested above here?


-Olof
