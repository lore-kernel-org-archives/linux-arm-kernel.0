From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Fri, 30 Nov 2012 13:30:44 +0100
Subject: [PATCH 3/5] ARM: mach-shmobile: sh73a0: Initialise MMCIF using DT
In-Reply-To: <1354265085-2444-4-git-send-email-horms@verge.net.au>
References: <1354265085-2444-1-git-send-email-horms@verge.net.au>
 <1354265085-2444-4-git-send-email-horms@verge.net.au>
Message-ID: <3094701.LTMQnxTPNp@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

Thank you for the patch.

On Friday 30 November 2012 17:44:43 Simon Horman wrote:
> From: Simon Horman <horms+renesas@verge.net.au>
> 
> This device also requires a voltage regulator which
> should be defined in a board-specific maner. An example
> dts snipped follows.
> 
> / {
> 	fixedregulator1v8: fixedregulator at 0 {
> 		compatible = "regulator-fixed";
> 		regulator-name = "fixed-1.8V";
> 		regulator-min-microvolt = <1800000>;
> 		regulator-max-microvolt = <1800000>;
> 	};
> };
> 
> &mmcif {
> 	vmmc-supply = <&fixedregulator1v8>;
> 	vqmmc-supply = <&fixedregulator1v8>;
> };
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> ---
> 
> v2
> * Removed SDHI intitialisation as the driver needs updating first
> * Moved MMC DT from sh73a0.dtsi to sh73a0-reference.dtsi
>   as it is not appropriate for use by sh73a0-kzm9g.dts yet.
>   This is because sh73a0-kzm9g.dts and board-kzm9g.c use
>   both the GIC and INTC interrupt controllers to provide
>   access to a rich set of devices. This is achieved by initilising
>   the interrupt controllers using C code. Work on allowing the INC
>   controller to be initialised using DT is in progress, however,
>   until that is complete only GIC may be initialised using DT.
> * Add extra entries to clock-sh73a0.c:lookups[] and
>   remove auxdata. Ultimtely the clocks will be described
>   in DT, but the code isn't there yet.

Could you please add this as a TO-DO item either in the commit message or in 
arch/arm/mach-shmobile/clock-sh73a0.c ?

> ---
>  arch/arm/boot/dts/sh73a0-reference.dtsi |   24 ++++++++++++++++++++++++
>  arch/arm/mach-shmobile/clock-sh73a0.c   |    1 +
>  2 files changed, 25 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sh73a0-reference.dtsi
> 
> diff --git a/arch/arm/boot/dts/sh73a0-reference.dtsi
> b/arch/arm/boot/dts/sh73a0-reference.dtsi new file mode 100644
> index 0000000..d4bb012
> --- /dev/null
> +++ b/arch/arm/boot/dts/sh73a0-reference.dtsi
> @@ -0,0 +1,24 @@
> +/*
> + * Device Tree Source for the SH73A0 SoC
> + *
> + * Copyright (C) 2012 Renesas Solutions Corp.
> + *
> + * This file is licensed under the terms of the GNU General Public License
> + * version 2.  This program is licensed "as is" without any warranty of any
> + * kind, whether express or implied.
> + */
> +
> +/include/ "sh73a0.dtsi"
> +
> +/ {
> +	compatible = "renesas,sh73a0";
> +
> +	mmcif: mmcif at 0x10010000 {
> +		compatible = "renesas,sh-mmcif";
> +		reg = <0xe6bd0000 0x100>;
> +		interrupt-parent = <&gic>;
> +		interrupts = <0 140 0x4
> +			      0 141 0x4>;
> +		reg-io-width = <4>;
> +	};
> +};
> diff --git a/arch/arm/mach-shmobile/clock-sh73a0.c
> b/arch/arm/mach-shmobile/clock-sh73a0.c index 8bc7a2b..0908123 100644
> --- a/arch/arm/mach-shmobile/clock-sh73a0.c
> +++ b/arch/arm/mach-shmobile/clock-sh73a0.c
> @@ -576,6 +576,7 @@ static struct clk_lookup lookups[] = {
>  	CLKDEV_DEV_ID("sh_mobile_sdhi.0", &mstp_clks[MSTP314]), /* SDHI0 */
>  	CLKDEV_DEV_ID("sh_mobile_sdhi.1", &mstp_clks[MSTP313]), /* SDHI1 */
>  	CLKDEV_DEV_ID("sh_mmcif.0", &mstp_clks[MSTP312]), /* MMCIF0 */
> +	CLKDEV_DEV_ID("e6bd0000.mmcif", &mstp_clks[MSTP312]), /* MMCIF0 */
>  	CLKDEV_DEV_ID("sh_mobile_sdhi.2", &mstp_clks[MSTP311]), /* SDHI2 */
>  	CLKDEV_DEV_ID("leds-renesas-tpu.12", &mstp_clks[MSTP303]), /* TPU1 */
>  	CLKDEV_DEV_ID("leds-renesas-tpu.21", &mstp_clks[MSTP302]), /* TPU2 */
-- 
Regards,

Laurent Pinchart
