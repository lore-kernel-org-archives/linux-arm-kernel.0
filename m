From: simon.guinot@sequanux.org (Simon Guinot)
Date: Fri, 2 Aug 2013 23:45:31 +0200
Subject: [PATCHv2 8/9] ARM: kirkwood: remove unused common code for LaCie
 platforms
In-Reply-To: <1375369655-1310-9-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1375369655-1310-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1375369655-1310-9-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130802214531.GB20330@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 01, 2013 at 05:07:34PM +0200, Thomas Petazzoni wrote:
> Now that all LaCie platforms have been converted to use the Device
> Tree, we can get rid of the lacie_v2-common.{c,h} files.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Acked-by: Simon Guinot <simon.guinot@sequanux.org>

Thanks,

Simon

> ---
>  arch/arm/mach-kirkwood/lacie_v2-common.c | 114 -------------------------------
>  arch/arm/mach-kirkwood/lacie_v2-common.h |  16 -----
>  2 files changed, 130 deletions(-)
>  delete mode 100644 arch/arm/mach-kirkwood/lacie_v2-common.c
>  delete mode 100644 arch/arm/mach-kirkwood/lacie_v2-common.h
> 
> diff --git a/arch/arm/mach-kirkwood/lacie_v2-common.c b/arch/arm/mach-kirkwood/lacie_v2-common.c
> deleted file mode 100644
> index 4894959..0000000
> --- a/arch/arm/mach-kirkwood/lacie_v2-common.c
> +++ /dev/null
> @@ -1,114 +0,0 @@
> -/*
> - * arch/arm/mach-kirkwood/lacie_v2-common.c
> - *
> - * This file is licensed under the terms of the GNU General Public
> - * License version 2.  This program is licensed "as is" without any
> - * warranty of any kind, whether express or implied.
> - */
> -
> -#include <linux/kernel.h>
> -#include <linux/init.h>
> -#include <linux/mtd/physmap.h>
> -#include <linux/spi/flash.h>
> -#include <linux/spi/spi.h>
> -#include <linux/i2c.h>
> -#include <linux/i2c/at24.h>
> -#include <linux/gpio.h>
> -#include <asm/mach/time.h>
> -#include <mach/kirkwood.h>
> -#include <mach/irqs.h>
> -#include <plat/time.h>
> -#include "common.h"
> -#include "lacie_v2-common.h"
> -
> -/*****************************************************************************
> - * 512KB SPI Flash on Boot Device (MACRONIX MX25L4005)
> - ****************************************************************************/
> -
> -static struct mtd_partition lacie_v2_flash_parts[] = {
> -	{
> -		.name = "u-boot",
> -		.size = MTDPART_SIZ_FULL,
> -		.offset = 0,
> -		.mask_flags = MTD_WRITEABLE, /* force read-only */
> -	},
> -};
> -
> -static const struct flash_platform_data lacie_v2_flash = {
> -	.type		= "mx25l4005a",
> -	.name		= "spi_flash",
> -	.parts		= lacie_v2_flash_parts,
> -	.nr_parts	= ARRAY_SIZE(lacie_v2_flash_parts),
> -};
> -
> -static struct spi_board_info __initdata lacie_v2_spi_slave_info[] = {
> -	{
> -		.modalias	= "m25p80",
> -		.platform_data	= &lacie_v2_flash,
> -		.irq		= -1,
> -		.max_speed_hz	= 20000000,
> -		.bus_num	= 0,
> -		.chip_select	= 0,
> -	},
> -};
> -
> -void __init lacie_v2_register_flash(void)
> -{
> -	spi_register_board_info(lacie_v2_spi_slave_info,
> -				ARRAY_SIZE(lacie_v2_spi_slave_info));
> -	kirkwood_spi_init();
> -}
> -
> -/*****************************************************************************
> - * I2C devices
> - ****************************************************************************/
> -
> -static struct at24_platform_data at24c04 = {
> -	.byte_len	= SZ_4K / 8,
> -	.page_size	= 16,
> -};
> -
> -/*
> - * i2c addr | chip         | description
> - * 0x50     | HT24LC04     | eeprom (512B)
> - */
> -
> -static struct i2c_board_info __initdata lacie_v2_i2c_info[] = {
> -	{
> -		I2C_BOARD_INFO("24c04", 0x50),
> -		.platform_data  = &at24c04,
> -	}
> -};
> -
> -void __init lacie_v2_register_i2c_devices(void)
> -{
> -	kirkwood_i2c_init();
> -	i2c_register_board_info(0, lacie_v2_i2c_info,
> -				ARRAY_SIZE(lacie_v2_i2c_info));
> -}
> -
> -/*****************************************************************************
> - * Hard Disk power
> - ****************************************************************************/
> -
> -static int __initdata lacie_v2_gpio_hdd_power[] = { 16, 17, 41, 42, 43 };
> -
> -void __init lacie_v2_hdd_power_init(int hdd_num)
> -{
> -	int i;
> -	int err;
> -
> -	/* Power up all hard disks. */
> -	for (i = 0; i < hdd_num; i++) {
> -		err = gpio_request(lacie_v2_gpio_hdd_power[i], NULL);
> -		if (err == 0) {
> -			err = gpio_direction_output(
> -					lacie_v2_gpio_hdd_power[i], 1);
> -			/* Free the HDD power GPIOs. This allow user-space to
> -			 * configure them via the gpiolib sysfs interface. */
> -			gpio_free(lacie_v2_gpio_hdd_power[i]);
> -		}
> -		if (err)
> -			pr_err("Failed to power up HDD%d\n", i + 1);
> -	}
> -}
> diff --git a/arch/arm/mach-kirkwood/lacie_v2-common.h b/arch/arm/mach-kirkwood/lacie_v2-common.h
> deleted file mode 100644
> index fc64f57..0000000
> --- a/arch/arm/mach-kirkwood/lacie_v2-common.h
> +++ /dev/null
> @@ -1,16 +0,0 @@
> -/*
> - * arch/arm/mach-kirkwood/lacie_v2-common.h
> - *
> - * This file is licensed under the terms of the GNU General Public
> - * License version 2.  This program is licensed "as is" without any
> - * warranty of any kind, whether express or implied.
> - */
> -
> -#ifndef __ARCH_KIRKWOOD_LACIE_V2_COMMON_H
> -#define __ARCH_KIRKWOOD_LACIE_V2_COMMON_H
> -
> -void lacie_v2_register_flash(void);
> -void lacie_v2_register_i2c_devices(void);
> -void lacie_v2_hdd_power_init(int hdd_num);
> -
> -#endif
> -- 
> 1.8.1.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130802/1a74be57/attachment.sig>
