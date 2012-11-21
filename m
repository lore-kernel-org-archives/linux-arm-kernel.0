From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Wed, 21 Nov 2012 21:14:18 +0100
Subject: [PATCH v8 1/3] ARM: S3C64XX: Removing old phy setup code
In-Reply-To: <1352889938-17311-2-git-send-email-p.paneri@samsung.com>
References: <1352889938-17311-1-git-send-email-p.paneri@samsung.com>
 <1352889938-17311-2-git-send-email-p.paneri@samsung.com>
Message-ID: <3928531.8Q9Wj2J146@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Praveen,

On Wednesday 14 of November 2012 16:15:36 Praveen Paneri wrote:
> This patch removes old phy code from platform side. 'setup-usb-phy.c'
> will be used for providing transceiver platform data in next
> patch. Not all of the platform data code is removed as there are others
> making use of platform_data defined for hsotg. That can be removed once
> all the SoCs start using the new transceiver for usb phy setup.
> 
> Signed-off-by: Praveen Paneri <p.paneri@samsung.com>
> ---
>  arch/arm/mach-s3c64xx/mach-crag6410.c |    3 -
>  arch/arm/mach-s3c64xx/mach-smartq.c   |    3 -
>  arch/arm/mach-s3c64xx/mach-smdk6410.c |    3 -
>  arch/arm/mach-s3c64xx/setup-usb-phy.c |   79
> --------------------------------- 4 files changed, 0 insertions(+), 88
> deletions(-)
> 
> diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c
> b/arch/arm/mach-s3c64xx/mach-crag6410.c index 2abe95d..48f4a2d 100644
> --- a/arch/arm/mach-s3c64xx/mach-crag6410.c
> +++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
> @@ -31,7 +31,6 @@
>  #include <linux/spi/spi.h>
> 
>  #include <linux/i2c/pca953x.h>
> -#include <linux/platform_data/s3c-hsotg.h>
> 
>  #include <video/platform_lcd.h>
> 
> @@ -805,7 +804,6 @@ static const struct gpio_led_platform_data
> gpio_leds_pdata = { .num_leds = ARRAY_SIZE(gpio_leds),
>  };
> 
> -static struct s3c_hsotg_plat crag6410_hsotg_pdata;
> 
>  static void __init crag6410_machine_init(void)
>  {
> @@ -831,7 +829,6 @@ static void __init crag6410_machine_init(void)
>  	s3c_i2c0_set_platdata(&i2c0_pdata);
>  	s3c_i2c1_set_platdata(&i2c1_pdata);
>  	s3c_fb_set_platdata(&crag6410_lcd_pdata);
> -	s3c_hsotg_set_platdata(&crag6410_hsotg_pdata);
> 
>  	i2c_register_board_info(0, i2c_devs0, ARRAY_SIZE(i2c_devs0));
>  	i2c_register_board_info(1, i2c_devs1, ARRAY_SIZE(i2c_devs1));
> diff --git a/arch/arm/mach-s3c64xx/mach-smartq.c
> b/arch/arm/mach-s3c64xx/mach-smartq.c index c6d7390..59bb34c 100644
> --- a/arch/arm/mach-s3c64xx/mach-smartq.c
> +++ b/arch/arm/mach-s3c64xx/mach-smartq.c
> @@ -18,7 +18,6 @@
>  #include <linux/serial_core.h>
>  #include <linux/spi/spi_gpio.h>
>  #include <linux/usb/gpio_vbus.h>
> -#include <linux/platform_data/s3c-hsotg.h>
> 
>  #include <asm/mach-types.h>
>  #include <asm/mach/map.h>
> @@ -187,7 +186,6 @@ static struct s3c_hwmon_pdata smartq_hwmon_pdata
> __initdata = { },
>  };
> 
> -static struct s3c_hsotg_plat smartq_hsotg_pdata;
> 
>  static int __init smartq_lcd_setup_gpio(void)
>  {
> @@ -385,7 +383,6 @@ void __init smartq_map_io(void)
>  void __init smartq_machine_init(void)
>  {
>  	s3c_i2c0_set_platdata(NULL);
> -	s3c_hsotg_set_platdata(&smartq_hsotg_pdata);
>  	s3c_hwmon_set_platdata(&smartq_hwmon_pdata);
>  	s3c_sdhci1_set_platdata(&smartq_internal_hsmmc_pdata);
>  	s3c_sdhci2_set_platdata(&smartq_internal_hsmmc_pdata);
> diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c
> b/arch/arm/mach-s3c64xx/mach-smdk6410.c index da1a771..123f452 100644
> --- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
> +++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
> @@ -30,7 +30,6 @@
>  #include <linux/regulator/fixed.h>
>  #include <linux/regulator/machine.h>
>  #include <linux/pwm_backlight.h>
> -#include <linux/platform_data/s3c-hsotg.h>
> 
>  #ifdef CONFIG_SMDK6410_WM1190_EV1
>  #include <linux/mfd/wm8350/core.h>
> @@ -627,7 +626,6 @@ static struct platform_pwm_backlight_data
> smdk6410_bl_data = { .pwm_id = 1,
>  };
> 
> -static struct s3c_hsotg_plat smdk6410_hsotg_pdata;
> 
>  static void __init smdk6410_map_io(void)
>  {
> @@ -657,7 +655,6 @@ static void __init smdk6410_machine_init(void)
>  	s3c_i2c0_set_platdata(NULL);
>  	s3c_i2c1_set_platdata(NULL);
>  	s3c_fb_set_platdata(&smdk6410_lcd_pdata);
> -	s3c_hsotg_set_platdata(&smdk6410_hsotg_pdata);
> 
>  	samsung_keypad_set_platdata(&smdk6410_keypad_data);
> 
> diff --git a/arch/arm/mach-s3c64xx/setup-usb-phy.c
> b/arch/arm/mach-s3c64xx/setup-usb-phy.c index f6757e0..7a09553 100644
> --- a/arch/arm/mach-s3c64xx/setup-usb-phy.c
> +++ b/arch/arm/mach-s3c64xx/setup-usb-phy.c
> @@ -9,82 +9,3 @@
>   *
>   */
> 
> -#include <linux/clk.h>
> -#include <linux/delay.h>
> -#include <linux/err.h>
> -#include <linux/io.h>
> -#include <linux/platform_device.h>
> -#include <mach/map.h>
> -#include <mach/regs-sys.h>
> -#include <plat/cpu.h>
> -#include <plat/regs-usb-hsotg-phy.h>
> -#include <plat/usb-phy.h>
> -
> -static int s3c_usb_otgphy_init(struct platform_device *pdev)
> -{
> -	struct clk *xusbxti;
> -	u32 phyclk;
> -
> -	writel(readl(S3C64XX_OTHERS) | S3C64XX_OTHERS_USBMASK,
> S3C64XX_OTHERS); -
> -	/* set clock frequency for PLL */
> -	phyclk = readl(S3C_PHYCLK) & ~S3C_PHYCLK_CLKSEL_MASK;
> -
> -	xusbxti = clk_get(&pdev->dev, "xusbxti");
> -	if (xusbxti && !IS_ERR(xusbxti)) {
> -		switch (clk_get_rate(xusbxti)) {
> -		case 12 * MHZ:
> -			phyclk |= S3C_PHYCLK_CLKSEL_12M;
> -			break;
> -		case 24 * MHZ:
> -			phyclk |= S3C_PHYCLK_CLKSEL_24M;
> -			break;
> -		default:
> -		case 48 * MHZ:
> -			/* default reference clock */
> -			break;
> -		}
> -		clk_put(xusbxti);
> -	}
> -
> -	/* TODO: select external clock/oscillator */
> -	writel(phyclk | S3C_PHYCLK_CLK_FORCE, S3C_PHYCLK);
> -
> -	/* set to normal OTG PHY */
> -	writel((readl(S3C_PHYPWR) & ~S3C_PHYPWR_NORMAL_MASK), S3C_PHYPWR);
> -	mdelay(1);
> -
> -	/* reset OTG PHY and Link */
> -	writel(S3C_RSTCON_PHY | S3C_RSTCON_HCLK | S3C_RSTCON_PHYCLK,
> -			S3C_RSTCON);
> -	udelay(20);	/* at-least 10uS */
> -	writel(0, S3C_RSTCON);
> -
> -	return 0;
> -}
> -
> -static int s3c_usb_otgphy_exit(struct platform_device *pdev)
> -{
> -	writel((readl(S3C_PHYPWR) | S3C_PHYPWR_ANALOG_POWERDOWN |
> -				S3C_PHYPWR_OTG_DISABLE), S3C_PHYPWR);
> -
> -	writel(readl(S3C64XX_OTHERS) & ~S3C64XX_OTHERS_USBMASK,
> S3C64XX_OTHERS); -
> -	return 0;
> -}
> -
> -int s5p_usb_phy_init(struct platform_device *pdev, int type)
> -{
> -	if (type == S5P_USB_PHY_DEVICE)
> -		return s3c_usb_otgphy_init(pdev);
> -
> -	return -EINVAL;
> -}
> -
> -int s5p_usb_phy_exit(struct platform_device *pdev, int type)
> -{
> -	if (type == S5P_USB_PHY_DEVICE)
> -		return s3c_usb_otgphy_exit(pdev);
> -
> -	return -EINVAL;
> -}

This patch will break git bisect, because applying it breaks USB gadget on 
s3c64xx until patch 2 gets applied.

I suggest you to add usb phy support to s3c64xx first and then remove the 
old code.

Best regards,
Tomasz Figa
