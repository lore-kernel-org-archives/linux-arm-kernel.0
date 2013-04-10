From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 10 Apr 2013 16:39:13 +0200
Subject: [PATCH 07/18] ARM: at91: cpuidle: use init/exit common routine
In-Reply-To: <1365603743-5618-8-git-send-email-daniel.lezcano@linaro.org>
References: <1365603743-5618-1-git-send-email-daniel.lezcano@linaro.org>
 <1365603743-5618-8-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <51657991.5010205@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/10/2013 04:22 PM, Daniel Lezcano :
> Remove the duplicate code and use the arm cpuidle driver's common code
> for initialization.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Seems okay:

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>


> ---
>  arch/arm/mach-at91/cpuidle.c |   17 ++---------------
>  1 file changed, 2 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/cpuidle.c b/arch/arm/mach-at91/cpuidle.c
> index 0130df7..48f1228 100644
> --- a/arch/arm/mach-at91/cpuidle.c
> +++ b/arch/arm/mach-at91/cpuidle.c
> @@ -27,8 +27,6 @@
>  
>  #define AT91_MAX_STATES	2
>  
> -static DEFINE_PER_CPU(struct cpuidle_device, at91_cpuidle_device);
> -
>  /* Actual code that puts the SoC in different idle states */
>  static int at91_enter_idle(struct cpuidle_device *dev,
>  			struct cpuidle_driver *drv,
> @@ -60,20 +58,9 @@ static struct cpuidle_driver at91_idle_driver = {
>  };
>  
>  /* Initialize CPU idle by registering the idle states */
> -static int at91_init_cpuidle(void)
> +static int __init at91_init_cpuidle(void)
>  {
> -	struct cpuidle_device *device;
> -
> -	device = &per_cpu(at91_cpuidle_device, smp_processor_id());
> -	device->state_count = AT91_MAX_STATES;
> -
> -	cpuidle_register_driver(&at91_idle_driver);
> -
> -	if (cpuidle_register_device(device)) {
> -		printk(KERN_ERR "at91_init_cpuidle: Failed registering\n");
> -		return -EIO;
> -	}
> -	return 0;
> +	return cpuidle_register(&at91_idle_driver, NULL);
>  }
>  
>  device_initcall(at91_init_cpuidle);
> 


-- 
Nicolas Ferre
