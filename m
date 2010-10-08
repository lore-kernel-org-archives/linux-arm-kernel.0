From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 8 Oct 2010 14:34:07 +0200
Subject: [PATCH] ARM: AT91: add board support for Pcontrol_G20
In-Reply-To: <1286466086.4306.41.camel@aspire.localdomain>
References: <1286466086.4306.41.camel@aspire.localdomain>
Message-ID: <20101008123407.GB30252@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17:41 Thu 07 Oct     , Peter Gsellmann wrote:
> Added target is a carrier board for Stamp9G20 with additional
> peripherals and memories. Configuration is mostly copied from there.
> Added Code is only active if CONFIG_MACH_PCONTROL_G20=y
> 
> Signed-off-by: Peter Gsellmann <pgsellmann@portner-elektronik.at>
> ---
>  arch/arm/configs/pcontrol_g20_defconfig | 1721 +++++++++++++++++++++++++++++++
please use savedefconfig
>  arch/arm/mach-at91/Kconfig              |    6 +
>  arch/arm/mach-at91/Makefile             |    1 +
>  arch/arm/mach-at91/board-pcontrol-g20.c |  314 ++++++
>  4 files changed, 2042 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/configs/pcontrol_g20_defconfig
>  create mode 100644 arch/arm/mach-at91/board-pcontrol-g20.c
> 

