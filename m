From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Mon, 30 Jan 2017 14:01:19 -0800
Subject: [PATCH] remoteproc: Move rproc_delete_debug_dir() to rproc_del()
In-Reply-To: <1485222528-20603-1-git-send-email-spjoshi@codeaurora.org>
References: <1485222528-20603-1-git-send-email-spjoshi@codeaurora.org>
Message-ID: <20170130220119.GD31134@builder>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 23 Jan 17:48 PST 2017, Sarangdhar Joshi wrote:

> The "remoteproc{0,1...}" sysfs entries are added in
> rproc_add() and deleted in rproc_type_release() instead of
> in rproc_del(). That leaves these lingering entries sticking
> around after we return from rproc_del(). Move the
> rproc_delete_debug_dir() to rproc_del() to fix this.
> 
> Signed-off-by: Sarangdhar Joshi <spjoshi@codeaurora.org>

I moved the rproc_delete_debug_dir() below the list_del() region to
allow reuse of the critical region in the upcoming "deleted" patch.

Applied, thank you.

Regards,
Bjorn

> ---
>  drivers/remoteproc/remoteproc_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 953ee29..78200a7 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1315,8 +1315,6 @@ static void rproc_type_release(struct device *dev)
>  
>  	dev_info(&rproc->dev, "releasing %s\n", rproc->name);
>  
> -	rproc_delete_debug_dir(rproc);
> -
>  	idr_destroy(&rproc->notifyids);
>  
>  	if (rproc->index >= 0)
> @@ -1491,6 +1489,8 @@ int rproc_del(struct rproc *rproc)
>  	if (rproc->auto_boot)
>  		rproc_shutdown(rproc);
>  
> +	rproc_delete_debug_dir(rproc);
> +
>  	/* the rproc is downref'ed as soon as it's removed from the klist */
>  	mutex_lock(&rproc_list_mutex);
>  	list_del(&rproc->node);
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
