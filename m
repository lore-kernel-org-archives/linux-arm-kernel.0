From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 6 Jan 2017 15:27:20 +0000
Subject: [PATCH] arm64: dts: juno: Fix CoreSight support for Juno r1/r2
 variants
In-Reply-To: <1483637646-39229-1-git-send-email-mike.leach@linaro.org>
References: <1483637646-39229-1-git-send-email-mike.leach@linaro.org>
Message-ID: <3082bef8-edf6-2575-85d0-1b06ea7b1f77@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+Suzuki

Hi Mike,

Thanks for fixing the R1/2 CS support. Suzuki was also looking at fixing it.

On 05/01/17 17:34, Mike Leach wrote:
> The CoreSight support added for Juno is valid for only Juno r0.
> The Juno r1 and r2 variants have additional components and alternative
> connection routes between trace source and sinks.
> 
> The CoreSight infrastructure external to the Cortex-Axx clusters, has
> been split into separate .dtsi include files for r0 and r1/r2 to correctly
> represent these variations.
> 
> Adds missing DT entry for the CoreSight STM component in the infrastructure
> .dtsi files.
> 

STM support can be a separate patch as it's a new feature added.

> Signed-off-by: Mike Leach <mike.leach@linaro.org>
> ---
>  arch/arm64/boot/dts/arm/juno-base.dtsi    | 135 ---------------
>  arch/arm64/boot/dts/arm/juno-cs-r0.dtsi   | 166 +++++++++++++++++++
>  arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi | 266 ++++++++++++++++++++++++++++++
>  arch/arm64/boot/dts/arm/juno-r1.dts       |   1 +
>  arch/arm64/boot/dts/arm/juno-r2.dts       |   1 +
>  arch/arm64/boot/dts/arm/juno.dts          |   1 +
>  6 files changed, 435 insertions(+), 135 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/arm/juno-cs-r0.dtsi
>  create mode 100644 arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi
> 
> diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
> index 7d83224..7c89000 100644
> --- a/arch/arm64/boot/dts/arm/juno-base.dtsi
> +++ b/arch/arm64/boot/dts/arm/juno-base.dtsi

[...]

> +
> +	stm at 20100000 {
> +		compatible = "arm,coresight-stm", "arm,primecell";
> +		reg = <0 0x20100000 0 0x1000>,
> +		      <0 0x28000000 0 0x180000>;
> +		reg-names = "stm-base", "stm-stimulus-base";
> +
> +		clocks = <&soc_smc50mhz>;
> +		clock-names = "apb_pclk";
> +		power-domains = <&scpi_devpd 0>;
> +		port {
> +			stm_out_port: endpoint {
> +				remote-endpoint = <&main_funnel_in_port2>;
> +			};
> +		};
> +	};

As mentioned above move this to a different patch.

-- 
Regards,
Sudeep
