From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 23 Jun 2016 17:37:12 +0100
Subject: [PATCH] coresight: add PM runtime calls to coresight_simple_func()
In-Reply-To: <1466185307-19539-1-git-send-email-mathieu.poirier@linaro.org>
References: <1466185307-19539-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <576C1038.502@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 17/06/16 18:41, Mathieu Poirier wrote:
> It is mandatory to enable a coresight block's power domain before
> trying to access management registers.  Otherwise the transaction
> simply stalls, leading to a system hang.
>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>   drivers/hwtracing/coresight/coresight-priv.h | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
> index ad975c58080d..b047241e7496 100644
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
> @@ -42,8 +43,10 @@ static ssize_t name##_show(struct device *_dev,				\
>   			   struct device_attribute *attr, char *buf)	\
>   {									\
>   	type *drvdata = dev_get_drvdata(_dev->parent);			\
> +	pm_runtime_get_sync(_dev->parent);				\
>   	return scnprintf(buf, PAGE_SIZE, "0x%x\n",			\
>   			 readl_relaxed(drvdata->base + offset));	\
> +	pm_runtime_put_sync(_dev->parent);				\

This is wrong, I just noticed when I was playing around this.
Perhaps you meant to do this before returning ? I wonder why compiler
doesn't throw any error.

-- 
Regards,
Sudeep
