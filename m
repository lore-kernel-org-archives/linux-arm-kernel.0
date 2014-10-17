From: davidriley@google.com (David Riley)
Date: Fri, 17 Oct 2014 10:43:56 -0700
Subject: [PATCH 06/12] ARM: tegra: Add memory controller support for
 Tegra20
In-Reply-To: <1413196434-5292-6-git-send-email-thierry.reding@gmail.com>
References: <1413196434-5292-1-git-send-email-thierry.reding@gmail.com>
 <1413196434-5292-6-git-send-email-thierry.reding@gmail.com>
Message-ID: <CAASgrz3Z2vW0L+u5kju9bAh-R4PnreMnhoGaKY_UwSTGFcBshA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thierry,

On Mon, Oct 13, 2014 at 3:33 AM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> From: Thierry Reding <treding@nvidia.com>
>
> Collapses the old memory-controller and IOMMU device tree nodes into a
> single node to more accurately describe the hardware.
>
> Note that this is an incompatible change, but while a GART driver has
> existed for a few years it has never been used to do any translations.
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  arch/arm/boot/dts/tegra20.dtsi | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
> index 3b374c49d04d..a195c1975f3c 100644
> --- a/arch/arm/boot/dts/tegra20.dtsi
> +++ b/arch/arm/boot/dts/tegra20.dtsi
> @@ -538,15 +538,14 @@
>
>         memory-controller at 7000f000 {
>                 compatible = "nvidia,tegra20-mc";
> -               reg = <0x7000f000 0x024
> -                      0x7000f03c 0x3c4>;
> +               reg = <0x7000f000 0x00000400   /* controller registers */
> +                      0x58000000 0x02000000>; /* GART aperture */

Aren't these bindings supposed to be stable?  The tegra20-mc driver
isn't modified.

> +               clocks = <&tegra_car TEGRA20_CLK_MC>;
> +               clock-names = "mc";
> +
>                 interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
> -       };
>
> -       iommu at 7000f024 {
> -               compatible = "nvidia,tegra20-gart";
> -               reg = <0x7000f024 0x00000018    /* controller registers */
> -                      0x58000000 0x02000000>;  /* GART aperture */
> +               #iommu-cells = <1>;
>         };
>
>         memory-controller at 7000f400 {
> --
> 2.1.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Dave
