From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 7 Jul 2011 11:24:19 +0100
Subject: [PATCH 3/4] arm: mach-s3c2440: dma: fix section mismatch
In-Reply-To: <1310033919-4245-4-git-send-email-w.sang@pengutronix.de>
References: <1310033919-4245-1-git-send-email-w.sang@pengutronix.de>
	<1310033919-4245-4-git-send-email-w.sang@pengutronix.de>
Message-ID: <20110707102419.GM8286@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 07, 2011 at 12:18:38PM +0200, Wolfram Sang wrote:
> If s3c2440_dma_add() and s3c2440_dma_init() are in __init, then the
> struct s3c2440_dma_driver they are using should be __initdata, too.
> 
> Fixes:
> 
> WARNING: vmlinux.o(.data+0x14ac): Section mismatch in reference from the variable s3c2440_dma_driver to the function .init.text:s3c2440_dma_add()
> The variable s3c2440_dma_driver references the function __init s3c2440_dma_add()

No, this is soo wrong (and illustrates why its important to check
before adding __init stuff.)

> diff --git a/arch/arm/mach-s3c2440/dma.c b/arch/arm/mach-s3c2440/dma.c
> index 3b0529f..f417959 100644
> --- a/arch/arm/mach-s3c2440/dma.c
> +++ b/arch/arm/mach-s3c2440/dma.c
> @@ -198,7 +198,7 @@ static int __init s3c2440_dma_add(struct sys_device *sysdev)
>  	return s3c24xx_dma_init_map(&s3c2440_dma_sel);
>  }
>  
> -static struct sysdev_driver s3c2440_dma_driver = {
> +static struct sysdev_driver __initdata s3c2440_dma_driver = {
>  	.add	= s3c2440_dma_add,
>  };

The code does this:

static int __init s3c2440_dma_init(void)
{
        return sysdev_driver_register(&s3c2440_sysclass, &s3c2440_dma_driver);
}

So, this registers the s3c2440_dma_driver structure.  Internally,
sysdev_driver_register() does this:

                list_add_tail(&drv->entry, &cls->drivers);

which adds s3c2440_dma_driver to a list of sysdev drivers.  Whenever
a sysdev is added, the code does this:

                /* Notify class auxiliary drivers */
                list_for_each_entry(drv, &cls->drivers, entry) {
                        if (drv->add)
                                drv->add(sysdev);
                }

What do you think will happen when this list is walked, but your
s3c2440_dma_driver structure has been discarded with the init section
and replaced with random data?
