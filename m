From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 3 Nov 2011 08:18:25 +0100
Subject: [PATCH] ARM : mx35: 3ds-board: add framebuffer device
In-Reply-To: <1320299797-23167-1-git-send-email-b39297@freescale.com>
References: <1320299797-23167-1-git-send-email-b39297@freescale.com>
Message-ID: <20111103071824.GB16886@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 03, 2011 at 01:56:37PM +0800, wu guoxing wrote:
> This patch adds framebuffer support for freescale mx35 3ds board
> 
> Signed-off-by: Wu Guoxing <b39297@freescale.com>
> ---
>  arch/arm/mach-imx/mach-mx35_3ds.c |   99 +++++++++++++++++++++++++++++++++++++
>  1 files changed, 99 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/mach-mx35_3ds.c b/arch/arm/mach-imx/mach-mx35_3ds.c
> index 5a5eb3e..e7889ca 100644
> --- a/arch/arm/mach-imx/mach-mx35_3ds.c
> +++ b/arch/arm/mach-imx/mach-mx35_3ds.c
> @@ -40,9 +40,74 @@
>  #include <mach/iomux-mx35.h>
>  #include <mach/irqs.h>
>  #include <mach/3ds_debugboard.h>
> +#include <video/platform_lcd.h>
>  
>  #include "devices-imx35.h"
>  
> +static const struct fb_videomode fb_modedb[] = {
> +	{
> +	 /* 800x480 @ 55 Hz */
> +	 .name = "Ceramate-CLAA070VC01",
> +	 .refresh = 55,
> +	 .xres = 800,
> +	 .yres = 480,
> +	 .pixclock = 40000,
> +	 .left_margin = 40,
> +	 .right_margin = 40,
> +	 .upper_margin = 5,
> +	 .lower_margin = 5,
> +	 .hsync_len = 20,
> +	 .vsync_len = 10,
> +	 .sync = FB_SYNC_OE_ACT_HIGH,
> +	 .vmode = FB_VMODE_NONINTERLACED,
> +	 .flag = 0,
> +	 },
> +};
> +
> +static const struct ipu_platform_data mx3_ipu_data __initconst = {
> +	.irq_base = MXC_IPU_IRQ_START,
> +};
> +
> +static struct mx3fb_platform_data mx3fb_pdata __initdata = {
> +	.name = "Ceramate-CLAA070VC01",
> +	.mode = fb_modedb,
> +	.num_modes = ARRAY_SIZE(fb_modedb),
> +};
> +
> +static struct i2c_board_info __initdata mc9s08dz60_i2c_device = {
> +	I2C_BOARD_INFO("mc9s08dz60", 0x69),
> +};
> +
> +static struct i2c_client *mc9s08dz60_client;
> +
> +static void mx35_3ds_lcd_set_power(struct plat_lcd_data *pd, unsigned int power)
> +{
> +	u8 temp;
> +
> +	if (!mc9s08dz60_client) {
> +		mc9s08dz60_client =
> +		    i2c_new_device(i2c_get_adapter(0), &mc9s08dz60_i2c_device);
> +	}
> +	if (mc9s08dz60_client) {
> +		temp = (u8) i2c_smbus_read_byte_data(mc9s08dz60_client, 0x20);
> +		if (power)
> +			temp |= (1 << 6);
> +		else
> +			temp &= ~(1 << 6);
> +
> +		i2c_smbus_write_byte_data(mc9s08dz60_client, 0x20, temp);
> +	}
> +}

The mc9s08dz60 is a RTC/Touchscreen/GPIO chip. You should write a driver
for it instead of adding a quick hack in the board code.

>  
>  static void __init mx35pdk_timer_init(void)
> @@ -225,3 +323,4 @@ MACHINE_START(MX35_3DS, "Freescale MX35PDK")
>  	.timer = &mx35pdk_timer,
>  	.init_machine = mx35_3ds_init,
>  MACHINE_END
> +

Please don't add blank lines to files.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
