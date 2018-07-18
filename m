From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 18 Jul 2018 19:30:50 +0800
Subject: [PATCH v3 00/18] arm64: allwinner: Add A64 DE2 HDMI support
In-Reply-To: <20180718105458.22304-1-jagan@amarulasolutions.com>
References: <20180718105458.22304-1-jagan@amarulasolutions.com>
Message-ID: <CAGb2v67=h=HAiDz9+sx52vkk5YdCZMdMvM=T_vFydeszqnjLmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 18, 2018 at 6:54 PM, Jagan Teki <jagan@amarulasolutions.com> wrote:
> Allwinner A64 has display engine pipeline like other Allwinner SOC's A83T/H3/H5.
>
> A64 behaviour similar to Allwinner A83T where
> Mixer0 => TCON0 => LVDS/RGB/MIPI-DSI
> Mixer1 => TCON1 => HDMI
> as per Display System Block Diagram from Allwinner_A64_User_Manual_V1.1.pdf
>
> This is third patch-set followed with previous RFC[1], first and second
> series[2][3] and merely concentrated on HDMI pipeline through TCON1 and
> rest will add eventually.
>
> This series fixed previous version comments
> - Rebasing on linux-next
> - sqash all pipeline components in one patch
> - Enable all pipeline components in board dts
> - about documenting fallback compatibles
> - adding new compatible for mixer1
>
> Log:
> [    1.450984] Jagan: sun8i_mixer_probe
> [    1.464981] sun4i-drm display-engine: bound 1200000.mixer (ops sun8i_mixer_ops)
> [    1.472572] sun4i-drm display-engine: bound 1c0d000.lcd-controller (ops sun4i_tcon_ops)
> [    1.480676] sun8i-dw-hdmi 1ee0000.hdmi: Linked as a consumer to regulator.10
> [    1.488738] sun8i-dw-hdmi 1ee0000.hdmi: Detected HDMI TX controller v1.32a with HDCP (sun8i_dw_hdmi_phy)
> [    1.498879] sun8i-dw-hdmi 1ee0000.hdmi: registered DesignWare HDMI I2C bus driver
> [    1.507372] sun4i-drm display-engine: bound 1ee0000.hdmi (ops sun8i_dw_hdmi_ops)
> [    1.514778] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
> [    1.521398] [drm] No driver support for vblank timestamp query.
> [    1.684611] random: fast init done
> [    2.011575] Console: switching to colour frame buffer device 180x56
> [    2.049858] sun4i-drm display-engine: fb0: DRM emulated frame buffer device
> [    2.057268] [drm] Initialized sun4i-drm 1.0.0 20150629 for display-engine on minor 0
>
> Note:
> Pine64 boards are unable to get edid by default like other A64 boards,
> but forcing 'video=HDMI-A-1:1920x1080 at 60D' kernel command line can
> create edid with display on penel
>
> [3] https://lkml.org/lkml/2018/5/18/461
> [2] https://lkml.org/lkml/2018/4/30/288
> [1] https://lkml.org/lkml/2018/4/24/547
>
> Icenowy Zheng (1):
>   drm: sun4i: add support for HVCC regulator for DWC HDMI glue
>
> Jagan Teki (17):
>   clk: sunxi-ng: a64: Add minimal rate for video PLLs
>   drm/sun4i: Add support for A64 mixer1
>   dt-bindings: display: Add compatible for A64 DE2 tcon1 blocks
>   drm/sun4i: Add support for A64 display engine
>   dt-bindings: display: Add compatible for A64 HDMI
>   dt-bindings: clock: sun50i-a64-ccu: Add PLL_VIDEO[0-1] macros
>   arm64: dts: allwinner: a64: Add tcon1 HDMI pipeline
>   clk: sunxi-ng: Enable DE2_CCU for SUN8I and SUN50I
>   arm64: defconfig: Enable CONFIG_DRM_SUN4I
>   drm/sun4i: Enable DE2 Mixer for SUN8I and SUN50I
>   drm/sun4i: Enable DesignWare HDMI for SUN50I

>   arm64: dts: allwinner: a64: bananapi-m64: Enable HDMI output
>   arm64: dts: allwinner: a64: nanopi-a64: Enable HDMI output
>   arm64: dts: allwinner: a64: orangepi-win: Enable HDMI output
>   arm64: dts: allwinner: a64: a64-olinuxino: Enable HDMI output
>   arm64: dts: allwinner: a64: pine64: Enable HDMI output
>   arm64: dts: allwinner: a64: sopine: Enable HDMI output

Please squash all the patches enabling HDMI on some board into one,
and write an informative commit message. See commit 8b1447aed5f4
("ARM: dts: sun6i: Enable HDMI support on some A31/A31s devices")
for such an example.

ChenYu

>
>  .../bindings/display/sunxi/sun4i-drm.txt      |   4 +
>  .../dts/allwinner/sun50i-a64-bananapi-m64.dts |  34 ++++++
>  .../dts/allwinner/sun50i-a64-nanopi-a64.dts   |  34 ++++++
>  .../dts/allwinner/sun50i-a64-olinuxino.dts    |  34 ++++++
>  .../dts/allwinner/sun50i-a64-orangepi-win.dts |  34 ++++++
>  .../boot/dts/allwinner/sun50i-a64-pine64.dts  |  34 ++++++
>  .../allwinner/sun50i-a64-sopine-baseboard.dts |  34 ++++++
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 110 ++++++++++++++++++
>  arch/arm64/configs/defconfig                  |   1 +
>  drivers/clk/sunxi-ng/Kconfig                  |   2 +
>  drivers/clk/sunxi-ng/ccu-sun50i-a64.c         |  46 ++++----
>  drivers/gpu/drm/sun4i/Kconfig                 |   3 +-
>  drivers/gpu/drm/sun4i/sun4i_drv.c             |   1 +
>  drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c         |  14 +++
>  drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h         |   2 +
>  drivers/gpu/drm/sun4i/sun8i_mixer.c           |  12 ++
>  include/dt-bindings/clock/sun50i-a64-ccu.h    |   2 +
>  17 files changed, 378 insertions(+), 23 deletions(-)
>
> --
> 2.17.1
>
