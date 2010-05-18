From: chasedouglas@gmail.com (Chase Douglas)
Date: Tue, 18 May 2010 08:46:04 -0400
Subject: [RFC PATCH 2/3] ep93xx i2s core support
In-Reply-To: <4BF21D74.206@bluewatersys.com>
References: <4BF21B67.8090404@bluewatersys.com> <4BF21D74.206@bluewatersys.com>
Message-ID: <AANLkTikPnVJqHhd4-VYtpLC19zMkrM9LoU3TU1y67zQH@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 18, 2010 at 12:54 AM, Ryan Mallon <ryan@bluewatersys.com> wrote:
> Add ep93xx core support for i2s audio
>
> Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
> ---
>
> diff --git a/arch/arm/mach-ep93xx/clock.c b/arch/arm/mach-ep93xx/clock.c
> index 5f80092..df88233 100644
> --- a/arch/arm/mach-ep93xx/clock.c
> +++ b/arch/arm/mach-ep93xx/clock.c
> @@ -108,6 +108,16 @@ static struct clk clk_video = {
> ? ? ? ?.set_rate ? ? ? = set_div_rate,
> ?};
>
> +static struct clk clk_i2s = {
> + ? ? ? .sw_locked ? ? ?= 1,
> + ? ? ? .enable_reg ? ? = EP93XX_SYSCON_I2SCLKDIV,
> + ? ? ? .enable_mask ? ?= (EP93XX_SYSCON_CLKDIV_ENABLE ?|
> + ? ? ? ? ? ? ? ? ? ? ? ? ?EP93XX_SYSCON_I2SCLKDIV_SENA |
> + ? ? ? ? ? ? ? ? ? ? ? ? ?EP93XX_SYSCON_I2SCLKDIV_SPOL |
> + ? ? ? ? ? ? ? ? ? ? ? ? ?EP93XX_SYSCON_I2SCLKDIV_ORIDE),
> + ? ? ? .set_rate ? ? ? = set_div_rate,
> +};
> +
> ?/* DMA Clocks */
> ?static struct clk clk_m2p0 = {
> ? ? ? ?.parent ? ? ? ? = &clk_h,
> @@ -186,6 +196,7 @@ static struct clk_lookup clocks[] = {
> ? ? ? ?INIT_CK("ep93xx-ohci", ? ? ? ? ?NULL, ? ? ? ? ? &clk_usb_host),
> ? ? ? ?INIT_CK("ep93xx-keypad", ? ? ? ?NULL, ? ? ? ? ? &clk_keypad),
> ? ? ? ?INIT_CK("ep93xx-fb", ? ? ? ? ? ?NULL, ? ? ? ? ? &clk_video),
> + ? ? ? INIT_CK("ep93xx-i2s", ? ? ? ? ? NULL, ? ? ? ? ? &clk_i2s),
> ? ? ? ?INIT_CK(NULL, ? ? ? ? ? ? ? ? ? "pwm_clk", ? ? ?&clk_pwm),
> ? ? ? ?INIT_CK(NULL, ? ? ? ? ? ? ? ? ? "m2p0", ? ? ? ? &clk_m2p0),
> ? ? ? ?INIT_CK(NULL, ? ? ? ? ? ? ? ? ? "m2p1", ? ? ? ? &clk_m2p1),
> diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
> index 90fb591..cceeac2 100644
> --- a/arch/arm/mach-ep93xx/core.c
> +++ b/arch/arm/mach-ep93xx/core.c
> @@ -617,6 +617,37 @@ void ep93xx_keypad_release_gpio(struct platform_device *pdev)
> ?}
> ?EXPORT_SYMBOL(ep93xx_keypad_release_gpio);
>
> +/*************************************************************************
> + * EP93xx I2S audio peripheral handling
> + *************************************************************************/
> +static struct resource ep93xx_i2s_resource[] = {
> + ? ? ? {
> + ? ? ? ? ? ? ? .start ?= EP93XX_I2S_PHYS_BASE,
> + ? ? ? ? ? ? ? .end ? ?= EP93XX_I2S_PHYS_BASE + 0x100 - 1,
> + ? ? ? ? ? ? ? .flags ?= IORESOURCE_MEM,
> + ? ? ? },
> +};
> +
> +static struct platform_device ep93xx_i2s_device = {
> + ? ? ? .name ? ? ? ? ? = "ep93xx-i2s",
> + ? ? ? .id ? ? ? ? ? ? = -1,
> + ? ? ? .num_resources ?= ARRAY_SIZE(ep93xx_i2s_resource),
> + ? ? ? .resource ? ? ? = ep93xx_i2s_resource,
> +};
> +
> +void __init ep93xx_register_i2s(unsigned pins)
> +{
> + ? ? ? if (pins != EP93XX_SYSCON_DEVCFG_I2SONSSP &&
> + ? ? ? ? ? pins != EP93XX_SYSCON_DEVCFG_I2SONAC97) {
> + ? ? ? ? ? ? ? pr_err("Invalid I2S pin configuration - not registering\n");
> + ? ? ? ? ? ? ? return;
> + ? ? ? }
> +
> + ? ? ? ep93xx_devcfg_clear_bits(EP93XX_SYSCON_DEVCFG_I2SONAC97 |
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?EP93XX_SYSCON_DEVCFG_I2SONAC97);

I think one of the above should be *_I2SONSSP?

> + ? ? ? ep93xx_devcfg_set_bits(pins);
> + ? ? ? platform_device_register(&ep93xx_i2s_device);
> +}
>
> ?extern void ep93xx_gpio_init(void);
>
> diff --git a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h b/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
> index 93e2ecc..074d99b 100644
> --- a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
> +++ b/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
> @@ -93,6 +93,7 @@
> ?/* APB peripherals */
> ?#define EP93XX_TIMER_BASE ? ? ? ? ? ? ?EP93XX_APB_IOMEM(0x00010000)
>
> +#define EP93XX_I2S_PHYS_BASE ? ? ? ? ? EP93XX_APB_PHYS(0x00020000)
> ?#define EP93XX_I2S_BASE ? ? ? ? ? ? ? ? ? ? ? ?EP93XX_APB_IOMEM(0x00020000)
>
> ?#define EP93XX_SECURITY_BASE ? ? ? ? ? EP93XX_APB_IOMEM(0x00030000)
> @@ -193,6 +194,10 @@
> ?#define EP93XX_SYSCON_CLKDIV_ESEL ? ? ?(1<<14)
> ?#define EP93XX_SYSCON_CLKDIV_PSEL ? ? ?(1<<13)
> ?#define EP93XX_SYSCON_CLKDIV_PDIV_SHIFT ? ? ? ?8
> +#define EP93XX_SYSCON_I2SCLKDIV ? ? ? ? ? ? ? ?EP93XX_SYSCON_REG(0x8c)
> +#define EP93XX_SYSCON_I2SCLKDIV_SENA ? (1<<31)
> +#define EP93XX_SYSCON_I2SCLKDIV_ORIDE ? (1<<29)
> +#define EP93XX_SYSCON_I2SCLKDIV_SPOL ? (1<<19)
> ?#define EP93XX_SYSCON_KEYTCHCLKDIV ? ? EP93XX_SYSCON_REG(0x90)
> ?#define EP93XX_SYSCON_KEYTCHCLKDIV_TSEN ? ? ? ?(1<<31)
> ?#define EP93XX_SYSCON_KEYTCHCLKDIV_ADIV ? ? ? ?(1<<16)
> diff --git a/arch/arm/mach-ep93xx/include/mach/platform.h b/arch/arm/mach-ep93xx/include/mach/platform.h
> index c6dc14d..9252adf 100644
> --- a/arch/arm/mach-ep93xx/include/mach/platform.h
> +++ b/arch/arm/mach-ep93xx/include/mach/platform.h
> @@ -43,6 +43,7 @@ void ep93xx_pwm_release_gpio(struct platform_device *pdev);
> ?void ep93xx_register_keypad(struct ep93xx_keypad_platform_data *data);
> ?int ep93xx_keypad_acquire_gpio(struct platform_device *pdev);
> ?void ep93xx_keypad_release_gpio(struct platform_device *pdev);
> +void ep93xx_register_i2s(unsigned pins);
>
> ?void ep93xx_init_devices(void);
> ?extern struct sys_timer ep93xx_timer;

-- Chase
