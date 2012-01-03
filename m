From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 3 Jan 2012 09:43:56 +0000
Subject: [PATCH] S3C: fix order of MACH_S3C* checks on GPIO count define
In-Reply-To: <1325164036-15638-1-git-send-email-dron0gus@gmail.com>
References: <1325164036-15638-1-git-send-email-dron0gus@gmail.com>
Message-ID: <20120103094356.GG2914@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 29, 2011 at 05:07:14PM +0400, Gusakov Andrey wrote:
> Differnt S3C24XX SoC have different number of GPIO. When building
> kernel for many S3C24XX SoCs GPIO number defined to minimun possible.
> This patch reordef ifdef's to define GPIO number to muximum possible.

This is error prome.  Please come up with a better solution to this.

> -#ifdef CONFIG_CPU_S3C244X
> -#define ARCH_NR_GPIOS	(32 * 9 + CONFIG_S3C24XX_GPIO_EXTRA)
> -#elif defined(CONFIG_CPU_S3C2443) || defined(CONFIG_CPU_S3C2416)
> +#if defined(CONFIG_CPU_S3C2443) || defined(CONFIG_CPU_S3C2416)
>  #define ARCH_NR_GPIOS	(32 * 12 + CONFIG_S3C24XX_GPIO_EXTRA)
> +#elif defined(CONFIG_CPU_S3C244X)
> +#define ARCH_NR_GPIOS	(32 * 9 + CONFIG_S3C24XX_GPIO_EXTRA)
>  #else
>  #define ARCH_NR_GPIOS	(256 + CONFIG_S3C24XX_GPIO_EXTRA)
>  #endif

Maybe something like:

#define S3C2443_NR_GPIOS	(32 * 12)
#define S3C2416_NR_GPIOS	(32 * 12)
#define S3C244X_NR_GPIOS	(32 * 9)

#define SAMSUNG_NR_GPIOS	(256)
#if defined (CONFIG_CPU_S3C244X) && S3C244X_NR_GPIOS > SAMSUNG_NR_GPIOS
#undef SAMSUNG_NR_GPIOS
#define SAMSUNG_NR_GPIOS	S3C244X_NR_GPIOS
#endif
#if defined (CONFIG_CPU_S3C2416) && S3C2416_NR_GPIOS > SAMSUNG_NR_GPIOS
#undef SAMSUNG_NR_GPIOS
#define SAMSUNG_NR_GPIOS	S3C2416_NR_GPIOS
#endif
#if defined (CONFIG_CPU_S3C2443) && S3C2443_NR_GPIOS > SAMSUNG_NR_GPIOS
#undef SAMSUNG_NR_GPIOS
#define SAMSUNG_NR_GPIOS	S3C2443_NR_GPIOS
#endif

#define ARCH_NR_GPIOS		(SAMSUNG_NR_GPIOS + CONFIG_S3C24XX_GPIO_EXTRA)

or maybe just solve this in Kconfig - we already have this:

config ARCH_NR_GPIO
        int
        default 1024 if ARCH_SHMOBILE || ARCH_TEGRA
        default 350 if ARCH_U8500
        default 0

to set ARCH_NR_GPIO in generic code.
