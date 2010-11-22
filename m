From: saeed.bishara@gmail.com (saeed bishara)
Date: Mon, 22 Nov 2010 09:39:36 +0200
Subject: [PATCH v2] [ARM] Dove: add support for CM-A510 machine.
In-Reply-To: <1289890503-10569-1-git-send-email-mike@compulab.co.il>
References: <alpine.LFD.2.00.1011151228250.6448@xanadu.home>
	<1289890503-10569-1-git-send-email-mike@compulab.co.il>
Message-ID: <AANLkTi=ku8kds5SC37UpSh6uiX134bzKMe=GE=TZTmOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 16, 2010 at 8:55 AM, Mike Rapoport <mike@compulab.co.il> wrote:
> From: Konstantin Sinyuk <kostyas@compulab.co.il>
>
> This patch adds support for CM-A510 machine
>
> Signed-off-by: Konstantin Sinyuk <kostyas@compulab.co.il>
> Signed-off-by: Mike Rapoport <mike@compulab.co.il>
> Reviewed-by: Saeed Bishara <saeed@marvell.com>
 Acked-by: Saeed Bishara <saeed@marvell.com>
> ---
> v2 changes:
> * rebase on top of current Linus tree
> * remove .phys_io and .io_pg_offst from machine description
>
> ?arch/arm/mach-dove/Kconfig ? | ? ?6 +++
> ?arch/arm/mach-dove/Makefile ?| ? ?1 +
> ?arch/arm/mach-dove/cm-a510.c | ? 95 ++++++++++++++++++++++++++++++++++++++++++
> ?3 files changed, 102 insertions(+), 0 deletions(-)
> ?create mode 100644 arch/arm/mach-dove/cm-a510.c
>
> diff --git a/arch/arm/mach-dove/Kconfig b/arch/arm/mach-dove/Kconfig
> index 3b9a32a..a4ed390 100644
> --- a/arch/arm/mach-dove/Kconfig
> +++ b/arch/arm/mach-dove/Kconfig
> @@ -9,6 +9,12 @@ config MACH_DOVE_DB
> ? ? ? ? ?Say 'Y' here if you want your kernel to support the
> ? ? ? ? ?Marvell DB-MV88AP510 Development Board.
>
> + config MACH_CM_A510
> + ? ? ? bool "CompuLab CM-A510 Board"
> + ? ? ? help
> + ? ? ? ? Say 'Y' here if you want your kernel to support the
> + ? ? ? ? CompuLab CM-A510 Board.
> +
> ?endmenu
>
> ?endif
> diff --git a/arch/arm/mach-dove/Makefile b/arch/arm/mach-dove/Makefile
> index 7ab3be5..f74f549 100644
> --- a/arch/arm/mach-dove/Makefile
> +++ b/arch/arm/mach-dove/Makefile
> @@ -1,3 +1,4 @@
> ?obj-y ? ? ? ? ? ? ? ? ? ? ? ? ?+= common.o addr-map.o irq.o pcie.o
>
> ?obj-$(CONFIG_MACH_DOVE_DB) ? ? += dove-db-setup.o
> +obj-$(CONFIG_MACH_CM_A510) ? ? += cm-a510.o
> diff --git a/arch/arm/mach-dove/cm-a510.c b/arch/arm/mach-dove/cm-a510.c
> new file mode 100644
> index 0000000..96e0e94
> --- /dev/null
> +++ b/arch/arm/mach-dove/cm-a510.c
> @@ -0,0 +1,95 @@
> +/*
> + * arch/arm/mach-dove/cm-a510.c
> + *
> + * Copyright (C) 2010 CompuLab, Ltd.
> + * Konstantin Sinyuk <kostyas@compulab.co.il>
> + *
> + * Based on Marvell DB-MV88AP510-BP Development Board Setup
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. ?This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +#include <linux/ata_platform.h>
> +#include <linux/mv643xx_eth.h>
> +#include <linux/spi/spi.h>
> +#include <linux/spi/flash.h>
> +
> +#include <asm/mach-types.h>
> +#include <asm/mach/arch.h>
> +
> +#include <mach/dove.h>
> +
> +#include "common.h"
> +
> +static struct mv643xx_eth_platform_data cm_a510_ge00_data = {
> + ? ? ? .phy_addr ? ? ? = MV643XX_ETH_PHY_ADDR_DEFAULT,
> +};
> +
> +static struct mv_sata_platform_data cm_a510_sata_data = {
> + ? ? ? .n_ports ? ? ? ?= 1,
> +};
> +
> +/*
> + * SPI Devices:
> + * SPI0: 1M Flash Winbond w25q32bv
> + */
> +static const struct flash_platform_data cm_a510_spi_flash_data = {
> + ? ? ? .type ? ? ? ? ? = "w25q32bv",
> +};
> +
> +static struct spi_board_info __initdata cm_a510_spi_flash_info[] = {
> + ? ? ? {
> + ? ? ? ? ? ? ? .modalias ? ? ? = "m25p80",
> + ? ? ? ? ? ? ? .platform_data ?= &cm_a510_spi_flash_data,
> + ? ? ? ? ? ? ? .irq ? ? ? ? ? ?= -1,
> + ? ? ? ? ? ? ? .max_speed_hz ? = 20000000,
> + ? ? ? ? ? ? ? .bus_num ? ? ? ?= 0,
> + ? ? ? ? ? ? ? .chip_select ? ?= 0,
> + ? ? ? },
> +};
> +
> +static int __init cm_a510_pci_init(void)
> +{
> + ? ? ? if (machine_is_cm_a510())
> + ? ? ? ? ? ? ? dove_pcie_init(1, 1);
> +
> + ? ? ? return 0;
> +}
> +
> +subsys_initcall(cm_a510_pci_init);
> +
> +/* Board Init */
> +static void __init cm_a510_init(void)
> +{
> + ? ? ? /*
> + ? ? ? ?* Basic Dove setup. Needs to be called early.
> + ? ? ? ?*/
> + ? ? ? dove_init();
> +
> + ? ? ? dove_ge00_init(&cm_a510_ge00_data);
> + ? ? ? dove_ehci0_init();
> + ? ? ? dove_ehci1_init();
> + ? ? ? dove_sata_init(&cm_a510_sata_data);
> + ? ? ? dove_sdio0_init();
> + ? ? ? dove_sdio1_init();
> + ? ? ? dove_spi0_init();
> + ? ? ? dove_spi1_init();
> + ? ? ? dove_uart0_init();
> + ? ? ? dove_uart1_init();
> + ? ? ? dove_i2c_init();
> + ? ? ? spi_register_board_info(cm_a510_spi_flash_info,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ARRAY_SIZE(cm_a510_spi_flash_info));
> +}
> +
> +MACHINE_START(CM_A510, "Compulab CM-A510 Board")
> + ? ? ? .boot_params ? ?= 0x00000100,
> + ? ? ? .init_machine ? = cm_a510_init,
> + ? ? ? .map_io ? ? ? ? = dove_map_io,
> + ? ? ? .init_irq ? ? ? = dove_init_irq,
> + ? ? ? .timer ? ? ? ? ?= &dove_timer,
> +MACHINE_END
> --
> 1.7.3.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
