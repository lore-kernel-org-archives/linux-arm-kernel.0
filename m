From: rogerq@ti.com (Roger Quadros)
Date: Thu, 9 Jun 2016 11:00:32 +0300
Subject: [RFC v4 2/7] Revert "extcon: usb-gpio: switch to use pm wakeirq
 apis"
In-Reply-To: <1465393686-16644-3-git-send-email-k.kozlowski@samsung.com>
References: <1465393686-16644-1-git-send-email-k.kozlowski@samsung.com>
 <1465393686-16644-3-git-send-email-k.kozlowski@samsung.com>
Message-ID: <57592220.9030201@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-balbi at ti
+balbi at kernel

Hi,

On 08/06/16 16:48, Krzysztof Kozlowski wrote:
> This reverts commit 8106e404174253639731cc30a44f5b3ab764c5b7.

The above commit id is not present in v4.7-rc1 and this patch doesn't apply properly.
Can you please rebase this series on v4.7-rc1?

> 
> When using PM wakeirq API only one wakeup IRQ can be set. However the
> driver will support also VBUS GPIO so we need two wakeup interrupts.
> ---
>  drivers/extcon/extcon-usb-gpio.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/extcon/extcon-usb-gpio.c b/drivers/extcon/extcon-usb-gpio.c
> index 2512660dc4b9..a36aab007022 100644
> --- a/drivers/extcon/extcon-usb-gpio.c
> +++ b/drivers/extcon/extcon-usb-gpio.c
> @@ -24,7 +24,6 @@
>  #include <linux/module.h>
>  #include <linux/of_gpio.h>
>  #include <linux/platform_device.h>
> -#include <linux/pm_wakeirq.h>
>  #include <linux/slab.h>
>  #include <linux/workqueue.h>
>  #include <linux/acpi.h>
> @@ -143,8 +142,7 @@ static int usb_extcon_probe(struct platform_device *pdev)
>  	}
>  
>  	platform_set_drvdata(pdev, info);
> -	device_init_wakeup(dev, true);
> -	dev_pm_set_wake_irq(dev, info->id_irq);
> +	device_init_wakeup(dev, 1);
>  
>  	/* Perform initial detection */
>  	usb_extcon_detect_cable(&info->wq_detcable.work);
> @@ -158,9 +156,6 @@ static int usb_extcon_remove(struct platform_device *pdev)
>  
>  	cancel_delayed_work_sync(&info->wq_detcable);
>  
> -	dev_pm_clear_wake_irq(&pdev->dev);
> -	device_init_wakeup(&pdev->dev, false);
> -
>  	return 0;
>  }
>  
> @@ -170,6 +165,12 @@ static int usb_extcon_suspend(struct device *dev)
>  	struct usb_extcon_info *info = dev_get_drvdata(dev);
>  	int ret = 0;
>  
> +	if (device_may_wakeup(dev)) {
> +		ret = enable_irq_wake(info->id_irq);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	/*
>  	 * We don't want to process any IRQs after this point
>  	 * as GPIOs used behind I2C subsystem might not be
> @@ -185,6 +186,12 @@ static int usb_extcon_resume(struct device *dev)
>  	struct usb_extcon_info *info = dev_get_drvdata(dev);
>  	int ret = 0;
>  
> +	if (device_may_wakeup(dev)) {
> +		ret = disable_irq_wake(info->id_irq);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	enable_irq(info->id_irq);
>  	if (!device_may_wakeup(dev))
>  		queue_delayed_work(system_power_efficient_wq,
> 

--
cheers,
-roger
