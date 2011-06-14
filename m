From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 15 Jun 2011 00:48:58 +0100
Subject: [MPCore Watchdog]: Convert from misc_dev to dynamic device node.
In-Reply-To: <BANLkTinaQpnVxwX5rB1jrabGX6ArvhhS7g@mail.gmail.com>
References: <BANLkTinaQpnVxwX5rB1jrabGX6ArvhhS7g@mail.gmail.com>
Message-ID: <20110614234858.GA15534@gallagher>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On Tue, Jun 14, 2011 at 04:29:26PM -0700, Peter Fordham wrote:
> The current MPCore watchdog driver uses a misc_dev device node.
> This patch changes it to use dynamically allocated device numbers.

I'm not sure that this is the correct thing to do.  All other watchdog devices 
use a miscdevice with a major:minor of 10:130, is there a specific reason 
that this node needs to be dynamic?

Also few other comments inline.

Jamie

> ---
>  drivers/watchdog/mpcore_wdt.c |   48 +++++++++++++++++++++++++++++------------
>  1 files changed, 34 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/watchdog/mpcore_wdt.c b/drivers/watchdog/mpcore_wdt.c
> index 2b4af22..f6afc20 100644
> --- a/drivers/watchdog/mpcore_wdt.c
> +++ b/drivers/watchdog/mpcore_wdt.c
> @@ -32,6 +32,8 @@
>  #include <linux/uaccess.h>
>  #include <linux/slab.h>
>  #include <linux/io.h>
> +#include <linux/cdev.h>
> +#include <linux/device.h>
> 
>  #include <asm/smp_twd.h>
> 
> @@ -42,6 +44,9 @@ struct mpcore_wdt {
>  	int		irq;
>  	unsigned int	perturb;
>  	char		expect_close;
> +        struct cdev     cdev;
> +        struct class    *class;
> +        dev_t           number;

It looks like tabs have been converted to spaces here.

>  };
> 
>  static struct platform_device *mpcore_wdt_dev;
> @@ -318,12 +323,6 @@ static const struct file_operations mpcore_wdt_fops = {
>  	.release	= mpcore_wdt_release,
>  };
> 
> -static struct miscdevice mpcore_wdt_miscdev = {
> -	.minor		= WATCHDOG_MINOR,
> -	.name		= "watchdog",
> -	.fops		= &mpcore_wdt_fops,
> -};
> -
>  static int __devinit mpcore_wdt_probe(struct platform_device *dev)
>  {
>  	struct mpcore_wdt *wdt;
> @@ -358,14 +357,15 @@ static int __devinit mpcore_wdt_probe(struct
> platform_device *dev)
>  		goto err_free;
>  	}
> 
> -	mpcore_wdt_miscdev.parent = &dev->dev;
> -	ret = misc_register(&mpcore_wdt_miscdev);
> -	if (ret) {
> + 	ret = alloc_chrdev_region(&wdt->number, 0, 1, "mpcore_wdt");
> +	if (ret < 0) {
>  		dev_printk(KERN_ERR, wdt->dev,
> -			"cannot register miscdev on minor=%d (err=%d)\n",
> -							WATCHDOG_MINOR, ret);
> +			"cannot register with dynamic device number (err=%d)\n", -ret);
>  		goto err_misc;
>  	}
> +	dev_printk(KERN_INFO, wdt->dev, "using device number %d, %d",
> MAJOR(wdt->number), MINOR(wdt->number));
> +
> +        cdev_init(&wdt->cdev, &mpcore_wdt_fops);
> 
>  	ret = request_irq(wdt->irq, mpcore_wdt_fire, IRQF_DISABLED,
>  							"mpcore_wdt", wdt);
> @@ -379,10 +379,24 @@ static int __devinit mpcore_wdt_probe(struct
> platform_device *dev)
>  	platform_set_drvdata(dev, wdt);
>  	mpcore_wdt_dev = dev;
> 
> -	return 0;
> +        ret = cdev_add(&wdt->cdev, wdt->number, 1);
> +	if (ret < 0) {
> +		dev_printk(KERN_ERR, wdt->dev, "failed to add character device\n");
> +		goto err_cdev_add;
> +	}
> 
> +        /* create /dev/watchdog
> +         * we use udev to make the file
> +         */
> +        wdt->class = class_create(THIS_MODULE,"watchdog");
> +        (void) device_create(wdt->class, wdt->dev,
> wdt->number,NULL,"watchdog");

The return value of class_create() and device_create() should be checked here 
and handled appropriately.  I believe the sysfs classes are pretty much 
deprecated now in preference of a bus too.

> +
> +        return 0;
> +
> +err_cdev_add:
> +	free_irq(wdt->irq, wdt);
>  err_irq:
> -	misc_deregister(&mpcore_wdt_miscdev);
> +        unregister_chrdev_region (wdt->number, 1);
>  err_misc:
>  	iounmap(wdt->base);
>  err_free:
> @@ -395,9 +409,15 @@ static int __devexit mpcore_wdt_remove(struct
> platform_device *dev)
>  {
>  	struct mpcore_wdt *wdt = platform_get_drvdata(dev);
> 
> +        device_destroy(wdt->class,wdt->number);
> +        class_unregister(wdt->class);
> +        class_destroy(wdt->class);

class_destroy() calls calls_unregister() internally so you wouldn't need to 
call this.

> +        cdev_del(&wdt->cdev);
> +
>  	platform_set_drvdata(dev, NULL);
> 
> -	misc_deregister(&mpcore_wdt_miscdev);
> +        unregister_chrdev_region (wdt->number, 1);
> 
>  	mpcore_wdt_dev = NULL;
> 
> -- 
> 1.7.0.4
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
