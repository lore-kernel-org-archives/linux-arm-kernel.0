From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 28 Mar 2011 14:46:16 -0500
Subject: [PATCH] ep93xx: add support Vision EP9307 SoM
In-Reply-To: <4D90E1B8.7080405@bluewatersys.com>
References: <201103281127.42908.hartleys@visionengravers.com>
	<4D90E1B8.7080405@bluewatersys.com>
Message-ID: <0D753D10438DA54287A00B027084269764D194F007@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, March 28, 2011 12:30 PM, Ryan Mallon wrote:
> On 03/29/2011 07:27 AM, H Hartley Sweeten wrote:
>> Add support for Vision Engraving Systems EP9307 based SoM.
>> 
>> Signed-off-by: Hartley Sweeten <hartleys@visionengravers.com>
>> Cc: Ryan Mallon <ryan@bluewatersys.com>
>
> Hi Hartley,
>
> Looks mostly good. Couple of minor comments below.

>> +static void vision_lcd_blank(int blank_mode, struct fb_info *info)
>> +{
>> +	if (blank_mode)
>> +		gpio_set_value(VISION_LCD_ENABLE, 0);
>> +	else
>> +		gpio_set_value(VISION_LCD_ENABLE, 1);
>
> This can just be:
>
>	gpio_set_value(VISION_LCD_ENABLE, blank_mode ^ 1);

That does kind of hide the meaning of blank_mode.  Also, it appears blank_mode
is actually an enum not 0 or 1.  Do you still feel your way is better?

>> +}
>> +
>> +static struct ep93xxfb_mach_info ep93xxfb_info __initdata = {
>> +	.num_modes	= EP93XXFB_USE_MODEDB,
>> +	.modes		= NULL,
>> +	.default_mode	= NULL,
>
> Remove this two NULL assignments and add a comment that the lcd uses the
> standard modedb modes.

OK.

>> +static struct pca953x_platform_data pca953x_74_gpio_data = {
>> +	.gpio_base	= PCA9539_74_GPIO_BASE,
>> +	.invert		= 0,
>> +	.irq_base	= EP93XX_BOARD_IRQ(0),
>> +	.context	= NULL,
>> +	.setup		= NULL,
>> +	.teardown	= NULL,
>
> Don't need the NULL assignments.

Agreed.  I had those in as placeholders until I decided if I needed to use them.
For now they can be removed.

>> +};
>> +
>> +static struct pca953x_platform_data pca953x_75_gpio_data = {
>> +	.gpio_base	= PCA9539_75_GPIO_BASE,
>> +	.invert		= 0,
>
> Don't need the zero assignments.

Again, they were put there until I decided I needed them.  Will remove for now.

>> +/*************************************************************************
>> + * I2C Bus
>> + *************************************************************************/
>> +static struct i2c_gpio_platform_data vision_i2c_gpio_data __initdata = {
>> +	.sda_pin		= EP93XX_GPIO_LINE_EEDAT,
>> +	.sda_is_open_drain	= 0,
>> +	.scl_pin		= EP93XX_GPIO_LINE_EECLK,
>> +	.scl_is_open_drain	= 0,
>> +	.udelay			= 0,	/* default to 100 kHz */
>> +	.timeout		= 0,	/* default to 100 ms */
>
> Remove the zero assignments, and just have a comment at the top saying
> the the default speed is used.

OK.

>> +};
>> +
>> +static struct i2c_board_info vision_i2c_info[] __initdata = {
>> +	{
>> +		I2C_BOARD_INFO("isl1208", 0x6f),
>> +		.irq		= IRQ_EP93XX_EXT1,
>> +	}, {
>
> Nitpick - opening braces should go on a new line.

For array definitions like this it appears the '}, {' is more common.

>> +/*************************************************************************
>> + * SPI Bus
>> + *************************************************************************/
>> +static struct spi_board_info vision_spi_board_info[] __initdata = {
>> +	{
>> +		.modalias		= "sst25l",
>> +		.platform_data		= &vision_spi_flash_data,
>> +		.controller_data	= &vision_spi_flash_hw,
>> +		.max_speed_hz		= 20000000,
>> +		.bus_num		= 0,
>> +		.chip_select		= 0,
>
> Note: Don't delete these zero assignments since they are meaningful :-).

Agree. 

> With those changes:

I'll post an update later.

Thanks,
Hartley
