From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 15 Apr 2014 11:23:03 +0200
Subject: [PATCH 2/2] ARM: dts: berlin: add GPIO nodes for the BG2Q
In-Reply-To: <1397549245-3338-3-git-send-email-antoine.tenart@free-electrons.com>
References: <1397549245-3338-1-git-send-email-antoine.tenart@free-electrons.com>
 <1397549245-3338-3-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <534CFA77.9030108@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/15/2014 10:07 AM, Antoine T?nart wrote:
> The Marvell Berlin BG2Q has 6 GPIO ports compatible with the snps,dw-apb-gpio
> driver. This patch add the corresponding device tree nodes.
>
> Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
> ---
>   arch/arm/boot/dts/berlin2q.dtsi | 102 ++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 102 insertions(+)
>
> diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
> index e6e556055dfc..b2625f896bc5 100644
> --- a/arch/arm/boot/dts/berlin2q.dtsi
> +++ b/arch/arm/boot/dts/berlin2q.dtsi
> @@ -109,6 +109,78 @@
>   			ranges = <0 0xe80000 0x10000>;
>   			interrupt-parent = <&aic>;
>
> +			gpio0: gpio at 0400 {
> +				compatible = "snps,dw-apb-gpio";
> +				reg = <0x0400 0x400>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				porta: gpio-controller at 0 {

ePAPR recommended name is even more generic, i.e. "gpio". If
that clashed in any way with other numbered names, I suggest
to rename to "gpio-port" as actually the controller is the
parent node and this represents one port (in the nomenclature
of DW-APB-GPIO).

> +					compatible = "snps,dw-apb-gpio-port";
> +					gpio-controller;
> +					#gpio-cells = <2>;
> +					snps,nr-gpios = <32>;

32 gpio pins for each of the 6 GPIO controllers? Either BG2Q is a GPIO
beast or it is a mistake :P

Can you please double-check?

I am fine with using nr-gpios property now, but I guess BG2Q also
has that CONFIG[1,2] registers to actually read out the features
synthesized in? If I find some time, I'll prepare a patch for
dw-apb-gpio to exploit that (optional) information instead of
using nr-gpios.

Otherwise,

Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

> +					reg = <0>;
> +					interrupt-controller;
> +					#interrupt-cells = <2>;
> +					interrupts = <0>;
> +				};
> +			};
> +
> +			gpio1: gpio at 0800 {
> +				compatible = "snps,dw-apb-gpio";
> +				reg = <0x0800 0x400>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				portb: gpio-controller at 1 {
> +					compatible = "snps,dw-apb-gpio-port";
> +					gpio-controller;
> +					#gpio-cells = <2>;
> +					snps,nr-gpios = <32>;
> +					reg = <0>;
> +					interrupt-controller;
> +					#interrupt-cells = <2>;
> +					interrupts = <1>;
> +				};
> +			};
> +
> +			gpio2: gpio at 0c00 {
> +				compatible = "snps,dw-apb-gpio";
> +				reg = <0x0c00 0x400>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				portc: gpio-controller at 2 {
> +					compatible = "snps,dw-apb-gpio-port";
> +					gpio-controller;
> +					#gpio-cells = <2>;
> +					snps,nr-gpios = <32>;
> +					reg = <0>;
> +					interrupt-controller;
> +					#interrupt-cells = <2>;
> +					interrupts = <2>;
> +				};
> +			};
> +
> +			gpio3: gpio at 1000 {
> +				compatible = "snps,dw-apb-gpio";
> +				reg = <0x1000 0x400>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				portd: gpio-controller at 3 {
> +					compatible = "snps,dw-apb-gpio-port";
> +					gpio-controller;
> +					#gpio-cells = <2>;
> +					snps,nr-gpios = <32>;
> +					reg = <0>;
> +					interrupt-controller;
> +					#interrupt-cells = <2>;
> +					interrupts = <3>;
> +				};
> +			};
> +
>   			timer0: timer at 2c00 {
>   				compatible = "snps,dw-apb-timer";
>   				reg = <0x2c00 0x14>;
> @@ -181,6 +253,36 @@
>   				interrupt-parent = <&gic>;
>   				interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
>   			};
> +
> +			gpio4: gpio at 5000 {
> +				compatible = "snps,dw-apb-gpio";
> +				reg = <0x5000 0x400>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				porte: gpio-controller at 4 {
> +					compatible = "snps,dw-apb-gpio-port";
> +					gpio-controller;
> +					#gpio-cells = <2>;
> +					snps,nr-gpios = <32>;
> +					reg = <0>;
> +				};
> +			};
> +
> +			gpio5: gpio at c000 {
> +				compatible = "snps,dw-apb-gpio";
> +				reg = <0xc000 0x400>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				portf: gpio-controller at 5 {
> +					compatible = "snps,dw-apb-gpio-port";
> +					gpio-controller;
> +					#gpio-cells = <2>;
> +					snps,nr-gpios = <32>;
> +					reg = <0>;
> +				};
> +			};
>   		};
>
>   		pinctrl: pinctrl at 0 {
>
