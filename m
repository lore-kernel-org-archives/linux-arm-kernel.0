From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed, 6 Jun 2018 10:24:22 +0200
Subject: [PATCH v4 05/14] coresight: get/put module in
 coresight_build/release_path
In-Reply-To: <20180605210710.22227-6-kim.phillips@arm.com>
References: <20180605210710.22227-1-kim.phillips@arm.com>
 <20180605210710.22227-6-kim.phillips@arm.com>
Message-ID: <20180606082422.GB19727@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 05, 2018 at 04:07:01PM -0500, Kim Phillips wrote:
> Increment the refcnt for driver modules in current use by calling
> module_get in coresight_build_path and module_put in release_path.
> 
> This prevents driver modules from being unloaded when they are in use,
> either in sysfs or perf mode.

Why does it matter?  Shouldn't you be allowed to remove any module at
any point in time, much like a networking driver?


> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Suzuki K Poulose <Suzuki.Poulose@arm.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Kim Phillips <kim.phillips@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
> index 338f1719641c..1c941351f1d1 100644
> --- a/drivers/hwtracing/coresight/coresight.c
> +++ b/drivers/hwtracing/coresight/coresight.c
> @@ -465,6 +465,12 @@ static int _coresight_build_path(struct coresight_device *csdev,
>  
>  	node->csdev = csdev;
>  	list_add(&node->link, path);
> +
> +	if (!try_module_get(csdev->dev.parent->driver->owner)) {

What is to keep parent->driver from going away right here?  What keeps
parent around?  This feels very fragile to me, I don't see any locking
anywhere around this code path to try to keep things in place.

thanks,

greg k-h
