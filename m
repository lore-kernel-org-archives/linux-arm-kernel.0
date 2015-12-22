From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 22 Dec 2015 12:23:23 +0100
Subject: [PATCH v1 5/6] ARM: dts: rockchip: add reboot-mode node
In-Reply-To: <1450775812-24244-1-git-send-email-andy.yan@rock-chips.com>
References: <1450774949-23901-1-git-send-email-andy.yan@rock-chips.com>
 <1450775812-24244-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <3977796.F76XlXnDRQ@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy,

Am Dienstag, 22. Dezember 2015, 17:16:52 schrieb Andy Yan:
> Add reboot mode driver DT node for rk3xxx,rk3288 platform

in general, I like that concept a lot :-) . Below some small issues.


> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> 
> ---
> 
> Changes in v1:
> - correct the maskrom magic number
> - use macro defined in rockchip_boot-mode.h for reboot-mode DT node
> 
>  arch/arm/boot/dts/rk3288.dtsi | 26 ++++++++++++++++++++++++++
>  arch/arm/boot/dts/rk3xxx.dtsi | 26 ++++++++++++++++++++++++++
>  2 files changed, 52 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
> index 04ea209..c6ea207 100644
> --- a/arch/arm/boot/dts/rk3288.dtsi
> +++ b/arch/arm/boot/dts/rk3288.dtsi
> @@ -45,6 +45,7 @@
>  #include <dt-bindings/clock/rk3288-cru.h>
>  #include <dt-bindings/thermal/thermal.h>
>  #include <dt-bindings/power/rk3288-power.h>
> +#include <dt-bindings/soc/rockchip_boot-mode.h>
>  #include "skeleton.dtsi"
> 
>  / {
> @@ -170,6 +171,31 @@
>  		};
>  	};
> 
> +	reboot_mode {

nodes are commonly written with a dash "-" instead of an underscore "_".


> +		compatible = "rockchip,reboot-mode";
> +		rockchip,regmap = <&pmu>;

I do believe this should be a sub-node of the pmu, similar to the power-
domains. Due to the "simple-mfd" compatible of the pmu, it will get probed 
automatically and the driver can than get the regmap via

	parent = dev->parent;
	regmap = syscon_node_to_regmap(parent->of_node);

as the power-domains do and therefore also doesn't need the rockchip,regmap 
property.


> +		offset = <0x94>;
> +		loader {
> +			linux,mode = "loader";
> +			linux,magic = <BOOT_LOADER>;

linux,mode seems correct, but the magic value is actually not linux-specific 
but instead firmware-specific, so I'm not sure about that linux-prefix there

But I guess that would be for the dt-people :-)


> +		};
> +
> +		maskrom {
> +			linux,mode = "maskrom";
> +			linux,magic = <BOOT_MASKROM>;
> +		};

Just for my understanding, while I expect the bootloader to interpret the 
other values, does the maskrom read and handle this one?


> +
> +		recovery {
> +			linux,mode = "recovery";
> +			linux,magic = <BOOT_RECOVERY>;
> +		};
> +
> +		fastboot {
> +			linux,mode = "fastboot";
> +			linux,magic = <BOOT_FASTBOOT>;
> +		};
> +	};
> +
>  	reserved-memory {
>  		#address-cells = <1>;
>  		#size-cells = <1>;

I do believe rk3288-veyron.dtsi would need some sort of special handling.
I don't think coreboot interprets most of those handles, but I guess only the 
maskrom one would be handled by the maskrom?


Heiko
