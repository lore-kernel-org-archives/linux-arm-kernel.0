From: Sudeep.KarkadaNagesha@arm.com (Sudeep KarkadaNagesha)
Date: Fri, 09 Aug 2013 10:25:33 +0100
Subject: [PATCH 2/5] ARM: vexpress: remove redundant vexpress_dt_cpus_num
 to get cpu count
In-Reply-To: <1374579164-30255-3-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1374579164-30255-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1374579164-30255-3-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Message-ID: <5204B58D.2030501@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pawel,

On 23/07/13 12:32, Sudeep KarkadaNagesha wrote:
> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> 
> arm_dt_init_cpu_maps parses the device tree, validates and sets the
> cpu_possible_mask appropriately. It is unnecessary to do another DT
> parse to get the number of cpus, use num_possible_cpus instead.
> 
> This patch also removes setting cpu_present_mask as platforms should
> only re-initialize it in smp_prepare_cpus() if present != possible.
> 
Can you pick this patch for v3.12 ?

Regards,
Sudeep

> Acked-by: Pawel Moll <pawel.moll@arm.com>
> Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> ---
>  arch/arm/mach-vexpress/platsmp.c | 32 +-------------------------------
>  1 file changed, 1 insertion(+), 31 deletions(-)
> 
> diff --git a/arch/arm/mach-vexpress/platsmp.c b/arch/arm/mach-vexpress/platsmp.c
> index 993c9ae..4a2d8c4 100644
> --- a/arch/arm/mach-vexpress/platsmp.c
> +++ b/arch/arm/mach-vexpress/platsmp.c
> @@ -77,39 +77,13 @@ void __init vexpress_dt_smp_map_io(void)
>  		WARN_ON(of_scan_flat_dt(vexpress_dt_find_scu, NULL));
>  }
>  
> -static int __init vexpress_dt_cpus_num(unsigned long node, const char *uname,
> -		int depth, void *data)
> -{
> -	static int prev_depth = -1;
> -	static int nr_cpus = -1;
> -
> -	if (prev_depth > depth && nr_cpus > 0)
> -		return nr_cpus;
> -
> -	if (nr_cpus < 0 && strcmp(uname, "cpus") == 0)
> -		nr_cpus = 0;
> -
> -	if (nr_cpus >= 0) {
> -		const char *device_type = of_get_flat_dt_prop(node,
> -				"device_type", NULL);
> -
> -		if (device_type && strcmp(device_type, "cpu") == 0)
> -			nr_cpus++;
> -	}
> -
> -	prev_depth = depth;
> -
> -	return 0;
> -}
> -
>  static void __init vexpress_dt_smp_init_cpus(void)
>  {
>  	int ncores = 0, i;
>  
>  	switch (vexpress_dt_scu) {
>  	case GENERIC_SCU:
> -		ncores = of_scan_flat_dt(vexpress_dt_cpus_num, NULL);
> -		break;
> +		return;
>  	case CORTEX_A9_SCU:
>  		ncores = scu_get_core_count(vexpress_dt_cortex_a9_scu_base);
>  		break;
> @@ -133,12 +107,8 @@ static void __init vexpress_dt_smp_init_cpus(void)
>  
>  static void __init vexpress_dt_smp_prepare_cpus(unsigned int max_cpus)
>  {
> -	int i;
> -
>  	switch (vexpress_dt_scu) {
>  	case GENERIC_SCU:
> -		for (i = 0; i < max_cpus; i++)
> -			set_cpu_present(i, true);
>  		break;
>  	case CORTEX_A9_SCU:
>  		scu_enable(vexpress_dt_cortex_a9_scu_base);
> 
