From: khilman@kernel.org (Kevin Hilman)
Date: Fri, 11 Sep 2015 13:39:51 -0700
Subject: [PATCH v18 4/4] ARM: dts: add the support power-domain node on
 RK3288 SoCs
In-Reply-To: <1441693103-26712-5-git-send-email-wxt@rock-chips.com> (Caesar
 Wang's message of "Tue, 8 Sep 2015 14:18:23 +0800")
References: <1441693103-26712-1-git-send-email-wxt@rock-chips.com>
 <1441693103-26712-5-git-send-email-wxt@rock-chips.com>
Message-ID: <7hzj0szo4o.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Caesar Wang <wxt@rock-chips.com> writes:

> We can add more domains node in the future.
> This patch add the needed clocks into power-controller.
> As the discuess about all the device clocks being listed in
> the power-domains itself.
>
> There are several reasons as follows:
>
> Firstly, the clocks need be turned off to save power when
> the system enter the suspend state. So we need to enumerate
> the clocks in the dts. In order to power domain can turn on and off.
>
> Secondly, the reset-circuit should reset be synchronous on RK3288,
> then sync revoked. So we need to enable clocks of all devices.
> In other words, we have to enable the clocks before you operate them
> if all the device clocks are included in someone domians.
>
> Thirdly, as the chip designs for PM hardhare. we need turn on the noc
> clocks, if we are operating the "pd_vio" domain to enter the idle status.
> The device's clock be included in domains that needed turn on if do that.
>
> The clocks in the dts are needed to enable before you want to happy work.
> At the moment, This patch is very good work for PM hardware.
>
> Also, we can add these clocks in the future if we have some hidden clocks.
>
> Signed-off-by: jinkun.hong <jinkun.hong@rock-chips.com>
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> Reviewed-by: Michael Turquette <mturquette@baylibre.com>
>
> ---
>
> Changes in v18:
> - Change the index order in the dts on PATCH [4/4] .
> - Add some notes for domains in the dts on PATCH [4/4].
>
> Changes in v17:
> - remove clocks of the HDMI ctrl.
> - update the description.
> - add Reviewed-by: Michale.
>
> Changes in v16:
> - Manually copy the problem in patch v15.
> - rebase the description.
>
> Changes in v15:
> - As Tomasz remarked previously the dts should represent the hardware
>   and the power-domains are part of the pmu.
>
> Changes in v14:
> - Remove essential clocks from rk3288 PD_VIO domain, Some clocks are
>   essential for the system health and should not be turned down.
>   However there is no owner for them so if they listed as belonging to power
>   domain we'll try toggling them up and down during power domain transition.
>   As a result we either fail to suspend or resume the system.
>
> Changes in v13: None
> Changes in v12: None
> Changes in v11: None
> Changes in v10:
> - fix missing the #include <dt-bindings/power-domain/rk3288.h>.
> - remove the notes.
>
> Changes in v9:
> - add decription for power-doamin node.
>
> Changes in v8:
> - DTS go back to v2.
>
> Changes in v7: None
> Changes in v6: None
> Changes in v5: None
> Changes in v4: None
> Changes in v3:
> - Decomposition power-controller, changed to multiple controller
>   (gpu-power-controller, hevc-power-controller).
>
> Changes in v2:
> - make pd_vio clocks all one entry per line and alphabetize.
> - power: power-controller move back to pinctrl: pinctrl.
>
>  arch/arm/boot/dts/rk3288.dtsi | 93 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 92 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
> index 906e938..d7fa534 100644
> --- a/arch/arm/boot/dts/rk3288.dtsi
> +++ b/arch/arm/boot/dts/rk3288.dtsi
> @@ -44,6 +44,7 @@
>  #include <dt-bindings/pinctrl/rockchip.h>
>  #include <dt-bindings/clock/rk3288-cru.h>
>  #include <dt-bindings/thermal/thermal.h>
> +#include <dt-bindings/power-domain/rk3288.h>
>  #include "skeleton.dtsi"
>  
>  / {
> @@ -613,8 +614,98 @@
>  	};
>  
>  	pmu: power-management at ff730000 {
> -		compatible = "rockchip,rk3288-pmu", "syscon";
> +		compatible = "rockchip,rk3288-pmu", "syscon", "simple-mfd";
>  		reg = <0xff730000 0x100>;
> +
> +		power: power-controller {
> +			compatible = "rockchip,rk3288-power-controller";
> +			#power-domain-cells = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			/*
> +			 * Note: Although SCLK_* are the working clocks
> +			 * of device without including on the NOC, needed for
> +			 * synchronous reset.
> +			 *
> +			 * The clocks on the which NOC:
> +			 * ACLK_IEP/ACLK_VIP/ACLK_VOP0 are on ACLK_VIO0_NIU.
> +			 * ACLK_ISP/ACLK_VOP1 are on ACLK_VIO1_NIU.
> +			 * ACLK_RGA is on ACLK_RGA_NIU.
> +			 * The others (HCLK_*,PLCK_*) are on HCLK_VIO_NIU.
> +			 *
> +			 * Which clock are device clocks:
> +			 *	clocks		devices
> +			 *	*_IEP		IEP:Image Enhancement Processor
> +			 *	*_ISP		ISP:Image Signal Processing
> +			 *	*_VIP		VIP:Video Input Processor
> +			 *	*_VOP*		VOP:Visual Output Processor
> +			 *	*_RGA		RGA
> +			 *	*_EDP*		EDP
> +			 *	*_LVDS_*	LVDS
> +			 *	*_HDMI		HDMI
> +			 *	*_MIPI_*	MIPI
> +			 */

This is very nice, thank you for including the details.

Kevin
