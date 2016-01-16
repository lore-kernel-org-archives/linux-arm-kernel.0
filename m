From: info@lategoodbye.de (Stefan Wahren)
Date: Sat, 16 Jan 2016 16:26:44 +0100
Subject: [PATCH V2 2/3] ARM: bcm2835: I2S: use new register-range and
 clock framework
In-Reply-To: <1452602149-5875-3-git-send-email-kernel@martin.sperl.org>
References: <1452602149-5875-1-git-send-email-kernel@martin.sperl.org>
 <1452602149-5875-3-git-send-email-kernel@martin.sperl.org>
Message-ID: <569A6134.6070504@lategoodbye.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Martin,

[add Mike and Remi]

Am 12.01.2016 um 13:35 schrieb kernel at martin.sperl.org:
> From: Martin Sperl <kernel@martin.sperl.org>
>
> Since the move to the new clock framework with commit 94cb7f76caa0
> ("ARM: bcm2835: Switch to using the new clock driver support.")
> the bcm2835-i2s driver was no longer working.
>
> This patch fixes the address ranges:
> * remove the PCM clock register range that is owned by the clockmanager
> * fix the length, which did not include the last register of this device
>
> It also adds the required pcm-clock.
>
> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
> ---
>   arch/arm/boot/dts/bcm2835.dtsi |    5 ++---

this won't apply, because the file has been renamed to bcm283x.dtsi.

>   1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
> index aef64de..83d9787 100644
> --- a/arch/arm/boot/dts/bcm2835.dtsi
> +++ b/arch/arm/boot/dts/bcm2835.dtsi
> @@ -120,9 +120,8 @@
>
>   		i2s: i2s at 7e203000 {
>   			compatible = "brcm,bcm2835-i2s";
> -			reg = <0x7e203000 0x20>,
> -			      <0x7e101098 0x02>;
> -
> +			reg = <0x7e203000 0x24>;
> +			clocks = <&clocks BCM2835_CLOCK_PCM>;

After applying clk series ([PATCH V4 0/7] clk: bcm2835: add clocks and 
add MASH support) and this series the pcm clock is an orphan.

Do we need to add "assigned-clocks" to the i2s node just like for pwm [1]?

Regards
Stefan

>   			dmas = <&dma 2>,
>   			       <&dma 3>;
>   			dma-names = "tx", "rx";
>

[1] - 
http://lists.infradead.org/pipermail/linux-rpi-kernel/2015-December/002789.html
