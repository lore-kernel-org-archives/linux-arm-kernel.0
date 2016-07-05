From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 05 Jul 2016 02:24:42 +0200
Subject: [PATCH v3] arm64: dts: rockchip: add the power domain node for
 rk3399
In-Reply-To: <1467635644-16798-1-git-send-email-wxt@rock-chips.com>
References: <1467635644-16798-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1904131.irFlfKsH8m@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 4. Juli 2016, 20:34:04 schrieb Caesar Wang:
> From: Elaine Zhang <zhangqing@rock-chips.com>
> 
> In order to meet low power requirements, a power management unit (PMU) is
> designed for controlling power resources in RK3399. The RK3399 PMU is
> dedicated for managing the power of the whole chip.
> 
> 1. add pd node for RK3399 Soc
> 2. create power domain tree
> 3. add qos node for domain
> 
> From the DT/binds and driver can get more detail information:
> The driver:
>         drivers/soc/rockchip/pm_domains.c
> The document:
>         Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
> 
> Note:
> As the TRM lists many voltage domains and power domains, then this patch
> adds some domains for driver. Due to some domains
> (e.g. emmc, usb, core)...We can't turned off it on
> bootup, or says some device driver can't handle the power domain enough.
> Maybe We will add more other domains in the future or later.

I talked with Caesar about that today and for example the gmac domain seems 
to cause problems right now when only using the generic power-domain 
handling the kernel provides on probe and remove.

So while this gets investigated, I'm probably ok with only using the stable 
power-domains, but will give the us-people a chance to also respond on 
wednesday :-) .


> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-rockchip at lists.infradead.org
> Cc: Heiko Stuebner <heiko@sntech.de>
> 
> ---
> 
> Changes in v3:
> - As some commnets on https://patchwork.kernel.org/patch/9209205/
> - according to the alphabetically sort
> - %s/RK3399_PD_VOP/RK3399_PD_VOPL, %s/RK3399_PD_IE/RK3399_PD_IEP
> 
> Changes in v2:
> - As Doug/Heiko commnets on https://patchwork.kernel.org/patch/9206415/.
>   drop the debugfs-dump and Add the comments for alphabetical order.
> 
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 179
> +++++++++++++++++++++++++++++++ 1 file changed, 179 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> b/arch/arm64/boot/dts/rockchip/rk3399.dtsi index a6dd623..4559c04 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> @@ -45,6 +45,7 @@
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/pinctrl/rockchip.h>
> +#include <dt-bindings/power/rk3399-power.h>
>  #include <dt-bindings/thermal/thermal.h>
> 
>  / {
> @@ -594,6 +595,184 @@
>  		status = "disabled";
>  	};
> 
> +	qos_hdcp: qos_hdcp at ffa90000 {

I guess I'll just rename that to qos_hdcp: qos at ffa90000
(similar for the other nodes), as the block itself is the same for all qos 
instances. So if that stays the only comment, there is no need to resend, as 
I can do the change myself.


> +		compatible = "syscon";
> +		reg = <0x0 0xffa90000 0x0 0x20>;
> +	};
