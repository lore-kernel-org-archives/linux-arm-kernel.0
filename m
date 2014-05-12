From: george.cherian@ti.com (George Cherian)
Date: Mon, 12 May 2014 10:29:52 +0530
Subject: [PATCH v2] ARM: dts: am33xx: Move the cppi41dma node so it's
 probed early
In-Reply-To: <1398373881-23369-1-git-send-email-ezequiel@vanguardiasur.com.ar>
References: <1398373881-23369-1-git-send-email-ezequiel@vanguardiasur.com.ar>
Message-ID: <53705548.7020400@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/25/2014 2:41 AM, Ezequiel Garcia wrote:
> The DMA controller is needed for the USB controller to be correctly
> registered. Therefore, if the DMA node is located at the end an unecessary
> probe deferral is produced systematically.
>
> This is easily fixed by moving the node at the beggining of the child list,
> so it's probed first.
>
> Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Acked-by: George Cherian <george.cherian@ti.com>
> --
> v1->v2:
>    * Added a comment to prevent a future clean-up based on the memory offset.
>
>   arch/arm/boot/dts/am33xx.dtsi | 34 ++++++++++++++++++++--------------
>   1 file changed, 20 insertions(+), 14 deletions(-)
>
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index 9770e35..02e1eb6 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -453,6 +453,26 @@
>   			ti,hwmods = "usb_otg_hs";
>   			status = "disabled";
>   
> +			/*
> +			 * The probe order matches the child ordering so the
> +			 * dma-controller node must be the first one to prevent
> +			 * spurious probe deferrals.
> +			 */
> +			cppi41dma: dma-controller at 47402000 {
> +				compatible = "ti,am3359-cppi41";
> +				reg =  <0x47400000 0x1000
> +					0x47402000 0x1000
> +					0x47403000 0x1000
> +					0x47404000 0x4000>;
> +				reg-names = "glue", "controller", "scheduler", "queuemgr";
> +				interrupts = <17>;
> +				interrupt-names = "glue";
> +				#dma-cells = <2>;
> +				#dma-channels = <30>;
> +				#dma-requests = <256>;
> +				status = "disabled";
> +			};
> +
>   			usb_ctrl_mod: control at 44e10620 {
>   				compatible = "ti,am335x-usb-ctrl-module";
>   				reg = <0x44e10620 0x10
> @@ -556,20 +576,6 @@
>   					"tx14", "tx15";
>   			};
>   
> -			cppi41dma: dma-controller at 47402000 {
> -				compatible = "ti,am3359-cppi41";
> -				reg =  <0x47400000 0x1000
> -					0x47402000 0x1000
> -					0x47403000 0x1000
> -					0x47404000 0x4000>;
> -				reg-names = "glue", "controller", "scheduler", "queuemgr";
> -				interrupts = <17>;
> -				interrupt-names = "glue";
> -				#dma-cells = <2>;
> -				#dma-channels = <30>;
> -				#dma-requests = <256>;
> -				status = "disabled";
> -			};
>   		};
>   
>   		epwmss0: epwmss at 48300000 {


-- 
-George
