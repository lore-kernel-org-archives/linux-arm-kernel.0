From: kernel@martin.sperl.org (Martin Sperl)
Date: Mon, 21 Dec 2015 12:51:27 +0100
Subject: [PATCH 4/4] ARM: bcm2835: Switch to using the new clock driver
 support.
In-Reply-To: <1441562263-19888-5-git-send-email-eric@anholt.net>
References: <1441562263-19888-1-git-send-email-eric@anholt.net>
 <1441562263-19888-5-git-send-email-eric@anholt.net>
Message-ID: <5677E7BF.3020404@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06.09.2015 19:57, Eric Anholt wrote:
>   
> +		clocks: cprman at 7e101000 {
> +			compatible = "brcm,bcm2835-cprman";
> +			#clock-cells = <1>;
> +			reg = <0x7e101000 0x2000>;
> +
> +			/* CPRMAN derives everything from the platform's
> +			 * oscillator.
> +			 */
> +			clocks = <&clk_osc>;
> +		};
> +
>
This actually breaks i2s because of an overlap in registers:
[   12.734352] bcm2835-i2s 20203000.i2s: can't request region for 
resource [mem 0x20101098-0x2010109f]
[   12.826571] bcm2835-i2s: probe of 20203000.i2s failed with error -16

here the corresponding section for i2s in /arch/arm/boot/dts/bcm2835.dtsi:
                 i2s: i2s at 7e203000 {
                         compatible = "brcm,bcm2835-i2s";
                         reg = <0x7e203000 0x20>,
                               <0x7e101098 0x02>;

                         dmas = <&dma 2>,
                                <&dma 3>;
                         dma-names = "tx", "rx";
                         status = "disabled";
                 };

Note that actually the PCM/I2S reg-range should be (off by 4):
     reg = <0x7e203000 0x24>;
(see also: https://github.com/raspberrypi/linux/pull/1079)

Ciao,
             Martin
