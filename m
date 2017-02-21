From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 21 Feb 2017 11:02:49 +0000
Subject: [PATCH] arm64: dts: juno: update definition for programmable
 replicator.
In-Reply-To: <1487358790-2618-1-git-send-email-mike.leach@linaro.org>
References: <1487358790-2618-1-git-send-email-mike.leach@linaro.org>
Message-ID: <2ba59da5-fc79-ab53-2f2a-2ddc6e5e9c3d@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On 17/02/17 19:13, Mike Leach wrote:
> Juno platforms have a programmable replicator splitting the trace output to
> TPIU and ETR. Currently this is not being programmed as it is being treated
> as a none-programmable replicator - which is the default operational mode
> for these devices. The TPIU in the system is enabled by default, and this
> combination is causing back-pressure in the trace system resulting in
> overflows at the source.
> 
> Replaces the existing definition with one that defines the programmable
> replicator, using the "qcom,coresight-replicator1x" driver that provides
> the correct functionality for CoreSight programmable replicators.
> 

I assume this is just enhancement and not a fix. Since it's too late for
v4.11 (already in merge window now), I will queue this for v4.12

> Signed-off-by: Mike Leach <mike.leach@linaro.org>
> ---
>  arch/arm64/boot/dts/arm/juno-base.dtsi | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
> index 9d799d9..6546e23 100644
> --- a/arch/arm64/boot/dts/arm/juno-base.dtsi
> +++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
> @@ -372,12 +372,14 @@
>  		};
>  	};
>  
> -	coresight-replicator {
> -		/*
> -		 * Non-configurable replicators don't show up on the
> -		 * AMBA bus.  As such no need to add "arm,primecell".
> -		 */
> -		compatible = "arm,coresight-replicator";
> +	coresight-replicator at 20120000 {
> +
> +		compatible = "qcom,coresight-replicator1x", "arm,primecell";
> +		reg = <0 0x20120000 0 0x1000>;
> +
> +		clocks = <&soc_smc50mhz>;
> +		clock-names = "apb_pclk";
> +		power-domains = <&scpi_devpd 0>;
>  
>  		ports {
>  			#address-cells = <1>;
> 

-- 
Regards,
Sudeep
