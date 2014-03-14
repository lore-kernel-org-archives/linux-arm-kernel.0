From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 14 Mar 2014 09:52:46 +0000
Subject: [RFC] PSCI: Use DT Function ID values only for old versions of
 spec
In-Reply-To: <1394772816-8078-1-git-send-email-ashwin.chaugule@linaro.org>
References: <1394772816-8078-1-git-send-email-ashwin.chaugule@linaro.org>
Message-ID: <20140314095246.GH25870@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Adding lakml and others with an interest in PSCI 0.2]

Hi Ashwin,

On Fri, Mar 14, 2014 at 04:53:36AM +0000, Ashwin Chaugule wrote:
> The PSCI v0.2+ spec mandates specific values of Function ID's
> for ARM32 and ARM64. Use DT bindings of Function ID's only
> when using older versions. Use static values otherwise.
> This patch also prepares the code to easily use the ACPI API
> which is based off of PSCI v0.2+.

Nit: %s/ID's/IDs/

> 
> Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
> ---
>  arch/arm/include/asm/psci.h   | 13 +++++++
>  arch/arm/kernel/psci.c        | 89 ++++++++++++++++++++++++++++++++++++-------
>  arch/arm64/include/asm/psci.h | 12 ++++++
>  arch/arm64/kernel/psci.c      | 85 +++++++++++++++++++++++++++++++++++------
>  4 files changed, 174 insertions(+), 25 deletions(-)
> 
> diff --git a/arch/arm/include/asm/psci.h b/arch/arm/include/asm/psci.h
> index c4ae171..931c992 100644
> --- a/arch/arm/include/asm/psci.h
> +++ b/arch/arm/include/asm/psci.h
> @@ -17,6 +17,19 @@
>  #define PSCI_POWER_STATE_TYPE_STANDBY		0
>  #define PSCI_POWER_STATE_TYPE_POWER_DOWN	1
>  
> +/* PSCI Function ID's for ARM32 as per PSCI spec v0.2 */
> +
> +#define PSCI_ID_VERSION				0x84000000
> +#define PSCI_ID_CPU_SUSPEND			0x84000001
> +#define PSCI_ID_CPU_OFF				0x84000002
> +#define PSCI_ID_CPU_ON				0x84000003
> +#define PSCI_ID_AFFINITY_INFO		0x84000004
> +#define PSCI_ID_CPU_MIGRATE			0x84000005
> +#define PSCI_ID_MIGRATE_INFO_TYPE	0x84000006
> +#define PSCI_ID_MIGRATE_INFO_UP_CPU	0x84000007
> +#define PSCI_ID_SYSTEM_OFF			0x84000008
> +#define PSCI_ID_SYSTEM_RESET		0x84000009
> +
>  struct psci_power_state {
>  	u16	id;
>  	u8	type;
> diff --git a/arch/arm/kernel/psci.c b/arch/arm/kernel/psci.c
> index 4693188..4e17565 100644
> --- a/arch/arm/kernel/psci.c
> +++ b/arch/arm/kernel/psci.c
> @@ -27,6 +27,7 @@
>  struct psci_operations psci_ops;
>  
>  static int (*invoke_psci_fn)(u32, u32, u32, u32);
> +typedef int (*psci_initcall_t)(const struct device_node *);
>  
>  enum psci_function {
>  	PSCI_FN_CPU_SUSPEND,
> @@ -153,25 +154,66 @@ static int psci_migrate(unsigned long cpuid)
>  	return psci_to_linux_errno(err);
>  }
>  
> -static const struct of_device_id psci_of_match[] __initconst = {
> -	{ .compatible = "arm,psci",	},
> -	{},
> -};
> +/*
> + * PSCI Function ID's for v0.2+ are well defined so use
> + * static values.
> + */
> +static int psci_static_init(struct device_node *np)
> +{
> +	const char *method;
> +	int err = 0;
> +
> +	pr_info("probing for conduit method from DT.\n");
> +
> +	if (of_property_read_string(np, "method", &method)) {
> +		pr_warn("missing \"method\" property\n");
> +		err = -ENXIO;
> +		goto out_put_node;
> +	}
> +
> +	if (!strcmp("hvc", method)) {
> +		invoke_psci_fn = __invoke_psci_fn_hvc;
> +	} else if (!strcmp("smc", method)) {
> +		invoke_psci_fn = __invoke_psci_fn_smc;
> +	} else {
> +		pr_warn("invalid \"method\" property: %s\n", method);
> +		err = -EINVAL;
> +		goto out_put_node;
> +	}
> +
> +	pr_info("using static PSCI Function ID's\n");

It's probably worth stating which static IDs are in use, e.g. "using
standard PSCI 0.2 function IDs". Later versions might get more
functions, and being explicit from the start will make debugging easier
across kernel versions.

Also, it would be good to print out the return value of PSCI_VERSION to
notify the user which version of PSCI the implementation claims to be
conformant with.

> +
> +	psci_function_id[PSCI_FN_CPU_SUSPEND] = PSCI_ID_CPU_SUSPEND;
> +	psci_ops.cpu_suspend = psci_cpu_suspend;
> +
> +	psci_function_id[PSCI_FN_CPU_OFF] = PSCI_ID_CPU_OFF;
> +	psci_ops.cpu_off = psci_cpu_off;
>  
> -void __init psci_init(void)
> +	psci_function_id[PSCI_FN_CPU_ON] = PSCI_ID_CPU_ON;
> +	psci_ops.cpu_on = psci_cpu_on;
> +
> +	psci_function_id[PSCI_FN_MIGRATE] = PSCI_ID_CPU_MIGRATE;
> +	psci_ops.migrate = psci_migrate;

It would also be a good idea to hook up AFFINITY_INFO to a cpu_kill
callback from the start, to ensure implementors bother to implement it,
and such that we can make kexec safe(r).

If we rely on it from the start it's more likely that it will actually
get implemented, and it will highlight any dodgy PSCI 0.2
implementations while there's a chance they can be fixed.

> +
> +out_put_node:
> +	of_node_put(np);
> +	return err;
> +}
> +
> +/*
> + * PSCI < v0.2 can override PSCI function ID's via DT.
> + */
> +static int psci_of_init(struct device_node *np)
>  {
> -	struct device_node *np;
>  	const char *method;
>  	u32 id;
> -
> -	np = of_find_matching_node(NULL, psci_of_match);
> -	if (!np)
> -		return;
> +	int err = 0;
>  
>  	pr_info("probing function IDs from device-tree\n");
>  
>  	if (of_property_read_string(np, "method", &method)) {
> -		pr_warning("missing \"method\" property\n");
> +		pr_warn("missing \"method\" property\n");

Unrelated change? (not that I'm against it).

> +		err = -EINVAL;
>  		goto out_put_node;
>  	}
>  
> @@ -180,7 +222,8 @@ void __init psci_init(void)
>  	} else if (!strcmp("smc", method)) {
>  		invoke_psci_fn = __invoke_psci_fn_smc;
>  	} else {
> -		pr_warning("invalid \"method\" property: %s\n", method);
> +		pr_warn("invalid \"method\" property: %s\n", method);
> +		err = -ENXIO;
>  		goto out_put_node;
>  	}
>  
> @@ -206,5 +249,25 @@ void __init psci_init(void)
>  
>  out_put_node:
>  	of_node_put(np);
> -	return;
> +	return err;
> +}
> +
> +static const struct of_device_id psci_of_match[] __initconst = {
> +	{ .compatible = "arm,psci", .data = psci_of_init},
> +	{ .compatible = "arm,psci-0.2", .data = psci_static_init},

This requires a binding document update, explaining exactly what this
string implies.

> +	{},
> +};
> +
> +int __init psci_init(void)
> +{
> +	struct device_node *np;
> +	const struct of_device_id *matched_np;
> +	psci_initcall_t init_fn;
> +
> +	np = of_find_matching_node_and_match(NULL, psci_of_match, &matched_np);
> +	if (!np)
> +		return -ENODEV;
> +
> +	init_fn = (psci_initcall_t)matched_np->data;

Is an explicit cast necessary here?

> +	return init_fn(np);
>  }
> diff --git a/arch/arm64/include/asm/psci.h b/arch/arm64/include/asm/psci.h
> index e5312ea..b72678f 100644
> --- a/arch/arm64/include/asm/psci.h
> +++ b/arch/arm64/include/asm/psci.h
> @@ -16,4 +16,16 @@
>  
>  int psci_init(void);
>  
> +/* PSCI Function ID's for ARM64 as per PSCI spec v0.2 */
> +#define PSCI_ID_VERSION				0x84000000
> +#define PSCI_ID_CPU_SUSPEND			0xc4000001
> +#define PSCI_ID_CPU_OFF				0x84000002
> +#define PSCI_ID_CPU_ON				0xc4000003
> +#define PSCI_ID_AFFINITY_INFO		0xc4000004
> +#define PSCI_ID_CPU_MIGRATE			0xc4000005
> +#define PSCI_ID_MIGRATE_INFO_TYPE	0x84000006
> +#define PSCI_ID_MIGRATE_INFO_UP_CPU	0xc4000007
> +#define PSCI_ID_SYSTEM_OFF			0x84000008
> +#define PSCI_ID_SYSTEM_RESET		0x84000009
> +
>  #endif /* __ASM_PSCI_H */
> diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
> index 4f97db3..a967707 100644
> --- a/arch/arm64/kernel/psci.c
> +++ b/arch/arm64/kernel/psci.c
> @@ -45,6 +45,7 @@ struct psci_operations {
>  static struct psci_operations psci_ops;
>  
>  static int (*invoke_psci_fn)(u64, u64, u64, u64);
> +typedef int (*psci_initcall_t)(const struct device_node *);
>  
>  enum psci_function {
>  	PSCI_FN_CPU_SUSPEND,
> @@ -171,26 +172,65 @@ static int psci_migrate(unsigned long cpuid)
>  	return psci_to_linux_errno(err);
>  }
>  
> -static const struct of_device_id psci_of_match[] __initconst = {
> -	{ .compatible = "arm,psci",	},
> -	{},
> -};
> +/*
> + * PSCI Function ID's for v0.2+ are well defined so use
> + * static values.
> + */
> +static int psci_static_init(struct device_node *np)
> +{
> +	const char *method;
> +	int err = 0;
>  
> -int __init psci_init(void)
> +	pr_info("probing for conduit method from DT.\n");
> +
> +	if (of_property_read_string(np, "method", &method)) {
> +		pr_warn("missing \"method\" property\n");
> +		err = -ENXIO;
> +		goto out_put_node;
> +	}
> +
> +	if (!strcmp("hvc", method)) {
> +		invoke_psci_fn = __invoke_psci_fn_hvc;
> +	} else if (!strcmp("smc", method)) {
> +		invoke_psci_fn = __invoke_psci_fn_smc;
> +	} else {
> +		pr_warn("invalid \"method\" property: %s\n", method);
> +		err = -EINVAL;
> +		goto out_put_node;
> +	}
> +
> +	pr_info("using static PSCI Function ID's\n");
> +
> +	psci_function_id[PSCI_FN_CPU_SUSPEND] = PSCI_ID_CPU_SUSPEND;
> +	psci_ops.cpu_suspend = psci_cpu_suspend;
> +
> +	psci_function_id[PSCI_FN_CPU_OFF] = PSCI_ID_CPU_OFF;
> +	psci_ops.cpu_off = psci_cpu_off;
> +
> +	psci_function_id[PSCI_FN_CPU_ON] = PSCI_ID_CPU_ON;
> +	psci_ops.cpu_on = psci_cpu_on;
> +
> +	psci_function_id[PSCI_FN_MIGRATE] = PSCI_ID_CPU_MIGRATE;

My comments for the 32-bit version apply here too.

Cheers,
Mark.
