From: Jonathan.Cameron@huawei.com (Jonathan Cameron)
Date: Thu, 17 May 2018 10:14:39 +0100
Subject: [PATCH 8/8] firmware: arm_scmi: simplify exit path by returning
 on error
In-Reply-To: <1525885634-22348-9-git-send-email-sudeep.holla@arm.com>
References: <1525885634-22348-1-git-send-email-sudeep.holla@arm.com>
 <1525885634-22348-9-git-send-email-sudeep.holla@arm.com>
Message-ID: <20180517101439.00007ba9@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 9 May 2018 18:07:14 +0100
Sudeep Holla <sudeep.holla@arm.com> wrote:

> Yet another nasty indentation left out during code restructuring. It's
> must simpler to return on error instead of having unnecessary indentation.
> 
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


> ---
>  drivers/firmware/arm_scmi/driver.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index 4087d6c50ecd..e996395af5f2 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -687,11 +687,12 @@ static int scmi_remove(struct platform_device *pdev)
>  		list_del(&info->node);
>  	mutex_unlock(&scmi_list_mutex);
>  
> -	if (!ret) {
> -		/* Safe to free channels since no more users */
> -		ret = idr_for_each(idr, scmi_mbox_free_channel, idr);
> -		idr_destroy(&info->tx_idr);
> -	}
> +	if (ret)
> +		return ret;
> +
> +	/* Safe to free channels since no more users */
> +	ret = idr_for_each(idr, scmi_mbox_free_channel, idr);
> +	idr_destroy(&info->tx_idr);
>  
>  	return ret;
>  }
