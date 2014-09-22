From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 22 Sep 2014 17:14:10 +0200
Subject: [PATCH v2 4/8] ARM: dts: add DT for Alphascale ASM9260 SoC
In-Reply-To: <1411325151-15107-3-git-send-email-linux@rempel-privat.de>
References: <1411324904-14881-1-git-send-email-linux@rempel-privat.de>
 <1411325151-15107-1-git-send-email-linux@rempel-privat.de>
 <1411325151-15107-3-git-send-email-linux@rempel-privat.de>
Message-ID: <3756861.P0c7Co8TUQ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 21 September 2014 20:45:47 Oleksij Rempel wrote:
> +
> +       chosen {
> +               bootargs = "mem=32M earlyprintk=serial console=ttyS4,115200n8 root=/dev/mtdblock1 init=/linuxrc mtdparts=NAND:4M at 10M(logo)ro,60M at 14M(root)ro";
> +       };

The command line should normally be set by the boot loader, and the individual
arguments don't make much sense here:

the memory size and the flash partitions should be listed in their own DT nodes,
the init program is a user-selected option and the serial port settings
can be derived from DT for the most part too.

> +};
> +&uart4 {
> +       status = "okay";
> +};
> diff --git a/arch/arm/boot/dts/alphascale-asm9260.dtsi b/arch/arm/boot/dts/alphascale-asm9260.dtsi
> new file mode 100644
> index 0000000..3ea4e03
> --- /dev/null
> +++ b/arch/arm/boot/dts/alphascale-asm9260.dtsi
> @@ -0,0 +1,166 @@
> +/*
> + * Copyright 2014 Oleksij Rempel <linux@rempel-privat.de>
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */

We have started moving towards using dual GPL+X11 or GPL+BSD licenses
for the dts files, it would be best if you do the same here.

> +#include "skeleton.dtsi"
> +#include <dt-bindings/clock/alphascale,asm9260.h>
> +
> +/ {
> +       interrupt-parent = <&icoll>;
> +
> +        aliases {
> +               serial0 = &uart0;
> +               serial1 = &uart1;
> +               serial2 = &uart2;
> +               serial3 = &uart3;
> +               serial4 = &uart4;
> +               serial5 = &uart5;
> +               serial6 = &uart6;
> +               serial7 = &uart7;
> +               serial8 = &uart8;
> +               serial9 = &uart9;
> +        };

The aliases for the serial ports are board specific, so you
should probably move those into the first file. Only one of
them is enabled there, so you probably want

aliases {
	serial0 = &uart4;
};

so it shows up as ttyX0.

	Arnd
