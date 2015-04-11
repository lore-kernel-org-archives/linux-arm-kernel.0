From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 11 Apr 2015 23:40:05 +0200
Subject: [PATCH 2/2] ARM: mvebu: dts: Add dts file for DLink DNS-327L
In-Reply-To: <1428784160-19431-3-git-send-email-andrew@ncrmnt.org>
References: <1428784160-19431-1-git-send-email-andrew@ncrmnt.org>
 <1428784160-19431-3-git-send-email-andrew@ncrmnt.org>
Message-ID: <20150411214005.GJ5244@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 11, 2015 at 11:29:20PM +0300, Andrew Andrianov wrote:
> Signed-off-by: Andrew Andrianov <andrew@ncrmnt.org>
> ---
>  arch/arm/boot/dts/Makefile                     |    1 +
>  arch/arm/boot/dts/armada-370-dlink-dns327l.dts |  309 ++++++++++++++++++++++++
>  2 files changed, 310 insertions(+)
>  create mode 100644 arch/arm/boot/dts/armada-370-dlink-dns327l.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index a1c776b..8535e4e 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -612,6 +612,7 @@ dtb-$(CONFIG_ARCH_ZYNQ) += \
>  	zynq-zybo.dtb
>  dtb-$(CONFIG_MACH_ARMADA_370) += \
>  	armada-370-db.dtb \
> +	armada-370-dlink-dns327l.dtb \
>  	armada-370-mirabox.dtb \
>  	armada-370-netgear-rn102.dtb \
>  	armada-370-netgear-rn104.dtb \
> diff --git a/arch/arm/boot/dts/armada-370-dlink-dns327l.dts b/arch/arm/boot/dts/armada-370-dlink-dns327l.dts
> new file mode 100644
> index 0000000..12bc072
> --- /dev/null
> +++ b/arch/arm/boot/dts/armada-370-dlink-dns327l.dts
> @@ -0,0 +1,309 @@
> +/*
> + * Device Tree file for DLINK DNS-327L
> + *
> + * Copyright (C) 2014, Andrew Andrianov <andrew@ncrmnt.org>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */

Hi Andrew

There has been a move to license all the 370 and XP DTS files under
dual GPL and X11. Are you willing to add X11?

> +
> +/* Remaining mysteries:
> + *
> + * There's still something unknown on i2c address 0x13
> + * CONFIG_ARM_MVEBU_V7_CPUIDLE=y causes hard freezes every 1-8 hours
> + *
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include "armada-370.dtsi"
> +
> +/ {
> +	model = "DLINK DNS-327L";
> +	compatible = "dlink,dns327l",
> +		"marvell,armada370",
> +		"marvell,armada-370-xp";
> +
> +	chosen {
> +		bootargs = "console=ttyS0,115200 earlyprintk";

It would be nice to have

stdout-path = &uart0;

here. That will help with boot loaders, using this DT file, and it a
step towards removing the console=ttyS0,115200.

> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x00000000 0x20000000>; /* 512 MiB */
> +	};
> +
> +	soc {
> +		ranges = <MBUS_ID(0xf0, 0x01) 0 0xd0000000 0x100000
> +			MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000>;
> +
> +		pcie-controller {
> +			status = "okay";
> +
> +			/* Connected to Marvell SATA controller */
> +			pcie at 1,0 {
> +				/* Port 0, Lane 0 */
> +				status = "okay";
> +			};
> +
> +			/* Connected to NEC USB 3.0 controller */
> +			pcie at 2,0 {
> +				/* Port 1, Lane 0 */
> +				status = "okay";
> +			};
> +		};
> +
> +		internal-regs {
> +			serial at 12000 {
> +				status = "okay";
> +			};
> +
> +			serial at 12100 {
> +				status = "okay";
> +			};

Are both serial ports usable?
Could you document the pinout for the console?

      Thanks
	Andrew
