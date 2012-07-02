From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 2 Jul 2012 15:46:32 +0200
Subject: [PATCH 5/5] at91: Add new board
In-Reply-To: <4FED9268.7020107@aksignal.cz>
References: <4FED9268.7020107@aksignal.cz>
Message-ID: <4FF1A638.3090500@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/29/2012 01:32 PM, Prchal Ji?? :
> Hi,
> I'd like to add support for our board based up on Telit's module GE863
> Pro3.
> Its like AT91SAM9260EK with 64MB RAM and 128MB NAND FLASH, many uarts,
> SD slot, eth phy...

Prchal,

It seems that Telit's module is submitted as a Device Tree machine as
submitted by Fabio Porcedda a few weeks ago.

AT91 will not include in mainline more boards based on previous
descriptions. We are moving to device tree infrastructure when possible.

Please check the AT91 git tree:
git://github.com/at91linux/linux-at91.git	at91-3.6-dt

And see if you can add your board on top of it...

Best regards,


> Signed-off-by: Jiri Prchal <jiri.prchal@aksignal.cz>
> ---
>  arch/arm/mach-at91/Kconfig     |    6 +
>  arch/arm/mach-at91/Makefile    |    1 +
>  arch/arm/mach-at91/board-cdu.c |  301
> ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 308 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-at91/board-cdu.c
> 
> diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
> index 19505c0..7e072d7 100644
> --- a/arch/arm/mach-at91/Kconfig
> +++ b/arch/arm/mach-at91/Kconfig
> @@ -260,6 +260,12 @@ config MACH_AT91SAM9260EK
>        Select this if you are using Atmel's AT91SAM9260-EK or AT91SAM9XE
> Evaluation Kit
>        <http://www.atmel.com/dyn/products/tools_card.asp?tool_id=3933>
> 
> +config MACH_CDU
> +    bool "CDU AKsignal board"
> +    help
> +      Select this if you are using AKsignal CDU board
> +      <http://www.aksignal.cz>
> +
>  config MACH_CAM60
>      bool "KwikByte KB9260 (CAM60) board"
>      help
> diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
> index 3bb7a51..b633748 100644
> --- a/arch/arm/mach-at91/Makefile
> +++ b/arch/arm/mach-at91/Makefile
> @@ -51,6 +51,7 @@ obj-$(CONFIG_MACH_RSI_EWS)    += board-rsi-ews.o
> 
>  # AT91SAM9260 board-specific support
>  obj-$(CONFIG_MACH_AT91SAM9260EK) += board-sam9260ek.o
> +obj-$(CONFIG_MACH_CDU)         += board-cdu.o
>  obj-$(CONFIG_MACH_CAM60)    += board-cam60.o
>  obj-$(CONFIG_MACH_SAM9_L9260)    += board-sam9-l9260.o
>  obj-$(CONFIG_MACH_USB_A9260)    += board-usb-a926x.o
> diff --git a/arch/arm/mach-at91/board-cdu.c
> b/arch/arm/mach-at91/board-cdu.c
> new file mode 100644
> index 0000000..1f266a8
> --- /dev/null
> +++ b/arch/arm/mach-at91/board-cdu.c
> @@ -0,0 +1,301 @@
> +/*
> + * linux/arch/arm/mach-at91/board-cdu.c
> + *
> + *  Copyright (C) 2005 SAN People
> + *  Copyright (C) 2006 Atmel
> + *  Copyright (C) 2011 AKsignal Brno
> + *                     jiri.prchal at aksignal.cz
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 
> 02111-1307  USA
> + */
> +
> +#include <linux/types.h>
> +#include <linux/gpio.h>
> +#include <linux/init.h>
> +#include <linux/mm.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/spi/spi.h>
> +#include <linux/clk.h>
> +#include <linux/spi/mcp23s08.h>
> +#include <linux/dma-mapping.h>
> +
> +#include <asm/setup.h>
> +#include <asm/mach-types.h>
> +#include <asm/irq.h>
> +
> +#include <asm/mach/arch.h>
> +#include <asm/mach/map.h>
> +#include <asm/mach/irq.h>
> +
> +#include <mach/hardware.h>
> +#include <mach/board.h>
> +#include <mach/gpio.h>
> +#include <mach/at91sam9_smc.h>
> +#include <mach/at91_shdwc.h>
> +#include <mach/system_rev.h>
> +
> +#include "sam9_smc.h"
> +#include "generic.h"
> +
> +static void __init cdu_init_early(void)
> +{
> +    /* Initialize processor: 6 MHz crystal */
> +    at91_initialize(6000000);
> +
> +    /* DBGU on ttyS0. (Rx & Tx only) */
> +    at91_register_uart(0, 0, 0);
> +
> +    /* modem */
> +    /* USART0 on ttyS1. (Rx, Tx, CTS, RTS, DTR, DSR, DCD, RI) */
> +    at91_register_uart(AT91SAM9260_ID_US0, 1, ATMEL_UART_CTS |
> ATMEL_UART_RTS
> +               | ATMEL_UART_DTR | ATMEL_UART_DSR | ATMEL_UART_DCD
> +               | ATMEL_UART_RI);
> +
> +    /* sbus */
> +    /* USART1 on ttyS2. (Rx, Tx, RTS) */
> +    at91_register_uart(AT91SAM9260_ID_US1, 2, ATMEL_UART_RTS);
> +
> +    /* aux RS485, pins 01,02 */
> +    /* USART2 on ttyS3. (Rx, Tx, RTS) */
> +    at91_register_uart(AT91SAM9260_ID_US2, 3, ATMEL_UART_RTS);
> +
> +    /* aux RS485, pins 05,06 */
> +    /* USART3 on ttyS4. (Rx, Tx, RTS) */
> +    at91_register_uart(AT91SAM9260_ID_US3, 4, ATMEL_UART_RTS);
> +}
> +
> +/*
> + * USB Host port
> + */
> +static struct at91_usbh_data __initdata cdu_usbh_data = {
> +    .ports        = 2,
> +    .vbus_pin    = {-EINVAL, -EINVAL},
> +    .overcurrent_pin= {-EINVAL, -EINVAL},
> +};
> +
> +/*
> + * USB Device port
> + */
> +static struct at91_udc_data __initdata cdu_udc_data = {
> +    .vbus_pin    = AT91_PIN_PC15,
> +    .pullup_pin    = -EINVAL,        /* pull-up driven by UDC */
> +};
> +
> +/*
> + * SPI devices.
> + */
> +static struct spi_board_info cdu_spi_devices[] = {
> +    { /* ADC LTC2488 */
> +        .modalias    = "spidev",
> +        .bus_num    = 1,
> +        .chip_select    = 0,
> +        .max_speed_hz    = 1 * 1000000,
> +    },
> +    { /* GPIO expander MCP23S08 */
> +        .modalias    = "spidev",
> +        .bus_num    = 1,
> +        .chip_select    = 1,
> +        .max_speed_hz    = 10 * 1000000,
> +        .mode        = SPI_MODE_3,
> +    },
> +    { /* non volatile memory (F-RAM) FM25VN10 */
> +        .modalias    = "spidev",
> +        .bus_num    = 1,
> +        .chip_select    = 2,
> +        .max_speed_hz    = 10 * 1000000,
> +    },
> +};
> +
> +/*
> + * MACB Ethernet device
> + */
> +static struct macb_platform_data __initdata cdu_macb_data = {
> +    .phy_irq_pin    = -EINVAL,
> +    .is_rmii    = 1,
> +};
> +
> +/*
> + * NAND flash
> + */
> +static struct mtd_partition __initdata cdu_nand_partition[] = {
> +    {
> +        .name   = "bootstrap",
> +        .offset = 0,
> +        .size   = SZ_256K,
> +    },
> +    {
> +        .name   = "uboot",
> +        .offset = MTDPART_OFS_APPEND,
> +        .size   = SZ_512K,
> +    },
> +    {
> +        .name   = "ubootenv",
> +        .offset = MTDPART_OFS_APPEND,
> +        .size   = SZ_256K,
> +    },
> +    {
> +        .name   = "kernel",
> +        .offset = MTDPART_OFS_APPEND,
> +        .size   = SZ_4M,
> +    },
> +    {
> +        .name   = "rootfs",
> +        .offset = MTDPART_OFS_APPEND,
> +        .size   = MTDPART_SIZ_FULL,
> +    },
> +};
> +
> +static struct atmel_nand_data __initdata cdu_nand_data = {
> +    .ale        = 21,
> +    .cle        = 22,
> +    .det_pin    = -EINVAL,
> +    .rdy_pin    = AT91_PIN_PC13,
> +    .enable_pin    = AT91_PIN_PC14,
> +    .bus_width_16    = 0,
> +    .ecc_mode    = NAND_ECC_SOFT,
> +    .parts        = cdu_nand_partition,
> +    .num_parts    = ARRAY_SIZE(cdu_nand_partition),
> +};
> +
> +static struct sam9_smc_config __initdata cdu_nand_smc_config = {
> +    .ncs_read_setup        = 0,
> +    .nrd_setup        = 1,
> +    .ncs_write_setup    = 0,
> +    .nwe_setup        = 1,
> +
> +    .ncs_read_pulse        = 3,
> +    .nrd_pulse        = 3,
> +    .ncs_write_pulse    = 3,
> +    .nwe_pulse        = 3,
> +
> +    .read_cycle        = 5,
> +    .write_cycle        = 5,
> +
> +    .tdf_cycles        = 2,
> +
> +    .mode            = AT91_SMC_READMODE | AT91_SMC_WRITEMODE |
> +                  AT91_SMC_EXNWMODE_DISABLE |
> +                  AT91_SMC_DBW_8,
> +};
> +
> +static void __init cdu_add_device_nand(void)
> +{
> +    sam9_smc_configure(0, 3, &cdu_nand_smc_config);
> +    at91_add_device_nand(&cdu_nand_data);
> +}
> +
> +/*
> +* MCI (SD/MMC)
> +*/
> +static struct mci_platform_data __initdata cdu_mmc_data = {
> +    .slot[0] = {
> +        .bus_width    = 4,
> +        .detect_pin    = -1,
> +        .wp_pin        = -1,
> +    },
> +};
> +
> +/*
> + * LEDs
> + */
> +static struct gpio_led cdu_leds[] = {
> +    {
> +        .name            = "red",
> +        .gpio            = AT91_PIN_PC10,
> +    },
> +    {
> +        .name            = "green",
> +        .gpio            = AT91_PIN_PA5,
> +        .active_low        = 1,
> +    },
> +    {
> +        .name            = "yellow",
> +        .gpio            = AT91_PIN_PB20,
> +        .active_low        = 1,
> +    },
> +    {
> +        .name            = "blue",
> +        .gpio            = AT91_PIN_PB21,
> +        .active_low        = 1,
> +        .default_state        = LEDS_GPIO_DEFSTATE_ON,
> +    },
> +};
> +
> +/*
> + * GPIOs
> + */
> +static struct gpio gpios[] = {
> +    { AT91_PIN_PA0,  GPIOF_OUT_INIT_LOW,  "ebus_dir"},
> +    { AT91_PIN_PA1,  GPIOF_OUT_INIT_LOW,  "time_dir"},
> +    { AT91_PIN_PB12, GPIOF_OUT_INIT_LOW,  "gsm_rst"},
> +    { AT91_PIN_PB13, GPIOF_OUT_INIT_LOW,  "gsm_on"},
> +    { AT91_PIN_PC2,  GPIOF_IN,            "por"},
> +    { AT91_PIN_PC7,  GPIOF_OUT_INIT_HIGH, "spk_shdn"},
> +
> +    { AT91_PIN_PC0,  GPIOF_IN,            "in13"},
> +    { AT91_PIN_PC1,  GPIOF_IN,            "in14"},
> +    { AT91_PIN_PA22, GPIOF_IN,            "in17"},
> +    { AT91_PIN_PA23, GPIOF_IN,            "in18"},
> +    { AT91_PIN_PA24, GPIOF_IN,            "in19"},
> +    { AT91_PIN_PA25, GPIOF_IN,            "in20"},
> +
> +    { AT91_PIN_PA26, GPIOF_OUT_INIT_LOW,  "out15"},
> +    { AT91_PIN_PA27, GPIOF_OUT_INIT_LOW,  "out16"},
> +    { AT91_PIN_PA28, GPIOF_OUT_INIT_LOW,  "out17"},
> +    { AT91_PIN_PA29, GPIOF_OUT_INIT_LOW,  "out18"},
> +    { AT91_PIN_PA30, GPIOF_OUT_INIT_LOW,  "out19"},
> +    { AT91_PIN_PB29, GPIOF_OUT_INIT_LOW,  "out20"},
> +};
> +
> +static void __init cdu_add_gpio(void)
> +{
> +    int i;
> +
> +    for (i = 0; i < ARRAY_SIZE(gpios); i++) {
> +        gpio_request_one(gpios[i].gpio, gpios[i].flags, gpios[i].label);
> +        gpio_export(gpios[i].gpio, 0);
> +        /* all inputs are active low */
> +        if (gpios[i].label == strstr(gpios[i].label, "in"))
> +            gpio_sysfs_set_active_low(gpios[i].gpio, 1);
> +    }
> +}
> +
> +/*
> + * init
> + */
> +static void __init cdu_board_init(void)
> +{
> +    at91_add_device_serial();
> +    at91_add_device_usbh(&cdu_usbh_data);
> +    at91_add_device_udc(&cdu_udc_data);
> +    at91_add_device_spi(cdu_spi_devices, ARRAY_SIZE(cdu_spi_devices));
> +    cdu_add_device_nand();
> +    at91_add_device_eth(&cdu_macb_data);
> +    at91_add_device_mci(0, &cdu_mmc_data);
> +    at91_add_device_ssc(AT91SAM9260_ID_SSC, (ATMEL_SSC_TF |
> ATMEL_SSC_TK | ATMEL_SSC_TD | ATMEL_SSC_RD));
> +    at91_gpio_leds(cdu_leds, ARRAY_SIZE(cdu_leds));
> +    cdu_add_gpio ();
> +}
> +
> +MACHINE_START(AT91SAM9260EK, "CDU")
> +    /* Maintainer: AKsignal Brno */
> +    /* Jiri Prchal <jiri.prchal@aksignal.cz> */
> +    .timer        = &at91sam926x_timer,
> +    .map_io        = at91_map_io,
> +    .init_early    = cdu_init_early,
> +    .init_irq    = at91_init_irq_default,
> +    .init_machine    = cdu_board_init,
> +MACHINE_END


-- 
Nicolas Ferre
