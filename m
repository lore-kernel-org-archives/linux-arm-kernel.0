From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 22 Jul 2013 10:37:59 -0400 (EDT)
Subject: [PATCH v3 06/16] drivers/bus: arm-cci: avoid parsing DT for cpu
 device nodes
In-Reply-To: <1374492747-13879-7-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1374069984-20567-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1374492747-13879-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1374492747-13879-7-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Message-ID: <alpine.LFD.2.03.1307221036510.15022@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 22 Jul 2013, Sudeep KarkadaNagesha wrote:

> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> 
> Since the CPU device nodes can be retrieved using arch_of_get_cpu_node,
> we can use it to avoid parsing the cpus node searching the cpu nodes and
> mapping to logical index.
> 
> This patch removes parsing DT for cpu nodes by using of_get_cpu_node.
> 
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

Acked-by: Nicolas Pitre <nico@linaro.org>


> ---
>  drivers/bus/arm-cci.c | 28 +++++++---------------------
>  1 file changed, 7 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
> index 7332889..7dd891c 100644
> --- a/drivers/bus/arm-cci.c
> +++ b/drivers/bus/arm-cci.c
> @@ -122,17 +122,8 @@ EXPORT_SYMBOL_GPL(cci_ace_get_port);
>  
>  static void __init cci_ace_init_ports(void)
>  {
> -	int port, ac, cpu;
> -	u64 hwid;
> -	const u32 *cell;
> -	struct device_node *cpun, *cpus;
> -
> -	cpus = of_find_node_by_path("/cpus");
> -	if (WARN(!cpus, "Missing cpus node, bailing out\n"))
> -		return;
> -
> -	if (WARN_ON(of_property_read_u32(cpus, "#address-cells", &ac)))
> -		ac = of_n_addr_cells(cpus);
> +	int port, cpu;
> +	struct device_node *cpun;
>  
>  	/*
>  	 * Port index look-up speeds up the function disabling ports by CPU,
> @@ -141,18 +132,13 @@ static void __init cci_ace_init_ports(void)
>  	 * The stashed index array is initialized for all possible CPUs
>  	 * at probe time.
>  	 */
> -	for_each_child_of_node(cpus, cpun) {
> -		if (of_node_cmp(cpun->type, "cpu"))
> -			continue;
> -		cell = of_get_property(cpun, "reg", NULL);
> -		if (WARN(!cell, "%s: missing reg property\n", cpun->full_name))
> -			continue;
> -
> -		hwid = of_read_number(cell, ac);
> -		cpu = get_logical_index(hwid & MPIDR_HWID_BITMASK);
> +	for_each_possible_cpu(cpu) {
> +		/* too early to use cpu->of_node */
> +		cpun = of_get_cpu_node(cpu);
>  
> -		if (cpu < 0 || !cpu_possible(cpu))
> +		if (WARN(!cpun, "Missing cpu device node\n"))
>  			continue;
> +
>  		port = __cci_ace_get_port(cpun, ACE_PORT);
>  		if (port < 0)
>  			continue;
> -- 
> 1.8.1.2
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
