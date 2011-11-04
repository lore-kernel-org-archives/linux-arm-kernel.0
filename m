From: jochen@scram.de (Jochen Friedrich)
Date: Fri, 04 Nov 2011 16:57:34 +0100
Subject: [PATCH v2 1/3] Add support for mini-box.com picoSAM9G45 board
In-Reply-To: <1320076396-6233-1-git-send-email-npavel@mini-box.com>
References: <1320076396-6233-1-git-send-email-npavel@mini-box.com>
Message-ID: <4EB40B6E.2000801@scram.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicu,

> This patch adds support for picoSAM9G45 board from mini-box.com. This board is
> based on Atmel G45 SOC. More details can be found at http://arm.mini-box.com

I just wonder if it makes sense to add more application specific board files to
Linux rather than switching to a DT based configuration. This board file makes
use of several assumptions about hardware connected to the board:

> +	/* USART1 on ttyS1. (Rx, Tx, RTS, CTS) */
> +	at91_register_uart(AT91SAM9G45_ID_US0, 1, ATMEL_UART_CTS | ATMEL_UART_RTS);
> +	/* USART1 on ttyS2. (Rx, Tx, RTS, CTS) */
> +	at91_register_uart(AT91SAM9G45_ID_US1, 2, ATMEL_UART_CTS | ATMEL_UART_RTS);

Optional. Depends on usage of J7 and J9. Can as well be used as GPIO lines.

> + * SPI devices.
> + */
> +static struct spi_board_info picosam9g45_spi_devices[] = {
> +	[0] = {/* SPI0 CS0 on right side connector J7*/
> +		.modalias= "spidev",
> +		.max_speed_hz= 15 * 1000 * 1000,
> +		.bus_num= 0,
> +		.chip_select= 0,
> +	},
> +	[1] = {/* SPI1 CS0 on left side connector J9*/
> +		.modalias= "spidev",
> +		.max_speed_hz= 15 * 1000 * 1000,
> +		.bus_num= 1,
> +		.chip_select= 0,
> +	},
> +};

Optional. Depends on usage of J7 and J9. Can as well be used as GPIO lines.

> +/*
> + * NAND flash
> + */
> +static struct mtd_partition __initdata picosam9g45_nand_partition[] = {
> +	{
> +		.name   = "Bootstrap",
> +		.offset = 0,
> +		.size   = SZ_4M
> +	},
> +	{
> +		.name= "RootFS",
> +		.offset= MTDPART_OFS_NXTBLK,
> +		.size= 60 * SZ_1M,
> +	},
> +	{
> +		.name= "Space",
> +		.offset= MTDPART_OFS_NXTBLK,
> +		.size= MTDPART_SIZ_FULL,
> +	},
> +};

At least my device didn't come with a NAND flash attached.

> +/*
> + * Touchscreen
> + */
> +static struct at91_tsadcc_data picosam9g45_tsadcc_data = {
> +	.adc_clock		= 300000,
> +	.pendet_debounce	= 0x0d,
> +	.ts_sample_hold_time	= 0x0a,
> +};

Useless for headless applications. The recently posted IIO AT91 ADC driver could
alternatively be used for the 4 ADC inputs if no TS is connected.

> +/*
> + * GPIO Buttons
> + */
> +#if defined(CONFIG_KEYBOARD_GPIO) || defined(CONFIG_KEYBOARD_GPIO_MODULE)
> +static struct gpio_keys_button picosam9g45_buttons[] = {
> +	{	/* J9 pin 5 gnd + pin 11 */
> +		.code		= KEY_BACK,
> +		.gpio		= AT91_PIN_PB6,
> +		.active_low	= 1,
> +		.desc		= "Back",
> +		.wakeup		= 1,
> +	},
> +	{	/* J9 pin 5 gnd + pin 13*/
> +		.code		= KEY_MENU,
> +		.gpio		= AT91_PIN_PB7,
> +		.active_low	= 1,
> +		.desc		= "Menu",
> +		.wakeup		= 1,
> +	},
> +	{	/* J9 pin 5 gnd + pin 12 */
> +		.code		= KEY_HOME,
> +		.gpio		= AT91_PIN_PB16,
> +		.active_low	= 1,
> +		.desc		= "Home",
> +	},
> +
> +};

Those are highly application specific as well.

Just my 2ct.

Thanks,
Jochen
