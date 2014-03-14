From: dinguyen@altera.com (Dinh Nguyen)
Date: Fri, 14 Mar 2014 12:01:39 -0500
Subject: [PATCH] arm: socfpga: reserve the region at start of phys mem
In-Reply-To: <1392744897-6384-1-git-send-email-bigeasy@linutronix.de>
References: <1392744897-6384-1-git-send-email-bigeasy@linutronix.de>
Message-ID: <1394816499.25786.1.camel@linux-builds1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-02-18 at 18:34 +0100, Sebastian Andrzej Siewior wrote:
> The SMP bringup code copies trampline code to the physical location 0x0.
> If somebody allocated memory from this location then it will be
> overwritten.
> This patch reserves the few bytes so that it won't be used by the memory
> allocator.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  arch/arm/mach-socfpga/socfpga.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/mach-socfpga/socfpga.c
> index a9050e6..2ba992a 100644
> --- a/arch/arm/mach-socfpga/socfpga.c
> +++ b/arch/arm/mach-socfpga/socfpga.c
> @@ -26,6 +26,7 @@
>  #include <linux/phy.h>
>  #include <linux/micrel_phy.h>
>  #include <linux/sys_soc.h>
> +#include <linux/memblock.h>
>  
>  #include <asm/hardware/cache-l2x0.h>
>  #include <asm/mach/arch.h>
> @@ -315,6 +316,17 @@ static void __init socfpga_cyclone5_init(void)
>  	socfpga_soc_device_init();
>  }
>  
> +static void __init socfmpga_smp_reserve(void)

s/socfmpga/socfpga
> +{
> +#ifdef CONFIG_SMP
> +	int trampoline_size = &secondary_trampoline_end - &secondary_trampoline;
> +	int ret;
> +
> +	ret = memblock_reserve(0, trampoline_size);
> +	WARN_ON(ret);
> +#endif
> +}
> +
>  static const char *altera_dt_match[] = {
>  	"altr,socfpga",
>  	NULL
> @@ -327,4 +339,5 @@ DT_MACHINE_START(SOCFPGA, "Altera SOCFPGA")
>  	.init_machine	= socfpga_cyclone5_init,
>  	.restart	= socfpga_cyclone5_restart,
>  	.dt_compat	= altera_dt_match,
> +	.reserve	= socfmpga_smp_reserve,

same..

I've applied this patch with the above edits.

Thanks,
Dinh
>  MACHINE_END
