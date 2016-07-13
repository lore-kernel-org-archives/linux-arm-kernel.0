From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Wed, 13 Jul 2016 10:12:12 +0100
Subject: [PATCH v22 1/8] arm64: kdump: reserve memory for crash dump kernel
In-Reply-To: <20160712050514.22307-2-takahiro.akashi@linaro.org>
References: <20160712050514.22307-1-takahiro.akashi@linaro.org>
 <20160712050514.22307-2-takahiro.akashi@linaro.org>
Message-ID: <e7034684-00ec-c441-c806-ae090d10cceb@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/07/16 06:05, AKASHI Takahiro wrote:
> On the startup of primary kernel, the memory region used by crash dump
> kernel must be specified by "crashkernel=" kernel parameter.
> reserve_crashkernel() will allocate and reserve the region for later use.
>
> User space tools, like kexec-tools, will be able to find that region as
> 	- "Crash kernel" in /proc/iomem, or
> 	- "linux,crashkernel-base" and "linux,crashkernel-size" under
> 	  /sys/firmware/devicetree/base/chosen
>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Signed-off-by: Mark Salter <msalter@redhat.com>
> Signed-off-by: Pratyush Anand <panand@redhat.com>
> Reviewed-by: James Morse <james.morse@arm.com>

Minor nits below.

> ---
>  arch/arm64/kernel/setup.c |   7 ++-
>  arch/arm64/mm/init.c      | 115 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 121 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index c1509e6..cb5eee0 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -31,7 +31,6 @@
>  #include <linux/screen_info.h>
>  #include <linux/init.h>
>  #include <linux/kexec.h>
> -#include <linux/crash_dump.h>
>  #include <linux/root_dev.h>
>  #include <linux/cpu.h>
>  #include <linux/interrupt.h>
> @@ -222,6 +221,12 @@ static void __init request_standard_resources(void)
>  		    kernel_data.end <= res->end)
>  			request_resource(res, &kernel_data);
>  	}
> +
> +#ifdef CONFIG_KEXEC_CORE
> +	/* User space tools will find "Crash kernel" region in /proc/iomem. */
> +	if (crashk_res.end)
> +		insert_resource(&iomem_resource, &crashk_res);
> +#endif

nit: Could we not do this from reserve_crashkernel() ?

>
>  #include <asm/boot.h>
>  #include <asm/fixmap.h>
> @@ -76,6 +78,117 @@ static int __init early_initrd(char *p)
>  early_param("initrd", early_initrd);
>  #endif
>
> +#ifdef CONFIG_KEXEC_CORE
> +static unsigned long long crash_size, crash_base;
> +static struct property crash_base_prop = {
> +	.name = "linux,crashkernel-base",
> +	.length = sizeof(u64),
> +	.value = &crash_base
> +};
> +static struct property crash_size_prop = {
> +	.name = "linux,crashkernel-size",
> +	.length = sizeof(u64),
> +	.value = &crash_size,
> +};
> +

> +
> +/*
> + * reserve_crashkernel() - reserves memory for crash kernel
> + *
> + * This function reserves memory area given in "crashkernel=" kernel command
> + * line parameter. The memory reserved is used by dump capture kernel when
> + * primary kernel is crashing.
> + */
> +static void __init reserve_crashkernel(void)
> +{
> +	int ret;
> +
> +	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
> +				&crash_size, &crash_base);
> +	/* no crashkernel= or invalid value specified */
> +	if (ret || !crash_size)
> +		return;
> +
> +	if (crash_base == 0) {

...

> +		memblock_reserve(crash_base, crash_size);
> +
> +	} else {

...

> +
> +		memblock_reserve(crash_base, crash_size);

> +	}

Nit: you could move the memblock_reserve() here to a single place.

> +
> +	pr_info("Reserving %lldMB of memory at %lldMB for crashkernel\n",
> +		crash_size >> 20, crash_base >> 20);
> +
> +	crashk_res.start = crash_base;
> +	crashk_res.end = crash_base + crash_size - 1;

As mentioned above, may be we could move the insert_resource() here, which
would keep the generic setup.c code cleaner and is a bit more reader friendly.

> +}
> +#else

Suzuki
