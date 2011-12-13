From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 13 Dec 2011 19:56:55 +0800
Subject: [PATCH V2 2/7] arm/imx6: add imx6q sabrelite board support
In-Reply-To: <1323757530-19402-3-git-send-email-richard.zhao@linaro.org>
References: <1323757530-19402-1-git-send-email-richard.zhao@linaro.org>
 <1323757530-19402-3-git-send-email-richard.zhao@linaro.org>
Message-ID: <20111213115648.GA10022@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 13, 2011 at 02:25:25PM +0800, Richard Zhao wrote:
> - Add basic board dts file
> - Add board compatible string to mach-imx6q.
> 
> Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> ---
>  arch/arm/boot/dts/imx6q-sabrelite.dts |   55 +++++++++++++++++++++++++++++++++
>  arch/arm/mach-imx/mach-imx6q.c        |    1 +
>  2 files changed, 56 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/boot/dts/imx6q-sabrelite.dts
> 

Documentation/devicetree/bindings/arm/fsl.txt needs to be updated to
include compatible string for this sabrelite board.

> diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
> new file mode 100644
> index 0000000..381f030
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
> @@ -0,0 +1,55 @@
> +/*
> + * Copyright 2011 Freescale Semiconductor, Inc.
> + * Copyright 2011 Linaro Ltd.
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +/dts-v1/;
> +/include/ "imx6q.dtsi"
> +
> +/ {
> +	model = "Freescale i.MX6 Quad SABRE Lite Board";
> +	compatible = "fsl,imx6q-sabrelite", "fsl,imx6q";
> +
> +	cpus {
> +		cpu at 0 {
> +			clock-frequency = <996000000>;
> +		};

I do not follow why we need to have cpu frequency encoded in board
level dts.  To me, what frequency the cpu is capable of running at
is really soc specific thing.  So putting this data in
imx6q-sabrelite.dts is kinda suggesting that imx6q soc on this
sabrelite board can run at 996000000, while on other boards like
sabreauto/arm2 can only run at other frequency.  This is seems different
from what I heard from Freescale internal development team.

-- 
Regards,
Shawn

> +	};
> +
> +	memory {
> +		reg = <0x10000000 0x40000000>;
> +	};
> +
> +	soc {
> +		aips-bus at 02100000 { /* AIPS2 */
> +			enet at 02188000 {
> +				phy-mode = "rgmii";
> +				phy-reset-gpios = <&gpio3 23 0>;
> +				status = "okay";
> +			};
> +
> +			usdhc at 02198000 { /* uSDHC3 */
> +				cd-gpios = <&gpio7 0 0>;
> +				wp-gpios = <&gpio7 1 0>;
> +				status = "okay";
> +			};
> +
> +			usdhc at 0219c000 { /* uSDHC4 */
> +				cd-gpios = <&gpio2 6 0>;
> +				wp-gpios = <&gpio2 7 0>;
> +				status = "okay";
> +			};
> +
> +			uart1: uart at 021e8000 { /* UART2 */
> +				status = "okay";
> +			};
> +		};
> +	};
> +};
> diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
> index 8deb012..d24d6c4 100644
> --- a/arch/arm/mach-imx/mach-imx6q.c
> +++ b/arch/arm/mach-imx/mach-imx6q.c
> @@ -73,6 +73,7 @@ static struct sys_timer imx6q_timer = {
>  
>  static const char *imx6q_dt_compat[] __initdata = {
>  	"fsl,imx6q-sabreauto",
> +	"fsl,imx6q-sabrelite",
>  	NULL,
>  };
>  
> -- 
> 1.7.5.4
