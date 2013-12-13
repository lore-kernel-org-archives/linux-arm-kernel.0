From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Fri, 13 Dec 2013 14:57:08 +0300
Subject: [PATCH CFT] ARM:S3C24XX: Enable ARM_PATCH_PHYS_VIRT and
 AUTO_ZRELADDR by default
In-Reply-To: <1386934105-23392-1-git-send-email-panchaxari.prasannamurthy@linaro.org>
References: <1386934105-23392-1-git-send-email-panchaxari.prasannamurthy@linaro.org>
Message-ID: <CA+E=qVcZVpWTYfL_MYbn-ue3V4LTcEowx2Fnzj7fdm7_YbB5dA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 13, 2013 at 2:28 PM, panchaxari
<panchaxari.prasannamurthy@linaro.org> wrote:
> Configs ARM_PATCH_PHYS_VIRT and AUTO_ZRELADDR are enabled as default
> to platform S3C24XX.
>
> Introduction of PHYS_VIRT config as default would enable phy-to-virt and
> virt-to-phy translation function at boot and module loading time
> and enforce dynamic reallocation of memory. AUTO_ZRELADDR config would
> enable calculation of kernel load address at run time.
>
> PHYS_VIRT config is mutually exclusive to XIP_KERNEL, XIP_KERNEL is used in
> systems with NOR flash devices, and ZRELADDR config is mutually exclusive
> to ZBOOT_ROM.
>
> CFT::Call For Testing
>
> Requesting maintainers of S3C24XX  platforms to evaluate the changes on the
> board and comment, as I dont have the board for testing and also requesting
> an ACK the changes.

Hi,

I guess AUTO_ZRELADDR will break S2RAM on h1940/rx1950 and rx3715
machines. Those machines require reservation of 4k at 0x30003000 and
4k at 0x30081000, because bootloader
will corrupt these areas on resume. See .reserve callback in
arch/arm/mach-s3c24xx/mach-{h1940,rx1950,rx3715}

Regards
Vasily

>
> Signed-off-by: panchaxari <panchaxari.prasannamurthy@linaro.org>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Ben Dooks <ben-linux@fluff.org>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-samsung-soc at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org
>
> ---
> S3C24XX is basically a Samsung SOC with ARM920T instruction set, and has
> an operating frquency of 203MHz, it also has enhanced MMU architecture
> to support WinCE, EPOC 32 and Linux.
>
> This SOC is an Integrated system for hand-held devices and general
> embedded systems.
>
> Supports various types of ROM for booting (NOR/NAND Flash, EEPROM, and others).
> Supports 8 memory banks, 128M for each bank, with a total of 1GB.
> ---
>  arch/arm/Kconfig |    2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 32acacb..ec1faea 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -708,6 +708,8 @@ config ARCH_S3C24XX
>         bool "Samsung S3C24XX SoCs"
>         select ARCH_HAS_CPUFREQ
>         select ARCH_REQUIRE_GPIOLIB
> +       select ARM_PATCH_PHYS_VIRT
> +       select AUTO_ZRELADDR
>         select CLKDEV_LOOKUP
>         select CLKSRC_SAMSUNG_PWM
>         select GENERIC_CLOCKEVENTS
> --
> 1.7.10.4
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
