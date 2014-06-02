From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon, 02 Jun 2014 15:07:46 +0200
Subject: [PATCH v2 5/7] ARM: EXYNOS: PM: use c15resume firmware method
 if secure firmware is enabled
In-Reply-To: <1401712543-14281-6-git-send-email-b.zolnierkie@samsung.com>
References: <1401712543-14281-1-git-send-email-b.zolnierkie@samsung.com>
 <1401712543-14281-6-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <538C7722.8020706@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 02.06.2014 14:35, Bartlomiej Zolnierkiewicz wrote:
> Use c15resume firmware method instead of accessing the registers
> directly in exynos_cpu_restore_register() if secure firmware is
> enabled.  This affects both PM resume method and cpuidle AFTR mode.
> 
> This patch shouldn't cause any functionality changes on boards that
> don't use secure firmware.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-exynos/pm.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
> index cf09383..aeff99e 100644
> --- a/arch/arm/mach-exynos/pm.c
> +++ b/arch/arm/mach-exynos/pm.c
> @@ -26,6 +26,7 @@
>  #include <asm/hardware/cache-l2x0.h>
>  #include <asm/smp_scu.h>
>  #include <asm/suspend.h>
> +#include <asm/firmware.h>
>  
>  #include <plat/pm-common.h>
>  #include <plat/pll.h>
> @@ -232,6 +233,9 @@ static void exynos_cpu_restore_register(void)
>  {
>  	unsigned long tmp;
>  
> +	if (call_firmware_op(c15resume, save_arm_register) == 0)
> +		return;
> +

As I mentioned in my comments to patch 2/7, instead of introducing
heavily SoC-specific operations, I'd rather add more general suspend and
resume firmware operations which would take care of both saving and
restoring those registers.

Best regards,
Tomasz
