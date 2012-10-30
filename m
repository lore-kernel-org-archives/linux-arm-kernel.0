From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 30 Oct 2012 14:29:46 -0600
Subject: [PATCH V3 0/4] ARM: tegra: Enable SLINK controller driver
In-Reply-To: <1351580726-17350-1-git-send-email-ldewangan@nvidia.com>
References: <1351580726-17350-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <509038BA.30600@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/30/2012 01:05 AM, Laxman Dewangan wrote:
> This series modify the dts file to add the slink addresses,
> make AUXDATA in board dt files, enable slink4 for tegra30-cardhu and 
> enable slink controller defconfig.

This series only instantiates the SPI controller, and not any SPI
devices. I tried to solve this:

> diff --git a/arch/arm/boot/dts/tegra30-cardhu.dtsi b/arch/arm/boot/dts/tegra30-cardhu.dtsi
> index 700f0a3..3689853 100644
> --- a/arch/arm/boot/dts/tegra30-cardhu.dtsi
> +++ b/arch/arm/boot/dts/tegra30-cardhu.dtsi
> @@ -278,6 +278,11 @@
>         spi at 7000da00 {
>                 status = "okay";
>                 spi-max-frequency = <25000000>;
> +               flash at 0 {
> +                       reg = <0>;
> +                       compatible = "atmel,at25df321a";
> +                       spi-max-frequency = <25000000>;
> +               };
>         };
>  
>         ahub {

However, this didn't work. Has the driver been tested? I'm seeing the
exact same problems I saw with the old driver, namely that the SPI flash
chip can't be identified; I think the ID bytes are read back as 0, and
hence drivers/mtd/devices/m25p80.c falls back to identifying the device
as mr25h256. Attempting to hexdump -C /dev/mtd0 gives me 32K of zeros,
whereas the device is 4M and full of non-zero data according to U-Boot.

Do you know what the problem is here? Can you please update the patch
series so that the SPI flash is instantiated and works correctly?
