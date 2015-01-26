From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 26 Jan 2015 12:15:55 +0100
Subject: [PATCH 4/4] ARM: dts: Add initial support for Alpine platform
In-Reply-To: <54c53663.0OSd3sO9f1oYd3El%tsahee@annapurnalabs.com>
References: <54c53663.0OSd3sO9f1oYd3El%tsahee@annapurnalabs.com>
Message-ID: <36490364.POE8pPlYQh@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 25 January 2015 20:30:59 Tsahee Zidenberg wrote:
> This patch introduces an initial device-tree for the Alpine platform.
> 
> Signed-off-by: Barak Wasserstrom <barak@annapurnalabs.com>
> Signed-off-by: Tsahee Zidenberg <tsahee@annapurnalabs.com>
> ---
>  .../bindings/arm/annapurna-labs,alpine.txt         |  96 +++++++++++
>  .../cpu-enable-method/annapurna-labs,alpine-smp    |  64 ++++++++
>  .../devicetree/bindings/vendor-prefixes.txt        |   1 +
>  arch/arm/boot/dts/Makefile                         |   2 +
>  arch/arm/boot/dts/alpine.dts                       | 181 +++++++++++++++++++++
>  5 files changed, 344 insertions(+)

I'd suggest splitting this into two patches.

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/annapurna-labs,alpine.txt
> @@ -0,0 +1,96 @@
> +Annapurna Labs Alpine Platform Device Tree Bindings
> +---------------------------------------------------------------
> +
> +Boards in the Alpine family shall have the following properties:
> +
> +* Required root node properties:
> +compatible: must contain "annapurna-labs,alpine"
> +
> +* Example:
> +
> +/ {
> +	model = "Annapurna Labs Alpine Dev Board";
> +	compatible = "annapurna-labs,alpine";
> +
> +	...
> +}
> +
> +* CPU node:
> +
> +The Alpine platform includes cortex-a15 cores.
> +enable-method: must be "annapurna-labs,alpine-smp" to allow smp  [1]

Any reason for not using PSCI on this platform?

> diff --git a/arch/arm/boot/dts/alpine.dts b/arch/arm/boot/dts/alpine.dts
> new file mode 100644
> index 0000000..fa0da66
> --- /dev/null
> +++ b/arch/arm/boot/dts/alpine.dts

Most people split this into one .dtsi file for the SoC and one .dts file
for a specific machine, to reduce the amount of duplication when there
are multiple machines that use the same chip.

> @@ -0,0 +1,181 @@
> +/*
> + * Copyright 2015 Annapurna Labs Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */

If you don't mind, please use a dual license for the dts file, to allow
distributing the file with other OSs that might to run on the same
hardware.

> +/dts-v1/;
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include "skeleton64.dtsi"
> +
> +/ {
> +	version = "2.4";

This is not documented anywhere.

> +	compatible = "annapurna-labs,alpine";
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +	clock-ranges;

No "model" property?

> +		/* North Bridge Service Registers */
> +		nb_service {
> +			compatible = "annapurna-labs,al-sysfabric-service";
> +			reg = <0x0 0xfb070000 0x0 0x10000>;
> +		};

What kinds of other registers are there in this device? Should it
be marked as "syscon" so you can use it through a regmap?

	Arnd
