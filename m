From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 26 Aug 2015 08:30:41 +0100
Subject: [PATCH 2/3] ARM: DT: STi: STiH407: Add c8sectpfe LinuxDVB DT node.
In-Reply-To: <1440519730-486-3-git-send-email-peter.griffin@linaro.org>
References: <1440519730-486-1-git-send-email-peter.griffin@linaro.org>
 <1440519730-486-3-git-send-email-peter.griffin@linaro.org>
Message-ID: <20150826073041.GT19409@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 25 Aug 2015, Peter Griffin wrote:

> This patch adds in the required DT node for the c8sectpfe
> Linux DVB demux driver which allows the tsin channels
> to be used on an upstream kernel.
> 
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>  arch/arm/boot/dts/stihxxx-b2120.dtsi | 38 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stihxxx-b2120.dtsi b/arch/arm/boot/dts/stihxxx-b2120.dtsi
> index 62994ae..1bc018e 100644
> --- a/arch/arm/boot/dts/stihxxx-b2120.dtsi
> +++ b/arch/arm/boot/dts/stihxxx-b2120.dtsi
> @@ -6,6 +6,10 @@
>   * it under the terms of the GNU General Public License version 2 as
>   * published by the Free Software Foundation.
>   */
> +
> +#include <dt-bindings/clock/stih407-clks.h>
> +#include <dt-bindings/media/c8sectpfe.h>
> +

Looks like some of the STi files are a little wavering on convention,
but I suggest the extra '\n's are superfluous.

>  / {
>  	soc {
>  		sbc_serial0: serial at 9530000 {
> @@ -85,5 +89,39 @@
>  			status = "okay";
>  		};
>  
> +		c8sectpfe at 08a20000 {

This should be a device type, not a model number.

demodulator at abcdabcd {

> +			compatible = "st,stih407-c8sectpfe";

To the uninitiated c8sectpfe is pretty indecipherable.

How about *-c8sectpfe-demod?

> +			status = "okay";
> +			reg = <0x08a20000 0x10000>, <0x08a00000 0x4000>;
> +			reg-names = "c8sectpfe", "c8sectpfe-ram";
> +
> +			interrupts = <0 34 0>, <0 35 0>;

Please use the predetermined DEFINES for the flags cell.

> +			interrupt-names = "c8sectpfe-error-irq",
> +					  "c8sectpfe-idle-irq";
> +
> +			pinctrl-names	= "tsin0-serial", "tsin0-parallel",
> +					  "tsin3-serial", "tsin4-serial",
> +					  "tsin5-serial";

I would put *-names *under* the properties they pertain to and in the
same format i.e. one per line in this case, for easy eye-match.

> +			pinctrl-0	= <&pinctrl_tsin0_serial>;
> +			pinctrl-1	= <&pinctrl_tsin0_parallel>;
> +			pinctrl-2	= <&pinctrl_tsin3_serial>;
> +			pinctrl-3	= <&pinctrl_tsin4_serial_alt3>;
> +			pinctrl-4	= <&pinctrl_tsin5_serial_alt1>;
> +
> +			clocks = <&clk_s_c0_flexgen CLK_PROC_STFE>;
> +			clock-names = "c8sectpfe";
> +
> +			/* tsin0 is TSA on NIMA */
> +			tsin0: port at 0 {
> +

Why the '\n'?

> +				tsin-num = <0>;
> +				serial-not-parallel;
> +				i2c-bus = <&ssc2>;

If you are adding this property, I would get Wolfram or one of the DT
guys to Ack it.

> +				rst-gpio = <&pio15 4 0>;

Why not use the whole name "reset"?

"-gpio" should be "-gpios".

So, in full: "reset-gpios"?

Flags: GPIO_ACTIVE_HIGH ?

> +				dvb-card = <STV0367_TDA18212_NIMA_1>;
> +			};
> +		};
>  	};
>  };

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
