From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Tue, 15 May 2012 10:55:43 +0300
Subject: [PATCH] MTD: LPC32xx SLC NAND driver
In-Reply-To: <1336829386-23301-1-git-send-email-stigge@antcom.de>
References: <1336829386-23301-1-git-send-email-stigge@antcom.de>
Message-ID: <1337068543.2528.143.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I am CCing few other guys who take care of several drivers which use
similar way of busy-waiting - probably you could change it?

Bastian: drivers/mtd/nand/sh_flctl.c
Lars-Peter: drivers/mtd/nand/jz4740_nand.c
Huang: drivers/mtd/nand/gpmi-nand/gpmi-lib.c
Lei Wen: drivers/mtd/nand/pxa3xx_nand.c

On Sat, 2012-05-12 at 15:29 +0200, Roland Stigge wrote:
> +       /*
> +        * The DMA is finished, but the NAND controller may still have
> +        * buffered data. Wait until all the data is sent.
> +        */
> +       timeout = LPC32XX_DMA_SIMPLE_TIMEOUT;
> +       while ((readl(SLC_STAT(host->io_base)) & SLCSTAT_DMA_FIFO)
> +              && (timeout > 0))
> +               timeout--;
> +       if (!timeout) {
> +               dev_err(mtd->dev.parent, "FIFO held data too long\n");
> +               status = -EIO;
> +       } 

I know the MTD tree is full of this, but this is bad, I think. The
timeout should be time-backed, not CPU-cycles-backed.

I do not know the best way to do this, hopefully someone in the arm list
could suggest, but the following pattern is at least better:


/* Chip reaction time timeout in milliseconds */
#define LPC32XX_DMA_TIMEOUT 100

timeout = loops_per_jiffy * msecs_to_jiffies(LPC32XX_DMA_TIMEOUT);

while ((readl(...)) && timeout-- > 0)
	cpu_relax();

if (!timeout)
	error;


So basically I turned your hard-coded iterations count into a time-based
timeout. I also used cpu_relax() which is commonly used in tight-loops
like this. Here is a piece of documentation about cpu_relax():

"
The right way to perform a busy wait is:

    while (my_variable != what_i_want)
        cpu_relax();

The cpu_relax() call can lower CPU power consumption or yield to a
hyperthreaded twin processor; it also happens to serve as a compiler
barrier, so, once again, volatile is unnecessary.  Of course, busy-
waiting is generally an anti-social act to begin with.
"

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120515/ef6888ed/attachment.sig>
