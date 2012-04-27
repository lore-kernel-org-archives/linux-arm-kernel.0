From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Fri, 27 Apr 2012 16:40:57 +0800
Subject: [PATCH 04/11] i2c: imx: add pinctrl support
In-Reply-To: <1335510185-7906-5-git-send-email-richard.zhao@freescale.com>
References: <1335510185-7906-1-git-send-email-richard.zhao@freescale.com>
 <1335510185-7906-5-git-send-email-richard.zhao@freescale.com>
Message-ID: <20120427084056.GD826@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2012 at 03:02:58PM +0800, Richard Zhao wrote:
> Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> ---
>  arch/arm/boot/dts/imx6q-sabrelite.dts |    2 ++
>  arch/arm/boot/dts/imx6q.dtsi          |   16 ++++++++++++++++
>  drivers/i2c/busses/i2c-imx.c          |    9 +++++++++
>  3 files changed, 27 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
> index 4663a4e..4e13293 100644
> --- a/arch/arm/boot/dts/imx6q-sabrelite.dts
> +++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
> @@ -50,6 +50,8 @@
>  			i2c at 021a0000 { /* I2C1 */
>  				status = "okay";
>  				clock-frequency = <100000>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_i2c1_1>;
>  
>  				codec: sgtl5000 at 0a {
>  					compatible = "fsl,sgtl5000";
> diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
> index 2ba32e7..fe8c80d 100644
> --- a/arch/arm/boot/dts/imx6q.dtsi
> +++ b/arch/arm/boot/dts/imx6q.dtsi
> @@ -390,6 +390,22 @@
>  				reg = <0x020e0000 0x4000>;
>  
>  				/* shared pinctrl settings */
> +				i2c1 {
> +					pinctrl_i2c1_1: i2c1grp-1 {
> +						fsl,pins =	"MX6Q_PAD_EIM_D21",
> +								"MX6Q_PAD_EIM_D28";
> +						fsl,hysteresis = <1>;
> +						fsl,mux = <0x16 0x11>;
> +						fsl,pull = <2>;
> +						fsl,pue = <1>;
> +						fsl,pke = <1>;
> +						fsl,open-drain = <1>;
> +						fsl,speed = <2>;
> +						fsl,drive-strength = <6>;
> +						fsl,slew-rate = <1>;
> +					};
The pinctrl binding is changed a bit since v1.
You may need to change here according to v2 or latter.

> +				};
> +
>  				uart4 {
>  					pinctrl_uart4_1: uart4grp-1 {
>  						fsl,pins =	"MX6Q_PAD_KEY_COL0",
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index dfb84b7..7a52067 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -48,6 +48,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/clk.h>
>  #include <linux/slab.h>
> +#include <linux/pinctrl/consumer.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/of_i2c.h>
> @@ -470,6 +471,7 @@ static int __init i2c_imx_probe(struct platform_device *pdev)
>  	struct imx_i2c_struct *i2c_imx;
>  	struct resource *res;
>  	struct imxi2c_platform_data *pdata = pdev->dev.platform_data;
> +	struct pinctrl *pct;
>  	void __iomem *base;
>  	resource_size_t res_size;
>  	int irq, bitrate;
> @@ -520,6 +522,13 @@ static int __init i2c_imx_probe(struct platform_device *pdev)
>  	i2c_imx->base			= base;
>  	i2c_imx->res			= res;
>  
> +	pct = devm_pinctrl_get_select_default(&pdev->dev);
You may want to check this change will break other platforms also using this driver.
Refer to:
http://www.spinics.net/lists/arm-kernel/msg171538.html

Regards
Dong Aisheng
