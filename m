From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 4 Jan 2012 12:52:18 -0700
Subject: [PATCH 1/6] ARM: tegra: Remove use of TEGRA_GPIO_TO_IRQ
In-Reply-To: <1325702378-20863-1-git-send-email-swarren@nvidia.com>
References: <1325702378-20863-1-git-send-email-swarren@nvidia.com>
Message-ID: <20120104195218.GF15503@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 04, 2012 at 11:39:33AM -0700, Stephen Warren wrote:
> Replace compile-time usage of TEGRA_GPIO_TO_IRQ with run-time calls to
> gpio_to_irq(). This will allow the base IRQ number for the Tegra GPIO
> driver to be dynamically allocated in a later patch.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

For the whole series:
Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
> This series is 3.4 material (obviously I guess!)
> 
>  arch/arm/mach-tegra/board-harmony.c  |    2 +-
>  arch/arm/mach-tegra/board-seaboard.c |    5 +++--
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-tegra/board-harmony.c b/arch/arm/mach-tegra/board-harmony.c
> index 789bdc9..c00aadb 100644
> --- a/arch/arm/mach-tegra/board-harmony.c
> +++ b/arch/arm/mach-tegra/board-harmony.c
> @@ -101,7 +101,6 @@ static struct wm8903_platform_data harmony_wm8903_pdata = {
>  static struct i2c_board_info __initdata wm8903_board_info = {
>  	I2C_BOARD_INFO("wm8903", 0x1a),
>  	.platform_data = &harmony_wm8903_pdata,
> -	.irq = TEGRA_GPIO_TO_IRQ(TEGRA_GPIO_CDC_IRQ),
>  };
>  
>  static void __init harmony_i2c_init(void)
> @@ -111,6 +110,7 @@ static void __init harmony_i2c_init(void)
>  	platform_device_register(&tegra_i2c_device3);
>  	platform_device_register(&tegra_i2c_device4);
>  
> +	wm8903_board_info.irq = gpio_to_irq(TEGRA_GPIO_CDC_IRQ);
>  	i2c_register_board_info(0, &wm8903_board_info, 1);
>  }
>  
> diff --git a/arch/arm/mach-tegra/board-seaboard.c b/arch/arm/mach-tegra/board-seaboard.c
> index ebac65f..d669847 100644
> --- a/arch/arm/mach-tegra/board-seaboard.c
> +++ b/arch/arm/mach-tegra/board-seaboard.c
> @@ -159,7 +159,6 @@ static struct platform_device *seaboard_devices[] __initdata = {
>  
>  static struct i2c_board_info __initdata isl29018_device = {
>  	I2C_BOARD_INFO("isl29018", 0x44),
> -	.irq = TEGRA_GPIO_TO_IRQ(TEGRA_GPIO_ISL29018_IRQ),
>  };
>  
>  static struct i2c_board_info __initdata adt7461_device = {
> @@ -183,7 +182,6 @@ static struct wm8903_platform_data wm8903_pdata = {
>  static struct i2c_board_info __initdata wm8903_device = {
>  	I2C_BOARD_INFO("wm8903", 0x1a),
>  	.platform_data = &wm8903_pdata,
> -	.irq = TEGRA_GPIO_TO_IRQ(TEGRA_GPIO_CDC_IRQ),
>  };
>  
>  static int seaboard_ehci_init(void)
> @@ -214,7 +212,10 @@ static void __init seaboard_i2c_init(void)
>  	gpio_request(TEGRA_GPIO_ISL29018_IRQ, "isl29018");
>  	gpio_direction_input(TEGRA_GPIO_ISL29018_IRQ);
>  
> +	isl29018_device.irq = gpio_to_irq(TEGRA_GPIO_ISL29018_IRQ);
>  	i2c_register_board_info(0, &isl29018_device, 1);
> +
> +	wm8903_device.irq = gpio_to_irq(TEGRA_GPIO_CDC_IRQ);
>  	i2c_register_board_info(0, &wm8903_device, 1);
>  
>  	i2c_register_board_info(3, &adt7461_device, 1);
> -- 
> 1.7.0.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
