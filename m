From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 30 Jun 2016 16:37:32 +0100
Subject: [PATCH V2] coresight: add PM runtime calls to
 coresight_simple_func()
In-Reply-To: <1466780963-21396-1-git-send-email-mathieu.poirier@linaro.org>
References: <1466780963-21396-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <57753CBC.7070905@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 24/06/16 16:09, Mathieu Poirier wrote:
> It is mandatory to enable a coresight block's power domain before
> trying to access management registers.  Otherwise the transaction
> simply stalls, leading to a system hang.
>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
> Change from V1:
>     - Fix erroneous return point in the macro.
>

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

>   drivers/hwtracing/coresight/coresight-priv.h | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
> index ad975c58080d..decfd52b5dc3 100644
> --- a/drivers/hwtracing/coresight/coresight-priv.h
> +++ b/drivers/hwtracing/coresight/coresight-priv.h
> @@ -16,6 +16,7 @@
>   #include <linux/bitops.h>
>   #include <linux/io.h>
>   #include <linux/coresight.h>
> +#include <linux/pm_runtime.h>
>
>   /*
>    * Coresight management registers (0xf00-0xfcc)
> @@ -42,8 +43,11 @@ static ssize_t name##_show(struct device *_dev,				\
>   			   struct device_attribute *attr, char *buf)	\
>   {									\
>   	type *drvdata = dev_get_drvdata(_dev->parent);			\
> -	return scnprintf(buf, PAGE_SIZE, "0x%x\n",			\
> -			 readl_relaxed(drvdata->base + offset));	\
> +	u32 val;							\
> +	pm_runtime_get_sync(_dev->parent);				\
> +	val = readl_relaxed(drvdata->base + offset);			\
> +	pm_runtime_put_sync(_dev->parent);				\
> +	return scnprintf(buf, PAGE_SIZE, "0x%x\n", val);		\
>   }									\
>   static DEVICE_ATTR_RO(name)
>
>
