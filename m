From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 8 Jun 2011 19:46:13 -0600
Subject: [PATCH] ARM: DT: don't try to access physical address zero
In-Reply-To: <alpine.LFD.2.00.1106082138420.2142@xanadu.home>
References: <alpine.LFD.2.00.1106082138420.2142@xanadu.home>
Message-ID: <20110609014613.GA1112@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 08, 2011 at 09:40:47PM -0400, Nicolas Pitre wrote:
> From: Nicolas Pitre <nicolas.pitre@linaro.org>
> 
> If the DT physical address is zero, this is equivalent to no DT.
> Especially when the actual RAM physical address is not located at zero,
> the result of phys_to_virt() would point to la-la-land and crash the
> kernel, which crash is completely silent this early during boot.
> 
> Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> CC: Grant Likely <grant.likely@secretlab.ca>

Hmmm, I thought I had fixed that.

This is obviously correct.

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
> diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
> index a701e42..0cdd7b4 100644
> --- a/arch/arm/kernel/devtree.c
> +++ b/arch/arm/kernel/devtree.c
> @@ -76,6 +76,9 @@ struct machine_desc * __init setup_machine_fdt(unsigned int dt_phys)
>  	unsigned long dt_root;
>  	const char *model;
>  
> +	if (!dt_phys)
> +		return NULL;
> +
>  	devtree = phys_to_virt(dt_phys);
>  
>  	/* check device tree validity */
