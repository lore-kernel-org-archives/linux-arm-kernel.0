From: augulis.darius@gmail.com (Darius Augulis)
Date: Thu, 17 Jun 2010 22:05:26 +0300
Subject: [PATCH 11/15] ARM: S3C2416: Add support for second HSMMC channel
In-Reply-To: <1273631766-15693-11-git-send-email-ben-linux@fluff.org>
References: <1273631766-15693-1-git-send-email-ben-linux@fluff.org>
	<1273631766-15693-11-git-send-email-ben-linux@fluff.org>
Message-ID: <4C1A71F6.5030203@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/12/2010 05:36 AM, Ben Dooks wrote:
> Add support for the second HSMMC channel on the S3C2416.

There is issue with mach-s3c2416 and sdhci-s3c driver.
Driver probe crashes with following backtrace:

sdhci: Secure Digital Host Controller Interface driver
sdhci: Copyright(c) Pierre Ossman
Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = c0004000
[00000000] *pgd=00000000
Internal error: Oops: 5 [#1]
last sysfs file:
CPU: 0    Not tainted  (2.6.35-rc3-00001-g7dfb002 #31)
PC is at sdhci_s3c_probe+0x188/0x42c
LR is at clk_enable+0x50/0x60

The reason is not completely initialised s3c_sdhci_platdata structure. 
When getting clocks in sdhci_s3c_probe():

for (clks = 0, ptr = 0; ptr < MAX_BUS_CLK; ptr++) {
                 struct clk *clk;
                 char *name = pdata->clocks[ptr];

Pointer clocks is not initialised at all, because mach-s3c2416 doesn't 
have such helpers like mach-s3c64xx does:

s3c6400_default_sdhci0()
s3c6400_default_sdhci1()
s3c6400_default_sdhci2()

Also other necessary s3c_sdhci_platdata members cfg_gpio and cfg_card 
are missing on s3c2416.

Is there any patch adding this missing info to mach-s3c2416?

>
> Signed-off-by: Ben Dooks<ben-linux@fluff.org>
> ---
>   arch/arm/mach-s3c2410/include/mach/irqs.h |    3 +++
>   arch/arm/mach-s3c2410/include/mach/map.h  |    5 +++--
>   arch/arm/mach-s3c2416/Kconfig             |    1 +
>   arch/arm/mach-s3c2416/mach-smdk2416.c     |    1 +
>   4 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-s3c2410/include/mach/irqs.h b/arch/arm/mach-s3c2410/include/mach/irqs.h
> index c1b8ec0..877c15e 100644
> --- a/arch/arm/mach-s3c2410/include/mach/irqs.h
> +++ b/arch/arm/mach-s3c2410/include/mach/irqs.h
> @@ -150,7 +150,10 @@
>   #define IRQ_S3C2443_HSMMC	S3C2410_IRQ(20)		/* IRQ_SDI */
>   #define IRQ_S3C2443_NAND	S3C2410_IRQ(24)		/* reserved */
>
> +#define IRQ_S3C2416_HSMMC0	S3C2410_IRQ(21)		/* S3C2416/S3C2450 */
> +
>   #define IRQ_HSMMC0		IRQ_S3C2443_HSMMC
> +#define IRQ_HSMMC1		IRQ_S3C2416_HSMMC0
>
>   #define IRQ_S3C2443_LCD1	S3C2410_IRQSUB(14)
>   #define IRQ_S3C2443_LCD2	S3C2410_IRQSUB(15)
> diff --git a/arch/arm/mach-s3c2410/include/mach/map.h b/arch/arm/mach-s3c2410/include/mach/map.h
> index b049e61..f07d680 100644
> --- a/arch/arm/mach-s3c2410/include/mach/map.h
> +++ b/arch/arm/mach-s3c2410/include/mach/map.h
> @@ -63,9 +63,9 @@
>   #define S3C2440_PA_AC97	   (0x5B000000)
>   #define S3C2440_SZ_AC97	   SZ_1M
>
> -/* S3C2443 High-speed SD/MMC */
> +/* S3C2443/S3C2416 High-speed SD/MMC */
>   #define S3C2443_PA_HSMMC   (0x4A800000)
> -#define S3C2443_SZ_HSMMC   (256)
> +#define S3C2416_PA_HSMMC0  (0x4AC00000)
>
>   /* S3C2412 memory and IO controls */
>   #define S3C2412_PA_SSMC	(0x4F000000)
> @@ -110,6 +110,7 @@
>   #define S3C_PA_UART	    S3C24XX_PA_UART
>   #define S3C_PA_USBHOST	S3C2410_PA_USBHOST
>   #define S3C_PA_HSMMC0	    S3C2443_PA_HSMMC
> +#define S3C_PA_HSMMC1	    S3C2416_PA_HSMMC0
>   #define S3C_PA_NAND	    S3C24XX_PA_NAND
>
>   #endif /* __ASM_ARCH_MAP_H */
> diff --git a/arch/arm/mach-s3c2416/Kconfig b/arch/arm/mach-s3c2416/Kconfig
> index 677f963..a1308d4 100644
> --- a/arch/arm/mach-s3c2416/Kconfig
> +++ b/arch/arm/mach-s3c2416/Kconfig
> @@ -27,6 +27,7 @@ config MACH_SMDK2416
>   	bool "SMDK2416"
>   	select CPU_S3C2416
>   	select S3C_DEV_HSMMC
> +	select S3C_DEV_HSMMC1
>   	help
>   	  Say Y here if you are using an SMDK2416
>
> diff --git a/arch/arm/mach-s3c2416/mach-smdk2416.c b/arch/arm/mach-s3c2416/mach-smdk2416.c
> index 8c9aed6..a51973c 100644
> --- a/arch/arm/mach-s3c2416/mach-smdk2416.c
> +++ b/arch/arm/mach-s3c2416/mach-smdk2416.c
> @@ -112,6 +112,7 @@ static struct platform_device *smdk2416_devices[] __initdata = {
>   	&s3c_device_wdt,
>   	&s3c_device_i2c0,
>   	&s3c_device_hsmmc0,
> +	&s3c_device_hsmmc1,
>   };
>
>   static void __init smdk2416_map_io(void)
