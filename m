From: robherring2@gmail.com (Rob Herring)
Date: Wed, 04 Jan 2012 13:54:25 -0600
Subject: [PATCH 6/6] gpio: tegra: Parameterize the number of banks
In-Reply-To: <1325702378-20863-6-git-send-email-swarren@nvidia.com>
References: <1325702378-20863-1-git-send-email-swarren@nvidia.com>
 <1325702378-20863-6-git-send-email-swarren@nvidia.com>
Message-ID: <4F04AE71.2090203@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/04/2012 12:39 PM, Stephen Warren wrote:
> Tegra20's GPIO controller has 7 banks, and Tegra30's controller has 8
> banks. Allow the number of banks to be configured at run-time by the
> device tree.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> This patch depends on:
> http://ftp.arm.linux.org.uk/pub/armlinux/kernel/git-cur/linux-2.6-arm.git
> devel-stable 44986ab056076e9dc9fb9f8b4729afef7fa72616
> ---
>  .../devicetree/bindings/gpio/gpio_nvidia.txt       |    4 ++
>  arch/arm/boot/dts/tegra20.dtsi                     |    1 +
>  arch/arm/boot/dts/tegra30.dtsi                     |    1 +
>  drivers/gpio/gpio-tegra.c                          |   41 +++++++++++++++----
>  4 files changed, 38 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/gpio/gpio_nvidia.txt b/Documentation/devicetree/bindings/gpio/gpio_nvidia.txt
> index d114e19..f9c2cc2 100644
> --- a/Documentation/devicetree/bindings/gpio/gpio_nvidia.txt
> +++ b/Documentation/devicetree/bindings/gpio/gpio_nvidia.txt
> @@ -3,6 +3,9 @@ NVIDIA Tegra 2 GPIO controller
>  Required properties:
>  - compatible : "nvidia,tegra20-gpio"
>  - reg : Physical base address and length of the controller's registers.
> +- nvidia,num-banks : The number of GPIO banks. This should be 7 for
> +  Tegra20 and 8 for Tegra30. This must match the number of interrupt
> +  specifiers in the interrupts property.

You can determine the number of banks based on the compatible property
rather than needing an additional property.

Otherwise, for the series:

Acked-by: Rob Herring <rob.herring@calxeda.com>

Rob

