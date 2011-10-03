From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 3 Oct 2011 10:59:33 +0100
Subject: [PATCH] ARM: S3C2410: Remove section mismatch warning
In-Reply-To: <1317634841-23339-1-git-send-email-tushar.behera@linaro.org>
References: <1317634841-23339-1-git-send-email-tushar.behera@linaro.org>
Message-ID: <20111003095933.GC11710@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 03, 2011 at 03:10:41PM +0530, Tushar Behera wrote:
> Some of the functions and structures did not have _init or __initdata
> attributes, even though they were referenced from functions / structures
> with those attribute, resulting in section mismatches.

Firstly - it's a good idea to include the warnings which you're fixing
in the commit log text, so that people know exactly what is being fixed.

> diff --git a/arch/arm/mach-s3c2410/usb-simtec.c b/arch/arm/mach-s3c2410/usb-simtec.c
> index 29bd3d9..3a1028c 100644
> --- a/arch/arm/mach-s3c2410/usb-simtec.c
> +++ b/arch/arm/mach-s3c2410/usb-simtec.c
> @@ -104,7 +104,7 @@ static struct s3c2410_hcd_info usb_simtec_info __initdata = {
>  };
>  
>  
> -int usb_simtec_init(void)
> +int __init usb_simtec_init(void)
>  {
>  	int ret;
>  

This one looks fine.

> diff --git a/arch/arm/mach-s3c2416/irq.c b/arch/arm/mach-s3c2416/irq.c
> index 28ad20d..153cb2f 100644
> --- a/arch/arm/mach-s3c2416/irq.c
> +++ b/arch/arm/mach-s3c2416/irq.c
> @@ -234,7 +234,7 @@ static int __init s3c2416_irq_add(struct sys_device *sysdev)
>  	return 0;
>  }
>  
> -static struct sysdev_driver s3c2416_irq_driver = {
> +static struct sysdev_driver s3c2416_irq_driver __initdata = {
>  	.add		= s3c2416_irq_add,
>  };
>  

I remain entirely unconvinced that this is correct.  As a result of
the "sysdev_driver_register(&s3c2416_sysclass, &s3c2416_irq_driver);"
call, this structure is placed on a list.

If this structure is marked __initdata, then the memory behind the
structure will be freed and overwritten - however, it's still on a
list which might be walked.  Such a walk would cause a kernel oops
or might even be an exploitable security hole if that page ends up
in userspace - especially as said structure contains function calls
which would be called in privileged mode.

The same comment applies to the other sysdev driver structures you're
marking __initdata too.
