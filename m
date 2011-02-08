From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 8 Feb 2011 14:10:49 +0530
Subject: [PATCH] ARM: Define wfi(), wfe(),
	sev() macros for pre-v7 processors
In-Reply-To: <1296829243-21313-1-git-send-email-dave.martin@linaro.org>
References: <1296829243-21313-1-git-send-email-dave.martin@linaro.org>
Message-ID: <b462b6fdb4265f13d0cd87d13df3c530@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dave,
> -----Original Message-----
> From: Dave Martin [mailto:dave.martin at linaro.org]
> Sent: Friday, February 04, 2011 7:51 PM
> To: linux-arm-kernel at lists.infradead.org
> Cc: Dave Martin; Tony Lindgren; Santosh Shilimkar; Jean Pihet;
> linux-omap at vger.kernel.org; Nicolas Pitre; Russell King
> Subject: [PATCH] ARM: Define wfi(), wfe(), sev() macros for pre-v7
> processors
>
> Pre-v7 processors don't have wfe/sev, so these are defined for
> consistency as empty barrier asms.
>
> For v6, wfi is architected as a defined MCR instruction, so
> use that definition.
>
> Doing a no-op instead of wfi() is probably bad, so for older
> processors than v6, wfi() is not defined.  If needed, some CPU-
> specific wfi() will have to be defined elsewhere.
>
> Signed-off-by: Dave Martin <dave.martin@linaro.org>
> ---
>  arch/arm/include/asm/system.h |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/include/asm/system.h
> b/arch/arm/include/asm/system.h
> index 97f6d60..0e1cae3 100644
> --- a/arch/arm/include/asm/system.h
> +++ b/arch/arm/include/asm/system.h
> @@ -129,7 +129,14 @@ extern unsigned int user_debug;
>  #define sev()	__asm__ __volatile__ ("sev" : : : "memory")
>  #define wfe()	__asm__ __volatile__ ("wfe" : : : "memory")
>  #define wfi()	__asm__ __volatile__ ("wfi" : : : "memory")
> +#else /* __LINUX_ARM_ARCH__ < 7 */
> +#define sev()	__asm__ __volatile__ ("" : : : "memory")
> +#define wfe()	__asm__ __volatile__ ("" : : : "memory")
This is not true for "CPU_32v6K" extensions, right. I think they do
support 'sev' and 'wfe' instructions.


> +#if __LINUX_ARM_ARCH__ == 6
> +#define wfi()	__asm__ __volatile__ ("mcr p15, 0, %0, c7, c5, 4"
> \
> +					: : "r" (0) : "memory")
>  #endif
> +#endif /* __LINUX_ARM_ARCH__ < 7 */
>
>  #if __LINUX_ARM_ARCH__ >= 7
>  #define isb() __asm__ __volatile__ ("isb" : : : "memory")
> --
> 1.7.1
