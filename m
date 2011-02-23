From: kmpark@infradead.org (Kyungmin Park)
Date: Wed, 23 Feb 2011 16:47:46 +0900
Subject: [PATCH] ARM: EXYNOS4: Fix wrong constants in the hotplug assembly
	code.
In-Reply-To: <1298444621-3739-1-git-send-email-kgene.kim@samsung.com>
References: <1298444621-3739-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <AANLkTinpjGwd+pFr1oKQb1jiaih2h81Wp9G7Df8J1LLk@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

At that time Russell modified the s5cv310, tegra, and realview also. I
think you also modify it.

Thank you,
Kyungmin Park

On Wed, Feb 23, 2011 at 4:03 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> This patch fixes wrong constants in the hotplug assembly code for
> Exynos4 such as Russell's changing in vexpress hotplug and fixes
> hard-coded control register constatns also.
>
> Reported-by: Changhwan Youn <chaos.youn@samsung.com>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
> ?arch/arm/mach-exynos4/hotplug.c | ? ?8 ++++----
> ?1 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-exynos4/hotplug.c b/arch/arm/mach-exynos4/hotplug.c
> index 4c42f9c..2b5909e 100644
> --- a/arch/arm/mach-exynos4/hotplug.c
> +++ b/arch/arm/mach-exynos4/hotplug.c
> @@ -30,13 +30,13 @@ static inline void cpu_enter_lowpower(void)
> ? ? ? ? * Turn off coherency
> ? ? ? ? */
> ? ? ? ?" ? ? ? mrc ? ? p15, 0, %0, c1, c0, 1\n"
> - ? ? ? " ? ? ? bic ? ? %0, %0, #0x20\n"
> + ? ? ? " ? ? ? bic ? ? %0, %0, %3\n"
> ? ? ? ?" ? ? ? mcr ? ? p15, 0, %0, c1, c0, 1\n"
> ? ? ? ?" ? ? ? mrc ? ? p15, 0, %0, c1, c0, 0\n"
> ? ? ? ?" ? ? ? bic ? ? %0, %0, %2\n"
> ? ? ? ?" ? ? ? mcr ? ? p15, 0, %0, c1, c0, 0\n"
> ? ? ? ? ?: "=&r" (v)
> - ? ? ? ? : "r" (0), "Ir" (CR_C)
> + ? ? ? ? : "r" (0), "Ir" (CR_C), "Ir" (0x40)
> ? ? ? ? ?: "cc");
> ?}
>
> @@ -49,10 +49,10 @@ static inline void cpu_leave_lowpower(void)
> ? ? ? ?" ? ? ? orr ? ? %0, %0, %1\n"
> ? ? ? ?" ? ? ? mcr ? ? p15, 0, %0, c1, c0, 0\n"
> ? ? ? ?" ? ? ? mrc ? ? p15, 0, %0, c1, c0, 1\n"
> - ? ? ? " ? ? ? orr ? ? %0, %0, #0x20\n"
> + ? ? ? " ? ? ? orr ? ? %0, %0, %2\n"
> ? ? ? ?" ? ? ? mcr ? ? p15, 0, %0, c1, c0, 1\n"
> ? ? ? ? ?: "=&r" (v)
> - ? ? ? ? : "Ir" (CR_C)
> + ? ? ? ? : "Ir" (CR_C), "Ir" (0x40)
> ? ? ? ? ?: "cc");
> ?}
>
> --
> 1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
