From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 5 Aug 2016 13:52:05 +0100
Subject: [PATCH v6 18/18] remoteproc: core: Retry
 rproc_fw_config_virtio() if !rproc->table_ptr
In-Reply-To: <1467795276-21725-19-git-send-email-peter.griffin@linaro.org>
References: <1467795276-21725-1-git-send-email-peter.griffin@linaro.org>
 <1467795276-21725-19-git-send-email-peter.griffin@linaro.org>
Message-ID: <20160805125205.GY5243@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 06 Jul 2016, Peter Griffin wrote:

> When rproc drivers are built-in the async firmware load done by rproc_add()
> can fail due to the firmware not being present. Subsqeuent calls to
> rproc_fw_boot() then fail, even though by this point firmware has been
> successfully obtained.
> 
> This patch changes the behaviour to re-execute rproc_fw_config_virtio()
> in rproc_fw_boot() if it has previously failed, and we are sure it is
> now available.
> 
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>  drivers/remoteproc/remoteproc_core.c     | 25 +++++++++++++++++++------
>  drivers/remoteproc/remoteproc_internal.h |  3 +++
>  2 files changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index db3958b..749f261 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -801,8 +801,12 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
>  	struct resource_table *table, *loaded_table;
>  	int ret, tablesz;
>  
> +	/*
> +	 * This can happen when built-in if initial async fw load fails.
> +	 * However we now have firmware available so retry.
> +	 */
>  	if (!rproc->table_ptr)
> -		return -ENOMEM;
> +		rproc_fw_config_virtio(fw, rproc);

It's probably better to "hold that thought" on this patch, since we're
going to make resource tables optional.  I'm keen to tackle this
issue, but need to work a few other things before doing so.

Current task list:
 - Amend/supply new resource table from platform-specific drivers
 - Make resource tables optional
 - Obtain firmwares from the root file system
 - Lots more here including; co-proc DT support, co-proc console, etc

[...]

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
