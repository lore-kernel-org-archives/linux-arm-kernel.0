From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Fri, 6 May 2016 11:59:14 -0700
Subject: [PATCH 3/5] remoteproc: core: Add ability to select a firmware
 from the client
In-Reply-To: <1462454983-13168-4-git-send-email-lee.jones@linaro.org>
References: <1462454983-13168-1-git-send-email-lee.jones@linaro.org>
 <1462454983-13168-4-git-send-email-lee.jones@linaro.org>
Message-ID: <20160506185914.GF1256@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 05 May 06:29 PDT 2016, Lee Jones wrote:

> ST Co-Processors can be loaded with different firmwares to execute
> specific tasks without the need for unloading the rproc module.
> 

I'm very much interested in ideas related to this and who "owns" the
life cycle of remoteprocs, do you have any code I can take a look at
that's using this interface?

> This patch provides a function which can update the firmware name.
> 
> NB: This can only happen if the rproc is offline.
> 

How is this working in the case when the remoteproc provides vdevs that
is holding references towards the rproc?

Do you unload rpmsg et al before doing this?

> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/remoteproc/remoteproc_core.c | 63 ++++++++++++++++++++++++++++++++++++
>  include/linux/remoteproc.h           | 13 ++++++++
>  2 files changed, 76 insertions(+)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 85e5fd8..03720c0 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1004,6 +1004,7 @@ int rproc_trigger_recovery(struct rproc *rproc)
>  
>  	/* Free the copy of the resource table */
>  	kfree(rproc->cached_table);
> +	rproc->cached_table = NULL;
>  

Somewhat unrelated, but should be fixed, so let's go with it.

>  	return rproc_add_virtio_devices(rproc);
>  }
> @@ -1329,6 +1330,66 @@ struct rproc *rproc_get_by_phandle(phandle phandle)
>  EXPORT_SYMBOL(rproc_get_by_phandle);
>  
>  /**
> + * rproc_set_fw_name() - change rproc fw name
> + * @rproc: rproc handle
> + * @firmware: name of firmware file to load
> + *
> + * set a new firmware name for rproc handle
> + * firmware name can be updated only if the rproc is offline
> + * if firmware name is NULL the fw name is set on default name
> + *
> + * this function can wait, if the old fw config virtio is not yet finish
> + * (fw config request is asynchronous)
> + *
> + * Returns 0 on success and an appropriate error code otherwise.
> + */
> +int rproc_set_fw_name(struct rproc *rproc, const char *firmware)
> +{
> +	struct rproc_vdev *rvdev, *rvtmp;
> +
> +	if (!rproc)
> +		return -EINVAL;
> +
> +	/* if rproc is just being registered, wait */
> +	wait_for_completion(&rproc->firmware_loading_complete);
> +
> +	mutex_lock(&rproc->lock);
> +
> +	if (rproc->state != RPROC_OFFLINE) {
> +		mutex_unlock(&rproc->lock);
> +		return -EBUSY;
> +	}
> +
> +	if (rproc->firmware && rproc->firmware != rproc->orig_firmware)
> +		kfree(rproc->firmware);

kfree(NULL) is fine, so you can drop the first part of the expression.

> +
> +	/* restore original fw name */
> +	if (!firmware) {
> +		rproc->firmware = rproc->orig_firmware;
> +	} else {
> +		rproc->firmware = kstrdup(firmware, GFP_KERNEL);
> +		if (!rproc->firmware)
> +			rproc->firmware = rproc->orig_firmware;

In the unlikely event that kstrdup fails I we should leave
rproc->firmware unchanged and return an error here.

As this is written we will silently (with a blarg in the log if anyone
checks) switch back to the default firmware and boot that.

> +	}
> +
> +	dev_info(&rproc->dev, "%s, fw name updated with:%s\n",
> +		 rproc->name, rproc->firmware);
> +
> +	mutex_unlock(&rproc->lock);
> +
> +	/* clean up remote vdev entries */
> +	list_for_each_entry_safe(rvdev, rvtmp, &rproc->rvdevs, node)
> +		rproc_remove_virtio_dev(rvdev);
> +
> +	/* Free the copy of the resource table */
> +	kfree(rproc->cached_table);
> +	rproc->cached_table = NULL;
> +
> +	return rproc_add_virtio_devices(rproc);
> +}
> +EXPORT_SYMBOL(rproc_set_fw_name);
[..]
>  
> +struct rproc_subdev {
> +	struct device dev;
> +	struct rproc *rproc;
> +	struct resource *res;
> +};
> +
> +#define to_subdevice(d) container_of(d, struct rproc_subdev, dev)
> +struct rproc_subdev *rproc_subdev_add(struct rproc *rproc,
> +				      struct resource *res);
> +void rproc_subdev_del(struct rproc_subdev *subdev);
> +struct device *rproc_subdev_lookup(struct rproc *rproc, const char *name);
> +int rproc_set_fw_name(struct rproc *rproc, const char *firmware);

These belongs to the next patch.

Regards,
Bjorn
