From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 16 Dec 2014 12:27:57 +0800
Subject: [PATCH] ARM: dts: imx51-babbage: Fix hang on USB probe
In-Reply-To: <1418657639-19589-1-git-send-email-fabio.estevam@freescale.com>
References: <1418657639-19589-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20141216042755.GA2411@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 15, 2014 at 01:33:59PM -0200, Fabio Estevam wrote:
> Currently the following hang is observed during USB probe:
> 
> [    1.243660] usbcore: registered new interface driver usb-storage
> [    1.261619] ci_hdrc ci_hdrc.1: doesn't support gadget
> [    1.266730] ci_hdrc ci_hdrc.1: EHCI Host Controller
> [    1.272058] ci_hdrc ci_hdrc.1: new USB bus registered, assigned bus number 1
> [    1.290639] ci_hdrc ci_hdrc.1: USB 2.0 started, EHCI 1.00
> [    1.301162] hub 1-0:1.0: USB hub found
> [    1.305248] hub 1-0:1.0: 1 port detected
> (hangs here...)

I suppose the patch fixes a regression.  If so, can we find out which
commit introduced the regression?

> 
> Pass the 'regulator-always-on' to make sure that the USB PHY and USB hub are
> properly powered.

Rather than having the regulator always on, shouldn't the user of the
regulator enables it?

Shawn 

> 
> Cc: <stable@vger.kernel.org> # 3.16
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/boot/dts/imx51-babbage.dts | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
> index 56569ce..65d3d97 100644
> --- a/arch/arm/boot/dts/imx51-babbage.dts
> +++ b/arch/arm/boot/dts/imx51-babbage.dts
> @@ -137,6 +137,7 @@
>  			regulator-max-microvolt = <5000000>;
>  			gpio = <&gpio2 5 GPIO_ACTIVE_HIGH>;
>  			enable-active-high;
> +			regulator-always-on;
>  		};
>  
>  		reg_usbotg_vbus: regulator at 1 {
> @@ -149,6 +150,7 @@
>  			regulator-max-microvolt = <5000000>;
>  			gpio = <&gpio1 7 GPIO_ACTIVE_HIGH>;
>  			enable-active-high;
> +			regulator-always-on;
>  		};
>  	};
>  
> -- 
> 1.9.1
> 
