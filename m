From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 20 Nov 2018 11:29:27 +0000
Subject: [PATCH v1 1/1] arm64: Early boot time stamps
In-Reply-To: <20181119214443.25175-2-pasha.tatashin@soleen.com>
References: <20181119214443.25175-1-pasha.tatashin@soleen.com>
 <20181119214443.25175-2-pasha.tatashin@soleen.com>
Message-ID: <d66a60d9-6772-a951-9da4-c07443b48aad@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pavel,

On 19/11/2018 21:44, Pavel Tatashin wrote:
> Allow printk time stamps/sched_clock() to be available from the early
> boot.
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> ---
>  arch/arm64/kernel/setup.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index f4fc1e0544b7..4df41a66b403 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -40,6 +40,7 @@
>  #include <linux/efi.h>
>  #include <linux/psci.h>
>  #include <linux/sched/task.h>
> +#include <linux/sched_clock.h>
>  #include <linux/mm.h>
>  
>  #include <asm/acpi.h>
> @@ -279,8 +280,26 @@ arch_initcall(reserve_memblock_reserved_regions);
>  
>  u64 __cpu_logical_map[NR_CPUS] = { [0 ... NR_CPUS-1] = INVALID_HWID };
>  
> +/*
> + * Get time stamps available early in boot, useful to identify boot time issues
> + * from the early boot.
> + */
> +static __init void sched_clock_early_init(void)
> +{
> +	u64 freq = arch_timer_get_cntfrq();
> +	u64 (*read_time)(void) = arch_counter_get_cntvct;

We already have arch_timer_read_counter which is exposed from
arm_arch_timer.h.

> +
> +	/* Early clock is available only on platforms with known freqs */

This comment is misleading. It should read something like:

	/*
	 * The arm64 boot protocol mandates that CNTFRQ_EL0 reflects
	 * the timer frequency. To avoid breakage on misconfigured
	 * systems, do not register the early sched_clock if the
	 * programmed value if zero. Other random values will just
	 * result in random output.
	 */

> +	if (!freq)
> +		return;
> +
> +	sched_clock_register(read_time, BITS_PER_LONG, freq);

This doesn't seem right. The counter has an architected minimum of 56
bits, and you can't assume that it is going to be more than that.

> +}
> +
>  void __init setup_arch(char **cmdline_p)
>  {
> +	sched_clock_early_init();
> +
>  	init_mm.start_code = (unsigned long) _text;
>  	init_mm.end_code   = (unsigned long) _etext;
>  	init_mm.end_data   = (unsigned long) _edata;
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
