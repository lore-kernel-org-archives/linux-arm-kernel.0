From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 10 Feb 2014 14:05:37 +0200
Subject: [PATCH] video: imxfb: Use regulator API with LCD class for
 powering
In-Reply-To: <1387624080-15312-1-git-send-email-shc_work@mail.ru>
References: <1387624080-15312-1-git-send-email-shc_work@mail.ru>
Message-ID: <52F8C091.50704@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/12/13 13:08, Alexander Shiyan wrote:
> This patch replaces custom lcd_power() callback with
> regulator API over LCD class.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  .../devicetree/bindings/video/fsl,imx-fb.txt       |  1 +
>  arch/arm/mach-imx/mach-mx27ads.c                   | 55 +++++++++++++++--
>  drivers/video/imxfb.c                              | 71 +++++++++++++++++++---
>  include/linux/platform_data/video-imxfb.h          |  1 -
>  4 files changed, 114 insertions(+), 14 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/video/fsl,imx-fb.txt b/Documentation/devicetree/bindings/video/fsl,imx-fb.txt
> index 46da08d..e6b1ee9 100644
> --- a/Documentation/devicetree/bindings/video/fsl,imx-fb.txt
> +++ b/Documentation/devicetree/bindings/video/fsl,imx-fb.txt
> @@ -15,6 +15,7 @@ Required nodes:
>  	- fsl,pcr: LCDC PCR value
>  
>  Optional properties:
> +- lcd-supply: Regulator for LCD supply voltage.
>  - fsl,dmacr: DMA Control Register value. This is optional. By default, the
>  	register is not modified as recommended by the datasheet.
>  - fsl,lscr1: LCDC Sharp Configuration Register value.
> diff --git a/arch/arm/mach-imx/mach-mx27ads.c b/arch/arm/mach-imx/mach-mx27ads.c
> index 9821b824..a7a4a9c 100644
> --- a/arch/arm/mach-imx/mach-mx27ads.c
> +++ b/arch/arm/mach-imx/mach-mx27ads.c
> @@ -21,6 +21,10 @@
>  #include <linux/mtd/physmap.h>
>  #include <linux/i2c.h>
>  #include <linux/irq.h>
> +
> +#include <linux/regulator/fixed.h>
> +#include <linux/regulator/machine.h>
> +
>  #include <asm/mach-types.h>
>  #include <asm/mach/arch.h>
>  #include <asm/mach/time.h>
> @@ -195,14 +199,58 @@ static const struct imxi2c_platform_data mx27ads_i2c1_data __initconst = {
>  static struct i2c_board_info mx27ads_i2c_devices[] = {
>  };
>  
> -void lcd_power(int on)
> +static void vgpio_set(struct gpio_chip *chip, unsigned offset, int value)
>  {
> -	if (on)
> +	if (value)
>  		__raw_writew(PBC_BCTRL1_LCDON, PBC_BCTRL1_SET_REG);
>  	else
>  		__raw_writew(PBC_BCTRL1_LCDON, PBC_BCTRL1_CLEAR_REG);
>  }
>  
> +static int vgpio_dir_out(struct gpio_chip *chip, unsigned offset, int value)
> +{
> +	return 0;
> +}
> +
> +#define MX27ADS_LCD_GPIO	(6 * 32)
> +
> +static struct regulator_consumer_supply mx27ads_lcd_regulator_consumer =
> +	REGULATOR_SUPPLY("lcd", "imx-fb.0");
> +
> +static struct regulator_init_data mx27ads_lcd_regulator_init_data = {
> +	.constraints	= {
> +		.valid_ops_mask	= REGULATOR_CHANGE_STATUS,
> +},
> +	.consumer_supplies	= &mx27ads_lcd_regulator_consumer,
> +	.num_consumer_supplies	= 1,
> +};
> +
> +static struct fixed_voltage_config mx27ads_lcd_regulator_pdata = {
> +	.supply_name	= "LCD",
> +	.microvolts	= 3300000,
> +	.gpio		= MX27ADS_LCD_GPIO,
> +	.init_data	= &mx27ads_lcd_regulator_init_data,
> +};
> +
> +static void __init mx27ads_regulator_init(void)
> +{
> +	struct gpio_chip *vchip;
> +
> +	vchip = kzalloc(sizeof(*vchip), GFP_KERNEL);
> +	vchip->owner		= THIS_MODULE;
> +	vchip->label		= "LCD";
> +	vchip->base		= MX27ADS_LCD_GPIO;
> +	vchip->ngpio		= 1;
> +	vchip->direction_output	= vgpio_dir_out;
> +	vchip->set		= vgpio_set;
> +	gpiochip_add(vchip);
> +
> +	platform_device_register_data(&platform_bus, "reg-fixed-voltage",
> +				      PLATFORM_DEVID_AUTO,
> +				      &mx27ads_lcd_regulator_pdata,
> +				      sizeof(mx27ads_lcd_regulator_pdata));
> +}
> +

Hmm, isn't all this something that should be in the board's .dts?

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140210/7e251ede/attachment.sig>
