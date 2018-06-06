From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Wed, 6 Jun 2018 12:14:33 +0530
Subject: [PATCH 01/20] coresight: Fix memory leak in coresight_register
In-Reply-To: <1528235011-30691-2-git-send-email-suzuki.poulose@arm.com>
References: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
 <1528235011-30691-2-git-send-email-suzuki.poulose@arm.com>
Message-ID: <b0100f00-c706-3a41-ca55-3c1329c53aa3@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suzuki,


On Wednesday 06 June 2018 03:13 AM, Suzuki K Poulose wrote:
> commit 6403587a930c ("coresight: use put_device() instead of kfree()")
> introduced a memory leak where, if we fail to register the device
> for coresight_device, we don't free the "coresight_device" object,
> which was allocated via kzalloc(). Fix this by jumping to the
> appropriate error path.
put_device() will decrement the last reference and then
free the memory by calling dev->release.  Internally
put_device() -> kobject_put() -> kobject_cleanup() which is
responsible to call 'dev -> release' and also free other kobject
resources. If you will see the coresight_device_release. There
we are releasing all allocated memory. Still if you call kfree() again
then it'll be redundancy.

~arvind
>
> Fixes: commit 6403587a930c ("coresight: use put_device() instead of kfree()")
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Arvind Yadav <arvind.yadav.cs@gmail.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>   drivers/hwtracing/coresight/coresight.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
> index 4969b32..2893cfe 100644
> --- a/drivers/hwtracing/coresight/coresight.c
> +++ b/drivers/hwtracing/coresight/coresight.c
> @@ -1020,7 +1020,7 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
>   	ret = device_register(&csdev->dev);
>   	if (ret) {
>   		put_device(&csdev->dev);
> -		goto err_kzalloc_csdev;
> +		goto err_kzalloc_refcnts;
>   	}
>   
>   	mutex_lock(&coresight_mutex);
