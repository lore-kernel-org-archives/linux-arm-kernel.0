From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 10 Jan 2012 11:16:31 +0800
Subject: [PATCH 4/6] ARM: imx: remove incorrect BSYM usage
In-Reply-To: <1326149146-19756-5-git-send-email-robherring2@gmail.com>
References: <1326149146-19756-1-git-send-email-robherring2@gmail.com>
 <1326149146-19756-5-git-send-email-robherring2@gmail.com>
Message-ID: <20120110031629.GD23362@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 09, 2012 at 04:45:44PM -0600, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> BSYM macro is only needed for assembly files and its usage in c files is
> wrong, so remove it. The linker will correctly set bit 0 for Thumb2
> kernels.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Cc: Dave Martin <dave.martin@linaro.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>

Tested on imx6 and confirmed the following:

 * Without patch, Thumb2 build fails to bring up secondary cores.
 * With the patch applied, both ARM and Thumb2 builds work just fine.

So,

Acked-by: Shawn Guo <shawn.guo@linaro.org>

Regards,
Shawn

> ---
>  arch/arm/mach-imx/src.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/src.c b/arch/arm/mach-imx/src.c
> index 4bde04f..29bd124 100644
> --- a/arch/arm/mach-imx/src.c
> +++ b/arch/arm/mach-imx/src.c
> @@ -15,7 +15,6 @@
>  #include <linux/of.h>
>  #include <linux/of_address.h>
>  #include <linux/smp.h>
> -#include <asm/unified.h>
>  
>  #define SRC_SCR				0x000
>  #define SRC_GPR1			0x020
> @@ -43,7 +42,7 @@ void imx_enable_cpu(int cpu, bool enable)
>  void imx_set_cpu_jump(int cpu, void *jump_addr)
>  {
>  	cpu = cpu_logical_map(cpu);
> -	writel_relaxed(BSYM(virt_to_phys(jump_addr)),
> +	writel_relaxed(virt_to_phys(jump_addr),
>  		       src_base + SRC_GPR1 + cpu * 8);
>  }
>  
> -- 
> 1.7.5.4
> 
