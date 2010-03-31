From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 31 Mar 2010 02:13:37 +0100
Subject: [PATCH 3/4] s3c244x: configure GPG13-15 as input before suspend
In-Reply-To: <1269109209-26237-4-git-send-email-anarsoul@gmail.com>
References: <1269109209-26237-1-git-send-email-anarsoul@gmail.com>
	<1269109209-26237-4-git-send-email-anarsoul@gmail.com>
Message-ID: <20100331011337.GM31126@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 20, 2010 at 08:20:08PM +0200, Vasily Khoruzhick wrote:
> According to datasheet GPG13-15 must be configured as input in NAND
> boot mode, otherwise device will not be able to wake up.
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  arch/arm/mach-s3c2440/s3c244x.c |   12 ++++++++++++
>  1 files changed, 12 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c2440/s3c244x.c b/arch/arm/mach-s3c2440/s3c244x.c
> index 5e4a97e..b100e92 100644
> --- a/arch/arm/mach-s3c2440/s3c244x.c
> +++ b/arch/arm/mach-s3c2440/s3c244x.c
> @@ -21,6 +21,7 @@
>  #include <linux/sysdev.h>
>  #include <linux/clk.h>
>  #include <linux/io.h>
> +#include <linux/gpio.h>
>  
>  #include <asm/mach/arch.h>
>  #include <asm/mach/map.h>
> @@ -146,6 +147,17 @@ static struct sleep_save s3c244x_sleep[] = {
>  static int s3c244x_suspend(struct sys_device *dev, pm_message_t state)
>  {
>  	s3c_pm_do_save(s3c244x_sleep, ARRAY_SIZE(s3c244x_sleep));
> +#ifdef CONFIG_S3C_DEV_NAND
> +	/* According to S3C2442 user's manual, page 7-17,
> +	 * when the system is operating in NAND boot mode,
> +	 * the hardware pin configuration - EINT[23:21] ???
> +	 * must be set as input for starting up after
> +	 * wakeup from sleep mode
> +	 */
> +	s3c2410_gpio_cfgpin(S3C2410_GPG(15), S3C2410_GPIO_INPUT);
> +	s3c2410_gpio_cfgpin(S3C2410_GPG(14), S3C2410_GPIO_INPUT);
> +	s3c2410_gpio_cfgpin(S3C2410_GPG(13), S3C2410_GPIO_INPUT);

Please don't do this conditionally, we can compile kernels supporting
many machines, some of the machines might not be using this boot method.

I'll think over the solution.

1) Make each machine add a relevant sysdev to hook suspend/resume.

2) Update the nand driver to do this, but would (a) need to check what
   else is s3c2440 compatible, and (b) it doesn't know if the system
   has booted from NAND or not.

> +#endif
>  	return 0;
>  }
>  
> -- 
> 1.7.0.2
> 
> 

> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
