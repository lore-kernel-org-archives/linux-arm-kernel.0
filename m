From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 11 Apr 2017 11:13:46 +0200
Subject: [PATCH 4/5] ARM: sun8i: h3: add operating-points-v2 table for CPU
In-Reply-To: <20170408185025.53841-5-icenowy@aosc.io>
References: <20170408185025.53841-1-icenowy@aosc.io>
 <20170408185025.53841-5-icenowy@aosc.io>
Message-ID: <20170411091346.mcwyskezadabsobn@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 09, 2017 at 02:50:24AM +0800, Icenowy Zheng wrote:
> The CPU on Allwinner H3 can do dynamic frequency scaling.
> 
> Add a DVFS table based on the one tweaked by Armbian developers, which
> are proven to work stably on BSP kernels.
> 
> Frequencies higher than 1008MHz are temporarily dropped in the table, as
> they may lead to over voltage on boards without proper regulator
> settings or over temperature on boards with proper regulator settings.
> They will be added back once regulator settings are ready and thermal
> sensor driver is merged.
> 
> In order to satisfy all different regulators (SY8106A which is 50mV per
> level, SY8113B which have two states: 1.1V and 1.3V, and some board with
> non-tweakable regulators), all the OPPs are defined with a range which has
> the target value as the minimum allowed value, and 1.3V (the highest
> VDD-CPUX voltage suggested by the datasheet) as the maximum allowed value.
> It's proven to work well with a board with SY8113B.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  arch/arm/boot/dts/sun8i-h3.dtsi | 38 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
> index b36f9f423c39..a0cee17fe44b 100644
> --- a/arch/arm/boot/dts/sun8i-h3.dtsi
> +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
> @@ -43,32 +43,68 @@
>  #include "sunxi-h3-h5.dtsi"
>  
>  / {
> +	cpu0_opp_table: opp_table0 {
> +		compatible = "operating-points-v2";
> +		opp-shared;
> +
> +		opp at 480000000 {
> +			opp-hz = /bits/ 64 <480000000>;
> +			opp-microvolt = <980000 980000 1300000>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +		};
> +
> +		opp at 648000000 {
> +			opp-hz = /bits/ 64 <816000000>;
> +			opp-microvolt = <1020000 1020000 1300000>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +		};
> +
> +		opp at 912000000 {
> +			opp-hz = /bits/ 64 <960000000>;
> +			opp-microvolt = <1080000 1080000 1300000>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +		};
> +
> +		opp at 1008000000 {
> +			opp-hz = /bits/ 64 <1008000000>;
> +			opp-microvolt = <1140000 1140000 1300000>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +		};
> +	};
> +

>From your serie, I guess you never actually tested those OPPs on any
board without SY8113B, right?

(and therefore, without operating at the voltages listed here).

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170411/e0c661e2/attachment-0001.sig>
