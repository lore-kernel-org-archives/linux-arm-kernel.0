From: robherring2@gmail.com (Rob Herring)
Date: Sun, 23 Aug 2015 18:23:14 -0500
Subject: [PATCH v3 06/14] Documentation: drm/bridge: add document for
 analogix_dp
In-Reply-To: <1439995834-18363-1-git-send-email-ykk@rock-chips.com>
References: <1439995728-18046-1-git-send-email-ykk@rock-chips.com>
 <1439995834-18363-1-git-send-email-ykk@rock-chips.com>
Message-ID: <CAL_JsqLz+8RtBucctUj4euXZ3Ac0DvB52N9ONpAerh5T9BiTJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 19, 2015 at 9:50 AM, Yakir Yang <ykk@rock-chips.com> wrote:
> Analogix dp driver is split from exynos dp driver, so we just
> make an copy of exynos_dp.txt, and then simplify exynos_dp.txt
>
> Beside update some exynos dtsi file with the latest change
> according to the devicetree binding documents.

You can't just change the exynos bindings and break compatibility. Is
there some agreement with exynos folks to do this?


> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
> ---
> Changes in v3:
> - Take Heiko suggest, add devicetree binding documents.
> - Take Thierry Reding suggest, remove sync pol & colorimetry properies
>   from the new analogix dp driver devicetree binding.
> - Update the exist exynos dtsi file with the latest DP DT properies.
>
> Changes in v2: None
>
>  .../devicetree/bindings/drm/bridge/analogix_dp.txt | 70 ++++++++++++++++++++++
>  .../devicetree/bindings/video/exynos_dp.txt        | 50 ++++++----------
>  arch/arm/boot/dts/exynos5250-arndale.dts           | 10 ++--
>  arch/arm/boot/dts/exynos5250-smdk5250.dts          | 10 ++--
>  arch/arm/boot/dts/exynos5250-snow.dts              | 12 ++--
>  arch/arm/boot/dts/exynos5250-spring.dts            | 12 ++--
>  arch/arm/boot/dts/exynos5420-peach-pit.dts         | 12 ++--
>  arch/arm/boot/dts/exynos5420-smdk5420.dts          | 10 ++--
>  arch/arm/boot/dts/exynos5800-peach-pi.dts          | 12 ++--
>  9 files changed, 119 insertions(+), 79 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/drm/bridge/analogix_dp.txt
>
> diff --git a/Documentation/devicetree/bindings/drm/bridge/analogix_dp.txt b/Documentation/devicetree/bindings/drm/bridge/analogix_dp.txt
> new file mode 100644
> index 0000000..6127018
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/drm/bridge/analogix_dp.txt
> @@ -0,0 +1,70 @@
> +Analogix Display Port bridge bindings
> +
> +Required properties for dp-controller:
> +       -compatible:
> +               platform specific such as:
> +                * "samsung,exynos5-dp"
> +                * "rockchip,rk3288-dp"
> +       -reg:
> +               physical base address of the controller and length
> +               of memory mapped region.
> +       -interrupts:
> +               interrupt combiner values.
> +       -clocks:
> +               from common clock binding: handle to dp clock.
> +       -clock-names:
> +               from common clock binding: Shall be "dp".
> +       -interrupt-parent:
> +               phandle to Interrupt combiner node.
> +       -phys:
> +               from general PHY binding: the phandle for the PHY device.
> +       -phy-names:
> +               from general PHY binding: Should be "dp".
> +       -analogix,color-space:
> +               input video data format.
> +                       COLOR_RGB = 0, COLOR_YCBCR422 = 1, COLOR_YCBCR444 = 2
> +       -analogix,color-depth:
> +               number of bits per colour component.
> +                       COLOR_6 = 0, COLOR_8 = 1, COLOR_10 = 2, COLOR_12 = 3

This seems pretty generic. Just use 6, 8, 10, or 12 for values. And
drop the vendor prefix.

> +       -analogix,link-rate:
> +               max link rate supported by the eDP controller.
> +                       LINK_RATE_1_62GBPS = 0x6, LINK_RATE_2_70GBPS = 0x0A,
> +                       LINK_RATE_5_40GBPS = 0x14

