From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 19 Mar 2014 20:06:14 -0700
Subject: [PATCH v1 1/2] PSCI: Use DT Function ID values only for old
 versions of spec
In-Reply-To: <1395276865-6868-1-git-send-email-ashwin.chaugule@linaro.org>
References: <1395276865-6868-1-git-send-email-ashwin.chaugule@linaro.org>
Message-ID: <20140320030614.GP1297@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 19, 2014 at 08:54:24PM -0400, Ashwin Chaugule wrote:
> The PSCI v0.2+ spec mandates specific values of Function IDs
> for ARM32 and ARM64. Use DT bindings of Function IDs only
> when using older versions. Use static values otherwise.
> This patch also prepares the code to easily use the ACPI API
> which is based off of PSCI v0.2+.
> 
> Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
> ---
>  arch/arm/include/asm/psci.h   |  15 ++++++
>  arch/arm/kernel/psci.c        | 110 +++++++++++++++++++++++++++++++++++++-----
>  arch/arm64/include/asm/psci.h |  12 +++++
>  arch/arm64/kernel/psci.c      | 106 +++++++++++++++++++++++++++++++++++-----
>  4 files changed, 218 insertions(+), 25 deletions(-)
> 
> diff --git a/arch/arm/include/asm/psci.h b/arch/arm/include/asm/psci.h
> index c4ae171..3f8ebf9 100644
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
> @@ -36,9 +49,11 @@ extern struct smp_operations psci_smp_ops;
>  
>  #ifdef CONFIG_ARM_PSCI
>  void psci_init(void);
> +int psci_get_version(void);
>  bool psci_smp_available(void);
>  #else
>  static inline void psci_init(void) { }
> +static inline int psci_get_version(void) { }
>  static inline bool psci_smp_available(void) { return false; }
>  #endif
>  
> diff --git a/arch/arm/kernel/psci.c b/arch/arm/kernel/psci.c
> index 4693188..48e0b0a 100644
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
> @@ -110,6 +111,20 @@ static noinline int __invoke_psci_fn_smc(u32 function_id, u32 arg0, u32 arg1,
>  	return function_id;
>  }
>  
> +#define PSCI_VER_MAJOR_MASK		0xffff0000
> +#define PSCI_VER_MINOR_MASK		0x0000ffff
> +#define PSCI_VER_MAJOR_SHIFT	16
> +
> +static int psci_get_version(void)
> +{
> +	int err;
> +	u32 fn;
> +
> +	fn = PSCI_ID_VERSION;
> +	err = invoke_psci_fn(fn, 0, 0, 0);
> +	return err;
> +}
> +
>  static int psci_cpu_suspend(struct psci_power_state state,
>  			    unsigned long entry_point)
>  {
> @@ -153,25 +168,65 @@ static int psci_migrate(unsigned long cpuid)
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
>  
> -void __init psci_init(void)
> +	pr_info("Using static PSCIv0.2+ function IDs\n");
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
> +	psci_ops.migrate = psci_migrate;
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
> +		err = -EINVAL;
>  		goto out_put_node;
>  	}
>  
> @@ -180,7 +235,8 @@ void __init psci_init(void)
>  	} else if (!strcmp("smc", method)) {
>  		invoke_psci_fn = __invoke_psci_fn_smc;
>  	} else {
> -		pr_warning("invalid \"method\" property: %s\n", method);
> +		pr_warn("invalid \"method\" property: %s\n", method);
> +		err = -ENXIO;
>  		goto out_put_node;
>  	}
>  
> @@ -206,5 +262,33 @@ void __init psci_init(void)
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
> +	{},
> +};
> +
> +int __init psci_init(void)
> +{
> +	struct device_node *np;
> +	const struct of_device_id *matched_np;
> +	psci_initcall_t init_fn;
> +	int ver = 0;
> +
> +	np = of_find_matching_node_and_match(NULL, psci_of_match, &matched_np);
> +	if (!np)
> +		return -ENODEV;
> +
> +	ver = psci_get_version();
> +
> +	pr_info("using static PSCIv%d.%d Function IDs\n",
> +			(ver & PSCI_VER_MAJOR_MASK) >> PSCI_VER_MAJOR_SHIFT,
> +			(ver & PSCI_VER_MINOR_MASK));
> +
> +
> +	init_fn = (psci_initcall_t)matched_np->data;
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
> index 4f97db3..d4cff4e 100644
> --- a/arch/arm64/kernel/psci.c
> +++ b/arch/arm64/kernel/psci.c
> @@ -45,12 +45,14 @@ struct psci_operations {
>  static struct psci_operations psci_ops;
>  
>  static int (*invoke_psci_fn)(u64, u64, u64, u64);
> +typedef int (*psci_initcall_t)(const struct device_node *);
>  
>  enum psci_function {
>  	PSCI_FN_CPU_SUSPEND,
>  	PSCI_FN_CPU_ON,
>  	PSCI_FN_CPU_OFF,
>  	PSCI_FN_MIGRATE,
> +	PSCI_FN_AFFINITY_INFO,
>  	PSCI_FN_MAX,
>  };
>  
> @@ -128,6 +130,20 @@ static noinline int __invoke_psci_fn_smc(u64 function_id, u64 arg0, u64 arg1,
>  	return function_id;
>  }
>  
> +#define PSCI_VER_MAJOR_MASK		0xffff0000
> +#define PSCI_VER_MINOR_MASK		0x0000ffff
> +#define PSCI_VER_MAJOR_SHIFT	16
> +
> +static int psci_get_version(void)
> +{
> +	int err;
> +	u32 fn;
> +
> +	fn = PSCI_ID_VERSION;
> +	err = invoke_psci_fn(fn, 0, 0, 0);
> +	return err;
> +}
> +
>  static int psci_cpu_suspend(struct psci_power_state state,
>  			    unsigned long entry_point)
>  {
> @@ -171,26 +187,64 @@ static int psci_migrate(unsigned long cpuid)
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
> +	pr_info("Using static PSCIv0.2+ function IDs\n");
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
> +	psci_ops.migrate = psci_migrate;
> +
> +out_put_node:
> +	of_node_put(np);
> +	return err;

Can any of this code not be shared between arm and arm64?

Looks almost identical.

-Christoffer
