From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 20 May 2018 20:50:50 +0800
Subject: [PATCH] ARM: dts: imx7d: use operating-points-v2 for cpu
In-Reply-To: <1526446097-7111-1-git-send-email-Anson.Huang@nxp.com>
References: <1526446097-7111-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <20180520125048.GX26863@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 16, 2018 at 12:48:17PM +0800, Anson Huang wrote:
> This patch uses "operating-points-v2" instead of
> "operating-points" to be more fit with cpufreq-dt
> driver.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  arch/arm/boot/dts/imx7d.dtsi | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
> index 4c9877e..28980c8 100644
> --- a/arch/arm/boot/dts/imx7d.dtsi
> +++ b/arch/arm/boot/dts/imx7d.dtsi
> @@ -9,12 +9,8 @@
>  / {
>  	cpus {
>  		cpu0: cpu at 0 {
> -			operating-points = <
> -				/* KHz	uV */
> -				996000	1075000
> -				792000	975000
> -			>;
>  			clock-frequency = <996000000>;
> +			operating-points-v2 = <&cpu0_opp_table>;
>  		};
>  
>  		cpu1: cpu at 1 {
> @@ -22,6 +18,24 @@
>  			device_type = "cpu";
>  			reg = <1>;
>  			clock-frequency = <996000000>;
> +			operating-points-v2 = <&cpu0_opp_table>;
> +		};
> +	};
> +
> +	cpu0_opp_table: opp_table0 {

Hyphen is recommended in node name.  Also the suffix 0 doesn't mean too
much here.  That said, a better node name would be 'opp-table'.

> +		compatible = "operating-points-v2";
> +		opp-shared;
> +
> +		opp-792000000 {
> +			opp-hz = /bits/ 64 <792000000>;
> +			opp-microvolt = <975000>;
> +			clock-latency-ns = <150000>;
> +		};

We recommend to have a newline between nodes.

I fixed them all and applied the patch.

Shawn

> +		opp-996000000 {
> +			opp-hz = /bits/ 64 <996000000>;
> +			opp-microvolt = <1075000>;
> +			clock-latency-ns = <150000>;
> +			opp-suspend;
>  		};
>  	};
>  
> -- 
> 2.7.4
> 
