From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 21 Aug 2012 07:10:01 +0200
Subject: [PATCH] ARM: Kirkwood: Iomega ix2-200 DT support Signed-off-by:
 Alan M Butler <alanbutty12@gmail.com>
In-Reply-To: <2b8d12ce68911cc12c96dcdd60c3345b72d25780.1345472556.git.alanbutty12@gmail.com>
References: <cover.1345472556.git.alanbutty12@gmail.com>
 <2b8d12ce68911cc12c96dcdd60c3345b72d25780.1345472556.git.alanbutty12@gmail.com>
Message-ID: <20120821051001.GB30810@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 20, 2012 at 03:29:07PM +0100, Alan M Butler wrote:
> Patch version 5.
> Add support for the Iomega ix2-200.
> Led's and buttons working as of kernel 3.6-rc2
> 
> the 3 lines in the network interface do seem to be required as
> removing either causes the network card to not be able to reach
> the network (at least on my device).
> 
> Product page:
> http://go.iomega.com/en/products/network-storage-desktop/storcenter-network-storage-solution/network-hard-drive-ix2-200-cloud/?partner=4735#tech_specsItem_tab
> 
> Signed-off-by: Alan M Butler <alanbutty12@gmail.com>
> 
> ---
>  arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts |  105 +++++++++++++++++++++++++
>  arch/arm/mach-kirkwood/Kconfig                |    7 ++
>  arch/arm/mach-kirkwood/Makefile               |    1 +
>  arch/arm/mach-kirkwood/Makefile.boot          |    1 +
>  arch/arm/mach-kirkwood/board-dt.c             |    4 +
>  arch/arm/mach-kirkwood/board-iomega_ix2_200.c |   57 ++++++++++++++
>  arch/arm/mach-kirkwood/common.h               |    6 ++
>  7 files changed, 181 insertions(+)
>  create mode 100644 arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts
>  create mode 100644 arch/arm/mach-kirkwood/board-iomega_ix2_200.c
> 
> diff --git a/arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts b/arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts
> new file mode 100644
> index 0000000..865aeec
> --- /dev/null
> +++ b/arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts
> @@ -0,0 +1,105 @@
> +/dts-v1/;
> +
> +/include/ "kirkwood.dtsi"
> +
> +/ {
> +	model = "Iomega StorCenter ix2-200";
> +	compatible = "iom,ix2-200", "marvell,kirkwood-88f6281", "marvell,kirkwood";
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x00000000 0x10000000>;
> +	};
> +
> +	chosen {
> +		bootargs = "console=ttyS0,115200n8 earlyprintk";
> +	};
> +
> +	ocp at f1000000 {
> +		i2c at 11000 {
> +			status = "okay";
> +
> +			lm63: lm63 at 4c {
> +				compatible = "national,lm63";
> +				reg = <0x4c>;
> +			};
> +		};
> +
> +		serial at 12000 {
> +			clock-frequency = <200000000>;
> +			status = "ok";
> +		};
> +
> +		nand at 3000000 {
> +			status = "okay";
> +
> +			partition at 0 {
> +				label = "u-boot";
> +				reg = <0x0000000 0x100000>;
> +				read-only;
> +			};
> +
> +			partition at a0000 {
> +				label = "env";
> +				reg = <0xa0000 0x20000>;
> +				read-only;
> +			};
> +
> +			partition at 100000 {
> +				label = "uImage";
> +				reg = <0x100000 0x300000>;
> +			};
> +
> +			partition at 400000 {
> +				label = "uInitrd";
> +				reg = <0x540000 0x1000000>;
> +			};
> +		};
> +		sata at 80000 {
> +			status = "okay";
> +			nr-ports = <2>;
> +		};
> +
> +	};
> +	gpio-leds {
> +		compatible = "gpio-leds";
> +
> +		power_led {
> +			label = "status:white:power_led";
> +			gpios = <&gpio0 16 0>;
> +			linux,default-trigger = "default-on";
> +		};
> +		health_led1 {
> +			label = "status:red:health_led";
> +			gpios = <&gpio1 5 0>;
> +		};
> +		health_led2 {
> +			label = "status:white:health_led";
> +			gpios = <&gpio1 4 0>;
> +		};
> +		backup_led {
> +			label = "status:blue:backup_led";
> +			gpios = <&gpio0 15 0>;
> +		};
> +	};
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		Power {
> +			label = "Power Button";
> +			linux,code = <116>;
> +			gpios = <&gpio0 14 1>;
> +		};
> +		Reset {
> +			label = "Reset Button";
> +			linux,code = <0x198>;
> +			gpios = <&gpio0 12 1>;
> +		};
> +		OTB {
> +			label = "OTB Button";
> +			linux,code = <133>;
> +			gpios = <&gpio1 3 1>;
> +		};
> +	};
> +};
> diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
> index ca5c15a..bee8451 100644
> --- a/arch/arm/mach-kirkwood/Kconfig
> +++ b/arch/arm/mach-kirkwood/Kconfig
> @@ -195,6 +195,13 @@ config MACH_T5325
>  	  Say 'Y' here if you want your kernel to support the
>  	  HP t5325 Thin Client.
>  
> +config MACH_IOMEGA_IX2_200_DT
> +	bool "Iomega StorCenter ix2-200 (Flattened Device Tree)"
> +	select ARCH_KIRKWOOD_DT
> +	help
> +	  Say 'Y' here if you want your kernel to support the
> +	  Iomega StorCenter ix2-200 (Flattened Device Tree).
> +
>  endmenu
>  
>  endif
> diff --git a/arch/arm/mach-kirkwood/Makefile b/arch/arm/mach-kirkwood/Makefile
> index 055c85a..f5484dc 100644
> --- a/arch/arm/mach-kirkwood/Makefile
> +++ b/arch/arm/mach-kirkwood/Makefile
> @@ -28,3 +28,4 @@ obj-$(CONFIG_MACH_IB62X0_DT)		+= board-ib62x0.o
>  obj-$(CONFIG_MACH_TS219_DT)		+= board-ts219.o tsx1x-common.o
>  obj-$(CONFIG_MACH_GOFLEXNET_DT)		+= board-goflexnet.o
>  obj-$(CONFIG_MACH_LSXL_DT)		+= board-lsxl.o
> +obj-$(CONFIG_MACH_IOMEGA_IX2_200_DT)	+= board-iomega_ix2_200.o
> diff --git a/arch/arm/mach-kirkwood/Makefile.boot b/arch/arm/mach-kirkwood/Makefile.boot
> index a571755..59b719d 100644
> --- a/arch/arm/mach-kirkwood/Makefile.boot
> +++ b/arch/arm/mach-kirkwood/Makefile.boot
> @@ -11,3 +11,4 @@ dtb-$(CONFIG_MACH_TS219_DT)	+= kirkwood-qnap-ts219.dtb
>  dtb-$(CONFIG_MACH_GOFLEXNET_DT) += kirkwood-goflexnet.dtb
>  dtb-$(CONFIG_MACH_LSXL_DT) += kirkwood-lschlv2.dtb
>  dtb-$(CONFIG_MACH_LSXL_DT) += kirkwood-lsxhl.dtb
> +dtb-$(CONFIG_MACH_IOMEGA_IX2_200_DT) += kirkwood-iomega_ix2_200.dtb
> diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
> index e4eb450..9b3ec17 100644
> --- a/arch/arm/mach-kirkwood/board-dt.c
> +++ b/arch/arm/mach-kirkwood/board-dt.c
> @@ -87,6 +87,9 @@ static void __init kirkwood_dt_init(void)
>  	if (of_machine_is_compatible("buffalo,lsxl"))
>  		lsxl_init();
>  
> +	if (of_machine_is_compatible("iom,ix2-200"))
> +		iomega_ix2_200_init();
> +
>  	of_platform_populate(NULL, kirkwood_dt_match_table,
>  			     kirkwood_auxdata_lookup, NULL);
>  }
> @@ -100,6 +103,7 @@ static const char *kirkwood_dt_board_compat[] = {
>  	"qnap,ts219",
>  	"seagate,goflexnet",
>  	"buffalo,lsxl",
> +	"iom,ix2-200",
>  	NULL
>  };
>  
> diff --git a/arch/arm/mach-kirkwood/board-iomega_ix2_200.c b/arch/arm/mach-kirkwood/board-iomega_ix2_200.c
> new file mode 100644
> index 0000000..158fb97
> --- /dev/null
> +++ b/arch/arm/mach-kirkwood/board-iomega_ix2_200.c
> @@ -0,0 +1,57 @@
> +/*
> + * arch/arm/mach-kirkwood/board-iomega_ix2_200.c
> + *
> + * Iomega StorCenter ix2-200
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +#include <linux/mv643xx_eth.h>
> +#include <linux/ethtool.h>
> +#include <mach/kirkwood.h>
> +#include "common.h"
> +#include "mpp.h"
> +
> +static struct mv643xx_eth_platform_data iomega_ix2_200_ge00_data = {
> +	.phy_addr       = MV643XX_ETH_PHY_NONE,
> +	.speed          = SPEED_1000,
> +	.duplex         = DUPLEX_FULL,
> +};
> +
> +static unsigned int iomega_ix2_200_mpp_config[] __initdata = {
> +	MPP12_GPIO,			/* Reset Button */
> +	MPP14_GPIO,			/* Power Button */
> +	MPP15_GPIO,			/* Backup LED (blue) */
> +	MPP16_GPIO,			/* Power LED (white) */
> +	MPP35_GPIO,			/* OTB Button */
> +	MPP36_GPIO,			/* Rebuild LED (white) */
> +	MPP37_GPIO,			/* Health LED (red) */
> +	MPP38_GPIO,			/* SATA LED brightness control 1 */
> +	MPP39_GPIO,			/* SATA LED brightness control 2 */
> +	MPP40_GPIO,			/* Backup LED brightness control 1 */
> +	MPP41_GPIO,			/* Backup LED brightness control 2 */
> +	MPP42_GPIO,			/* Power LED brightness control 1 */
> +	MPP43_GPIO,			/* Power LED brightness control 2 */
> +	MPP44_GPIO,			/* Health LED brightness control 1 */
> +	MPP45_GPIO,			/* Health LED brightness control 2 */
> +	MPP46_GPIO,			/* Rebuild LED brightness control 1 */
> +	MPP47_GPIO,			/* Rebuild LED brightness control 2 */
> +	0
> +};
> +
> +void __init iomega_ix2_200_init(void)
> +{
> +	/*
> +	 * Basic setup. Needs to be called early.
> +	 */
> +	kirkwood_mpp_conf(iomega_ix2_200_mpp_config);
> +
> +	kirkwood_ehci_init();
> +
> +	kirkwood_ge01_init(&iomega_ix2_200_ge00_data);
> +}
> diff --git a/arch/arm/mach-kirkwood/common.h b/arch/arm/mach-kirkwood/common.h
> index 304dd1a..d5d4064 100644
> --- a/arch/arm/mach-kirkwood/common.h
> +++ b/arch/arm/mach-kirkwood/common.h
> @@ -94,6 +94,12 @@ void lsxl_init(void);
>  static inline void lsxl_init(void) {};
>  #endif
>  
> +#ifdef CONFIG_MACH_IOMEGA_IX2_200_DT
> +void iomega_ix2_200_init(void);
> +#else
> +static inline void iomega_ix2_200_init(void) {};
> +#endif
> +
>  /* early init functions not converted to fdt yet */
>  char *kirkwood_id(void);
>  void kirkwood_l2_init(void);
> -- 
> 1.7.9.5
> 

Acked-by: Andrew Lunn <andrew@lunn.ch>

	  Andrew
