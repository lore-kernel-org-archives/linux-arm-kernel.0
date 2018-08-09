From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 09 Aug 2018 22:09:42 +0200
Subject: [PATCH] arm64: dts: rockchip: Add idle-states to device tree for
 rk3399
In-Reply-To: <1467793254-10808-1-git-send-email-wxt@rock-chips.com>
References: <1467793254-10808-1-git-send-email-wxt@rock-chips.com>
Message-ID: <5620784.b19SH5PkdR@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 6. Juli 2016, 10:20:54 CEST schrieb Caesar Wang:
> As the rk3399 ATF had been supported on ARM github [0], so we can add
> idle-states for rk3399.
> This patch adds idle-states bindings data collected through tests
> experiments (latency and energy consumption) on rk3399 evb2 board.
> 
> You can see detail idle-states definitions on document [1].
> 
> * arm,psci-suspend-param: power_state parameter to pass to the PSCI
>   suspend call.
> * entry-latency: Worst case latency required to enter the idle state. The
>   exit-latency may be guaranteed only after entry-latency has passed.
> * min-residency: Minimum period, including preparation and entry, for a
>   given idle state to be worthwhile energywise
> * min-residency: Minimum period, including preparation and entry, for a
>   given idle state to be worthwhile energywise.
> 
> [0]:
> https://github.com/ARM-software/arm-trusted-firmware
> [1]:
> Documentation/devicetree/bindings/arm/psci.txt
> Documentation/devicetree/bindings/arm/idle-states.txt
> 
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>

Looks like this patch slipped through the cracks and nobody reposted
them over time.


>  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> index a6dd623..12ce265 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> @@ -101,6 +101,18 @@
>  			};
>  		};
>  
> +		idle-states {
> +			entry-method = "psci";
> +			cpu_sleep: cpu-sleep-0 {
> +				compatible = "arm,idle-state";
> +				local-timer-stop;
> +				arm,psci-suspend-param = <0x0010000>;
> +				entry-latency-us = <350>;
> +				exit-latency-us = <600>;
> +				min-residency-us = <1150>;

Looking at the chromeos kernel, there are some more patches adapting
this idle-state to use different timings.

There also was a cluster-idle state added for a while but that seems to
cause audio issues according to the CrOS history.

In any case, I'll try to look at this shortly.


Heiko
