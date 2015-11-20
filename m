From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri, 20 Nov 2015 22:06:59 +0100
Subject: [PATCH v2 6/6] arm64: dts: berlin4ct: add pll and clock nodes
In-Reply-To: <1448008952-1787-7-git-send-email-jszhang@marvell.com>
References: <1448008952-1787-1-git-send-email-jszhang@marvell.com>
 <1448008952-1787-7-git-send-email-jszhang@marvell.com>
Message-ID: <564F8B73.7070403@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20.11.2015 09:42, Jisheng Zhang wrote:
> Add syspll, mempll, cpupll, gateclk and berlin-clk nodes.
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> ---
>  arch/arm64/boot/dts/marvell/berlin4ct.dtsi | 38 ++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/marvell/berlin4ct.dtsi b/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
> index a4a1876..808a997 100644
> --- a/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
> +++ b/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
> @@ -42,6 +42,7 @@
>   *     OTHER DEALINGS IN THE SOFTWARE.
>   */
>  
> +#include <dt-bindings/clock/berlin4ct.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  
>  / {
> @@ -135,6 +136,22 @@
>  			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
>  		};
>  
> +		cpupll: cpupll {
> +			compatible = "marvell,berlin-pll";
> +			reg = <0x922000 0x14>, <0xea0710 4>;
> +			#clock-cells = <0>;
> +			clocks = <&osc>, <&clk CLK_CPUFASTREF>;
> +			bypass-shift = /bits/ 8 <2>;
> +		};
> +
> +		mempll: mempll {
> +			compatible = "marvell,berlin-pll";
> +			reg = <0x940034 0x14>, <0xea0710 4>;

Whenever you see overlapping/repeating reg ranges, e.g. <0xea0710 4>
you can be sure you are not representing HW structure but driver
structure here.

Please merge clocks/gates/plls to a single clock complex node
and deal with the internals by using "simple-mfd" and "syscon" regmaps.

> +			#clock-cells = <0>;
> +			clocks = <&osc>, <&clk CLK_MEMFASTREF>;
> +			bypass-shift = /bits/ 8 <1>;
> +		};
> +
>  		apb at e80000 {
>  			compatible = "simple-bus";
>  			#address-cells = <1>;
> @@ -225,6 +242,27 @@
>  			};
>  		};
>  
> +		syspll: syspll {
> +			compatible = "marvell,berlin-pll";
> +			reg = <0xea0200 0x14>, <0xea0710 4>;
> +			#clock-cells = <0>;
> +			clocks = <&osc>;
> +			bypass-shift = /bits/ 8 <0>;
> +		};
> +
> +		gateclk: gateclk {
> +			compatible = "marvell,berlin4ct-gateclk";
> +			reg = <0xea0700 4>;
> +			#clock-cells = <1>;
> +		};
> +
> +		clk: clk {
> +			compatible = "marvell,berlin4ct-clk";
> +			reg = <0xea0720 0x144>;

Looking at the reg ranges, I'd say that they are all clock related
and pretty close to each other:

gateclk: reg = <0xea0700 4>;
bypass:  reg = <0xea0710 4>;
clk:     reg = <0xea0720 0x144>;

So, please just follow the OF/driver structure we already
have for Berlin2.

Sebastian

> +			#clock-cells = <1>;
> +			clocks = <&syspll>;
> +		};
> +
>  		soc_pinctrl: pin-controller at ea8000 {
>  			compatible = "marvell,berlin4ct-soc-pinctrl";
>  			reg = <0xea8000 0x14>;
> 
