From: gregkh@linuxfoundation.org (Greg KH)
Date: Sat, 8 Apr 2017 17:42:23 +0200
Subject: [PATCH 1/3] coresight: Replace sprintf with scnprintf
In-Reply-To: <1490634573-11068-2-git-send-email-mathieu.poirier@linaro.org>
References: <1490634573-11068-1-git-send-email-mathieu.poirier@linaro.org>
 <1490634573-11068-2-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <20170408154223.GA22401@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 27, 2017 at 11:09:31AM -0600, Mathieu Poirier wrote:
> From: Olav Haugan <ohaugan@codeaurora.org>
> 
> Replace all occurrences of sprintf with scnprintf in coresight driver for
> consistency. scnprintf is also a safer alternative to sprintf.

But it's totally pointless here :(


> 
> Signed-off-by: Olav Haugan <ohaugan@codeaurora.org>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>  drivers/hwtracing/coresight/coresight-etb10.c      |  2 +-
>  drivers/hwtracing/coresight/coresight-etm-perf.c   |  2 +-
>  .../hwtracing/coresight/coresight-etm3x-sysfs.c    | 66 +++++++++++-----------
>  drivers/hwtracing/coresight/coresight-funnel.c     |  4 +-
>  drivers/hwtracing/coresight/coresight-stm.c        |  2 +-
>  drivers/hwtracing/coresight/coresight-tmc.c        |  2 +-
>  6 files changed, 39 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
> index d7325c6534ad..491f4da61c11 100644
> --- a/drivers/hwtracing/coresight/coresight-etb10.c
> +++ b/drivers/hwtracing/coresight/coresight-etb10.c
> @@ -588,7 +588,7 @@ static ssize_t trigger_cntr_show(struct device *dev,
>  	struct etb_drvdata *drvdata = dev_get_drvdata(dev->parent);
>  	unsigned long val = drvdata->trigger_cntr;
>  
> -	return sprintf(buf, "%#lx\n", val);
> +	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);

There is no need for this in sysfs show callbacks.  You _know_ this is a
PAGE_SIZE buffer, and that you can not overflow it with a simple number.

So don't change these types of functions for no reason please.

Same for most of this patch.

thanks,

greg k-h
