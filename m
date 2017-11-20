From: hias@horus.com (Matthias Reichl)
Date: Mon, 20 Nov 2017 14:18:15 +0100
Subject: [PATCH RFC] ARM: dts: bcm283x: Fix probing of bcm2835-i2s
In-Reply-To: <1511110827-2726-1-git-send-email-stefan.wahren@i2se.com>
References: <1511110827-2726-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <20171120131815.2oaa7mvksi2h5bip@camel2.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan!

On Sun, Nov 19, 2017 at 06:00:27PM +0100, Stefan Wahren wrote:
> Since 517e7a1537a ("ASoC: bcm2835: move to use the clock framework")
> the bcm2835-i2s requires a clock as DT property. Unfortunately
> the necessary DT change has never been applied. While we are at it
> also fix the first PCM register range to cover the PCM_GRAY register.
> 
> This patch also fixes the dt-bindings accordlingly.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.txt   | 4 ++--
>  Documentation/devicetree/bindings/sound/brcm,bcm2835-i2s.txt | 9 ++++-----
>  arch/arm/boot/dts/bcm283x.dtsi                               | 4 ++--
>  3 files changed, 8 insertions(+), 9 deletions(-)
> 
> Hi, this is only probe tested with a RPi 1B. I don't have the sound hardware
> to test the drivers function.
> 
> diff --git a/Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.txt b/Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.txt
> index baf9b34..b6a8cc0 100644
> --- a/Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.txt
> +++ b/Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.txt
> @@ -74,8 +74,8 @@ Example:
>  
>  bcm2835_i2s: i2s at 7e203000 {
>  	compatible = "brcm,bcm2835-i2s";
> -	reg = <	0x7e203000 0x20>,
> -	      < 0x7e101098 0x02>;
> +	reg = <	0x7e203000 0x24>;
> +	clocks = <&clocks BCM2835_CLOCK_PCM>;
>  
>  	dmas = <&dma 2>,
>  	       <&dma 3>;
> diff --git a/Documentation/devicetree/bindings/sound/brcm,bcm2835-i2s.txt b/Documentation/devicetree/bindings/sound/brcm,bcm2835-i2s.txt
> index 65783de..7bb0362 100644
> --- a/Documentation/devicetree/bindings/sound/brcm,bcm2835-i2s.txt
> +++ b/Documentation/devicetree/bindings/sound/brcm,bcm2835-i2s.txt
> @@ -2,9 +2,8 @@
>  
>  Required properties:
>  - compatible: "brcm,bcm2835-i2s"
> -- reg: A list of base address and size entries:
> -	* The first entry should cover the PCM registers
> -	* The second entry should cover the PCM clock registers
> +- reg: Should contain PCM registers location and length.
> +- clocks: the (PCM) clock to use
>  - dmas: List of DMA controller phandle and DMA request line ordered pairs.
>  - dma-names: Identifier string for each DMA request line in the dmas property.
>    These strings correspond 1:1 with the ordered pairs in dmas.
> @@ -16,8 +15,8 @@ Example:
>  
>  bcm2835_i2s: i2s at 7e203000 {
>  	compatible = "brcm,bcm2835-i2s";
> -	reg = <0x7e203000 0x20>,
> -	      <0x7e101098 0x02>;
> +	reg = <0x7e203000 0x24>;
> +	clocks = <&clocks BCM2835_CLOCK_PCM>;
>  
>  	dmas = <&dma 2>,
>  	       <&dma 3>;
> diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
> index 431dcfc..01733a9 100644
> --- a/arch/arm/boot/dts/bcm283x.dtsi
> +++ b/arch/arm/boot/dts/bcm283x.dtsi
> @@ -391,8 +391,8 @@
>  
>  		i2s: i2s at 7e203000 {
>  			compatible = "brcm,bcm2835-i2s";
> -			reg = <0x7e203000 0x20>,
> -			      <0x7e101098 0x02>;
> +			reg = <0x7e203000 0x24>;
> +			clocks = <&clocks BCM2835_CLOCK_PCM>;
>  
>  			dmas = <&dma 2>,
>  			       <&dma 3>;
> -- 

Thanks a lot for fixing the DT and binding docs, the register range
and clock changes look fine to me.

While testing with a simple card DT overlay I noticed another
issue: the i2s node is missing the #sound-dai-cells property
and simple card refuses to load because of that:

[    0.956912] OF: /sound/simple-audio-card,cpu: could not get #sound-dai-cells for /soc/i2s at 7e203000

As bcm2835-i2s has only a single DAI I think that property should
be set to 0:

diff --git a/Documentation/devicetree/bindings/sound/brcm,bcm2835-i2s.txt b/Documentation/devicetree/bindings/sound/brcm,bcm2835-i2s.txt
index 7bb0362828ec..7349f22bed1b 100644
--- a/Documentation/devicetree/bindings/sound/brcm,bcm2835-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/brcm,bcm2835-i2s.txt
@@ -7,6 +7,7 @@ Required properties:
 - dmas: List of DMA controller phandle and DMA request line ordered pairs.
 - dma-names: Identifier string for each DMA request line in the dmas property.
   These strings correspond 1:1 with the ordered pairs in dmas.
+- #sound-dai-cells: Must be set to 0.
 
   One of the DMA channels will be responsible for transmission (should be
   named "tx") and one for reception (should be named "rx").
@@ -21,4 +22,5 @@ bcm2835_i2s: i2s at 7e203000 {
 	dmas = <&dma 2>,
 	       <&dma 3>;
 	dma-names = "tx", "rx";
+	#sound-dai-cells = <0>;
 };
diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
index e08203c1d74a..bbe890d4dbb5 100644
--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -402,6 +402,7 @@
 			dmas = <&dma 2>,
 			       <&dma 3>;
 			dma-names = "tx", "rx";
+			#sound-dai-cells = <0>;
 			status = "disabled";
 		};

With this additional change I could successfully test the following
overlay with a PCM5102 codec attached to a RPi B+:

/dts-v1/;
/plugin/;

/ {
    compatible = "brcm,bcm2835";

    fragment at 0 {
        target = <&i2s>;
        __overlay__ {
            status = "okay";
        };
    };

    fragment at 1 {
        target-path = "/";
        __overlay__ {
            spdif_codec: spdif-transmitter {
                #address-cells = <0>;
                #size-cells = <0>;
                #sound-dai-cells = <0>;
                compatible = "linux,spdif-dit";
            };

            sound {
                compatible = "simple-audio-card";
                simple-audio-card,name = "simple";
                simple-audio-card,format = "i2s";
                simple-audio-card,bitclock-master = <&dailink_master>;
                simple-audio-card,frame-master = <&dailink_master>;

                dailink_master: simple-audio-card,cpu {
                        sound-dai = <&i2s>;
                };

                simple-audio-card,codec {
                        sound-dai = <&spdif_codec>;
                };
            };
        };
    };
};

BTW: this overlay will work without any hardware attached, you
just need to enable SND_SIMPLE_CARD and SND_SOC_SPDIF (which
serves as a generic codec) in your config.

so long,

Hias
