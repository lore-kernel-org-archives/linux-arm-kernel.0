From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 11 Apr 2014 10:18:59 +0200
Subject: [PATCH RESEND 5/5] ARM: dts: berlin: add the pinctrl node and
 muxing setup for uarts
In-Reply-To: <1397135274-10764-6-git-send-email-antoine.tenart@free-electrons.com>
References: <1397135274-10764-1-git-send-email-antoine.tenart@free-electrons.com>
 <1397135274-10764-6-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <20140411081859.GL10240@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 10, 2014 at 03:07:54PM +0200, Antoine T?nart wrote:
> The uart0 pinmux configuration is in the dtsi because uart0 will always
> use uart0-pmux to work, no other possibility. Same thing for uart1.
> 
> Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
> ---
>  arch/arm/boot/dts/berlin2.dtsi   | 20 ++++++++++++++++++++
>  arch/arm/boot/dts/berlin2cd.dtsi | 13 +++++++++++++
>  arch/arm/boot/dts/berlin2q.dtsi  | 20 ++++++++++++++++++++
>  3 files changed, 53 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/berlin2.dtsi b/arch/arm/boot/dts/berlin2.dtsi
> index 56a1af2f1052..43eb90c36050 100644
> --- a/arch/arm/boot/dts/berlin2.dtsi
> +++ b/arch/arm/boot/dts/berlin2.dtsi
> @@ -176,6 +176,22 @@
>  			};
>  		};
>  
> +		pinctrl: pinctrl at 0 {
> +			compatible = "marvell,berlin2-pinctrl";
> +			reg = <0xea0000 0x08>, <0xfc0000 0x44>;
> +			reg-names = "global_base", "apb_base";
> +
> +			uart0_pmux: uart0-pmux {
> +				berlin,group = "GSM4";
> +				berlin,function = <0>;
> +			};
> +
> +			uart1_pmux: uart1-pmux {
> +				berlin,group = "GSM5";
> +				berlin,function = <1>;

Hi Antoine

This very much looks like black magic.

I assume the data sheet is not available? So i think you need to
document all possible combinations of values of group and function.
Maybe you can add a file in

arch/arm/boot/dts/include/dt-bindings/pinctrl/

with something like

#define GSM4_UART0	0
#define GSM5_UART1	1
#define GSM12_UART0	1
#define GSM12_IrDA0	1
#define GSM12_GPIO	2

	Andrew
