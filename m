From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Fri, 30 May 2014 13:45:37 +0200
Subject: [PATCH] ARM: EXYNOS: SWRESET is needed to boot secondary CPU
 on Exynos3250
In-Reply-To: <1400152691-29705-1-git-send-email-k.kozlowski@samsung.com>
References: <1400152691-29705-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <53886F61.7070900@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

On 15.05.2014 13:18, Krzysztof Kozlowski wrote:
> Without software reset the secondary CPU does not power up and
> exynos_boot_secondary() ends with pen_release equal to 1. This can be
> observed in dmesg:
> 	CPU1: failed to come online
> 	Brought up 1 CPUs
> 	SMP: Total of 1 processors activated.
> 	CPU: All CPU(s) started in SVC mode.
> 
> When booting the secondary CPU on Exynos3250 execute also software
> reset for core 1.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  arch/arm/mach-exynos/platsmp.c  | 22 ++++++++++++++++++++++
>  arch/arm/mach-exynos/regs-pmu.h |  3 +++
>  2 files changed, 25 insertions(+)
> 
> diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
> index 8b88eb2f077b..64ec5ca18f60 100644
> --- a/arch/arm/mach-exynos/platsmp.c
> +++ b/arch/arm/mach-exynos/platsmp.c
> @@ -76,6 +76,25 @@ static inline void __iomem *cpu_boot_reg(int cpu)
>  }
>  
>  /*
> + * Set wake up by local power mode and execute software reset for given core.
> + *
> + * Currently this is needed only when booting secondary CPU on Exynos3250.
> + */
> +static inline void exynos_core_restart(u32 core_id)

nit: AFAIK when not strictly necessary, it's preferable to let the
compiler decide to inline a function or not, instead of adding the
inline keyword.

> +{
> +	if (of_machine_is_compatible("samsung,exynos3250")) {

nit: This could be probably changed into

	if (!of_machine_is_compatible("samsung,exynos3250"))
		return;

Other than these two minor nitpicks the patch looks good, so if there is
no reason to resend, feel free to ignore them. Although I think it might
be necessary to rebase it on Kukjin's for-next.

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz
