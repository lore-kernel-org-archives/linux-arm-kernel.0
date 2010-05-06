From: aaro.koskinen@nokia.com (Aaro Koskinen)
Date: Thu, 06 May 2010 19:20:41 +0300
Subject: [PATCH 6/6] ARM: oprofile: convert from sysdev to platform device
In-Reply-To: <1271695361-7121-7-git-send-email-will.deacon@arm.com>
References: <1271695361-7121-1-git-send-email-will.deacon@arm.com>
	<1271695361-7121-2-git-send-email-will.deacon@arm.com>
	<1271695361-7121-3-git-send-email-will.deacon@arm.com>
	<1271695361-7121-4-git-send-email-will.deacon@arm.com>
	<1271695361-7121-5-git-send-email-will.deacon@arm.com>
	<1271695361-7121-6-git-send-email-will.deacon@arm.com>
	<1271695361-7121-7-git-send-email-will.deacon@arm.com>
Message-ID: <4BE2EC59.4060101@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Will Deacon wrote:
> This is a reworking of an original patch posted by Aaro Koskinen:
> 
> oprofile does not work with PM, because sysdev_suspend() is done with
> interrupts disabled and oprofile needs a mutex. Implementing oprofile
> as a platform device solves this problem.
> 
> Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
> Cc: Aaro Koskinen <aaro.koskinen@nokia.com>

You can change this to Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>

Thanks,

A.

> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm/oprofile/common.c |   44 +++++++++++++++++++++++++++++---------------
>  1 files changed, 29 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm/oprofile/common.c b/arch/arm/oprofile/common.c
> index aad83df..0691176 100644
> --- a/arch/arm/oprofile/common.c
> +++ b/arch/arm/oprofile/common.c
> @@ -10,13 +10,14 @@
>   */
>  
>  #include <linux/cpumask.h>
> +#include <linux/err.h>
>  #include <linux/errno.h>
>  #include <linux/init.h>
>  #include <linux/mutex.h>
>  #include <linux/oprofile.h>
>  #include <linux/perf_event.h>
> +#include <linux/platform_device.h>
>  #include <linux/slab.h>
> -#include <linux/sysdev.h>
>  #include <asm/stacktrace.h>
>  #include <linux/uaccess.h>
>  
> @@ -227,7 +228,7 @@ static void op_arm_stop(void)
>  }
>  
>  #ifdef CONFIG_PM
> -static int op_arm_suspend(struct sys_device *dev, pm_message_t state)
> +static int op_arm_suspend(struct platform_device *dev, pm_message_t state)
>  {
>  	mutex_lock(&op_arm_mutex);
>  	if (op_arm_enabled)
> @@ -236,7 +237,7 @@ static int op_arm_suspend(struct sys_device *dev, pm_message_t state)
>  	return 0;
>  }
>  
> -static int op_arm_resume(struct sys_device *dev)
> +static int op_arm_resume(struct platform_device *dev)
>  {
>  	mutex_lock(&op_arm_mutex);
>  	if (op_arm_enabled && op_perf_start())
> @@ -245,34 +246,42 @@ static int op_arm_resume(struct sys_device *dev)
>  	return 0;
>  }
>  
> -static struct sysdev_class oprofile_sysclass = {
> -	.name		= "oprofile",
> +static struct platform_driver oprofile_driver = {
> +	.driver		= {
> +		.name		= "arm-oprofile",
> +	},
>  	.resume		= op_arm_resume,
>  	.suspend	= op_arm_suspend,
>  };
>  
> -static struct sys_device device_oprofile = {
> -	.id		= 0,
> -	.cls		= &oprofile_sysclass,
> -};
> +static struct platform_device *oprofile_pdev;
>  
>  static int __init init_driverfs(void)
>  {
>  	int ret;
>  
> -	if (!(ret = sysdev_class_register(&oprofile_sysclass)))
> -		ret = sysdev_register(&device_oprofile);
> +	ret = platform_driver_register(&oprofile_driver);
> +	if (ret)
> +		goto out;
> +
> +	oprofile_pdev =	platform_device_register_simple(
> +				oprofile_driver.driver.name, 0, NULL, 0);
> +	if (IS_ERR(oprofile_pdev)) {
> +		ret = PTR_ERR(oprofile_pdev);
> +		platform_driver_unregister(&oprofile_driver);
> +	}
>  
> +out:
>  	return ret;
>  }
>  
>  static void  exit_driverfs(void)
>  {
> -	sysdev_unregister(&device_oprofile);
> -	sysdev_class_unregister(&oprofile_sysclass);
> +	platform_device_unregister(oprofile_pdev);
> +	platform_driver_unregister(&oprofile_driver);
>  }
>  #else
> -#define init_driverfs()	do { } while (0)
> +static int __init init_driverfs(void) { return 0; }
>  #define exit_driverfs() do { } while (0)
>  #endif /* CONFIG_PM */
>  
> @@ -353,6 +362,12 @@ int __init oprofile_arch_init(struct oprofile_operations *ops)
>  		return -ENOMEM;
>  	}
>  
> +	ret = init_driverfs();
> +	if (ret) {
> +		kfree(counter_config);
> +		return ret;
> +	}
> +
>  	for_each_possible_cpu(cpu) {
>  		perf_events[cpu] = kcalloc(perf_num_counters,
>  				sizeof(struct perf_event *), GFP_KERNEL);
> @@ -365,7 +380,6 @@ int __init oprofile_arch_init(struct oprofile_operations *ops)
>  		}
>  	}
>  
> -	init_driverfs();
>  	ops->backtrace		= arm_backtrace;
>  	ops->create_files	= op_arm_create_files;
>  	ops->setup		= op_arm_setup;
