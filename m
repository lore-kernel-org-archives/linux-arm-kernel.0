From: stefan@agner.ch (Stefan Agner)
Date: Tue, 11 Nov 2014 22:20:07 +0100
Subject: [[PATCHv2] 2/3] ARM: dts: vfxxx: Add SNVS node
In-Reply-To: <64244b916de3864b714e829c3adeecec71aea2b3.1415364391.git.maitysanchayan@gmail.com>
References: <cover.1415364391.git.maitysanchayan@gmail.com>
 <64244b916de3864b714e829c3adeecec71aea2b3.1415364391.git.maitysanchayan@gmail.com>
Message-ID: <38daf99040ba00bd5150e7bc73a2fd76@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-11-07 14:04, Sanchayan Maity wrote:
> This patch adds a devicetree node for the Secure
> Non-Volatile Storage (SNVS) on the VF610 platform.
> The SNVS block also has a Real Time Counter (RTC).
> 
> Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
> ---
>  arch/arm/boot/dts/vfxxx.dtsi |   15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
> index 4e70833..bc131b0 100644
> --- a/arch/arm/boot/dts/vfxxx.dtsi
> +++ b/arch/arm/boot/dts/vfxxx.dtsi
> @@ -338,6 +338,21 @@
>  				status = "disabled";
>  			};
>  
> +			snvs0: snvs at 400a7000 {
> +				compatible = "fsl,sec-v4.0-mon", "simple-bus";
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				ranges = <0 0x400a7000 0x2000>;
> +
> +				snvs-rtc-lp at 34 {
> +					compatible = "fsl,sec-v4.0-mon-rtc-lp";
> +					reg = <0x34 0x58>;
> +					interrupts = <0 100 IRQ_TYPE_LEVEL_HIGH>;

With the new device tree structure, the interrupt field needs to be part
of the vf500.dtsi now. The vfxxx.dtsi will be the parent also for the
Cortex-M4 device tree, which uses a different interrupt controller.

While at it, use the GIC_SPI macro for the first cell (so this will be
blend into the other interrupt definitions).

> +					clocks = <&clks VF610_CLK_SNVS>;
> +					clock-names = "snvs-rtc";
> +				};
> +			};
> +
>  			uart4: serial at 400a9000 {
>  				compatible = "fsl,vf610-lpuart";
>  				reg = <0x400a9000 0x1000>;
