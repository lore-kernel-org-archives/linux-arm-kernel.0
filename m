From: jon-hunter@ti.com (Jon Hunter)
Date: Mon, 11 Jun 2012 09:57:03 -0500
Subject: [PATCH 1/5] ARM: OMAP3EVM: Add NAND flash definition
In-Reply-To: <1339423216-1323-2-git-send-email-zumeng.chen@gmail.com>
References: <zumeng.chen@gmail.com>
 <1339423216-1323-1-git-send-email-zumeng.chen@gmail.com>
 <1339423216-1323-2-git-send-email-zumeng.chen@gmail.com>
Message-ID: <4FD6073F.8080703@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/11/2012 09:00 AM, Zumeng Chen wrote:
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Tested-by: Zumeng Chen <zumeng.chen@gmail.com>

I think that you need to have something in the changelog above, even if
this is a trivial change.

> ---
>  arch/arm/mach-omap2/board-omap3evm.c |   39 ++++++++++++++++++++++++++++++++++
>  1 files changed, 39 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
> index 639bd07..fef911d 100644
> --- a/arch/arm/mach-omap2/board-omap3evm.c
> +++ b/arch/arm/mach-omap2/board-omap3evm.c
> @@ -24,6 +24,10 @@
>  #include <linux/leds.h>
>  #include <linux/interrupt.h>
>  
> +#include <linux/mtd/mtd.h>
> +#include <linux/mtd/partitions.h>
> +#include <linux/mtd/nand.h>
> +
>  #include <linux/spi/spi.h>
>  #include <linux/spi/ads7846.h>
>  #include <linux/i2c/twl.h>
> @@ -43,6 +47,7 @@
>  
>  #include <plat/board.h>
>  #include <plat/usb.h>
> +#include <plat/nand.h>
>  #include "common.h"
>  #include <plat/mcspi.h>
>  #include <video/omapdss.h>
> @@ -607,6 +612,37 @@ static struct regulator_consumer_supply dummy_supplies[] = {
>  	REGULATOR_SUPPLY("vdd33a", "smsc911x.0"),
>  };
>  
> +static struct mtd_partition omap3evm_nand_partitions[] = {
> +	/* All the partition sizes are listed in terms of NAND block size */
> +	{
> +		.name           = "xloader-nand",

Is this the only non-volatile memory on the EVM? If so, you can probably
drop the "-nand" part from the name. Also, if you look at other board
files to be consistent in naming they use "X-Loader".

> +		.offset         = 0,
> +		.size           = 4*(SZ_128K),
> +		.mask_flags     = MTD_WRITEABLE
> +	},
> +	{
> +		.name           = "uboot-nand",

"U-Boot"

> +		.offset         = MTDPART_OFS_APPEND,
> +		.size           = 14*(SZ_128K),
> +		.mask_flags     = MTD_WRITEABLE
> +	},
> +	{
> +		.name           = "params-nand",

"U-Boot Env"

> +		.offset         = MTDPART_OFS_APPEND,
> +		.size           = 2*(SZ_128K)
> +	},
> +	{
> +		.name           = "linux-nand",

"Kernel"

> +		.offset         = MTDPART_OFS_APPEND,
> +		.size           = 40*(SZ_128K)
> +	},
> +	{
> +		.name           = "jffs2-nand",

"File System"
> +		.size           = MTDPART_SIZ_FULL,
> +		.offset         = MTDPART_OFS_APPEND,
> +	},
> +};
> +
>  static void __init omap3_evm_init(void)
>  {
>  	struct omap_board_mux *obm;
> @@ -656,6 +692,9 @@ static void __init omap3_evm_init(void)
>  	}
>  	usb_musb_init(&musb_board_data);
>  	usbhs_init(&usbhs_bdata);
> +	omap_nand_flash_init(NAND_BUSWIDTH_16, omap3evm_nand_partitions,
> +			     ARRAY_SIZE(omap3evm_nand_partitions));
> +
>  	omap_ads7846_init(1, OMAP3_EVM_TS_GPIO, 310, NULL);
>  	omap3evm_init_smsc911x();
>  	omap3_evm_display_init();

Cheers
Jon
