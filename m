From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 18 Jan 2016 10:41:43 +0000
Subject: [PATCH v2 11/16] ARM64: ACPI: Check if it runs on Xen to enable
 or disable ACPI
In-Reply-To: <1452840929-19612-12-git-send-email-zhaoshenglong@huawei.com>
References: <1452840929-19612-1-git-send-email-zhaoshenglong@huawei.com>
 <1452840929-19612-12-git-send-email-zhaoshenglong@huawei.com>
Message-ID: <20160118104142.GC21067@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 15, 2016 at 02:55:24PM +0800, Shannon Zhao wrote:
> From: Shannon Zhao <shannon.zhao@linaro.org>
> 
> When it's a Xen domain0 booting with ACPI, it will supply a /chosen and
> a /hypervisor node in DT. So check if it needs to enable ACPI.
> 
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> ---
>  arch/arm64/kernel/acpi.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> index d1ce8e2..4e92be0 100644
> --- a/arch/arm64/kernel/acpi.c
> +++ b/arch/arm64/kernel/acpi.c
> @@ -67,10 +67,13 @@ static int __init dt_scan_depth1_nodes(unsigned long node,
>  {
>  	/*
>  	 * Return 1 as soon as we encounter a node at depth 1 that is
> -	 * not the /chosen node.
> +	 * not the /chosen node, or /hypervisor node when running on Xen.
>  	 */
> -	if (depth == 1 && (strcmp(uname, "chosen") != 0))
> -		return 1;
> +	if (depth == 1 && (strcmp(uname, "chosen") != 0)) {
> +		if (!xen_initial_domain() || (strcmp(uname, "hypervisor") != 0))
> +			return 1;
> +	}
> +
>  	return 0;
>  }

As this is changing the semantic of an "empty" DT, we should consider
now if there's anything else that might also need to exist in an "empty"
DT. We don't want to change this again in future if we don't have to,
given the compatiblity nightmare that's sure to result.

We should also consider if the "hypervisor" node name is sufficient (I
think it is, but let's not assume anything).

Mark.

>  
> @@ -184,7 +187,8 @@ void __init acpi_boot_table_init(void)
>  	/*
>  	 * Enable ACPI instead of device tree unless
>  	 * - ACPI has been disabled explicitly (acpi=off), or
> -	 * - the device tree is not empty (it has more than just a /chosen node)
> +	 * - the device tree is not empty (it has more than just a /chosen node,
> +	 *   and a /hypervisor node when running on Xen)
>  	 *   and ACPI has not been force enabled (acpi=force)
>  	 */
>  	if (param_acpi_off ||
> -- 
> 2.0.4
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-efi" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
