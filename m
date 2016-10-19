From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 19 Oct 2016 18:21:05 +0200
Subject: [PATCH] mtd: nand: Add OX820 NAND Support
In-Reply-To: <20161019145523.6763-1-narmstrong@baylibre.com>
References: <20161019145523.6763-1-narmstrong@baylibre.com>
Message-ID: <20161019182105.23c31ed9@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 19 Oct 2016 16:55:23 +0200
Neil Armstrong <narmstrong@baylibre.com> wrote:

> Add NAND driver to support the Oxford Semiconductor OX820 NAND Controller.
> This is a simple memory mapped NAND controller with single chip select and
> software ECC.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../devicetree/bindings/mtd/oxnas-nand.txt         |  24 +++
>  drivers/mtd/nand/Kconfig                           |   5 +
>  drivers/mtd/nand/Makefile                          |   1 +
>  drivers/mtd/nand/oxnas_nand.c                      | 204 +++++++++++++++++++++
>  4 files changed, 234 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/oxnas-nand.txt
>  create mode 100644 drivers/mtd/nand/oxnas_nand.c
> 
> Changes since RFC http://lkml.kernel.org/r/20161018090927.1990-1-narmstrong at baylibre.com :
>  - Avoid using chip->IO_ADDR*
>  - Use new DT structure
>  - Assign a chip for the subnode
>  - Use the nand_hw_control structure
>  - Cleanup probe
>  - Cleanup cmd_ctrl by using a context ctrl offset used in write_bytes
> 
> diff --git a/Documentation/devicetree/bindings/mtd/oxnas-nand.txt b/Documentation/devicetree/bindings/mtd/oxnas-nand.txt
> new file mode 100644
> index 0000000..83b684d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/oxnas-nand.txt
> @@ -0,0 +1,24 @@
> +* Oxford Semiconductor OXNAS NAND Controller
> +
> +Please refer to nand.txt for generic information regarding MTD NAND bindings.
> +
> +Required properties:
> + - compatible: "oxsemi,ox820-nand"
> + - reg: Base address and length for NAND mapped memory.
> +
> +Optional Properties:
> + - clocks: phandle to the NAND gate clock if needed.
> + - resets: phandle to the NAND reset control if needed.
> +
> +Example:
> +
> +nand: nand at 41000000 {
> +	compatible = "oxsemi,ox820-nand";
> +	reg = <0x41000000 0x100000>;
> +	nand-ecc-mode = "soft";
> +	clocks = <&stdclk CLK_820_NAND>;
> +	resets = <&reset RESET_NAND>;
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	status = "disabled";
> +};
> diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
> index 7b7a887..c023125 100644
> --- a/drivers/mtd/nand/Kconfig
> +++ b/drivers/mtd/nand/Kconfig
> @@ -426,6 +426,11 @@ config MTD_NAND_ORION
>  	  No board specific support is done by this driver, each board
>  	  must advertise a platform_device for the driver to attach.
>  
> +config MTD_NAND_OXNAS
> +	tristate "NAND Flash support for Oxford Semiconductor SoC"
> +	help
> +	  This enables the NAND flash controller on Oxford Semiconductor SoCs.
> +
>  config MTD_NAND_FSL_ELBC
>  	tristate "NAND support for Freescale eLBC controllers"
>  	depends on FSL_SOC
> diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
> index cafde6f..05fc054 100644
> --- a/drivers/mtd/nand/Makefile
> +++ b/drivers/mtd/nand/Makefile
> @@ -35,6 +35,7 @@ obj-$(CONFIG_MTD_NAND_TMIO)		+= tmio_nand.o
>  obj-$(CONFIG_MTD_NAND_PLATFORM)		+= plat_nand.o
>  obj-$(CONFIG_MTD_NAND_PASEMI)		+= pasemi_nand.o
>  obj-$(CONFIG_MTD_NAND_ORION)		+= orion_nand.o
> +obj-$(CONFIG_MTD_NAND_OXNAS)		+= oxnas_nand.o
>  obj-$(CONFIG_MTD_NAND_FSL_ELBC)		+= fsl_elbc_nand.o
>  obj-$(CONFIG_MTD_NAND_FSL_IFC)		+= fsl_ifc_nand.o
>  obj-$(CONFIG_MTD_NAND_FSL_UPM)		+= fsl_upm.o
> diff --git a/drivers/mtd/nand/oxnas_nand.c b/drivers/mtd/nand/oxnas_nand.c
> new file mode 100644
> index 0000000..a9fe1ac
> --- /dev/null
> +++ b/drivers/mtd/nand/oxnas_nand.c
> @@ -0,0 +1,204 @@
> +/*
> + * Oxford Semiconductor OXNAS NAND driver
> +
> + * Copyright (C) 2016 Neil Armstrong <narmstrong@baylibre.com>
> + * Heavily based on plat_nand.c :
> + * Author: Vitaly Wool <vitalywool@gmail.com>
> + * Copyright (C) 2013 Ma Haijun <mahaijuns@gmail.com>
> + * Copyright (C) 2012 John Crispin <blogic@openwrt.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/clk.h>
> +#include <linux/reset.h>
> +#include <linux/mtd/mtd.h>
> +#include <linux/mtd/nand.h>
> +#include <linux/mtd/partitions.h>
> +#include <linux/of.h>
> +
> +/* Nand commands */
> +#define OXNAS_NAND_CMD_ALE		BIT(18)
> +#define OXNAS_NAND_CMD_CLE		BIT(19)
> +
> +#define OXNAS_NAND_MAX_CHIPS	1
> +
> +struct oxnas_nand {

One last thing, please rename the struct: oxnas_nandc, oxnas_nand_ctrl
or oxnas_nand_controller. Pick the one you prefer or choose another
one, I don't care, as long as the name clearly shows that this is a NAND
controller and not the NAND chip.

> +	struct nand_hw_control base;
> +	void __iomem *io_base;
> +	struct clk *clk;
> +	struct nand_chip *chips[OXNAS_NAND_MAX_CHIPS];
> +	unsigned long ctrl;
> +};
