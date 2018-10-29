From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Sun, 28 Oct 2018 19:20:03 -0700
Subject: [PATCH 0/9] Analogix ANX6345 RGB-(e)DP bridge support
In-Reply-To: <20181018073327.64942-1-icenowy@aosc.io>
References: <20181018073327.64942-1-icenowy@aosc.io>
Message-ID: <CA+E=qVenpYz3oZC0iiS6ZFxTnkFcBkE0=qB46rvXA30o_AJAYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 18, 2018 at 12:35 AM Icenowy Zheng <icenowy@aosc.io> wrote:
>
> This patchset brings the support for Analogix ANX6345 RGB-(e)DP bridge,
> which is used by some Allwinner A64 laptops, such as Pinebook and Olimex
> TERES-I.
>
> It reuses some definitions from the ANX78xx driver that already exists
> in the kernel tree, but the driver code itself is rewritten, because the
> big difference between ANX6345 and ANX78xx.
>
> This patchset also enables the bridge on Pinebook and TERES-I, and a
> temporary workaround patch (do not merge) for the dot clock accuracy
> problem of sun4i-drm.
>
> This patchset assumes some fixes ([1], [2] and [3]) are already
> applied, without them the patchset cannot be tested on the A64 devices
> mentioned above.

For whole series:

Tested-by: Vasily Khoruzhick <anarsoul@gmail.com>

>
> [1] https://patchwork.kernel.org/patch/10628827/
> [2] https://patchwork.kernel.org/patch/10628825/
> [3] https://patchwork.kernel.org/patch/10646791/
>
> Chen-Yu Tsai (1):
>   [DO NOT MERGE] drm/sun4i: rgb: Add 5% tolerance to dot clock frequency
>     check
>
> Icenowy Zheng (8):
>   drm/bridge: move ANA78xx driver to analogix subdirectory
>   drm/bridge: split some definitions of ANX78xx to dedicated headers
>   drm/bridge: extract some Analogix I2C DP common code
>   dt-bindings: Add ANX6345 DP/eDP transmitter binding
>   drm/bridge: Add Analogix anx6345 support
>   arm64: allwinner: a64: add pinmux for RGB666 LCD
>   arm64: allwinner: a64: enable ANX6345 bridge on Pinebook
>   arm64: allwinner: a64: enable ANX6345 bridge on TERES-I
>
>  .../bindings/display/bridge/anx6345.txt       |  39 +
>  .../dts/allwinner/sun50i-a64-pinebook.dts     |  43 +
>  .../boot/dts/allwinner/sun50i-a64-teres-i.dts |  40 +-
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |   9 +
>  drivers/gpu/drm/bridge/Kconfig                |  10 -
>  drivers/gpu/drm/bridge/Makefile               |   4 +-
>  drivers/gpu/drm/bridge/analogix-anx78xx.h     | 719 ---------------
>  drivers/gpu/drm/bridge/analogix/Kconfig       |  25 +
>  drivers/gpu/drm/bridge/analogix/Makefile      |   4 +
>  .../drm/bridge/analogix/analogix-anx6345.c    | 862 ++++++++++++++++++
>  .../bridge/{ => analogix}/analogix-anx78xx.c  | 146 +--
>  .../drm/bridge/analogix/analogix-anx78xx.h    | 265 ++++++
>  .../drm/bridge/analogix/analogix-i2c-dptx.c   | 169 ++++
>  .../drm/bridge/analogix/analogix-i2c-dptx.h   | 258 ++++++
>  .../bridge/analogix/analogix-i2c-txcommon.h   | 240 +++++
>  drivers/gpu/drm/sun4i/sun4i_rgb.c             |   5 +-
>  16 files changed, 1956 insertions(+), 882 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/anx6345.txt
>  delete mode 100644 drivers/gpu/drm/bridge/analogix-anx78xx.h
>  create mode 100644 drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
>  rename drivers/gpu/drm/bridge/{ => analogix}/analogix-anx78xx.c (90%)
>  create mode 100644 drivers/gpu/drm/bridge/analogix/analogix-anx78xx.h
>  create mode 100644 drivers/gpu/drm/bridge/analogix/analogix-i2c-dptx.c
>  create mode 100644 drivers/gpu/drm/bridge/analogix/analogix-i2c-dptx.h
>  create mode 100644 drivers/gpu/drm/bridge/analogix/analogix-i2c-txcommon.h
>
> --
> 2.18.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
