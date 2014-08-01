From: dianders@chromium.org (Doug Anderson)
Date: Fri, 1 Aug 2014 13:33:23 -0700
Subject: [PATCH v5 05/10] ARM: dts: Move dp_hpd from exynos5250 into
 smdk5250 and snow
In-Reply-To: <1406868897-26874-6-git-send-email-afaerber@suse.de>
References: <1406868897-26874-1-git-send-email-afaerber@suse.de>
 <1406868897-26874-6-git-send-email-afaerber@suse.de>
Message-ID: <CAD=FV=WhocoyQ=rU7dU1EPM-PAQq06gg9HhamSOm+BgMDeM8NA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andreas,

On Thu, Jul 31, 2014 at 9:54 PM, Andreas F?rber <afaerber@suse.de> wrote:
> Spring uses a different GPIO, so this is not a generic SoC piece.
>
> Suggested-by: Tomasz Figa <t.figa@samsung.com>
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  v5: New (Tomasz Figa)
>  Frees dp_hpd for Spring.
>
>  arch/arm/boot/dts/exynos5250-pinctrl.dtsi | 7 -------
>  arch/arm/boot/dts/exynos5250-smdk5250.dts | 9 +++++++++
>  arch/arm/boot/dts/exynos5250-snow.dts     | 7 +++++++
>  3 files changed, 16 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm/boot/dts/exynos5250-pinctrl.dtsi b/arch/arm/boot/dts/exynos5250-pinctrl.dtsi
> index 886cfca044ac..ed0e5230514b 100644
> --- a/arch/arm/boot/dts/exynos5250-pinctrl.dtsi
> +++ b/arch/arm/boot/dts/exynos5250-pinctrl.dtsi
> @@ -581,13 +581,6 @@
>                         samsung,pin-pud = <0>;
>                         samsung,pin-drv = <0>;
>                 };
> -
> -               dp_hpd: dp_hpd {
> -                       samsung,pins = "gpx0-7";
> -                       samsung,pin-function = <3>;
> -                       samsung,pin-pud = <0>;
> -                       samsung,pin-drv = <0>;
> -               };
>         };
>
>         pinctrl at 13400000 {
> diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
> index aaa055ac0fe3..5d30fe1dcda4 100644
> --- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
> +++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
> @@ -414,3 +414,12 @@
>                 };
>         };
>  };
> +
> +&pinctrl_0 {
> +       dp_hpd: dp_hpd {
> +               samsung,pins = "gpx0-7";
> +               samsung,pin-function = <3>;
> +               samsung,pin-pud = <0>;
> +               samsung,pin-drv = <0>;
> +       };
> +};
> diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
> index c4b0c73c736d..a9a2f2743794 100644
> --- a/arch/arm/boot/dts/exynos5250-snow.dts
> +++ b/arch/arm/boot/dts/exynos5250-snow.dts
> @@ -547,6 +547,13 @@
>  };
>
>  &pinctrl_0 {
> +       dp_hpd: dp_hpd {
> +               samsung,pins = "gpx0-7";
> +               samsung,pin-function = <3>;
> +               samsung,pin-pud = <0>;
> +               samsung,pin-drv = <0>;
> +       };
> +

NAK.  dp_hpd is a generic SoC piece.  Pin function 0 and 1 are GPIOs.
Pin function 3 is special function.  This pin _is_ the hot plug detect
pin for display port.  When it's set as special function 3 it goes
straight into the hot plug logic of the display port controller.

Spring may have had its reasons to detect hot plug events on a GPIO
instead of using this pin, but that doesn't make this pin any less the
"hot plug pin".

-Doug
