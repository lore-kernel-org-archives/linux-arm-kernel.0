From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue, 2 Jan 2018 20:03:13 +0100 (CET)
Subject: [PATCH 4/4] ARM: dts: bcm2837-rpi-3-b: add GPIO expander
In-Reply-To: <a29df633ee568e150c150debde66c0783a57c70a.1514898134.git.baruch@tkos.co.il>
References: <cover.1514898134.git.baruch@tkos.co.il>
 <a29df633ee568e150c150debde66c0783a57c70a.1514898134.git.baruch@tkos.co.il>
Message-ID: <1524381852.182115.1514919793281@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Baruch,

> Baruch Siach <baruch@tkos.co.il> hat am 2. Januar 2018 um 14:19 geschrieben:
> 
> 
> Add a description of the RPi3 GPIO expander that the VC4 firmware controls.
> 
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  arch/arm/boot/dts/bcm2837-rpi-3-b.dts | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/bcm2837-rpi-3-b.dts b/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
> index b44b3b5af00d..09dca48da2bd 100644
> --- a/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
> +++ b/arch/arm/boot/dts/bcm2837-rpi-3-b.dts
> @@ -23,6 +23,16 @@
>  			gpios = <&gpio 47 0>;
>  		};
>  	};
> +
> +	soc {

unfortunately this is a common issue of the RPi firmware drivers. These nodes shouldn't be child of the soc, because it's only bound for memory mapped IO. So please move it to the same level as soc. Otherwise we get more warnings with W=1 and Rob Herring gets unhappy.

> +		expgpio: expgpio {
> +			compatible = "brcm,bcm2835-expgpio";
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			firmware = <&firmware>;

Please add the gpio-line-names from Eric's patch [1].

Thanks
Stefan

[1] - https://patchwork.kernel.org/patch/9339857/

> +			status = "okay";
> +		};
> +	};
>  };
>  
>  /* uart0 communicates with the BT module */
> -- 
> 2.15.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
