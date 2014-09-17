From: dianders@chromium.org (Doug Anderson)
Date: Wed, 17 Sep 2014 08:47:54 -0700
Subject: [PATCH 2/2] ARM: dts: Add rtc_src clk for s3c-rtc on
 exynos5250-snow
In-Reply-To: <1410954633-27025-3-git-send-email-javier.martinez@collabora.co.uk>
References: <1410954633-27025-1-git-send-email-javier.martinez@collabora.co.uk>
 <1410954633-27025-3-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <CAD=FV=W7xJ01m2oLtuDnogOmrpwpztbir=59oSWU6oojFYUWKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Sep 17, 2014 at 4:50 AM, Javier Martinez Canillas
<javier.martinez@collabora.co.uk> wrote:
> commit 546b117fdf17 ("rtc: s3c: add support for RTC of Exynos3250 SoC")
> added an "rtc_src" DT property for the Samsung's S3C Real Time Clock
> controller that specifies the 32.768 kHz clock that uses the RTC as its
> source clock. In the case of the Exynos5250 based Snow board, the Maxim
> 77686 32kHz AP clock is used as the source clock.
>
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> ---
>  arch/arm/boot/dts/exynos5250-snow.dts | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
> index e51fcef..56eec56 100644
> --- a/arch/arm/boot/dts/exynos5250-snow.dts
> +++ b/arch/arm/boot/dts/exynos5250-snow.dts
> @@ -10,6 +10,7 @@
>
>  /dts-v1/;
>  #include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/clock/maxim,max77686.h>
>  #include "exynos5250.dtsi"
>
>  / {
> @@ -29,6 +30,8 @@
>
>         rtc at 101E0000 {
>                 status = "okay";
> +               clocks = <&clock CLK_RTC>, <&max77686 MAX77686_CLK_AP>;
> +               clock-names = "rtc", "rtc_src";

Wait, seriously?  Snow is still using the "rtc at 101E0000" syntax?
Whatever happened to the series that Andreas worked so hard on,
including <https://patchwork.kernel.org/patch/4664801/>?

Kukjin: Andreas's patch series was Reviewed long ago I think and by
now I'd imagine it's got some conflicts due to it not having been
applied in a timely fashion.  Perhaps you could fix it up for Andreas
(since he's already rebased it several times) and land it?

If I had to guess, outstanding from Andreas's series (patchwork IDs listed):

4751131 New          [v7] ARM: dts: Prepare node labels for exynos5250
4664801 New          [v6,04/10] ARM: dts: Clean up exynos5250-snow
4664771 New          [v6,05/10] ARM: dts: Fill in bootargs for exynos5250-snow
4664731 New          [v6,06/10] ARM: dts: Clean up exynos5250-smdk5250
4664751 New          [v6,07/10] ARM: dts: Clean up exynos5250-arndale
4664711 New          [v6,08/10] ARM: dts: Fix apparent GPIO typo in
exynos5250-arndale
4664681 New          [v6,09/10] ARM: dts: Simplify USB3503 on exynos5250-arndale
4664691 New          [v6,10/10] ARM: dts: Add exynos5250-spring device tree


>         };
>
>         pinctrl at 11400000 {
> @@ -350,7 +353,7 @@
>         samsung,i2c-sda-delay = <100>;
>         samsung,i2c-max-bus-freq = <378000>;
>
> -       max77686 at 09 {
> +       max77686: max77686 at 09 {
>                 compatible = "maxim,max77686";
>                 interrupt-parent = <&gpx3>;
>                 interrupts = <2 0>;

In any case, there's nothing wrong with Javier's patch other than the
fact that it will eventually need to get merged with Andreas's, so:

Reviewed-by: Doug Anderson <dianders@chromium.org>
