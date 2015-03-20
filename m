From: michal.simek@xilinx.com (Michal Simek)
Date: Fri, 20 Mar 2015 08:48:56 +0100
Subject: [PATCH v4] ARM: zynq: use restart_handler mechanism for slcr reset
In-Reply-To: <1426775078-31496-1-git-send-email-joshc@ni.com>
References: <BN1BFFO11FD028DBA8016227BB3B18A2B8E2010@BN1BFFO11FD028.protection.gbl>
 <1426775078-31496-1-git-send-email-joshc@ni.com>
Message-ID: <BL2FFO11FD023E0F02C7ACC5756029B69E20E0@BL2FFO11FD023.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/19/2015 03:24 PM, Josh Cartwright wrote:
> By making use of the restart_handler chain mechanism, the SLCR-based
> reset mechanism can be prioritized amongst other mechanisms available on
> a particular board.
> 
> Choose a default high-ish priority of 192 for this restart mechanism.
> 
> Signed-off-by: Josh Cartwright <joshc@ni.com>
> ---
> 
> v3 -> v4: Document restart notifier callback parameters.
> v2 -> v3: Don't drop the kerneldoc
> v1 -> v2: Also drop zynq_slcr_system_reset prototype from common.h
> 
>  arch/arm/mach-zynq/common.c |  6 ------
>  arch/arm/mach-zynq/common.h |  1 -
>  arch/arm/mach-zynq/slcr.c   | 21 +++++++++++++++++++--
>  3 files changed, 19 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
> index 58ef2a7..616d584 100644
> --- a/arch/arm/mach-zynq/common.c
> +++ b/arch/arm/mach-zynq/common.c
> @@ -190,11 +190,6 @@ static void __init zynq_irq_init(void)
>  	irqchip_init();
>  }
>  
> -static void zynq_system_reset(enum reboot_mode mode, const char *cmd)
> -{
> -	zynq_slcr_system_reset();
> -}
> -
>  static const char * const zynq_dt_match[] = {
>  	"xlnx,zynq-7000",
>  	NULL
> @@ -212,5 +207,4 @@ DT_MACHINE_START(XILINX_EP107, "Xilinx Zynq Platform")
>  	.init_time	= zynq_timer_init,
>  	.dt_compat	= zynq_dt_match,
>  	.reserve	= zynq_memory_init,
> -	.restart	= zynq_system_reset,
>  MACHINE_END
> diff --git a/arch/arm/mach-zynq/common.h b/arch/arm/mach-zynq/common.h
> index 382c60e..f2f0bf2 100644
> --- a/arch/arm/mach-zynq/common.h
> +++ b/arch/arm/mach-zynq/common.h
> @@ -21,7 +21,6 @@ void zynq_secondary_startup(void);
>  
>  extern int zynq_slcr_init(void);
>  extern int zynq_early_slcr_init(void);
> -extern void zynq_slcr_system_reset(void);
>  extern void zynq_slcr_cpu_stop(int cpu);
>  extern void zynq_slcr_cpu_start(int cpu);
>  extern bool zynq_slcr_cpu_state_read(int cpu);
> diff --git a/arch/arm/mach-zynq/slcr.c b/arch/arm/mach-zynq/slcr.c
> index c3c24fd8..af8fb50 100644
> --- a/arch/arm/mach-zynq/slcr.c
> +++ b/arch/arm/mach-zynq/slcr.c
> @@ -15,6 +15,7 @@
>   */
>  
>  #include <linux/io.h>
> +#include <linux/reboot.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/of_address.h>
>  #include <linux/regmap.h>
> @@ -92,9 +93,17 @@ u32 zynq_slcr_get_device_id(void)
>  }
>  
>  /**
> - * zynq_slcr_system_reset - Reset the entire system.
> + * zynq_slcr_system_restart - Restart the entire system.
> + *
> + * @nb:		Pointer to restart notifier block (unused)
> + * @action:	Reboot mode (unused)
> + * @data:	Restart handler private data (unused)
> + *
> + * Return:	a negative value on error, 0 on success

:-) I can't see any negative value on error.
I will fix it myself to 0 always.

Applied both.

Cheers,
Michal
