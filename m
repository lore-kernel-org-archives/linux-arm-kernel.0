From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 17 Aug 2013 12:50:07 +0200
Subject: [RFC PATCH v2 3/4] powerpc: refactor of_get_cpu_node to support
 other architectures
In-Reply-To: <1376674791-28244-2-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1376586580-5409-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376674791-28244-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376674791-28244-2-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Message-ID: <2032060.4bgTKOdEX2@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sudeep,

This looks good to me overall, but I have one more question inline.

On Friday 16 of August 2013 18:39:50 Sudeep KarkadaNagesha wrote:
> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> 
> Currently different drivers requiring to access cpu device node are
> parsing the device tree themselves. Since the ordering in the DT need
> not match the logical cpu ordering, the parsing logic needs to consider
> that. However, this has resulted in lots of code duplication and in some
> cases even incorrect logic.
> 
> It's better to consolidate them by adding support for getting cpu
> device node for a given logical cpu index in DT core library. However
> logical to physical index mapping can be architecture specific.
> 
> PowerPC has it's own implementation to get the cpu node for a given
> logical index.
> 
> This patch refactors the current implementation of of_get_cpu_node.
> This in preparation to move the implementation to DT core library.
> It separates out the logical to physical mapping so that a default
> matching of the physical id to the logical cpu index can be added
> when moved to common code. Architecture specific code can override it.
> 
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Grant Likely <grant.likely@linaro.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> ---
>  arch/powerpc/kernel/prom.c | 76
> ++++++++++++++++++++++++++++------------------ 1 file changed, 47
> insertions(+), 29 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> index eb23ac9..fb12be6 100644
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -865,45 +865,63 @@ static int __init prom_reconfig_setup(void)
>  __initcall(prom_reconfig_setup);
>  #endif
> 
> +bool arch_match_cpu_phys_id(int cpu, u64 phys_id)
> +{
> +	return (int)phys_id == get_hard_smp_processor_id(cpu);
> +}
> +
> +static bool __of_find_n_match_cpu_property(struct device_node *cpun,
> +			const char *prop_name, int cpu, unsigned int 
*thread)
> +{
> +	const __be32 *cell;
> +	int ac, prop_len, tid;
> +	u64 hwid;
> +
> +	ac = of_n_addr_cells(cpun);
> +	cell = of_get_property(cpun, prop_name, &prop_len);
> +	if (!cell)
> +		return false;

I wonder how would this handle uniprocessor ARM (pre-v7) cores, for which 
the updated bindings[1] define #address-cells = <0> and so no reg 
property.

[1] - http://thread.gmane.org/gmane.linux.ports.arm.kernel/260795

Best regards,
Tomasz
