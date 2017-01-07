From: wens@csie.org (Chen-Yu Tsai)
Date: Sun, 8 Jan 2017 03:00:40 +0800
Subject: [PATCH v2 0/8] ASoC: sunxi: Add support for audio codec in A23/H3
 SoCs
In-Reply-To: <20161125123442.28410-1-wens@csie.org>
References: <20161125123442.28410-1-wens@csie.org>
Message-ID: <CAGb2v65mo2g90QX6DMpw4dN4=fjccP2kp-NAbUPBzXYTtF8kMg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On Fri, Nov 25, 2016 at 8:34 PM, Chen-Yu Tsai <wens@csie.org> wrote:
> Hi everyone,
>
> This is v2 of my Allwinner A23 and H3 audio codec support series.
>
> Changes since v1:
>
>   - Use DEFINE_RES_MEM for the analog path controls block resources.
>   - Added Rob's ack.
>
> This series adds support for the audio codec found in Allwinner A23 and
> H3 SoCs. The design and data paths are similar to the audio codec found
> in earlier SoCs such as the A31. The analog audio paths are symmetrical
> with left/right channels and down-mix selectors for mono differential
> output.
>
> What deviates from previous SoCs is that the analog path controls have
> been moved to a separate control bus, accessed through a message box
> like register interface in the PRCM block. This necessitates writing
> a separate component driver for it, which is then tied into the sound
> card as an ASoC auxiliary device.
>
> Patch 1 adds the analog path controls block to the sun6i-prcm driver as
> a sub-device, for the A23. The H3 currently does not use the PRCM driver.
>
> Patch 2 adds PCM and card support for the A23 codec to the sun4i-codec
> driver.
>
> Patch 3 adds a device node for the analog path controls block to the A23
> dtsi.
>
> Patch 4 adds a device node for the audio codec, and the phandle for the
> analog path controls block to the A23 dtsi.
>
> Patch 5 enables the audio codec for the A23 Q8 tablets. On these tablets
> the headphone output is driven in DC coupled, or "direct drive", mode.
>
> Patch 6 adds PCM and card support for the H3 codec to the sun4i-codec
> driver.
>
> Patch 7 adds device nodes for the audio codec and analog path controls
> block to the H3 dtsi.
>
> Patch 8 enables the audio codec on the Orange Pi PC. The audio output
> jack on the board is tied to the line out pins on the SoC.

All the driver bits are in. Can you pick up the dts patches?

Thanks
ChenYu

>
>
> Please take a look and let me know what you think.
>
> In addition, the sun4i-codec driver is getting pretty large. Maybe we
> want to split the different parts into different files?
>
>
> Regards
> ChenYu
>
>
> Chen-Yu Tsai (8):
>   mfd: sun6i-prcm: Add codec analog controls sub-device for Allwinner
>     A23
>   ASoC: sun4i-codec: Add support for A23 codec
>   ARM: dts: sun8i: Add codec analog path controls node in PRCM for
>     A23/A33
>   ARM: dts: sun8i-a23: Add device node for internal audio codec
>   ARM: dts: sun8i-a23: q8-tablet: Enable internal audio codec
>   ASoC: sun4i-codec: Add support for H3 codec
>   ARM: dts: sun8i-h3: Add device nodes for audio codec and its analog
>     controls
>   ARM: dts: sun8i-h3: orange-pi-pc: Enable audio codec
>
>  .../devicetree/bindings/sound/sun4i-codec.txt      |  14 +-
>  arch/arm/boot/dts/sun8i-a23-a33.dtsi               |   4 +
>  arch/arm/boot/dts/sun8i-a23-q8-tablet.dts          |  23 +++
>  arch/arm/boot/dts/sun8i-a23.dtsi                   |  16 ++
>  arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts         |   8 +
>  arch/arm/boot/dts/sun8i-h3.dtsi                    |  19 +++
>  drivers/mfd/sun6i-prcm.c                           |  13 ++
>  sound/soc/sunxi/sun4i-codec.c                      | 179 +++++++++++++++++++++
>  8 files changed, 274 insertions(+), 2 deletions(-)
>
> --
> 2.10.2
>
