From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 20 Jan 2015 11:42:28 +0000
Subject: [PATCH 1/2] arm64: support new attribute reg-var-mask in cpu node
In-Reply-To: <1421730471-8256-1-git-send-email-thunder.leizhen@huawei.com>
References: <1421730471-8256-1-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <20150120114228.GC15924@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 20, 2015 at 05:07:50AM +0000, Zhen Lei wrote:
> Now, a cpu node in dts can only describe one cpu. All the same attribute node's
> value in each cpu node are the same, except reg attribute. For example:
> 	cpu at 0 {
> 		device_type = "cpu";
> 		compatible = "arm,armv8";
> 		reg = <0x0 0x0>;
> 		enable-method = "spin-table";
> 		cpu-release-addr = <0x0 0x8000fff8>;
> 	};
> 	cpu at 1 {
> 		device_type = "cpu";
> 		compatible = "arm,armv8";
> 		reg = <0x0 0x1>;
> 		enable-method = "spin-table";
> 		cpu-release-addr = <0x0 0x8000fff8>;
> 	};
> 
> Wow! Assume a processor have 4 clusters, each cluster contains 8 cores, we
> should write 32 times. It's too long. But base upon reg-var-mask, we can simply
> write like below(only one cpu node):
> 	cpu at 0-31 {
> 		device_type = "cpu";
> 		compatible = "arm,armv8";
> 		reg = <0x0 0x0>;
> 		reg-var-mask = <0x0 0x307>;
> 		enable-method = "spin-table";
> 		cpu-release-addr = <0x0 0x8000fff8>;
> 	};
> In the above example, reg-var-mask = <0x0 0x307>. The mask of cluster-id field
> is 3, means cluster-id can be variable from 0 to 3. The mask of core-id field is
> 7, means core-id can be variable from 0 to 7. Each varible result OR with reg to
> form the final hwid. like C code:
> 	for (cluster-id = 0; cluster-id <= 3; cluster-id++)
> 		for (core-id = 0; core-id <= 7; core-id++)
> 			hwid = reg | <cluster-id> | <core-id>;
> 
> If only run cluster-1, we can slightly modified like below:
> 	cpu at 8-15 {
> 		device_type = "cpu";
> 		compatible = "arm,armv8";
> 		reg = <0x0 0x100>;
> 		reg-var-mask = <0x0 0x7>;
> 		enable-method = "spin-table";
> 		cpu-release-addr = <0x0 0x8000fff8>;
> 	};
> 
> reg-var-mask is optional, if omitted or zero value, use the old style.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

I'm really not a fan of this. I appreciate that having a node for each
CPU is laborious to construct by hand, and there is some redundenacy,
but this introduces additional complexity that every piece of code
handing a DTB will have to deal with, and I don't see that the benefit
outweights the cost.

If generating the DTB is painful, that can easily be templated/scripted
at build-time without introducing the additional complexity at run-time.

For the case of common properties (e.g. the enable-method), ePAPR
suggests that these can be placed under /cpus directly, e.g.

cpus {
	#address-cells = <2>;
	#size-cells = <2>;

	enable-method = "spin-table";
	cpu-release-addr = <0x0 0x8000fff8>;

	cpu at 0 {
		reg = <0 0>;
		device_type = "cpu";
		compatible = "vendor,cpu-model";
	};

	cpu at 0 {
		reg = <0 1>;
		device_type = "cpu";
		compatible = "vendor,cpu-model";
	};
};

We don't have code for that at present, though I have been experimenting
locally.

I would hope that for spin-table each CPU got a unique release address
(or better, spin-table were not used for large systems).

Thanks,
Mark.

