From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 6 Sep 2012 09:04:23 +0200
Subject: [PATCH v2] ARM: initial DTS support for km_kirkwood
In-Reply-To: <1346752502-30862-1-git-send-email-valentin.longchamp@keymile.com>
References: <1346752502-30862-1-git-send-email-valentin.longchamp@keymile.com>
Message-ID: <20120906070423.GB21036@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 04, 2012 at 11:55:02AM +0200, Valentin Longchamp wrote:
> This is a first attempt to support the km_kirkwood reference design with
> a device tree. This km_kirkwood design is present in many Keymile
> products. It is based on the Marvell Bobcat SOC which integrates a
> Kirkwood CPU next to a big L2 Ethernet Switch. The Kirkwood in the SOC
> is very similar to the "normal" one, but there are a few differences.
> 
> This initial support is minimal: the kernel can boot with network
> (ge0), serial port and NAND functional.
> 
> Signed-off-by: Valentin Longchamp <valentin.longchamp@keymile.com>
> Cc: Holger Brunck <holger.brunck@keymile.com>
> ---
>  arch/arm/boot/dts/kirkwood-km_kirkwood.dts |   29 ++++++++++++++
>  arch/arm/mach-kirkwood/Kconfig             |    7 +++
>  arch/arm/mach-kirkwood/Makefile            |    1 +
>  arch/arm/mach-kirkwood/Makefile.boot       |    1 +
>  arch/arm/mach-kirkwood/board-dt.c          |    4 ++
>  arch/arm/mach-kirkwood/board-km_kirkwood.c |   57 ++++++++++++++++++++++++++++
>  arch/arm/mach-kirkwood/common.h            |    6 +++
>  7 files changed, 105 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/boot/dts/kirkwood-km_kirkwood.dts
>  create mode 100644 arch/arm/mach-kirkwood/board-km_kirkwood.c
> 
> diff --git a/arch/arm/boot/dts/kirkwood-km_kirkwood.dts b/arch/arm/boot/dts/kirkwood-km_kirkwood.dts
> new file mode 100644
> index 0000000..75bdb93
> --- /dev/null
> +++ b/arch/arm/boot/dts/kirkwood-km_kirkwood.dts
> @@ -0,0 +1,29 @@
> +/dts-v1/;
> +
> +/include/ "kirkwood.dtsi"
> +
> +/ {
> +	model = "Keymile Kirkwood Reference Design";
> +	compatible = "keymile,km_kirkwood", "marvell,kirkwood-98DX4122", "marvell,kirkwood";
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x00000000 0x08000000>;
> +	};
> +
> +	chosen {
> +		bootargs = "console=ttyS0,115200n8 earlyprintk";
> +	};
> +
> +	ocp at f1000000 {
> +		serial at 12000 {
> +			clock-frequency = <200000000>;
> +			status = "ok";
> +		};
> +
> +		nand at 3000000 {
> +			status = "ok";
> +			chip-delay = <25>;
> +		};
> +	};
> +};
> diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
> index ca5c15a..a2a99a1 100644
> --- a/arch/arm/mach-kirkwood/Kconfig
> +++ b/arch/arm/mach-kirkwood/Kconfig
> @@ -109,6 +109,13 @@ config MACH_LSXL_DT
>  	  Buffalo Linkstation LS-XHL & LS-CHLv2 devices, using
>  	  Flattened Device Tree.
>  
> +config MACH_KM_KIRKWOOD_DT
> +	bool "Keymile Kirkwood Reference Design (Flattened Device Tree)"
> +	select ARCH_KIRKWOOD_DT
> +	help
> +	  Say 'Y' here if you want your kernel to support the
> +	  Keymile Kirkwood Reference Desgin, using Flattened Device Tree.
> +
>  config MACH_TS219
>  	bool "QNAP TS-110, TS-119, TS-119P+, TS-210, TS-219, TS-219P and TS-219P+ Turbo NAS"
>  	help
> diff --git a/arch/arm/mach-kirkwood/Makefile b/arch/arm/mach-kirkwood/Makefile
> index 055c85a..f23ed81 100644
> --- a/arch/arm/mach-kirkwood/Makefile
> +++ b/arch/arm/mach-kirkwood/Makefile
> @@ -28,3 +28,4 @@ obj-$(CONFIG_MACH_IB62X0_DT)		+= board-ib62x0.o
>  obj-$(CONFIG_MACH_TS219_DT)		+= board-ts219.o tsx1x-common.o
>  obj-$(CONFIG_MACH_GOFLEXNET_DT)		+= board-goflexnet.o
>  obj-$(CONFIG_MACH_LSXL_DT)		+= board-lsxl.o
> +obj-$(CONFIG_MACH_KM_KIRKWOOD_DT)	+= board-km_kirkwood.o
> diff --git a/arch/arm/mach-kirkwood/Makefile.boot b/arch/arm/mach-kirkwood/Makefile.boot
> index a571755..4f1dc3c 100644
> --- a/arch/arm/mach-kirkwood/Makefile.boot
> +++ b/arch/arm/mach-kirkwood/Makefile.boot
> @@ -11,3 +11,4 @@ dtb-$(CONFIG_MACH_TS219_DT)	+= kirkwood-qnap-ts219.dtb
>  dtb-$(CONFIG_MACH_GOFLEXNET_DT) += kirkwood-goflexnet.dtb
>  dtb-$(CONFIG_MACH_LSXL_DT) += kirkwood-lschlv2.dtb
>  dtb-$(CONFIG_MACH_LSXL_DT) += kirkwood-lsxhl.dtb
> +dtb-$(CONFIG_MACH_KM_KIRKWOOD_DT) += kirkwood-km_kirkwood.dtb
> diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
> index e4eb450..9decc97 100644
> --- a/arch/arm/mach-kirkwood/board-dt.c
> +++ b/arch/arm/mach-kirkwood/board-dt.c
> @@ -87,6 +87,9 @@ static void __init kirkwood_dt_init(void)
>  	if (of_machine_is_compatible("buffalo,lsxl"))
>  		lsxl_init();
>  
> +	if (of_machine_is_compatible("keymile,km_kirkwood"))
> +		km_kirkwood_init();
> +
>  	of_platform_populate(NULL, kirkwood_dt_match_table,
>  			     kirkwood_auxdata_lookup, NULL);
>  }
> @@ -100,6 +103,7 @@ static const char *kirkwood_dt_board_compat[] = {
>  	"qnap,ts219",
>  	"seagate,goflexnet",
>  	"buffalo,lsxl",
> +	"keymile,km_kirkwood",
>  	NULL
>  };
>  
> diff --git a/arch/arm/mach-kirkwood/board-km_kirkwood.c b/arch/arm/mach-kirkwood/board-km_kirkwood.c
> new file mode 100644
> index 0000000..f7d3283
> --- /dev/null
> +++ b/arch/arm/mach-kirkwood/board-km_kirkwood.c
> @@ -0,0 +1,57 @@
> +/*
> + * Copyright 2012 2012 KEYMILE AG, CH-3097 Bern
> + * Valentin Longchamp <valentin.longchamp@keymile.com>
> + *
> + * arch/arm/mach-kirkwood/board-km_kirkwood.c
> + *
> + * Keymile km_kirkwood Reference Desing Init for drivers not converted to
> + * flattened device tree yet.
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/mv643xx_eth.h>
> +#include <linux/clk.h>
> +#include <linux/clk-private.h>
> +#include "common.h"
> +#include "mpp.h"
> +
> +static struct mv643xx_eth_platform_data km_kirkwood_ge00_data = {
> +	.phy_addr	= MV643XX_ETH_PHY_ADDR(0),
> +};
> +
> +static unsigned int km_kirkwood_mpp_config[] __initdata = {
> +	MPP8_GPIO,	/* I2C SDA */
> +	MPP9_GPIO,	/* I2C SCL */
> +	0
> +};
> +
> +void __init km_kirkwood_init(void)
> +{
> +	struct clk *sata_clk;
> +	/*
> +	 * Basic setup. Needs to be called early.
> +	 */
> +	kirkwood_mpp_conf(km_kirkwood_mpp_config);
> +
> +	/*
> +	 * Our variant of kirkwood (integrated in the Bobcat) hangs on accessing
> +	 * SATA bits (14-15) of the Clock Gating Control Register. Since these
> +	 * devices are also not present in this variant, their clocks get
> +	 * disabled because unused when clk_disable_unused() gets called.
> +	 * That's why we change the flags to these clocks to CLK_IGNORE_UNUSED
> +	 */
> +	sata_clk = clk_get_sys("sata_mv.0", "0");
> +	if (!IS_ERR(sata_clk))
> +		sata_clk->flags |= CLK_IGNORE_UNUSED;
> +	sata_clk = clk_get_sys("sata_mv.0", "1");
> +	if (!IS_ERR(sata_clk))
> +		sata_clk->flags |= CLK_IGNORE_UNUSED;
> +
> +	kirkwood_ehci_init();
> +	kirkwood_ge00_init(&km_kirkwood_ge00_data);
> +}
> diff --git a/arch/arm/mach-kirkwood/common.h b/arch/arm/mach-kirkwood/common.h
> index 304dd1a..219eecc 100644
> --- a/arch/arm/mach-kirkwood/common.h
> +++ b/arch/arm/mach-kirkwood/common.h
> @@ -94,6 +94,12 @@ void lsxl_init(void);
>  static inline void lsxl_init(void) {};
>  #endif
>  
> +#ifdef CONFIG_MACH_KM_KIRKWOOD_DT
> +void km_kirkwood_init(void);
> +#else
> +static inline void km_kirkwood_init(void) {};
> +#endif
> +
>  /* early init functions not converted to fdt yet */
>  char *kirkwood_id(void);
>  void kirkwood_l2_init(void);
> -- 
> 1.7.1
 
Hi Valentin

With the understanding that we re-work the SATA clocks once we have
better DT support for clocks:

Acked-by: Andrew Lunn <andrew@lunn.ch>