>  - interrupts : The interrupt outputs from the controller.
>  - #gpio-cells : Should be two. The first cell is the pin number and the
>    second cell is used to specify optional parameters:
> @@ -24,6 +27,7 @@ Example:
>  gpio: gpio at 6000d000 {
>  	compatible = "nvidia,tegra20-gpio";
>  	reg = < 0x6000d000 0x1000 >;
> +	nvidia,num-banks = <7>;
>  	interrupts = < 0 32 0x04
>  		       0 33 0x04
>  		       0 34 0x04
> diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
> index 0cdc4a6..853a5c6 100644
> --- a/arch/arm/boot/dts/tegra20.dtsi
> +++ b/arch/arm/boot/dts/tegra20.dtsi
> @@ -66,6 +66,7 @@
>  	gpio: gpio at 6000d000 {
>  		compatible = "nvidia,tegra20-gpio";
>  		reg = < 0x6000d000 0x1000 >;
> +		nvidia,num-banks = <7>;
>  		interrupts = < 0 32 0x04
>  			       0 33 0x04
>  			       0 34 0x04
> diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
> index 83024c0..368cbb3 100644
> --- a/arch/arm/boot/dts/tegra30.dtsi
> +++ b/arch/arm/boot/dts/tegra30.dtsi
> @@ -55,6 +55,7 @@
>  	gpio: gpio at 6000d000 {
>  		compatible = "nvidia,tegra30-gpio", "nvidia,tegra20-gpio";
>  		reg = < 0x6000d000 0x1000 >;
> +		nvidia,num-banks = <8>;
>  		interrupts = < 0 32 0x04
>  			       0 33 0x04
>  			       0 34 0x04
> diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
> index c877a33..d27ca13 100644
> --- a/drivers/gpio/gpio-tegra.c
> +++ b/drivers/gpio/gpio-tegra.c
> @@ -77,7 +77,8 @@ struct tegra_gpio_bank {
>  
>  static struct irq_domain irq_domain;
>  static void __iomem *regs;
> -static struct tegra_gpio_bank tegra_gpio_banks[7];
> +static u32 tegra_gpio_bank_count;
> +static struct tegra_gpio_bank *tegra_gpio_banks;
>  
>  static inline void tegra_gpio_writel(u32 val, u32 reg)
>  {
> @@ -274,7 +275,7 @@ void tegra_gpio_resume(void)
>  
>  	local_irq_save(flags);
>  
> -	for (b = 0; b < ARRAY_SIZE(tegra_gpio_banks); b++) {
> +	for (b = 0; b < tegra_gpio_bank_count; b++) {
>  		struct tegra_gpio_bank *bank = &tegra_gpio_banks[b];
>  
>  		for (p = 0; p < ARRAY_SIZE(bank->oe); p++) {
> @@ -297,7 +298,7 @@ void tegra_gpio_suspend(void)
>  	int p;
>  
>  	local_irq_save(flags);
> -	for (b = 0; b < ARRAY_SIZE(tegra_gpio_banks); b++) {
> +	for (b = 0; b < tegra_gpio_bank_count; b++) {
>  		struct tegra_gpio_bank *bank = &tegra_gpio_banks[b];
>  
>  		for (p = 0; p < ARRAY_SIZE(bank->oe); p++) {
> @@ -338,23 +339,45 @@ static struct lock_class_key gpio_lock_class;
>  
>  static int __devinit tegra_gpio_probe(struct platform_device *pdev)
>  {
> +	int irq_base;
>  	struct resource *res;
>  	struct tegra_gpio_bank *bank;
>  	int gpio;
>  	int i;
>  	int j;
>  
> -	irq_domain.irq_base = irq_alloc_descs(-1, 0, TEGRA_NR_GPIOS, 0);
> -	if (irq_domain.irq_base < 0) {
> +	if (pdev->dev.of_node) {
> +		if (of_property_read_u32(pdev->dev.of_node, "nvidia,num-banks",
> +					 &tegra_gpio_bank_count) < 0) {
> +			dev_err(&pdev->dev,
> +				"Missing property 'nvidia,num-banks'\n");
> +			return -ENODEV;
> +		}
> +	}
> +	if (!tegra_gpio_bank_count)
> +		tegra_gpio_bank_count = 7;
> +	tegra_gpio_chip.ngpio = tegra_gpio_bank_count * 32;
> +
> +	tegra_gpio_banks = devm_kzalloc(&pdev->dev,
> +			tegra_gpio_bank_count * sizeof(*tegra_gpio_banks),
> +			GFP_KERNEL);
> +	if (!tegra_gpio_banks) {
> +		dev_err(&pdev->dev, "Couldn't allocate bank structure\n");
> +		return -ENODEV;
> +	}
> +
> +	irq_base = irq_alloc_descs(-1, 0, tegra_gpio_chip.ngpio, 0);
> +	if (irq_base < 0) {
>  		dev_err(&pdev->dev, "Couldn't allocate IRQ numbers\n");
>  		return -ENODEV;
>  	}
> -	irq_domain.nr_irq = TEGRA_NR_GPIOS;
> +	irq_domain.irq_base = irq_base;
> +	irq_domain.nr_irq = tegra_gpio_chip.ngpio;
>  	irq_domain.ops = &irq_domain_simple_ops;
>  	irq_domain.of_node = pdev->dev.of_node;
>  	irq_domain_add(&irq_domain);
>  
> -	for (i = 0; i < ARRAY_SIZE(tegra_gpio_banks); i++) {
> +	for (i = 0; i < tegra_gpio_bank_count; i++) {
>  		res = platform_get_resource(pdev, IORESOURCE_IRQ, i);
>  		if (!res) {
>  			dev_err(&pdev->dev, "Missing IRQ resource\n");
> @@ -398,7 +421,7 @@ static int __devinit tegra_gpio_probe(struct platform_device *pdev)
>  
>  	gpiochip_add(&tegra_gpio_chip);
>  
> -	for (gpio = 0; gpio < TEGRA_NR_GPIOS; gpio++) {
> +	for (gpio = 0; gpio < tegra_gpio_chip.ngpio; gpio++) {
>  		int irq = irq_domain_to_irq(&irq_domain, gpio);
>  		/* No validity check; all Tegra GPIOs are valid IRQs */
>  
> @@ -411,7 +434,7 @@ static int __devinit tegra_gpio_probe(struct platform_device *pdev)
>  		set_irq_flags(irq, IRQF_VALID);
>  	}
>  
> -	for (i = 0; i < ARRAY_SIZE(tegra_gpio_banks); i++) {
> +	for (i = 0; i < tegra_gpio_bank_count; i++) {
>  		bank = &tegra_gpio_banks[i];
>  
>  		irq_set_chained_handler(bank->irq, tegra_gpio_irq_handler);
