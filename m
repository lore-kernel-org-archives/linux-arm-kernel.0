From: padma.kvr@gmail.com (padma venkat)
Date: Wed, 23 May 2012 15:20:17 +0530
Subject: [PATCH 6/6] ARM: dts: Add nodes for spi controllers for Samsung
 Exynos5 platforms
In-Reply-To: <1337334392-6441-7-git-send-email-thomas.abraham@linaro.org>
References: <1337334392-6441-1-git-send-email-thomas.abraham@linaro.org>
 <1337334392-6441-7-git-send-email-thomas.abraham@linaro.org>
Message-ID: <CAAgF-BfftSDEFrskY2X6G76hETJfh=0hynmVnz2my+b9phf_5Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Fri, May 18, 2012 at 3:16 PM, Thomas Abraham
<thomas.abraham@linaro.org>wrote:

> Add device nodes for the three instances of spi controllers in Exynos5
> platforms and enable instance spi 1 for smdk5250 board.
>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> ---
>  arch/arm/boot/dts/exynos5250-smdk5250.dts |   47
> ++++++++++++++++++++++++++++-
>  arch/arm/boot/dts/exynos5250.dtsi         |   46
> ++++++++++++++++++++++++++++
>  2 files changed, 92 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts
> b/arch/arm/boot/dts/exynos5250-smdk5250.dts
> index 49945cc..dca572d 100644
> --- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
> +++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
> @@ -16,12 +16,18 @@
>        model = "SAMSUNG SMDK5250 board based on EXYNOS5250";
>        compatible = "samsung,smdk5250", "samsung,exynos5250";
>
> +       aliases {
> +               spi0 = &spi_0;
> +               spi1 = &spi_1;
> +               spi2 = &spi_2;
> +       };
> +
>        memory {
>                reg = <0x40000000 0x80000000>;
>        };
>
>        chosen {
> -               bootargs = "root=/dev/ram0 rw ramdisk=8192
> console=ttySAC1,115200";
> +               bootargs ="root=/dev/ram0 rw ramdisk=8192
> initrd=0x41000000,8M console=ttySAC2,115200 init=/linuxrc";
>        };
>
>        i2c at 12C60000 {
> @@ -48,6 +54,45 @@
>                };
>        };
>
> +
> +       spi_1: spi at 12d30000 {
> +               gpios = <&gpa2 4 2 3 0>,
> +                       <&gpa2 6 2 3 0>,
> +                       <&gpa2 7 2 3 0>;
> +
> +               w25q80bw at 0 {
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       compatible = "w25x80";
> +                       reg = <0>;
> +                       spi-max-frequency = <10000>;
> +
> +                       controller-data {
> +                               cs-gpio = <&gpa2 5 1 0 3>;
> +                               samsung,spi-feedback-delay = <0>;
> +                       };
> +
> +                       partition at 0 {
> +                               label = "U-Boot";
> +                               reg = <0x0 0x40000>;
> +                               read-only;
> +                       };
> +
> +                       partition at 40000 {
> +                               label = "Kernel";
> +                               reg = <0x40000 0xc0000>;
> +                       };
> +               };
> +       };
> +
> +       spi_0: spi at 12d20000 {
> +               status = "disabled";
> +       };
> +
> +       spi_2: spi at 12d40000 {
> +               status = "disabled";
> +       };
> +
>        i2c at 12C80000 {
>                status = "disabled";
>        };
> diff --git a/arch/arm/boot/dts/exynos5250.dtsi
> b/arch/arm/boot/dts/exynos5250.dtsi
> index 5ca0cdb..9d7add0 100644
> --- a/arch/arm/boot/dts/exynos5250.dtsi
> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> @@ -30,6 +30,22 @@
>                reg = <0x10481000 0x1000>, <0x10482000 0x2000>;
>        };
>
> +       combiner:interrupt-controller at 10440000 {
> +               compatible = "samsung,exynos4210-combiner";
> +               #interrupt-cells = <2>;
> +               interrupt-controller;
> +               samsung,combiner-nr = <32>;
> +               reg = <0x10440000 0x1000>;
> +               interrupts = <0 0 0>, <0 1 0>, <0 2 0>, <0 3 0>,
> +                            <0 4 0>, <0 5 0>, <0 6 0>, <0 7 0>,
> +                            <0 8 0>, <0 9 0>, <0 10 0>, <0 11 0>,
> +                            <0 12 0>, <0 13 0>, <0 14 0>, <0 15 0>,
> +                            <0 16 0>, <0 17 0>, <0 18 0>, <0 19 0>,
> +                            <0 20 0>, <0 21 0>, <0 22 0>, <0 23 0>,
> +                            <0 24 0>, <0 25 0>, <0 26 0>, <0 27 0>,
> +                            <0 28 0>, <0 29 0>, <0 30 0>, <0 31 0>;
> +       };
> +
>
The combiner interrupt controller support is already present in the
following patch.
         ARM: Exynos5: Add combiner, wakeup interrupt controller and
ethernet nodes
This code can be removed from this patch.
Thanks&Regards
Padma

>        watchdog {
>                compatible = "samsung,s3c2410-wdt";
>                reg = <0x101D0000 0x100>;
> @@ -130,6 +146,36 @@
>                #size-cells = <0>;
>        };
>
> +       spi_0: spi at 12d20000 {
> +               compatible = "samsung,exynos4210-spi";
> +               reg = <0x12d20000 0x100>;
> +               interrupts = <0 66 0>;
> +               tx-dma-channel = <&pdma0 5>;
> +               rx-dma-channel = <&pdma0 4>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +       };
> +
> +       spi_1: spi at 12d30000 {
> +               compatible = "samsung,exynos4210-spi";
> +               reg = <0x12d30000 0x100>;
> +               interrupts = <0 67 0>;
> +               tx-dma-channel = <&pdma1 5>;
> +               rx-dma-channel = <&pdma1 4>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +       };
> +
> +       spi_2: spi at 12d40000 {
> +               compatible = "samsung,exynos4210-spi";
> +               reg = <0x12d40000 0x100>;
> +               interrupts = <0 68 0>;
> +               tx-dma-channel = <&pdma0 7>;
> +               rx-dma-channel = <&pdma0 6>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +       };
> +
>        amba {
>                #address-cells = <1>;
>                #size-cells = <1>;
> --
> 1.6.6.rc2
>
> --
> To unsubscribe from this list: send the line "unsubscribe
> linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120523/bacf21af/attachment-0001.html>