> ---
>  arch/arm64/kernel/smp.c |   85 ++++++++++++++++++++++++++++++++++++++++++++---
>  1 files changed, 80 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 7ae6ee0..cb1b9d5 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -318,6 +318,56 @@ void __init smp_prepare_boot_cpu(void)
>  	set_my_cpu_offset(per_cpu_offset(smp_processor_id()));
>  }
> 
> +struct hwid_var_ctrl {
> +	struct {
> +		u8 num;
> +		u8 shift;
> +	} fields[BITS_PER_LONG >> 1];
> +
> +	u64 var;
> +	int num;
> +};
> +
> +static void init_var_fields(u64 var_mask, struct hwid_var_ctrl *ctrl)
> +{
> +	int i, idx = -1, found_field = 0;
> +
> +	if (!var_mask)
> +		goto scan_finished;
> +
> +	for (i = 0; i < BITS_PER_LONG; i++)
> +		if (((u64)1 << i) & var_mask)
> +			if (!found_field) {
> +				found_field = 1;
> +				ctrl->fields[++idx].shift = i;
> +				ctrl->fields[idx].num = 1;
> +			} else {
> +				ctrl->fields[idx].num++;
> +			}
> +		else
> +			found_field = 0;
> +
> +scan_finished:
> +	ctrl->var = 0;
> +	ctrl->num = idx + 1;
> +}
> +
> +static u64 fill_var_fields(u64 hwid, struct hwid_var_ctrl *ctrl)
> +{
> +	int i;
> +	u64 var, mask;
> +
> +	var = ctrl->var++;
> +
> +	for (i = 0; i < ctrl->num; i++) {
> +		mask = ((u64)1 << ctrl->fields[i].num) - 1;
> +		hwid |= (mask & var) << ctrl->fields[i].shift;
> +		var >>= ctrl->fields[i].num;
> +	}
> +
> +	return hwid;
> +}
> +
>  /*
>   * Enumerate the possible CPU set from the device tree and build the
>   * cpu logical map array containing MPIDR values related to logical
> @@ -332,6 +382,8 @@ void __init smp_init_cpus(void)
>  	while ((dn = of_find_node_by_type(dn, "cpu"))) {
>  		const u32 *cell;
>  		u64 hwid;
> +		u64 hwid_fixed, var_mask;
> +		struct hwid_var_ctrl ctrl;
> 
>  		/*
>  		 * A cpu node with missing "reg" property is
> @@ -341,18 +393,37 @@ void __init smp_init_cpus(void)
>  		cell = of_get_property(dn, "reg", NULL);
>  		if (!cell) {
>  			pr_err("%s: missing reg property\n", dn->full_name);
> -			goto next;
> +			cpu++;
> +			continue;
> +		}
> +		hwid_fixed = of_read_number(cell, of_n_addr_cells(dn));
> +
> +		cell = of_get_property(dn, "reg-var-mask", NULL);
> +		if (!cell)
> +			var_mask = 0;
> +		else
> +			var_mask = of_read_number(cell, of_n_addr_cells(dn));
> +
> +		if ((hwid_fixed & var_mask) != 0) {
> +			pr_warn("reg-var-mask 0x%llx is incorrect, ignored\n",
> +					var_mask);
> +			var_mask = 0;
>  		}
> -		hwid = of_read_number(cell, of_n_addr_cells(dn));
> 
>  		/*
>  		 * Non affinity bits must be set to 0 in the DT
>  		 */
> -		if (hwid & ~MPIDR_HWID_BITMASK) {
> +		if ((hwid_fixed | var_mask) & ~MPIDR_HWID_BITMASK) {
>  			pr_err("%s: invalid reg property\n", dn->full_name);
> -			goto next;
> +			cpu++;
> +			continue;
>  		}
> 
> +		init_var_fields(var_mask, &ctrl);
> +
> +inc_var_fields:
> +		hwid = fill_var_fields(hwid_fixed, &ctrl);
> +
>  		/*
>  		 * Duplicate MPIDRs are a recipe for disaster. Scan
>  		 * all initialized entries and check for
> @@ -389,7 +460,7 @@ void __init smp_init_cpus(void)
>  			 * the enable-method so continue without
>  			 * incrementing cpu.
>  			 */
> -			continue;
> +			goto var_check;
>  		}
> 
>  		if (cpu >= NR_CPUS)
> @@ -405,6 +476,10 @@ void __init smp_init_cpus(void)
>  		cpu_logical_map(cpu) = hwid;
>  next:
>  		cpu++;
> +
> +var_check:
> +		if ((hwid & var_mask) != var_mask)
> +			goto inc_var_fields;
>  	}
> 
>  	/* sanity check */
> --
> 1.7.1
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
