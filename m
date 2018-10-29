From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 29 Oct 2018 19:10:39 +0100
Subject: [PATCH 1/2] ARM: cpuidle: Don't register the driver when back-end
 init returns -ENXIO
In-Reply-To: <20181026144843.3028-1-ulf.hansson@linaro.org>
References: <../../misc/pm_patches/submitted_patches/cpuidle_arm_consolidate/0002-ARM-cpuidle-Convert-to-use-cpuidle_register-unregist.patch>
 <20181026144843.3028-1-ulf.hansson@linaro.org>
Message-ID: <6313b4d7-a2a7-98c4-3951-0a1c3e4ff2d5@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/10/2018 16:48, Ulf Hansson wrote:
> There's no point to register the cpuidle driver for the current CPU, when
> the initialization of the arch specific back-end data fails by returning
> -ENXIO.
> 
> Instead, let's re-order the sequence to its original flow, by first trying
> to initialize the back-end part and then act accordingly on the returned
> error code. Additionally, let's print the error message, no matter of what
> error code that was returned.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> 
> Note, as far as I can tell it's only qcom-spm that may return -ENXIO, which also
> was original reason to why this error path was invented.
> 
> Unfurtunate I don't have a qcom spm platfrom at hand, however I manually tried
> this by hacking the PSCI driver to return -ENXIO for some CPUs. So I assume it
> should then also work for qcom spm.
> 
> ---
>  drivers/cpuidle/cpuidle-arm.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
> index 073557f433eb..df564d783216 100644
> --- a/drivers/cpuidle/cpuidle-arm.c
> +++ b/drivers/cpuidle/cpuidle-arm.c
> @@ -103,13 +103,6 @@ static int __init arm_idle_init_cpu(int cpu)
>  		goto out_kfree_drv;
>  	}
>  
> -	ret = cpuidle_register_driver(drv);
> -	if (ret) {
> -		if (ret != -EBUSY)
> -			pr_err("Failed to register cpuidle driver\n");
> -		goto out_kfree_drv;
> -	}
> -

Why not move the following block at the beginning of the function ?

--->

        /*
         * Call arch CPU operations in order to initialize
         * idle states suspend back-end specific data
         */
        ret = arm_cpuidle_init(cpu);

        /*
         * Skip the cpuidle device initialization if the reported
         * failure is a HW misconfiguration/breakage (-ENXIO).
         */
        if (ret == -ENXIO)
                return 0;

        if (ret) {
                pr_err("CPU %d failed to init idle CPU ops\n", cpu);
                s/goto out_unregister_drv;/return ret;/
        }

<---


>  	/*
>  	 * Call arch CPU operations in order to initialize
>  	 * idle states suspend back-end specific data
> @@ -117,15 +110,20 @@ static int __init arm_idle_init_cpu(int cpu)
>  	ret = arm_cpuidle_init(cpu);
>  
>  	/*
> -	 * Skip the cpuidle device initialization if the reported
> +	 * Allow the initialization to continue for other CPUs, if the reported
>  	 * failure is a HW misconfiguration/breakage (-ENXIO).
>  	 */
> -	if (ret == -ENXIO)
> -		return 0;
> -
>  	if (ret) {
>  		pr_err("CPU %d failed to init idle CPU ops\n", cpu);
> -		goto out_unregister_drv;
> +		ret = ret == -ENXIO ? 0 : ret;
> +		goto out_kfree_drv;
> +	}
> +
> +	ret = cpuidle_register_driver(drv);
> +	if (ret) {
> +		if (ret != -EBUSY)
> +			pr_err("Failed to register cpuidle driver\n");
> +		goto out_kfree_drv;
>  	}
>  
>  	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
> 


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
