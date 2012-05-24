From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 24 May 2012 02:15:54 -0700
Subject: [PATCH] remoteproc: block premature rproc booting
In-Reply-To: <1337687472-23009-1-git-send-email-ohad@wizery.com>
References: <1337687472-23009-1-git-send-email-ohad@wizery.com>
Message-ID: <4FBDFC4A.1060602@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/22/2012 4:51 AM, Ohad Ben-Cohen wrote:
> When an rproc instance is registered, remoteproc asynchronously
> loads its firmware in order to tell which vdevs it supports.
>
> Later on those vdevs are registered, and when probed, their drivers
> usually trigger powering on of the remote processor.
>
> OTOH, non-standard scenarios might involve early invocation of
> rproc_boot even before the asynchronous fw loading has completed.
>
> We're not sure we really want to support those scenarios, but right
> now we do (e.g. via rproc_get_by_name), so let's simply fix this race
> by blocking those premature rproc_boot() flows until the async fw
> loading is completed.
>
> Reported-and-tested-by: Sjur Brandeland <sjur.brandeland@stericsson.com>
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> ---
>  drivers/remoteproc/remoteproc_core.c |   12 ++++++++++++
>  1 files changed, 12 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 40e2b2d..464ea4f 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1141,6 +1141,18 @@ int rproc_boot(struct rproc *rproc)
>  
>  	dev = rproc->dev;
>  
> +	/*
> +	 * if asynchronoush fw loading is underway, wait up to 65 secs
> +	 * (just a bit more than the firmware request's timeout)
> +	 */
> +	ret = wait_for_completion_interruptible_timeout(
> +					&rproc->firmware_loading_complete,
> +					msecs_to_jiffies(65000));

The request_firmware timeout is defaulted to 60 seconds but not
necessarily 60 if the user has changed the timeout in sysfs.

Why does this need to be a timeout at all? Presumably
request_firmware_nowait() in rproc_register() will timeout and complete
the firmware_loading_complete completion variable. Would it suffice to
have some new rproc->state like RPROC_UNKNOWN that we set in
rproc_register() before adding it to the list of rprocs? If we find the
firmware then we set it to RPROC_READY or RPROC_REGISTERED? Then we
wait_for_completion() and check the state, failing if it's still in the
unknown state.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
