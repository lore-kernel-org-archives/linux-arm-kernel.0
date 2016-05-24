From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Tue, 24 May 2016 07:30:17 +0200
Subject: [PATCH v3 1/3] arm64: dts: r8a7796: Add Renesas R8A7796 SoC
 support
In-Reply-To: <1464054880-25843-2-git-send-email-horms+renesas@verge.net.au>
References: <1464054880-25843-1-git-send-email-horms+renesas@verge.net.au>
 <1464054880-25843-2-git-send-email-horms+renesas@verge.net.au>
Message-ID: <b30c9c84-23b6-b088-4983-b2498317492b@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On 24.05.2016 03:54, Simon Horman wrote:
> Basic support for the Gen 3 R-Car M3-W SoC.
>
> Based on work for the r8a7795 and r8a7796 SoCs by
> Takeshi Kihara, Dirk Behme and Geert Uytterhoeven.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v3
> * As suggested by Geert Uytterhoeven:
>   - Drop 0x from unit address of gic
> * As suggested by Khiem Nguyen:
>   - Use psci-0.2
> * Added Reviewed-by tag from Geert Uytterhoeven
>
> v2
> * As suggested by Geert Uytterhoeven:
>   - Move L2_CA57 node under cpus node and include reg property
>   - Omit status = "disabled" from scif_clk node
> ---
>  Documentation/devicetree/bindings/arm/shmobile.txt |   4 +
>  arch/arm64/Kconfig.platforms                       |   6 ++
>  arch/arm64/boot/dts/renesas/r8a7796.dtsi           | 120 +++++++++++++++++++++
>  3 files changed, 130 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/renesas/r8a7796.dtsi
>
> diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
> index 9cf67e48f222..d5ed554830d7 100644
> --- a/Documentation/devicetree/bindings/arm/shmobile.txt
> +++ b/Documentation/devicetree/bindings/arm/shmobile.txt
> @@ -29,6 +29,8 @@ SoCs:
>      compatible = "renesas,r8a7794"
>    - R-Car H3 (R8A77950)
>      compatible = "renesas,r8a7795"
> +  - R-Car M3-W (R8A77960)
> +    compatible = "renesas,r8a7796"
>
>
>  Boards:
> @@ -61,5 +63,7 @@ Boards:
>      compatible = "renesas,porter", "renesas,r8a7791"
>    - Salvator-X (RTP0RC7795SIPB0010S)
>      compatible = "renesas,salvator-x", "renesas,r8a7795";
> +  - Salvator-X
> +    compatible = "renesas,salvator-x", "renesas,r8a7796";
>    - SILK (RTP0RC7794LCB00011S)
>      compatible = "renesas,silk", "renesas,r8a7794"
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index efa77c146415..16d8d26839ea 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -114,6 +114,12 @@ config ARCH_R8A7795
>  	help
>  	  This enables support for the Renesas R-Car H3 SoC.
>
> +config ARCH_R8A7796
> +	bool "Renesas R-Car M3-W SoC Platform"
> +	depends on ARCH_RENESAS
> +	help
> +	  This enables support for the Renesas R-Car M3-W SoC.
> +
>  config ARCH_STRATIX10
>  	bool "Altera's Stratix 10 SoCFPGA Family"
>  	help
> diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
> new file mode 100644
> index 000000000000..178debf68318
> --- /dev/null
> +++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
> @@ -0,0 +1,120 @@
> +/*
> + * Device Tree Source for the r8a7796 SoC
> + *
> + * Copyright (C) 2016 Renesas Electronics Corp.
> + *
> + * This file is licensed under the terms of the GNU General Public License
> + * version 2.  This program is licensed "as is" without any warranty of any
> + * kind, whether express or implied.
> + */
> +
> +#include <dt-bindings/clock/r8a7796-cpg-mssr.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>


With Renesas R-Car3 we will get a whole family of SoCs. I.e. different 
computing power (e.g. different number of Cores) with more or less 
similar peripherals.

I would think that we want to reflect this in the device tree, too. 
Therefore I think what we want is a hierarchy of device trees. Similar 
what's done with other SoC families (compare e.g. i.MX6).

E.g. we want an initial rcar3.dtsi, which contains all common parts of 
all R-Car3 SoCs. E.g. one CA57 core, the SCIF where its common etc.

Then you will have the r8a779x.dtsi which includes the rcar3.dtsi and 
extends it for SoC specific parts. Which then will be included by the 
board device trees, as already done, now.

Or in other words: As soon as you have similar parts in the 
r8a779x.dtsi's, it's time to think about moving the parts one hierarchy 
level up into the rcar3.dtsi. Else you will end up in a maintenance hell 
once you have to change/fix anything.

Best regards

Dirk
