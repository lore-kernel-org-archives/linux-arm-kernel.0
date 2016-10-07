From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Fri, 7 Oct 2016 16:35:30 +0800
Subject: [PATCH 00/14] ASoc: sunxi: Add Allwinner A33 codec driver
In-Reply-To: <cover.1475569400.git.mylene.josserand@free-electrons.com>
References: <cover.1475569400.git.mylene.josserand@free-electrons.com>
Message-ID: <20161007163530.7b027091@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue,  4 Oct 2016 11:46:13 +0200
Myl?ne Josserand <mylene.josserand@free-electrons.com> wrote:

> Hi everyone,
> 
> 
> This patchset add the audio codec for Allwinner A33 (sun8i) SoC.
> 
> It adds different drivers:
>    - sun8i-codec-analog (patch 4): This driver implements the analog
> part of the audio codec. The analog part is handled in PRCM registers
> so this driver must be added as prcm's subnode (patch 5).
>    - sun8i-codec (patch 6): This driver implements the digital part
> of the A33 codec.
>    - sun8i (patch 7): This driver implements a sound card for A33.
>    It links the DAI and the audio codec. The analog codec driver is
> handled as an "aux_device".
> 
> The DAI for this codec is the same than for A20: "sun4i-i2s".
> The digital codec code is coming from Allwinner's BSP (after some
> cleanup and DAPM conversion) [1]
> The analog codec driver is coming from Chen-Yu Tsai's driver [2]
> with some modifications (such as read/write regmap functions).
> 
> Currently, all the drivers handle only the playback feature.
> The other ones (such as capture) and all other interfaces except
> headphone are not supported.
> 
> These drivers are functional except for one issue. When playing a
> sound for the first time, a short delay can be noticed. On a second
> play (right after), the sound is played correctly. If we wait a short
> time (~5 sec), the delay is back.
> There is the same behavior for left/right channel. On the first
> time, a left sound is played on the left channel but in the second
> time, the sound will be played on wrong channel.
> 
> These issues will be fixed in a second time. Is someone have
> suggestions about it?
> 
> Examples of amixer commands:
> 	amixer set 'Headphone' 75%
> 	amixer set 'Headphone' on
> 	amixer set 'DAC' on
> 	amixer set 'Right DAC Mixer RSlot 0' on
> 	amixer set 'Left DAC Mixer LSlot 0' on
> 	amixer set 'DAC Reversed Right' on
> 	amixer set 'DAC Reversed Left' on
> 
> It was tested on Parrot and Sinlinx board where device tree's
> modifications are added (patch 11 to 14).

I tested it on my iNet D978 Rev2 board (dts available in linux-next now)
Directly output audio from mpg123 to the audio codec failed, with
noises appear in the earphone. (And the mpg123 process terminated very
fast, seems that the bitrate become wrong)

However, paplay works well with the decoded wav file, and ```mpg123 -o
pulse``` works properly.

> 
> Thank you in advance,
> Best regards,
> 
> [1]:
> https://github.com/allwinner-zh/linux-3.4-sunxi/blob/master/sound/soc/sunxi/audiocodec/sun8iw5_sndcodec.c
> [2]: https://github.com/wens/linux/tree/a31-audio
> 
> Myl?ne Josserand (14):
>   dma: sun6i-dma: Add burst case of 4
>   clk: ccu-sun8i-a33: Add CLK_SET_RATE_PARENT to ac-dig
>   ASoC: sun4i-i2s: Add apb reset
>   ASoC: Add sun8i analog codec driver
>   mfd: sun6i-prcm: Add sun8i analog codec as subnode
>   ASoC: Add sun8i digital audio codec
>   ASoC: Add sun8i audio card
>   dt-bindings: sound: Add sun8i analog codec documentation
>   dt-bindings: sound: Add sun8i codec documentation
>   dt-bindings: sound: Add sun8i audio card documentation
>   ARM: dts: sun8i: Add analog codec on prcm node
>   ARM: dts: sun8i: Add audio codec, dai and card for A33
>   ARM: dts: sun8i: parrot: Enable audio nodes
>   ARM: dts: sun8i: sinlinx: Enable audio nodes
> 
>  .../devicetree/bindings/sound/sun8i-audio.txt      |  17 +
>  .../bindings/sound/sun8i-codec-analog.txt          |  20 +
>  .../devicetree/bindings/sound/sun8i-codec.txt      |  24 +
>  arch/arm/boot/dts/sun8i-a23-a33.dtsi               |   7 +
>  arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts     |   8 +
>  arch/arm/boot/dts/sun8i-a33.dtsi                   |  33 ++
>  arch/arm/boot/dts/sun8i-r16-parrot.dts             |   8 +
>  drivers/clk/sunxi-ng/ccu-sun8i-a33.c               |   2 +-
>  drivers/dma/sun6i-dma.c                            |   2 +
>  drivers/mfd/sun6i-prcm.c                           |  16 +
>  sound/soc/sunxi/Kconfig                            |  30 ++
>  sound/soc/sunxi/Makefile                           |   3 +
>  sound/soc/sunxi/sun4i-i2s.c                        |  16 +-
>  sound/soc/sunxi/sun8i-codec-analog.c               | 305
> +++++++++++++ sound/soc/sunxi/sun8i-codec.c                      |
> 492 +++++++++++++++++++++
> sound/soc/sunxi/sun8i.c                            | 101 +++++ 16
> files changed, 1082 insertions(+), 2 deletions(-) create mode 100644
> Documentation/devicetree/bindings/sound/sun8i-audio.txt create mode
> 100644 Documentation/devicetree/bindings/sound/sun8i-codec-analog.txt
> create mode 100644
> Documentation/devicetree/bindings/sound/sun8i-codec.txt create mode
> 100644 sound/soc/sunxi/sun8i-codec-analog.c create mode 100644
> sound/soc/sunxi/sun8i-codec.c create mode 100644
> sound/soc/sunxi/sun8i.c
> 
