From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 3 Oct 2017 14:43:53 -0400 (EDT)
Subject: [PATCH 1/2] of/fdt: add of_fdt_device_is_available function
In-Reply-To: <20171003161815.25999-1-robh@kernel.org>
References: <20171003161815.25999-1-robh@kernel.org>
Message-ID: <nycvar.YSQ.7.76.1710031443230.5407@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 3 Oct 2017, Rob Herring wrote:

> Add an equivalent function to of_device_is_available for flattened DT, and
> convert the one existing open coded occurrence.
> 
> Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Signed-off-by: Rob Herring <robh@kernel.org>

Tested-by: Nicolas Pitre <nico@linaro.org>


> ---
>  drivers/of/fdt.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 27c535af0be8..f8c39705418b 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -132,6 +132,19 @@ bool of_fdt_is_big_endian(const void *blob, unsigned long node)
>  	return false;
>  }
>  
> +static bool of_fdt_device_is_available(const void *blob, unsigned long node)
> +{
> +	const char *status = fdt_getprop(blob, node, "status", NULL);
> +
> +	if (!status)
> +		return true;
> +
> +	if (!strcmp(status, "ok") || !strcmp(status, "okay"))
> +		return true;
> +
> +	return false;
> +}
> +
>  /**
>   * of_fdt_match - Return true if node matches a list of compatible values
>   */
> @@ -605,7 +618,6 @@ static int __init __fdt_scan_reserved_mem(unsigned long node, const char *uname,
>  					  int depth, void *data)
>  {
>  	static int found;
> -	const char *status;
>  	int err;
>  
>  	if (!found && depth == 1 && strcmp(uname, "reserved-memory") == 0) {
> @@ -625,8 +637,7 @@ static int __init __fdt_scan_reserved_mem(unsigned long node, const char *uname,
>  		return 1;
>  	}
>  
> -	status = of_get_flat_dt_prop(node, "status", NULL);
> -	if (status && strcmp(status, "okay") != 0 && strcmp(status, "ok") != 0)
> +	if (!of_fdt_device_is_available(initial_boot_params, node))
>  		return 0;
>  
>  	err = __reserved_mem_reserve_reg(node, uname);
> -- 
> 2.11.0
> 
> 
