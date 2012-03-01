From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 1 Mar 2012 19:48:51 +0000
Subject: [PATCH 4/4] ARM: kirkwood: convert orion-wdt to fdt.
In-Reply-To: <2f29e88b98b2bcff0c241996e6d7216a60995d2d.1330625878.git.jason@lakedaemon.net>
References: <cover.1330625877.git.jason@lakedaemon.net>
 <2f29e88b98b2bcff0c241996e6d7216a60995d2d.1330625878.git.jason@lakedaemon.net>
Message-ID: <201203011948.51642.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 01 March 2012, Jason Cooper wrote:
>  static int heartbeat = -1;             /* module parameter (seconds) */
>  static unsigned int wdt_max_duration;  /* (seconds) */
>  static unsigned int wdt_tclk;
> +static unsigned int wdt_reg;
>  static unsigned long wdt_status;
> static DEFINE_SPINLOCK(wdt_lock);

This variable needs to be a 'void __iomem *', not an int.

> +       wdt_reg = TIMER_VIRT_BASE;
> +
> +       of_property_read_u32(np, "reg", &wdt_reg);
> +
>         if (orion_wdt_miscdev.parent)
>                 return -EBUSY;
>         orion_wdt_miscdev.parent = &pdev->dev;

Don't just read a reg property, but use the resource instead and ioremap it.

This driver still uses hardcoded virtual addresses for its registers, which
we're trying to get rid of. The best solution would be to always put the
register address into the platform device resources, either hardcoded for
classic boards or automatic through the device tree.

A reg property is special in that it's not just a number but is relative
to the "ranges" property of the parent device and can be multiple 32 bit
values for the address, which get turned into a CPU physical address using
of_translate_address().

	Arnd
