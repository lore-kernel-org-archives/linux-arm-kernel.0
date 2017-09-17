From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun, 17 Sep 2017 12:39:52 +0200 (CEST)
Subject: [PATCH] ARM: dts: bcm283x: Fix console path on RPi3
In-Reply-To: <1505422080-14336-1-git-send-email-loic.poulain@gmail.com>
References: <1505422080-14336-1-git-send-email-loic.poulain@gmail.com>
Message-ID: <940601883.58031.1505644792507@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Loic,

> Loic Poulain <loic.poulain@gmail.com> hat am 14. September 2017 um 22:48 geschrieben:
> 
> 
> Contrary to other RPi devices, RPi3 uses uart0 to communicate with
> the BCM43438 bluetooth controller. uart1 is then used for the console.
> Today, the console configuration is inherited from the bcm283x dtsi
> (bootargs) which is not the correct one for the RPi3. This leads to
> routing issue and confuses the Bluetooth controller with unexpected
> data.
> 
> This patch introduces chosen/stdout path to configure console to uart0
> on bcm283x family and overwrite it to uart1 in the RPi3 dts.
> 
> Create serial0/1 aliases referring to uart0 ant uart1 paths.
> Remove unneeded earlyprintk.
> 
> Fixes: 4188ea2aeb6d ("ARM: bcm283x: Define UART pinmuxing on board level")
> Signed-off-by: Loic Poulain <loic.poulain@gmail.com>
> ---
>  arch/arm/boot/dts/bcm2837-rpi-3-b.dts | 5 +++++
>  arch/arm/boot/dts/bcm283x.dtsi        | 7 ++++++-
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/bcm2837-rpi-3-b.dts b/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
> index 20725ca..f1c0811 100644
> --- a/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
> +++ b/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
> @@ -8,6 +8,11 @@
>  	compatible = "raspberrypi,3-model-b", "brcm,bcm2837";
>  	model = "Raspberry Pi 3 Model B";
>  
> +	chosen {
> +		/* 8250 auxiliar UART instead of pl011 */
> +		stdout-path = "serial1:115200n8";
> +	};
> +
>  	memory {
>  		reg = <0 0x40000000>;
>  	};
> diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
> index 431dcfc..013431e 100644
> --- a/arch/arm/boot/dts/bcm283x.dtsi
> +++ b/arch/arm/boot/dts/bcm283x.dtsi
> @@ -20,8 +20,13 @@
>  	#address-cells = <1>;
>  	#size-cells = <1>;
>  
> +	aliases {
> +		serial0 = &uart0;
> +		serial1 = &uart1;
> +	};
> +

looks good, but since the bcm2835-rpi-zero-w.dts also defines this, please remove it there.

>  	chosen {
> -		bootargs = "earlyprintk console=ttyAMA0";
> +		stdout-path = "serial0:115200n8";
>  	};
>  
>  	thermal-zones {
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
