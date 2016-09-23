From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 23 Sep 2016 17:01:51 +0100
Subject: [PATCH] ARM/dt: Respect #address-cells when parsing CPUs
In-Reply-To: <31c4684aa8ef7ef210cc74da5f1b02ff2882a099.1474645829.git.robin.murphy@arm.com>
References: <31c4684aa8ef7ef210cc74da5f1b02ff2882a099.1474645829.git.robin.murphy@arm.com>
Message-ID: <20160923160151.GB22454@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

On Fri, Sep 23, 2016 at 04:51:48PM +0100, Robin Murphy wrote:
> Whilst MPIDR values themselves are only 32 bits, it is still perfectly
> valid for a DT to have #address-cells > 1 in the CPUs node, resulting in
> the "reg" property having leading zero cell(s). In that situation, the
> big-endian nature of the data conspires with the current behaviour of
> just parsing the first cell to cause the kernel to think all CPUs have
> ID 0, and become resoundingly unhappy as a consequence.
> 
> Take #address-cells into account when parsing CPUs so as to be correct
> under any circumstances.

To be correct under any circumstances you'll also need to verify that
the upper bits (e.g. Aff3) are zero, and handle the non-zero case
somewhow.

As it stands, this can have the kernel think that MPIDR.Aff* values
exist which were never in the DT.

Thanks,
Mark.

> CC: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  arch/arm/kernel/devtree.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
> index 40ecd5f514a2..7ab113c5c818 100644
> --- a/arch/arm/kernel/devtree.c
> +++ b/arch/arm/kernel/devtree.c
> @@ -88,6 +88,7 @@ void __init arm_dt_init_cpu_maps(void)
>  		return;
>  
>  	for_each_child_of_node(cpus, cpu) {
> +		const u32 *cell;
>  		u32 hwid;
>  
>  		if (of_node_cmp(cpu->type, "cpu"))
> @@ -99,12 +100,14 @@ void __init arm_dt_init_cpu_maps(void)
>  		 * properties is considered invalid to build the
>  		 * cpu_logical_map.
>  		 */
> -		if (of_property_read_u32(cpu, "reg", &hwid)) {
> +		cell = of_get_property(cpu, "reg", NULL);
> +		if (!cell) {
>  			pr_debug(" * %s missing reg property\n",
>  				     cpu->full_name);
>  			of_node_put(cpu);
>  			return;
>  		}
> +		hwid = of_read_number(cell, of_n_addr_cells(cpu));
>  
>  		/*
>  		 * 8 MSBs must be set to 0 in the DT since the reg property
> -- 
> 2.8.1.dirty
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
