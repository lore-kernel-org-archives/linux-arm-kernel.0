From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 29 Jan 2013 13:46:05 +0530
Subject: [PATCH 5/5] ARM: SPEAr13xx: Pass generic DW DMAC platform data
 from DT
In-Reply-To: <1359410300-26113-6-git-send-email-arnd@arndb.de>
References: <1359395857-1235-1-git-send-email-arnd@arndb.de>
 <1359410300-26113-1-git-send-email-arnd@arndb.de>
 <1359410300-26113-6-git-send-email-arnd@arndb.de>
Message-ID: <CAKohpokrvYDaMgB-5HV+bJh01YNU4H5UrSUnzxa_NpvE1qQqiA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

You forgot spear-devel for this series.

On 29 January 2013 03:28, Arnd Bergmann <arnd@arndb.de> wrote:
> This replaces an earlier patch from Viresh Kumar to move
> the spear platform over to the generic DMA binding. This
> version is now based on the merged multiplatform capable
> spear platform, rather than the separate spear13xx/3xx/6xx
> directories.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Vinod Koul <vinod.koul@linux.intel.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: devicetree-discuss at lists.ozlabs.org
> ---
>  arch/arm/boot/dts/spear1340.dtsi         |   3 +
>  arch/arm/boot/dts/spear13xx.dtsi         |  25 +++++-
>  arch/arm/mach-spear/generic.h            |   6 --
>  arch/arm/mach-spear/include/mach/spear.h |   2 -
>  arch/arm/mach-spear/spear1310.c          |  30 +-------
>  arch/arm/mach-spear/spear1340.c          |  32 +-------
>  arch/arm/mach-spear/spear13xx-dma.h      | 128 -------------------------------
>  arch/arm/mach-spear/spear13xx.c          |  58 --------------
>  8 files changed, 29 insertions(+), 255 deletions(-)
>  delete mode 100644 arch/arm/mach-spear/spear13xx-dma.h
>
> diff --git a/arch/arm/boot/dts/spear1340.dtsi b/arch/arm/boot/dts/spear1340.dtsi
> index 34da11a..e1786a0 100644
> --- a/arch/arm/boot/dts/spear1340.dtsi
> +++ b/arch/arm/boot/dts/spear1340.dtsi
> @@ -113,6 +113,9 @@
>                                 reg = <0xb4100000 0x1000>;
>                                 interrupts = <0 105 0x4>;
>                                 status = "disabled";
> +                               dmas = <&dwdma0 0x600 0 0 1>, /* 0xC << 11 */
> +                                       <&dwdma0 0x680 0 1 0>; /* 0xD << 7 */
> +                               dma-names = "tx", "rx";
>                         };
>
>                         thermal at e07008c4 {
> diff --git a/arch/arm/boot/dts/spear13xx.dtsi b/arch/arm/boot/dts/spear13xx.dtsi
> index b4ca60f..45597fd 100644
> --- a/arch/arm/boot/dts/spear13xx.dtsi
> +++ b/arch/arm/boot/dts/spear13xx.dtsi
> @@ -98,13 +98,24 @@
>                         reg = <0xb2800000 0x1000>;
>                         interrupts = <0 29 0x4>;
>                         status = "disabled";
> +                       dmas = <&dwdma0 0 0 0 0>;
> +                       dma-names = "data";
>                 };
>
> -               dma at ea800000 {
> +               dwdma0: dma at ea800000 {
>                         compatible = "snps,dma-spear1340";
>                         reg = <0xea800000 0x1000>;
>                         interrupts = <0 19 0x4>;
>                         status = "disabled";
> +
> +                       dma-channels = <8>;
> +                       #dma-cells = <3>;

4?
