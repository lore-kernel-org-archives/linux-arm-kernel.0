From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Tue, 9 Aug 2016 10:40:49 -0700
Subject: [PATCH 8/9] remoteproc: core: Skip resource table integrity
 checks if there are amendments
In-Reply-To: <20160804092153.23032-9-lee.jones@linaro.org>
References: <20160804092153.23032-1-lee.jones@linaro.org>
 <20160804092153.23032-9-lee.jones@linaro.org>
Message-ID: <20160809174049.GE26240@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 04 Aug 02:21 PDT 2016, Lee Jones wrote:

> There is little point wasting CPU cycles completing integrity checking
> (i.e. ensuring nothing has changed) on the resource table if we *know*
> that it will be changed (by us).  In this patch we skip resource table
> integrity checks if a platform-specific remoteproc driver has requested
> an amendment or an appended entry.
> 

If we apply the auto-boot series first, I believe this dance goes away.

Regards,
Bjorn

> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/remoteproc/remoteproc_core.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 6b4e29a..9a077e4 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1126,6 +1126,10 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
>  	rproc->bootaddr = rproc_get_boot_addr(rproc, fw);
>  	ret = -EINVAL;
>  
> +	/* If we've overridden the resource table, we know it's changed. */
> +	if (!list_empty(&rproc->override_resources))
> +		goto skip_table_check;
> +
>  	/* look for the resource table */
>  	table = rproc_find_rsc_table(rproc, fw, &tablesz);
>  	if (!table) {
> @@ -1139,6 +1143,8 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
>  		goto clean_up;
>  	}
>  
> + skip_table_check:
> +
>  	/* handle fw resources which are required to boot rproc */
>  	ret = rproc_handle_resources(rproc, tablesz, rproc_loading_handlers);
>  	if (ret) {
> @@ -1216,10 +1222,15 @@ static void rproc_fw_config_virtio(const struct firmware *fw, void *context)
>  		table = rproc_apply_resource_overrides(rproc, &table, &tablesz);
>  		if (IS_ERR(table))
>  			goto out;
> +
> +		/* No point checking table if we know it *has* changed */
> +		goto skip_table_check;
>  	}
>  
>  	rproc->table_csum = crc32(0, table, tablesz);
>  
> + skip_table_check:
> +
>  	/*
>  	 * Create a copy of the resource table. When a virtio device starts
>  	 * and calls vring_new_virtqueue() the address of the allocated vring
> -- 
> 2.9.0
> 
