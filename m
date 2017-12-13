From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 13 Dec 2017 11:50:04 +0100
Subject: [PATCH 2/4] arm: dts: sun8i: a83t: Add registers needed for MCPM
In-Reply-To: <20171211075001.6100-3-mylene.josserand@free-electrons.com>
References: <20171211075001.6100-1-mylene.josserand@free-electrons.com>
 <20171211075001.6100-3-mylene.josserand@free-electrons.com>
Message-ID: <20171213105004.k2hlnl3dzvs2plhh@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Dec 11, 2017 at 08:49:59AM +0100, Myl?ne Josserand wrote:
> Add 3 registers needed for MCPM (ie SMP): prcm, cpucfg and r_cpucfg.
> prcm and cpucfg are identical with sun9i-a80. The only difference
> is the r_cpucfg that does not exist on sun9i.
> 
> Signed-off-by: Myl?ne Josserand <mylene.josserand@free-electrons.com>
> ---
>  arch/arm/boot/dts/sun8i-a83t.dtsi | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
> index a384b766f3dc..eeb2e7d0d6dc 100644
> --- a/arch/arm/boot/dts/sun8i-a83t.dtsi
> +++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
> @@ -323,6 +323,16 @@
>  			#reset-cells = <1>;
>  		};


> +		cpucfg at 01700000 {

Please drop the leading zero here, it generates a warning in dtc.

> +			compatible = "allwinner,sun9i-a80-cpucfg";

There's some significant differences between the A83t and the A80 IPs,
you should use a different compatible.

> +			reg = <0x01700000 0x100>;

the size is 1k (0x400)

> +		};
> +
> +		r_cpucfg at 1f01c00 {
> +			compatible = "allwinner,sun8i-a83t-r-cpucfg";
> +			reg = <0x1f01c00 0x100>;

You should order the nodes by physical address

> +		};
> +
>  		pio: pinctrl at 1c20800 {
>  			compatible = "allwinner,sun8i-a83t-pinctrl";
>  			interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
> @@ -493,6 +503,11 @@
>  			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
>  		};
>  
> +		prcm at 1f01400 {
> +			compatible = "allwinner,sun9i-a80-prcm";

That block is significantly different on the A83t. Please use a
different compatible.

> +			reg = <0x1f01400 0x200>;
> +		};
> +

The size is 1k, again.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171213/dbb4fb64/attachment.sig>
