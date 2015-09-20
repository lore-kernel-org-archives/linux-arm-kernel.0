From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sun, 20 Sep 2015 21:38:00 +0200
Subject: [PATCH 5/5] arm64: dts: berlin4ct: add the pinctrl node and muxing
 setup for uart0
In-Reply-To: <1442656956-5740-6-git-send-email-jszhang@marvell.com>
References: <1442656956-5740-1-git-send-email-jszhang@marvell.com>
 <1442656956-5740-6-git-send-email-jszhang@marvell.com>
Message-ID: <55FF0B18.5060505@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19.09.2015 12:02, Jisheng Zhang wrote:
> Add the avio, soc, sm pinctrl nodes for Marvell berlin4ct SoC. This
> patch also adds urt0 txd and rxd muxing setup in the dtsi because uart0
> always use them to work, no other possibilities.

Please split the patch into two:
one adding the pinctrl nodes and
one adding the default pinmux to uart0 node.

> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> ---
>   arch/arm64/boot/dts/marvell/berlin4ct.dtsi | 27 +++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/berlin4ct.dtsi b/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
> index a3b5f1d..4566e4e 100644
> --- a/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
> +++ b/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
> @@ -225,6 +225,16 @@
>   			};
>   		};
>
> +		soc_pinctrl: pinctrl at ea8000 {
> +			compatible = "marvell,berlin4ct-soc-pinctrl";
> +			reg = <0xea8000 0x14>;
> +		};
> +
> +		avio_pinctrl: pinctrl at ea8400 {
> +			compatible = "marvell,berlin4ct-avio-pinctrl";
> +			reg = <0xea8400 8>;

s/8/0x8/

> +		};
> +
>   		apb at fc0000 {
>   			compatible = "simple-bus";
>   			#address-cells = <1>;
> @@ -278,6 +288,23 @@
>   				clocks = <&osc>;
>   				reg-shift = <2>;
>   				status = "disabled";
> +				pinctrl-0 = <&urt0_txd_pmux>, <&urt0_rxd_pmux>;
> +				pinctrl-names = "default", "default";

pinctrl-names = "default", "default"; refers to pinctrl-0 and pinctrl-1
respectively. There is no pinctrl-1, so please remove the second
pinctrl-names element.

> +			};
> +		};
> +
> +		sm_pinctrl: pinctrl at fe2200 {
> +			compatible = "marvell,berlin4ct-sm-pinctrl";
> +			reg = <0xfe2200 0xc>;
> +
> +			urt0_txd_pmux: urt0_txd-pmux {
> +				groups = "SM_URT0_TXD";
> +				function = "sm_urt0_txd";
> +			};
> +
> +			urt0_rxd_pmux: urt0_rxd-pmux {
> +				groups = "SM_URT0_RXD";
> +				function = "sm_urt0_rxd";

If you change the driver to generic function names ("uart0") this
boils down to a single

uart0_pmux: uart0-pmux {
	groups = "SM_UART0_TXD", "SM_UART0_RXD";
	function = "uart0";
};

pinmux node and the reference in uart0 node to

pinctrl-0 = <&uart0_pmux>;
pinctrl-names = "default";

Sebastian

>   			};
>   		};
>   	};
>