Same here. I'd rather see something like "link-rate-mbps" and use the
actual rate.

> +       -analogix,lane-count:
> +               max number of lanes supported by the eDP contoller.
> +                       LANE_COUNT1 = 1, LANE_COUNT2 = 2, LANE_COUNT4 = 4

And drop the vendor prefix here.

> +       -port@[X]: SoC specific port nodes with endpoint definitions as defined
> +               in Documentation/devicetree/bindings/media/video-interfaces.txt,
> +               please refer to the SoC specific binding document:
> +               * Documentation/devicetree/bindings/video/exynos_dp.txt
> +               * Documentation/devicetree/bindings/video/analogix_dp-rockchip.txt
> +
> +Optional properties for dp-controller:
> +       -analogix,hpd-gpio:
> +               Hotplug detect GPIO.
> +                       Indicates which GPIO should be used for hotplug
> +                       detection

We should align with "hpd-gpios" used by HDMI connector binding. Or do
we need a DP connector binding that this should be defined in?
Probably so.

The DRM related bindings are such a cluster f*ck with everyone picking
their own way to do things. Just grep hpd in bindings for starters.
That is just the tip.

> +       -video interfaces: Device node can contain video interface port
> +                           nodes according to [1].

Isn't this the same as ports above? How are they optional? 0 ports
would be pretty useless.

