From: quentin.schulz@bootlin.com (Quentin Schulz)
Date: Thu, 6 Sep 2018 09:24:29 +0200
Subject: [PATCH v3 30/30] ARM: sun8i: a83t: full range OPP tables and
 CPUfreq
In-Reply-To: <20180830154518.29507-31-embed3d@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
 <20180830154518.29507-31-embed3d@gmail.com>
Message-ID: <20180906072429.7qjwbbqsjlbskk6v@qschulz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,

On Thu, Aug 30, 2018 at 05:45:18PM +0200, Philipp Rossak wrote:
> Since we have now thermal trotteling enabeled we can now add the full
> range of the OPP table.
> 

That's not the reason why they were not added.

Please see commit 2db639d8c1663d7543c9ab5323383d94c8a76c63[1].

Basically, you only want the OPPs which can work below or at the default
voltage of the CPU supply, because the CPU supply is specific to each
board.

If you set your CPU to work at a given frequency and the voltage isn't
updated (saying opp-microvolt = <x>; in DT isn't enough, you need
cpu-supply to be provided and functional), the CPU might just crash.

Without cpu-supply property, underclocking isn't effective in term of
thermal cooling or power saving. Overclocking is very, very, very likely
to make the CPU crash.

It's not a very difficult thing to do to test if a given frequency work
well but it needs a specific test environment and it's a lengthy test,
you can have a look at those tools here[3] if you like. It's not because
it works in a given test case that'll work on the long term under heavy
load and constant frequency changes.

For A83T, I already did it and the outcome is the patch in [1]. Same for
A33.

So, if you want to use these three higher OPPs, you need to define them
in your board DTS and add the cpu-supply property. See what's done for
the A33 and more specifically the Sinlinx SinA33[2] as an example.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2db639d8c1663d7543c9ab5323383d94c8a76c63
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
[3] http://linux-sunxi.org/Hardware_Reliability_Tests#CPU

Quentin

> The operating points were found in Allwinner BSP and fex files.
> 
> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> ---
>  arch/arm/boot/dts/sun8i-a83t.dtsi | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
> index 78aa448e869f..ddcf404f9c80 100644
> --- a/arch/arm/boot/dts/sun8i-a83t.dtsi
> +++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
> @@ -250,6 +250,22 @@
>  			opp-microvolt = <840000>;
>  			clock-latency-ns = <244144>; /* 8 32k periods */
>  		};
> +
> +		opp-1608000000 {
> +			opp-hz = /bits/ 64 <1608000000>;
> +			opp-microvolt = <920000>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +		};
> +		opp-1800000000 { /* BOOT FREQ */
> +			opp-hz = /bits/ 64 <1800000000>;
> +			opp-microvolt = <1000000>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +		};
> +		opp-2016000000 {
> +			opp-hz = /bits/ 64 <2016000000>;
> +			opp-microvolt = <1080000>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +		};
>  	};
>  
>  	cpu1_opp_table: opp_table1 {
> @@ -303,6 +319,22 @@
>  			opp-microvolt = <840000>;
>  			clock-latency-ns = <244144>; /* 8 32k periods */
>  		};
> +
> +		opp-1608000000 {
> +			opp-hz = /bits/ 64 <1608000000>;
> +			opp-microvolt = <920000>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +		};
> +		opp-1800000000 { /* BOOT FREQ */
> +			opp-hz = /bits/ 64 <1800000000>;
> +			opp-microvolt = <1000000>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +		};
> +		opp-2016000000 {
> +			opp-hz = /bits/ 64 <2016000000>;
> +			opp-microvolt = <1080000>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +		};
>  	};
>  
>  	soc {
> -- 
> 2.11.0
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180906/a2510630/attachment.sig>
