From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 19 Mar 2015 11:44:23 +0100
Subject: [PATCH v2] ARM: zynq: use restart_handler mechanism for slcr reset
In-Reply-To: <1425049769-24929-1-git-send-email-joshc@ni.com>
References: <1425049769-24929-1-git-send-email-joshc@ni.com>
Message-ID: <BL2FFO11OLC004560F6047881E93573D75E2010@BL2FFO11OLC004.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/27/2015 04:09 PM, Josh Cartwright wrote:
> By making use of the restart_handler chain mechanism, the SLCR-based
> reset mechanism can be prioritized amongst other mechanisms available on
> a particular board.
> 
> Choose a default high-ish priority of 192 for this restart mechanism.
> 
> Signed-off-by: Josh Cartwright <joshc@ni.com>
> ---
> v1 -> v2: Also drop zynq_slcr_system_reset prototype from common.h
> 
>  arch/arm/mach-zynq/common.c |  6 ------
>  arch/arm/mach-zynq/common.h |  1 -
>  arch/arm/mach-zynq/slcr.c   | 16 ++++++++++++----
>  3 files changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
> index c887196..39c1c7d4 100644
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
> index c3c24fd8..e92b319 100644
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
> @@ -91,10 +92,9 @@ u32 zynq_slcr_get_device_id(void)
>  	return val;
>  }
>  
> -/**
> - * zynq_slcr_system_reset - Reset the entire system.
> - */
> -void zynq_slcr_system_reset(void)
> +static
> +int zynq_slcr_system_restart(struct notifier_block *nb,
> +			     unsigned long action, void *data)
>  {

First of all sorry for delay.
Any reason to remove kernel-doc format?

The rest looks good and I have also tested it.

BTW: was also thinking about syscon-reboot option but it doesn't fit to
our reset sequence. :-(

Thanks,
Michal
