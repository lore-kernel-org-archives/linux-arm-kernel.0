From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 16 Jul 2014 12:48:48 +0200
Subject: [RESEND PATCH v2] ARM: exynos4: hotplug: Fix CPU idle clock down
 after CPU off
In-Reply-To: <1405499003-9975-1-git-send-email-k.kozlowski@samsung.com>
References: <1405499003-9975-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <53C65890.8000500@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

Please see my comment below.

On 16.07.2014 10:23, Krzysztof Kozlowski wrote:
> On Exynos4 USE_DELAYED_RESET_ASSERTION must be set in
> ARM_COREx_OPTION register during CPU power down. This is the proper way
> of powering down CPU on Exynos4.
> 
> Additionally on Exynos4212 without this the CPU clock down feature won't
> work after powering down some CPU and the online CPUs will work at full
> frequency chosen by CPUfreq governor.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

[snip]

> @@ -36,6 +36,14 @@ static inline void cpu_leave_lowpower(void)
>  	  : "=&r" (v)
>  	  : "Ir" (CR_C), "Ir" (0x40)
>  	  : "cc");
> +
> +	if (soc_is_exynos4()) {
> +		unsigned int tmp;
> +
> +		tmp = __raw_readl(EXYNOS_ARM_CORE_OPTION(core_id));
> +		tmp &= ~(S5P_USE_DELAYED_RESET_ASSERTION);
> +		__raw_writel(tmp, EXYNOS_ARM_CORE_OPTION(core_id));
> +	}

This code is executed only if the CPU doesn't manage to power off before
already receiving a wake-up event. Otherwise the context is lost after
wfi(), as the core power is being cut down.

The normal wake-up path goes through platsmp's exynos_boot_secondary()
and I believe that setting of S5P_USE_DELAYED_RESET_ASSERTION should be
taken care there as well.

Best regards,
Tomasz
