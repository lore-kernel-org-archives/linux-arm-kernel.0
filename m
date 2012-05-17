From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 17 May 2012 21:22:05 +0000
Subject: [PATCH 12/18] ARM: ux500: Disable platform setup of the ab8500
 when DT is enabled
In-Reply-To: <1337262323-27692-13-git-send-email-lee.jones@linaro.org>
References: <1337262323-27692-1-git-send-email-lee.jones@linaro.org>
 <1337262323-27692-13-git-send-email-lee.jones@linaro.org>
Message-ID: <201205172122.05611.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 17 May 2012, Lee Jones wrote:
> @@ -601,7 +601,6 @@ static struct platform_device *snowball_platform_devs[] __initdata = {
>  
>  static struct platform_device *snowball_of_platform_devs[] __initdata = {
>         &snowball_key_dev,
> -       &ab8500_device,
>  };
>  
>  static void __init mop500_init_machine(void)
> @@ -767,6 +766,9 @@ struct of_dev_auxdata u8500_auxdata_lookup[] __initdata = {
>  static const struct of_device_id u8500_local_bus_nodes[] = {
>         /* only create devices below soc node */
>         { .compatible = "stericsson,db8500", },
> +       { .compatible = "stericsson,db8500-prcmu", },
> +       { .compatible = "stericsson,ab8500", },
> +       { .compatible = "stericsson,ab8500-regulator", },
>         { .compatible = "simple-bus"},
>         { },
>  };

You remove the ab8500_device registration from snowball but add the prcmu and ab8500
in a place that is common to all three machines, so they will show up twice
on mop500 and hrefv60. If those two are not broken before this patch, I think
they are after it.

I think the two options you have here are to either remove the ab8500 device from
mop500_platform_devs[] too (essentially registering mop500_gpio_keys_device
and ab8500_device separately when you need them, instead of doing the loop),
or to split u8500_local_bus_nodes so you use a different table for snowball
from the one you use for the other boards.

	Arnd
