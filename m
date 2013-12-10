From: dianders@chromium.org (Doug Anderson)
Date: Mon, 9 Dec 2013 16:57:01 -0800
Subject: [PATCH 1/3] ARM: dts: Leave Exynos5250 SPI controller disabled by
 default
In-Reply-To: <1385381710-5212-1-git-send-email-broonie@kernel.org>
References: <1385381710-5212-1-git-send-email-broonie@kernel.org>
Message-ID: <CAD=FV=XEKUFWEM-30Bx0pVBOT8X0zXsdHyzq=pDY8TOcdGHgRg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Nov 25, 2013 at 4:15 AM, Mark Brown <broonie@kernel.org> wrote:
> From: Mark Brown <broonie@linaro.org>
>
> Rather than requiring each board to explicitly disable the SPI controllers
> it is not using instead require boards to enable those that they are using.
> This is less work overall since normally at most one of the controllers is
> in use and avoids issues caused by inappropriate pinmuxing.
>
> Signed-off-by: Mark Brown <broonie@linaro.org>
> Acked-by: Tomasz Figa <t.figa@samsung.com>
> ---
>  arch/arm/boot/dts/cros5250-common.dtsi    |  9 +--------
>  arch/arm/boot/dts/exynos5250-arndale.dts  | 12 ------------
>  arch/arm/boot/dts/exynos5250-smdk5250.dts |  6 ++----
>  arch/arm/boot/dts/exynos5250.dtsi         |  3 +++
>  4 files changed, 6 insertions(+), 24 deletions(-)
>
> diff --git a/arch/arm/boot/dts/cros5250-common.dtsi b/arch/arm/boot/dts/cros5250-common.dtsi
> index dc259e8b8a73..0fcca2930c61 100644
> --- a/arch/arm/boot/dts/cros5250-common.dtsi
> +++ b/arch/arm/boot/dts/cros5250-common.dtsi
> @@ -286,19 +286,12 @@
>                 };
>         };
>
> -       spi_0: spi at 12d20000 {
> -               status = "disabled";
> -       };
> -
>         spi_1: spi at 12d30000 {
> +               status = "okay";
>                 samsung,spi-src-clk = <0>;
>                 num-cs = <1>;
>         };
>
> -       spi_2: spi at 12d40000 {
> -               status = "disabled";
> -       };
> -
>         hdmi {
>                 hpd-gpio = <&gpx3 7 0>;
>         };
> diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
> index 684527087aa4..0385b58116ec 100644
> --- a/arch/arm/boot/dts/exynos5250-arndale.dts
> +++ b/arch/arm/boot/dts/exynos5250-arndale.dts
> @@ -434,18 +434,6 @@
>                 status = "okay";
>         };
>
> -       spi_0: spi at 12d20000 {
> -               status = "disabled";
> -       };
> -
> -       spi_1: spi at 12d30000 {
> -               status = "disabled";
> -       };
> -
> -       spi_2: spi at 12d40000 {
> -               status = "disabled";
> -       };
> -
>         gpio_keys {
>                 compatible = "gpio-keys";
>
> diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
> index f86d56760a45..5d0395e07eee 100644
> --- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
> +++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
> @@ -189,6 +189,8 @@
>         };
>
>         spi_1: spi at 12d30000 {
> +               status = "okay";
> +
>                 w25q80bw at 0 {
>                         #address-cells = <1>;
>                         #size-cells = <1>;
> @@ -214,10 +216,6 @@
>                 };
>         };
>
> -       spi_2: spi at 12d40000 {
> -               status = "disabled";
> -       };
> -
>         hdmi {
>                 hpd-gpio = <&gpx3 7 0>;
>         };

I'm a little surprised that I don't see removal of spi_0 on SMDK5250.
When I apply your patch to ToT Linux I still see this in
"exynos5250-smdk5250.dts":

        spi_0: spi at 12d20000 {
                status = "disabled";
        };

Other than that things look good to me and you can add my Reviewed-by:

Reviewed-by: Doug Anderson <dianders@chromium.org>


-Doug
