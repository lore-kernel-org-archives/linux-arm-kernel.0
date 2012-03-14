From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 14 Mar 2012 21:40:54 +0000
Subject: [PATCH v3 2/5] ARM: Add a printk loglevel modifier
In-Reply-To: <20120314200630.GB2391@pengutronix.de>
References: <20120314101928.GA29474@pengutronix.de>
 <201203141312.51547.arnd@arndb.de> <20120314200630.GB2391@pengutronix.de>
Message-ID: <201203142140.55052.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 14 March 2012, Uwe Kleine-K?nig wrote:
> I don't get your reasoning here.
> 
> An (independant) printk (that is expected to start at a new line) must
> start with KERN_SOMETHING iff the previous printk always ends in \n?
> Probably not. 
> 
> Independently of the correctness of the first patch that splits the
> printk I'm just taking it as an example:
> 
> In this case the two printks in question are:
> 
>                 printk("CPU: %s [%08x] revision %d (ARMv%s)", ...);
>         #ifdef CONFIG_CPU_CP15
>                 printk(KERN_CONT ", cr=%08lx\n", cr_alignment);
>         #endif
> 
> and
> 
>                 printk("CPU: %s data cache, %s instruction cache\n", ...)
> 
> In this case it's correct to add KERN_INFO to the last printk, isn't it?
> When would you consider it to be wrong?

I forgot about KERN_CONT, which did not exist until a few years ago
and is still not all that common. Initially, KERN_CONT was just an
empty string that was used to make it clear when a printk was
intentionally used as a continuation of the previous line, rather
than having no KERN_* at all.

In the example above, the first and the second line should get a KERN_INFO
or one of the others.

> If you want to have the first group of printks to always end in \n, I'd
> have to do:
> 
>                 printk("CPU: %s [%08x] revision %d (ARMv%s)", ...);
>         #ifdef CONFIG_CPU_CP15
>                 printk(KERN_CONT ", cr=%08lx", cr_alignment);
>         #endif
>                 printk(KERN_CONT "\n");
> 
> but ISTR Linus (Torvalds) telling me that KERN_CONT "\n" is wrong and
> should just be skipped.

Ok, didn't know that.

	Arnd
