From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 2 Nov 2018 12:24:12 +0100
Subject: [PATCH v2 2/2] ARM: cpuidle: Convert to use
 cpuidle_register|unregister()
In-Reply-To: <20181101101558.3035-1-ulf.hansson@linaro.org>
References: <20181101101558.3035-1-ulf.hansson@linaro.org>
Message-ID: <e167cd49-1547-17ad-1bba-9dbf892e8286@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/11/2018 11:15, Ulf Hansson wrote:
> The only reason that remains, to why the ARM cpuidle driver calls
> cpuidle_register_driver(), is to avoid printing an error message in case
> another driver already have been registered for the CPU. This seems a bit
> silly, but more importantly, if that is a common scenario, perhaps we
> should change cpuidle_register() accordingly instead.
> 
> In either case, let's consolidate the code, by converting to use
> cpuidle_register|unregister(), which also avoids the unnecessary allocation
> of the struct cpuidle_device.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
> 
> Changes in v2:
> 	- Fixup spelling in changelog.
> 	- Added Lorenzo's reviewed-by tag.
> 
> ---
>  drivers/cpuidle/cpuidle-arm.c | 30 +++---------------------------
>  1 file changed, 3 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
> index df564d783216..3a407a3ef22b 100644
> --- a/drivers/cpuidle/cpuidle-arm.c
> +++ b/drivers/cpuidle/cpuidle-arm.c
> @@ -82,7 +82,6 @@ static int __init arm_idle_init_cpu(int cpu)
>  {
>  	int ret;
>  	struct cpuidle_driver *drv;
> -	struct cpuidle_device *dev;
>  
>  	drv = kmemdup(&arm_idle_driver, sizeof(*drv), GFP_KERNEL);
>  	if (!drv)
> @@ -119,33 +118,12 @@ static int __init arm_idle_init_cpu(int cpu)
>  		goto out_kfree_drv;
>  	}
>  
> -	ret = cpuidle_register_driver(drv);
> -	if (ret) {
> -		if (ret != -EBUSY)
> -			pr_err("Failed to register cpuidle driver\n");
> +	ret = cpuidle_register(drv, NULL);
> +	if (ret)
>  		goto out_kfree_drv;
> -	}
> -
> -	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
> -	if (!dev) {
> -		ret = -ENOMEM;
> -		goto out_unregister_drv;
> -	}
> -	dev->cpu = cpu;
> -
> -	ret = cpuidle_register_device(dev);
> -	if (ret) {
> -		pr_err("Failed to register cpuidle device for CPU %d\n",
> -		       cpu);
> -		goto out_kfree_dev;
> -	}
>  
>  	return 0;
>  
> -out_kfree_dev:
> -	kfree(dev);
> -out_unregister_drv:
> -	cpuidle_unregister_driver(drv);
>  out_kfree_drv:
>  	kfree(drv);
>  	return ret;
> @@ -176,9 +154,7 @@ static int __init arm_idle_init(void)
>  	while (--cpu >= 0) {
>  		dev = per_cpu(cpuidle_devices, cpu);
>  		drv = cpuidle_get_cpu_driver(dev);
> -		cpuidle_unregister_device(dev);
> -		cpuidle_unregister_driver(drv);
> -		kfree(dev);
> +		cpuidle_unregister(drv);
>  		kfree(drv);
>  	}
>  
> 


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
