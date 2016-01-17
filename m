From: heiko@sntech.de (Heiko Stuebner)
Date: Sun, 17 Jan 2016 20:18:46 +0100
Subject: [PATCH v3 8/9] ARM: dts: rockchip: add reboot-mode node for
 rk3036 SoCs
In-Reply-To: <1452865796-23527-9-git-send-email-wxt@rock-chips.com>
References: <1452865796-23527-1-git-send-email-wxt@rock-chips.com>
 <1452865796-23527-9-git-send-email-wxt@rock-chips.com>
Message-ID: <3866840.JFJvXxmQit@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Caesar, Andy,

Am Freitag, 15. Januar 2016, 21:49:55 schrieb Caesar Wang:
> Add reboot mode driver DT node for rk3036 platform.
> This patch adds the needed reboot mode node for rk3036.
> 
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>

this obviously depends on Andy's reboot series.

Andy, could you include this patch into further submissions of your series 
please? That way it won't keep floating unconnected on the lists :-)


Thanks
Heiko

> ---
> 
> Changes in v3: None
> 
>  arch/arm/boot/dts/rk3036.dtsi | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
> index cf0968c..f5ecfff 100644
> --- a/arch/arm/boot/dts/rk3036.dtsi
> +++ b/arch/arm/boot/dts/rk3036.dtsi
> @@ -43,6 +43,7 @@
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/pinctrl/rockchip.h>
>  #include <dt-bindings/clock/rk3036-cru.h>
> +#include <dt-bindings/soc/rockchip_boot-mode.h>
>  #include "skeleton.dtsi"
> 
>  / {
> @@ -297,8 +298,33 @@
>  	};
> 
>  	grf: syscon at 20008000 {
> -		compatible = "rockchip,rk3036-grf", "syscon";
> +		compatible = "rockchip,rk3036-grf", "syscon", "simple-mfd";
>  		reg = <0x20008000 0x1000>;
> +
> +		reboot-mode {
> +			compatible = "syscon-reboot-mode";
> +			offset = <0x1d8>;
> +
> +			normal {
> +				linux,mode = "normal";
> +				loader,magic = <BOOT_NORMAL>;
> +			};
> +
> +			loader {
> +				linux,mode = "loader";
> +				loader,magic = <BOOT_LOADER>;
> +			};
> +
> +			recovery {
> +				linux,mode = "recovery";
> +				loader,magic = <BOOT_RECOVERY>;
> +			};
> +
> +			fastboot {
> +				linux,mode = "fastboot";
> +				loader,magic = <BOOT_FASTBOOT>;
> +			};
> +		};
>  	};
> 
>  	acodec: acodec-ana at 20030000 {
