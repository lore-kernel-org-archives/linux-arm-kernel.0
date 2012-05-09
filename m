From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Wed, 9 May 2012 23:04:00 +0200
Subject: [PATCHv4 2/4] cpuidle: fix error handling in
 __cpuidle_register_device
In-Reply-To: <1336438662-10484-3-git-send-email-ccross@android.com>
References: <1336438662-10484-1-git-send-email-ccross@android.com>
 <1336438662-10484-3-git-send-email-ccross@android.com>
Message-ID: <201205092304.01272.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, May 08, 2012, Colin Cross wrote:
> Fix the error handling in __cpuidle_register_device to include
> the missing list_del.  Move it to a label, which will simplify
> the error handling when coupled states are added.
> 
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Tested-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Reviewed-by: Kevin Hilman <khilman@ti.com>
> Tested-by: Kevin Hilman <khilman@ti.com>
> Signed-off-by: Colin Cross <ccross@android.com>

I've said

Reviewed-by: Rafael J. Wysocki <rjw@sisk.pl>

to this already too.

Rafael


> ---
>  drivers/cpuidle/cpuidle.c |   13 +++++++++----
>  1 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index 3e3e3e4..4540672 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -403,13 +403,18 @@ static int __cpuidle_register_device(struct cpuidle_device *dev)
>  
>  	per_cpu(cpuidle_devices, dev->cpu) = dev;
>  	list_add(&dev->device_list, &cpuidle_detected_devices);
> -	if ((ret = cpuidle_add_sysfs(cpu_dev))) {
> -		module_put(cpuidle_driver->owner);
> -		return ret;
> -	}
> +	ret = cpuidle_add_sysfs(cpu_dev);
> +	if (ret)
> +		goto err_sysfs;
>  
>  	dev->registered = 1;
>  	return 0;
> +
> +err_sysfs:
> +	list_del(&dev->device_list);
> +	per_cpu(cpuidle_devices, dev->cpu) = NULL;
> +	module_put(cpuidle_driver->owner);
> +	return ret;
>  }
>  
>  /**
> 