> +
> +[1]: Documentation/devicetree/bindings/media/video-interfaces.txt
> +-------------------------------------------------------------------------------
> +
> +Example:
> +
> +       dp-controller {
> +               compatible = "samsung,exynos5-dp";
> +               reg = <0x145b0000 0x10000>;
> +               interrupts = <10 3>;
> +               interrupt-parent = <&combiner>;
> +               clocks = <&clock 342>;
> +               clock-names = "dp";
> +
> +               phys = <&dp_phy>;
> +               phy-names = "dp";
> +
> +               analogix,color-space = <0>;
> +               analogix,color-depth = <1>;
> +               analogix,link-rate = <0x0a>;
> +               analogix,lane-count = <4>;
> +       };
> diff --git a/Documentation/devicetree/bindings/video/exynos_dp.txt b/Documentation/devicetree/bindings/video/exynos_dp.txt
> index 7a3a9cd..177506f 100644
> --- a/Documentation/devicetree/bindings/video/exynos_dp.txt
> +++ b/Documentation/devicetree/bindings/video/exynos_dp.txt
> @@ -31,28 +31,10 @@ Required properties for dp-controller:
>                 from general PHY binding: the phandle for the PHY device.
>         -phy-names:
>                 from general PHY binding: Should be "dp".
> -       -samsung,color-space:
> -               input video data format.
> -                       COLOR_RGB = 0, COLOR_YCBCR422 = 1, COLOR_YCBCR444 = 2
> -       -samsung,dynamic-range:
> -               dynamic range for input video data.
> -                       VESA = 0, CEA = 1
> -       -samsung,ycbcr-coeff:
> -               YCbCr co-efficients for input video.
> -                       COLOR_YCBCR601 = 0, COLOR_YCBCR709 = 1
> -       -samsung,color-depth:
> -               number of bits per colour component.
> -                       COLOR_6 = 0, COLOR_8 = 1, COLOR_10 = 2, COLOR_12 = 3
> -       -samsung,link-rate:
> -               link rate supported by the panel.
> -                       LINK_RATE_1_62GBPS = 0x6, LINK_RATE_2_70GBPS = 0x0A
> -       -samsung,lane-count:
> -               number of lanes supported by the panel.
> -                       LANE_COUNT1 = 1, LANE_COUNT2 = 2, LANE_COUNT4 = 4
> -       - display-timings: timings for the connected panel as described by
> -               Documentation/devicetree/bindings/video/display-timing.txt
>
>  Optional properties for dp-controller:
> +       - display-timings: timings for the connected panel as described by
> +               Documentation/devicetree/bindings/video/display-timing.txt
>         -interlaced:
>                 interlace scan mode.
>                         Progressive if defined, Interlaced if not defined
> @@ -62,14 +44,18 @@ Optional properties for dp-controller:
>         -hsync-active-high:
>                 HSYNC polarity configuration.
>                         High if defined, Low if not defined
> -       -samsung,hpd-gpio:
> -               Hotplug detect GPIO.
> -                       Indicates which GPIO should be used for hotplug
> -                       detection
> -       -video interfaces: Device node can contain video interface port
> -                           nodes according to [1].
>
> -[1]: Documentation/devicetree/bindings/media/video-interfaces.txt
> +For the below properties, please refer to Analogix DP binding document:
> + * Documentation/devicetree/bindings/drm/bridge/analogix_dp.txt
> +       -phys (required)
> +       -phy-names (required)
> +       -analogix,color-space (required)
> +       -analogix,color-depth (required)
> +       -analogix,link-rate (required)
> +       -analogix,lane-count (required)
> +       -analogix,hpd-gpio (optional)
> +       -video interfaces (optional)
> +-------------------------------------------------------------------------------
>
>  Example:
>
> @@ -88,12 +74,10 @@ SOC specific portion:
>
>  Board Specific portion:
>         dp-controller {
> -               samsung,color-space = <0>;
> -               samsung,dynamic-range = <0>;
> -               samsung,ycbcr-coeff = <0>;
> -               samsung,color-depth = <1>;
> -               samsung,link-rate = <0x0a>;
> -               samsung,lane-count = <4>;
> +               analogix,color-space = <0>;
> +               analogix,color-depth = <1>;
> +               analogix,link-rate = <0x0a>;
> +               analogix,lane-count = <4>;
>
>                 display-timings {
>                         native-mode = <&lcd_timing>;
> diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
> index 7e728a1..e48798d 100644
> --- a/arch/arm/boot/dts/exynos5250-arndale.dts
> +++ b/arch/arm/boot/dts/exynos5250-arndale.dts
> @@ -119,12 +119,10 @@
>
>  &dp {
>         status = "okay";
> -       samsung,color-space = <0>;
> -       samsung,dynamic-range = <0>;
> -       samsung,ycbcr-coeff = <0>;
> -       samsung,color-depth = <1>;
> -       samsung,link-rate = <0x0a>;
> -       samsung,lane-count = <4>;
> +       analogix,color-space = <0>;
> +       analogix,color-depth = <1>;
> +       analogix,link-rate = <0x0a>;
> +       analogix,lane-count = <4>;
>  };
>
>  &fimd {
> diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
> index 4fe186d..b8c6b8b 100644
> --- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
> +++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
> @@ -75,12 +75,10 @@
>  };
>
>  &dp {
> -       samsung,color-space = <0>;
> -       samsung,dynamic-range = <0>;
> -       samsung,ycbcr-coeff = <0>;
> -       samsung,color-depth = <1>;
> -       samsung,link-rate = <0x0a>;
> -       samsung,lane-count = <4>;
> +       analogix,color-space = <0>;
> +       analogix,color-depth = <1>;
> +       analogix,link-rate = <0x0a>;
> +       analogix,lane-count = <4>;
>
>         pinctrl-names = "default";
>         pinctrl-0 = <&dp_hpd>;
> diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
> index b7f4122..9ce2b89 100644
> --- a/arch/arm/boot/dts/exynos5250-snow.dts
> +++ b/arch/arm/boot/dts/exynos5250-snow.dts
> @@ -239,13 +239,11 @@
>         status = "okay";
>         pinctrl-names = "default";
>         pinctrl-0 = <&dp_hpd>;
> -       samsung,color-space = <0>;
> -       samsung,dynamic-range = <0>;
> -       samsung,ycbcr-coeff = <0>;
> -       samsung,color-depth = <1>;
> -       samsung,link-rate = <0x0a>;
> -       samsung,lane-count = <2>;
> -       samsung,hpd-gpio = <&gpx0 7 GPIO_ACTIVE_HIGH>;
> +       analogix,color-space = <0>;
> +       analogix,color-depth = <1>;
> +       analogix,link-rate = <0x0a>;
> +       analogix,lane-count = <2>;
> +       analogix,hpd-gpio = <&gpx0 7 GPIO_ACTIVE_HIGH>;
>
>         ports {
>                 port at 0 {
> diff --git a/arch/arm/boot/dts/exynos5250-spring.dts b/arch/arm/boot/dts/exynos5250-spring.dts
> index d03f9b8..9288ae6 100644
> --- a/arch/arm/boot/dts/exynos5250-spring.dts
> +++ b/arch/arm/boot/dts/exynos5250-spring.dts
> @@ -69,13 +69,11 @@
>         status = "okay";
>         pinctrl-names = "default";
>         pinctrl-0 = <&dp_hpd_gpio>;
> -       samsung,color-space = <0>;
> -       samsung,dynamic-range = <0>;
> -       samsung,ycbcr-coeff = <0>;
> -       samsung,color-depth = <1>;
> -       samsung,link-rate = <0x0a>;
> -       samsung,lane-count = <1>;
> -       samsung,hpd-gpio = <&gpc3 0 GPIO_ACTIVE_HIGH>;
> +       analogix,color-space = <0>;
> +       analogix,color-depth = <1>;
> +       analogix,link-rate = <0x0a>;
> +       analogix,lane-count = <1>;
> +       analogix,hpd-gpio = <&gpc3 0 GPIO_ACTIVE_HIGH>;
>  };
>
>  &ehci {
> diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
> index 8f4d76c..695a380 100644
> --- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
> +++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
> @@ -147,13 +147,11 @@
>         status = "okay";
>         pinctrl-names = "default";
>         pinctrl-0 = <&dp_hpd_gpio>;
> -       samsung,color-space = <0>;
> -       samsung,dynamic-range = <0>;
> -       samsung,ycbcr-coeff = <0>;
> -       samsung,color-depth = <1>;
> -       samsung,link-rate = <0x06>;
> -       samsung,lane-count = <2>;
> -       samsung,hpd-gpio = <&gpx2 6 0>;
> +       analogix,color-space = <0>;
> +       analogix,color-depth = <1>;
> +       analogix,link-rate = <0x06>;
> +       analogix,lane-count = <2>;
> +       analogix,hpd-gpio = <&gpx2 6 0>;
>
>         ports {
>                 port at 0 {
> diff --git a/arch/arm/boot/dts/exynos5420-smdk5420.dts b/arch/arm/boot/dts/exynos5420-smdk5420.dts
> index 98871f9..fd46714 100644
> --- a/arch/arm/boot/dts/exynos5420-smdk5420.dts
> +++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
> @@ -91,12 +91,10 @@
>  &dp {
>         pinctrl-names = "default";
>         pinctrl-0 = <&dp_hpd>;
> -       samsung,color-space = <0>;
> -       samsung,dynamic-range = <0>;
> -       samsung,ycbcr-coeff = <0>;
> -       samsung,color-depth = <1>;
> -       samsung,link-rate = <0x0a>;
> -       samsung,lane-count = <4>;
> +       analogix,color-space = <0>;
> +       analogix,color-depth = <1>;
> +       analogix,link-rate = <0x0a>;
> +       analogix,lane-count = <4>;
>         status = "okay";
>  };
>
> diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
> index 7d5b386..54b4c63 100644
> --- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
> +++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
> @@ -141,13 +141,11 @@
>         status = "okay";
>         pinctrl-names = "default";
>         pinctrl-0 = <&dp_hpd_gpio>;
> -       samsung,color-space = <0>;
> -       samsung,dynamic-range = <0>;
> -       samsung,ycbcr-coeff = <0>;
> -       samsung,color-depth = <1>;
> -       samsung,link-rate = <0x0a>;
> -       samsung,lane-count = <2>;
> -       samsung,hpd-gpio = <&gpx2 6 0>;
> +       analogix,color-space = <0>;
> +       analogix,color-depth = <1>;
> +       analogix,link-rate = <0x0a>;
> +       analogix,lane-count = <2>;
> +       analogix,hpd-gpio = <&gpx2 6 0>;
>         panel = <&panel>;
>  };
>
> --
> 1.9.1
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
