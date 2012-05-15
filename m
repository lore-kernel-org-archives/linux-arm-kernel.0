From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 15 May 2012 11:12:18 +0200
Subject: [PATCH 2/8] arm: mach-armada: add source files
In-Reply-To: <1337072084-21967-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1337072084-21967-3-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20120515091218.GB6820@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 15, 2012 at 10:54:38AM +0200, Thomas Petazzoni wrote:
> This patch adds basic source files for Marvell Armada SoCs.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Signed-off-by: Lior Amsalem <alior@marvell.com>
> ---
>  arch/arm/boot/dts/a370.dtsi        |   23 ++++
>  arch/arm/boot/dts/armada.dtsi      |   67 ++++++++++
>  arch/arm/boot/dts/axp.dtsi         |   43 +++++++
>  arch/arm/mach-armada/Kconfig       |    5 +
>  arch/arm/mach-armada/Makefile      |    2 +
>  arch/arm/mach-armada/Makefile.boot |    1 +
>  arch/arm/mach-armada/common.c      |   56 +++++++++
>  arch/arm/mach-armada/common.h      |   27 ++++
>  arch/arm/mach-armada/irq.c         |  116 +++++++++++++++++
>  arch/arm/mach-armada/time.c        |  243 ++++++++++++++++++++++++++++++++++++
>  10 files changed, 583 insertions(+)
>  create mode 100644 arch/arm/boot/dts/a370.dtsi
>  create mode 100644 arch/arm/boot/dts/armada.dtsi
>  create mode 100644 arch/arm/boot/dts/axp.dtsi
>  create mode 100644 arch/arm/mach-armada/Kconfig
>  create mode 100644 arch/arm/mach-armada/Makefile
>  create mode 100644 arch/arm/mach-armada/Makefile.boot
>  create mode 100644 arch/arm/mach-armada/common.c
>  create mode 100644 arch/arm/mach-armada/common.h
>  create mode 100644 arch/arm/mach-armada/irq.c
>  create mode 100644 arch/arm/mach-armada/time.c
> 
> diff --git a/arch/arm/boot/dts/a370.dtsi b/arch/arm/boot/dts/a370.dtsi
> new file mode 100644
> index 0000000..f11e56a
> --- /dev/null
> +++ b/arch/arm/boot/dts/a370.dtsi
> @@ -0,0 +1,23 @@
> +/*
> + * Device Tree Include file for Marvell Armada 370 family SoC
> + *
> + * Copyright (C) 2012 Marvell
> + *
> + * Lior Amsalem <alior@marvell.com>
> + * Gregory CLEMENT <gregory.clement@free-electrons.com>
> + * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + *
> + * Contains definitions specific to the Armada 370 SoC that are not
> + * common to all Armada SoCs.
> + */
> +
> +/include/ "armada.dtsi"
> +
> +/ {
> +	model = "Marvell Armada 370 family SoC";
> +	compatible = "marvell,armada370", "marvell,armada";

It should be mrvl, not marvell, in all the compatibility strings.

Also, we need to be careful with armada. kirkwood is an armada for
example. It maybe be better to not actually use armada without
postfix.

> +void armada_restart(char mode, const char *cmd)
> +{
> +	/*
> +	 * Enable soft reset to assert RSTOUTn.
> +	 */
> +	writel(SOFT_RESET_OUT_EN, RSTOUTn_MASK);
> +
> +	/*
> +	 * Assert soft reset.
> +	 */
> +	writel(SOFT_RESET, SYSTEM_SOFT_RESET);
> +	while (1)
> +		;
> +}

This chunk of code comes up multiple times in various orion
devices. Could it be refactored into plat-orion?

Thanks
	Andrew
