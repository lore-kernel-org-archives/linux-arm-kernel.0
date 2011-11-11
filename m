From: robherring2@gmail.com (Rob Herring)
Date: Fri, 11 Nov 2011 09:54:03 -0600
Subject: [PATCH v2] ARM: highbank: convert logical CPU numbers to physical
 numbers
In-Reply-To: <1321009767-19944-1-git-send-email-will.deacon@arm.com>
References: <1321009767-19944-1-git-send-email-will.deacon@arm.com>
Message-ID: <4EBD451B.8010900@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/11/2011 05:09 AM, Will Deacon wrote:
> This patch uses the new cpu_logical_map() macro for converting logical
> CPU numbers into physical numbers when releasing CPUs during the SMP
> boot and CPU hotplug paths.
> 
> Cc: Rob Herring <rob.herring@calxeda.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---

Thanks.

Acked-by: Rob Herring <rob.herring@calxeda.com>

>  arch/arm/mach-highbank/highbank.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-highbank/highbank.c b/arch/arm/mach-highbank/highbank.c
> index b82dcf0..88660d5 100644
> --- a/arch/arm/mach-highbank/highbank.c
> +++ b/arch/arm/mach-highbank/highbank.c
> @@ -22,6 +22,7 @@
>  #include <linux/of_irq.h>
>  #include <linux/of_platform.h>
>  #include <linux/of_address.h>
> +#include <linux/smp.h>
>  
>  #include <asm/cacheflush.h>
>  #include <asm/unified.h>
> @@ -72,6 +73,9 @@ static void __init highbank_map_io(void)
>  
>  void highbank_set_cpu_jump(int cpu, void *jump_addr)
>  {
> +#ifdef CONFIG_SMP
> +	cpu = cpu_logical_map(cpu);
> +#endif
>  	writel(BSYM(virt_to_phys(jump_addr)), HB_JUMP_TABLE_VIRT(cpu));
>  	__cpuc_flush_dcache_area(HB_JUMP_TABLE_VIRT(cpu), 16);
>  	outer_clean_range(HB_JUMP_TABLE_PHYS(cpu),
