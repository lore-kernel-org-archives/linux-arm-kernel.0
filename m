From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 7 Mar 2012 11:22:19 +0000
Subject: [PATCH] ARM: S3C24XX: Fix Section mismatch
In-Reply-To: <1331116612-14491-1-git-send-email-kgene.kim@samsung.com>
References: <1331116612-14491-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <20120307112219.GR17370@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 07, 2012 at 02:36:52AM -0800, Kukjin Kim wrote:
> WARNING: arch/arm/mach-s3c24xx/built-in.o(.data+0xf44): Section mismatch in reference
> from the variable s3c2416_irq_interface to the function .init.text:s3c2416_irq_add()
> The variable s3c2416_irq_interface references
> the function __init s3c2416_irq_add()
> If the reference is valid then annotate the
> variable with __init* or __refdata (see linux/init.h) or name the variable:
> *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console
> 
> WARNING: arch/arm/mach-s3c24xx/built-in.o(.data+0x1b80): Section mismatch in reference
> from the variable s3c2443_irq_interface to the function .init.text:s3c2443_irq_add()
> The variable s3c2443_irq_interface references
> the function __init s3c2443_irq_add()
> If the reference is valid then annotate the
> variable with __init* or __refdata (see linux/init.h) or name the variable:
> *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console

> diff --git a/arch/arm/mach-s3c24xx/irq-s3c2416.c b/arch/arm/mach-s3c24xx/irq-s3c2416.c
> index b8a5836..59b7632 100644
> --- a/arch/arm/mach-s3c24xx/irq-s3c2416.c
> +++ b/arch/arm/mach-s3c24xx/irq-s3c2416.c
> @@ -310,7 +310,7 @@ static int __init s3c2416_irq_add(struct device *dev)
>  	return 0;
>  }
>  
> -static struct subsys_interface s3c2416_irq_interface = {
> +static struct subsys_interface s3c2416_irq_interface __initdata = {
>  	.name		= "s3c2416_irq",
>  	.subsys		= &s3c2416_subsys,
>  	.add_dev	= s3c2416_irq_add,
> diff --git a/arch/arm/mach-s3c24xx/irq-s3c2443.c b/arch/arm/mach-s3c24xx/irq-s3c2443.c
> index 35e4ff2..439f186 100644
> --- a/arch/arm/mach-s3c24xx/irq-s3c2443.c
> +++ b/arch/arm/mach-s3c24xx/irq-s3c2443.c
> @@ -265,7 +265,7 @@ static int __init s3c2443_irq_add(struct device *dev)
>  	return 0;
>  }
>  
> -static struct subsys_interface s3c2443_irq_interface = {
> +static struct subsys_interface s3c2443_irq_interface __initdata = {
>  	.name		= "s3c2443_irq",
>  	.subsys		= &s3c2443_subsys,
>  	.add_dev	= s3c2443_irq_add,

You register these structures with some other bit of code.  That other
bit of code adds these structures to a list. You then mark them as
__initdata, which means they get freed and the memory reused.  That
corrupts the list beneath the other code.

So, clearly, both of these are wrong.
