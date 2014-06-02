From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon, 02 Jun 2014 15:01:59 +0200
Subject: [PATCH v2 3/7] ARM: EXYNOS: add AFTR mode support to firmware
 do_idle method
In-Reply-To: <1401712543-14281-4-git-send-email-b.zolnierkie@samsung.com>
References: <1401712543-14281-1-git-send-email-b.zolnierkie@samsung.com>
 <1401712543-14281-4-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <538C75C7.4030708@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 02.06.2014 14:35, Bartlomiej Zolnierkiewicz wrote:
> On some platforms (i.e. EXYNOS ones) more than one idle mode is
> available and we need to distinguish them in firmware do_idle method.
> 
> Add mode parameter to do_idle firmware method and AFTR mode support
> to EXYNOS do_idle implementation.
> 
> This change is a preparation for adding secure firmware support to
> EXYNOS cpuidle driver.
> 
> This patch shouldn't cause any functionality changes (please note
> that do_idle firmware method is unused currently).
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/include/asm/firmware.h |  7 ++++++-
>  arch/arm/mach-exynos/firmware.c | 10 ++++++++--
>  2 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/include/asm/firmware.h b/arch/arm/include/asm/firmware.h
> index 70883c7..63989c3 100644
> --- a/arch/arm/include/asm/firmware.h
> +++ b/arch/arm/include/asm/firmware.h
> @@ -28,7 +28,7 @@ struct firmware_ops {
>  	/*
>  	 * Enters CPU idle mode
>  	 */
> -	int (*do_idle)(void);
> +	int (*do_idle)(int mode);
>  	/*
>  	 * Sets boot address of specified physical CPU
>  	 */
> @@ -47,6 +47,11 @@ struct firmware_ops {
>  	int (*c15resume)(u32 *regs);
>  };
>  
> +enum {

What about making this enum named and using it instead of int for mode
argument of do_idle operation?

> +	FW_DO_IDLE_NORMAL,

IMHO this should be called FW_DO_IDLE_SLEEP, as this is how it is used
on Exynos4x12.

OR (which is probably a better idea)

This is probably too Exynos-specific, so mode argument could be kept int
or maybe unsigned long to make it more universal and this enum defined
in an Exynos-specific header instead.

Best regards,
Tomasz
