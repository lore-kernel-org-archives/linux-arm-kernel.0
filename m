From: will.deacon@arm.com (Will Deacon)
Date: Thu, 13 Dec 2012 14:50:12 +0000
Subject: [PATCH] [ARM] sharpsl_param: fix invalid memory access in
 sharpsl_save_param()
In-Reply-To: <1355409893-24200-1-git-send-email-dromede@gmail.com>
References: <1355409893-24200-1-git-send-email-dromede@gmail.com>
Message-ID: <20121213145012.GJ26540@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marko,

On Thu, Dec 13, 2012 at 02:44:53PM +0000, dromede at gmail.com wrote:
> From: Marko Katic <dromede.gmail.com>
> 
> Devices that call sharpsl_save_param() will hang on boot due to
> a memcpy call that uses physical addresses that are no longer
> valid. This is caused by the following commit:
> 
> commit 72662e01088394577be4a3f14da94cf87bea2591
> Author: Will Deacon <will.deacon@arm.com>
> Date:   Wed Nov 23 12:03:27 2011 +0000
> 
>     ARM: head.S: only include __turn_mmu_on in the initial identity mapping
> 
> Tested  on Zaurus corgi/poodle/spitz devices.
> 
> Signed-off-by: Marko Katic <dromede@gmail.com>

Interesting find! Now, I wonder, if you revert Dave's patch conditionalising
the hyp mode entry (1ecec696c8bb "ARM: 7599/1: head: Remove boot-time HYP
mode check for v5 and below") and apply your patch below, does your i2c
still work?

Cheers,

Will

> ---
>  arch/arm/common/sharpsl_param.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/common/sharpsl_param.c b/arch/arm/common/sharpsl_param.c
> index d56c932..04555dc 100644
> --- a/arch/arm/common/sharpsl_param.c
> +++ b/arch/arm/common/sharpsl_param.c
> @@ -14,6 +14,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/string.h>
> +#include <asm/memory.h>
>  #include <asm/mach/sharpsl_param.h>
>  
>  /*
> @@ -41,7 +42,8 @@ EXPORT_SYMBOL(sharpsl_param);
>  
>  void sharpsl_save_param(void)
>  {
> -	memcpy(&sharpsl_param, (void *)PARAM_BASE, sizeof(struct sharpsl_param_info));
> +	void *param_start = phys_to_virt(PARAM_BASE);
> +	memcpy(&sharpsl_param, param_start, sizeof(struct sharpsl_param_info));
>  
>  	if (sharpsl_param.comadj_keyword != COMADJ_MAGIC)
>  		sharpsl_param.comadj=-1;
> -- 
> 1.7.10.4
> 
> 
