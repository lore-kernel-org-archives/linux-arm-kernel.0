From: will.deacon@arm.com (Will Deacon)
Date: Mon, 25 Apr 2016 11:53:40 +0100
Subject: [PATCH] make dt_scan_depth1_nodes more readable
In-Reply-To: <alpine.DEB.2.10.1604251121590.4855@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1604251121590.4855@sstabellini-ThinkPad-X260>
Message-ID: <20160425105340.GE16065@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 25, 2016 at 11:25:11AM +0100, Stefano Stabellini wrote:
> From: Mark Rutland <mark.rutland@arm.com>
> 
> Improve the readability of dt_scan_depth1_nodes by removing the nested
> conditionals.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
> 
> ---
> 
> Note: this patch is based on xentip/for-linus-4.7

So how should I merge it? :/

Will

> 
> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> index 57ee317..6884c76 100644
> --- a/arch/arm64/kernel/acpi.c
> +++ b/arch/arm64/kernel/acpi.c
> @@ -66,17 +66,24 @@ static int __init dt_scan_depth1_nodes(unsigned long node,
>  				       void *data)
>  {
>  	/*
> -	 * Return 1 as soon as we encounter a node at depth 1 that is
> -	 * not the /chosen node, or /hypervisor node with compatible
> -	 * string "xen,xen".
> +	 * Ignore anything not directly under the root node; we'll
> +	 * catch its parent instead.
>  	 */
> -	if (depth == 1 && (strcmp(uname, "chosen") != 0)) {
> -		if (strcmp(uname, "hypervisor") != 0 ||
> -		    !of_flat_dt_is_compatible(node, "xen,xen"))
> -			return 1;
> -	}
> +	if (depth != 1)
> +		return 0;
>  
> -	return 0;
> +	if (strcmp(uname, "chosen") == 0)
> +		return 0;
> +
> +	if (strcmp(uname, "hypervisor") == 0 &&
> +	    of_flat_dt_is_compatible(node, "xen,xen"))
> +		return 0;
> +
> +	/*
> +	 * This node at depth 1 is neither a chosen node nor a xen node,
> +	 * which we do not expect.
> +	 */
> +	return 1;
>  }
>  
>  /*
> 