> +config MACH_PCONTROL_G20
> +	bool "PControl G20 CPU module"
> +	help
> +	  Select this if you are using taskit's Stamp9G20 CPU module on this
> +	  carrier board.
> +
what is the difference with stamg9g20?
>  endif
>  
>  if (ARCH_AT91SAM9260 || ARCH_AT91SAM9G20)
> diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
> index ca2ac00..7fabc1b 100644
> --- a/arch/arm/mach-at91/Makefile
> +++ b/arch/arm/mach-at91/Makefile
> @@ -65,6 +65,7 @@ obj-$(CONFIG_MACH_AT91SAM9G20EK_2MMC) += board-sam9g20ek-2slot-mmc.o
>  obj-$(CONFIG_MACH_CPU9G20)	+= board-cpu9krea.o
>  obj-$(CONFIG_MACH_STAMP9G20)	+= board-stamp9g20.o
>  obj-$(CONFIG_MACH_PORTUXG20)	+= board-stamp9g20.o
> +obj-$(CONFIG_MACH_PCONTROL_G20)	+= board-pcontrol-g20.o
>  
>  # AT91SAM9260/AT91SAM9G20 board-specific support
>  obj-$(CONFIG_MACH_SNAPPER_9260)	+= board-snapper9260.o
> diff --git a/arch/arm/mach-at91/board-pcontrol-g20.c b/arch/arm/mach-at91/board-pcontrol-g20.c
> new file mode 100644
> index 0000000..e8f4d09
> --- /dev/null
> +++ b/arch/arm/mach-at91/board-pcontrol-g20.c
> @@ -0,0 +1,314 @@
> +/*
> + *  Copyright (C) 2010 Christian Glindkamp <christian.glindkamp@taskit.de>
> + *                     taskit GmbH
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
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> + */
> +/*
> + * copied and adjusted from board-stamp9g20.c by Peter Gsellmann <pgsellmann@portner-elektronik.at>
> + */
> +
> +#include <linux/mm.h>
> +#include <linux/platform_device.h>
> +#include <linux/gpio.h>
> +#include <linux/w1-gpio.h>
> +
> +#include <asm/mach-types.h>
> +#include <asm/mach/arch.h>
> +
> +#include <mach/board.h>
> +#include <mach/at91sam9_smc.h>
> +
> +#include "sam9_smc.h"
> +#include "generic.h"
> +
> +
> +static void __init pcontrol_g20_map_io(void)
> +{
> +	/* Initialize processor: 18.432 MHz crystal */
> +	at91sam9260_initialize(18432000);
> +
> +	/* DGBU on ttyS0. (Rx, Tx) only TTL -> JTAG connector X7 17,19 ) */
> +	at91_register_uart(0, 0, 0);
> +
> +	/* USART0 on ttyS1. (Rx, Tx, CTS, RTS) piggyback  A2 */
> +	at91_register_uart(AT91SAM9260_ID_US0, 1, ATMEL_UART_CTS | ATMEL_UART_RTS);
> +
> +	/* USART1 on ttyS2. (Rx, Tx, CTS, RTS) isolated RS485  X5 */
> +	at91_register_uart(AT91SAM9260_ID_US1, 2, ATMEL_UART_CTS | ATMEL_UART_RTS);
> +
> +	/* USART2 on ttyS3. (Rx, Tx)  9bit-Bus  Multidrop-mode  X4 */
> +	at91_register_uart(AT91SAM9260_ID_US4, 3, 0);
> +
> +	/* set serial console to ttyS0 (ie, DBGU) */
> +	at91_set_serial_console(0);
> +}
> +
> +
> +static void __init init_irq(void)
> +{
> +	at91sam9260_init_interrupts(NULL);
> +}
> +
> +
> +/*
> + * NAND flash 512MiB 1,8V 8-bit, sector size 128 KiB
> + */
> +static struct atmel_nand_data __initdata nand_data = {
> +	.ale		= 21,
> +	.cle		= 22,
> +	.rdy_pin	= AT91_PIN_PC13,
> +	.enable_pin	= AT91_PIN_PC14,
> +	.bus_width_16	= 0,
non need it's 0 by default
> +};
> +
> +/*
> + * Bus timings; unit = 7.57ns
> + */
> +static struct sam9_smc_config __initdata nand_smc_config = {
> +	.ncs_read_setup		= 0,
> +	.nrd_setup		= 2,
> +	.ncs_write_setup	= 0,
> +	.nwe_setup		= 2,
> +
> +	.ncs_read_pulse		= 4,
> +	.nrd_pulse		= 4,
> +	.ncs_write_pulse	= 4,
> +	.nwe_pulse		= 4,
> +
> +	.read_cycle		= 7,
> +	.write_cycle		= 7,
> +
> +	.mode			= AT91_SMC_READMODE | AT91_SMC_WRITEMODE | AT91_SMC_EXNWMODE_DISABLE | AT91_SMC_DBW_8,
> +	.tdf_cycles		= 3,
> +};
> +
> +static struct sam9_smc_config __initdata pcontrol_smc_config[2] = { {
> +	.ncs_read_setup		= 16,
> +	.nrd_setup		= 18,
> +	.ncs_write_setup	= 16,
> +	.nwe_setup		= 18,
> +
> +	.ncs_read_pulse		= 63,
> +	.nrd_pulse		= 55,
> +	.ncs_write_pulse	= 63,
> +	.nwe_pulse		= 55,
> +
> +	.read_cycle		= 127,
> +	.write_cycle		= 127,
> +
> +	.mode			= AT91_SMC_READMODE | AT91_SMC_WRITEMODE | AT91_SMC_EXNWMODE_DISABLE | AT91_SMC_DBW_8,
> +	.tdf_cycles		= 3,
> +}, {
> +	.ncs_read_setup		= 0,
> +	.nrd_setup		= 0,
> +	.ncs_write_setup	= 0,
> +	.nwe_setup		= 1,
> +
> +	.ncs_read_pulse		= 8,
> +	.nrd_pulse		= 8,
> +	.ncs_write_pulse	= 5,
> +	.nwe_pulse		= 4,
> +
> +	.read_cycle		= 8,
> +	.write_cycle		= 7,
> +
> +	.mode			= AT91_SMC_READMODE | AT91_SMC_WRITEMODE | AT91_SMC_EXNWMODE_DISABLE | AT91_SMC_DBW_16,
> +	.tdf_cycles		= 1,
> +} };
> +
> +static void __init add_device_nand(void)
> +{
> +	/* configure chip-select 3 (NAND) */
> +	sam9_smc_configure(3, &nand_smc_config);
> +	at91_add_device_nand(&nand_data);
> +}
> +
> +
> +static void __init add_device_pcontrol(void)
> +{
> +	/* configure chip-select 4 (slow IO  X4 ) */
> +	sam9_smc_configure(4, &pcontrol_smc_config);
> +	/* configure chip-select 7 (FerroRAM  256KiBx16bit  MR2A16A  D4 ) */
> +	sam9_smc_configure(7, &pcontrol_smc_config+1);
> +}
> +
> +
> +/*
> + * MCI (SD/MMC)
> + * det_pin, wp_pin and vcc_pin are not connected
> + */
> +#if defined(CONFIG_MMC_ATMELMCI) || defined(CONFIG_MMC_ATMELMCI_MODULE)
> +static struct mci_platform_data __initdata mmc_data = {
> +	.slot[0] = {
> +		.bus_width	= 4,
> +	},
> +};
> +#else
> +static struct at91_mmc_data __initdata mmc_data = {
> +	.slot_b		= 0,
> +	.wire4		= 1,
> +};
> +#endif
> +
> +
> +/*
> + * USB Host port
> + */
> +static struct at91_usbh_data __initdata usbh_data = {
> +	.ports		= 2,
> +};
> +
> +
> +/*
> + * USB Device port
> + */
> +static struct at91_udc_data __initdata pcontrol_g20_udc_data = {
> +	.vbus_pin	= AT91_PIN_PA22,	/* Detect +5V bus voltage */
> +	.pullup_pin	= AT91_PIN_PA4,		/* K-state, active low */
> +};
> +
> +
> +/*
> + * MACB Ethernet device
> + */
> +static struct at91_eth_data __initdata macb_data = {
> +	.phy_irq_pin	= AT91_PIN_PA28,
> +	.is_rmii	= 1,
> +};
> +
> +
> +/*
> + * I2C devices: eeprom and phy/switch
> + */
> +static struct i2c_board_info __initdata pcontrol_g20_i2c_devices[] = {
> +        {
> +                I2C_BOARD_INFO("24c64", 0x50)	/* D7 address width=2, 8KiB */
> +        }, {
> +                I2C_BOARD_INFO("lan9303", 0x0a)	/* D8 address width=1, byte has 32 bits! */
> +        },
> +};
whitespace please fix it
> +
> +
> +/*
> + * LEDs
> + */
> +static struct gpio_led pcontrol_g20_leds[] = {
> +	{
> +		.name			= "LED1",	/* red  H5 */
is it no better to give a better namei for the leds?

best Regards,
J.
