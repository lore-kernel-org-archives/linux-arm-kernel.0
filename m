From: gregkh@linuxfoundation.org (Greg KH)
Date: Sat, 8 Apr 2017 17:43:28 +0200
Subject: [PATCH 2/3] coresight: etm3x: Correctly output counter values in
 sysfs node
In-Reply-To: <1490634573-11068-3-git-send-email-mathieu.poirier@linaro.org>
References: <1490634573-11068-1-git-send-email-mathieu.poirier@linaro.org>
 <1490634573-11068-3-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <20170408154328.GB22401@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 27, 2017 at 11:09:32AM -0600, Mathieu Poirier wrote:
> From: Olav Haugan <ohaugan@codeaurora.org>
> 
> cntr_val_show function does not print the intended information. It is only
> printing the latest counter value. Fix this.
> 
> Signed-off-by: Olav Haugan <ohaugan@codeaurora.org>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>  drivers/hwtracing/coresight/coresight-etm3x-sysfs.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> index 4cbbd1313331..62acf07d604b 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> @@ -730,19 +730,29 @@ static ssize_t cntr_val_show(struct device *dev,
>  	u32 val;
>  	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>  	struct etm_config *config = &drvdata->config;
> +	int buf_size = PAGE_SIZE;
>  
>  	if (!local_read(&drvdata->mode)) {
>  		spin_lock(&drvdata->spinlock);
> -		for (i = 0; i < drvdata->nr_cntr; i++)
> -			ret += scnprintf(buf, PAGE_SIZE, "counter %d: %x\n",
> -				       i, config->cntr_val[i]);
> +		for (i = 0; i < drvdata->nr_cntr; i++) {
> +			ret += scnprintf(&buf[ret], buf_size,
> +					 "counter %d: %x\n",
> +					 i, config->cntr_val[i]);
> +			buf_size -= ret;
> +			if (buf_size <= 0)
> +				break;
> +		}

This is NOT a one-value-per-file thing.  That needs to be fixed, don't
try to make it worse here.  You are not following the proper sysfs
rules.

I can't take this, sorry.

greg k-h
