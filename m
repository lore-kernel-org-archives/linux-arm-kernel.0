From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 23 Nov 2010 10:12:11 +0000
Subject: [PATCH] ARM: mx3/pcm037: properly allocate memory for mx3-camera
In-Reply-To: <1290505382-16110-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20101011152516.GF27153@n2100.arm.linux.org.uk>
	<1290505382-16110-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20101123101210.GA18170@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 23, 2010 at 10:43:02AM +0100, Uwe Kleine-K?nig wrote:
> There is no need to memzero the buffer because dma_alloc_coherent zeros
> the memory for us.
> 
> This fixes:
> 
> 	BUG: Your driver calls ioremap() on system memory.  This leads
> 	<4>to architecturally unpredictable behaviour on ARMv6+, and ioremap()
> 	<4>will fail in the next kernel release.  Please fix your driver.
> 
> Tested-by: Michael Grzeschik <mgr@pengutronix.de>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
> 
> it seems to work this way, still I'd like to have some feedback if this
> is done right.  Russell?

Yes and probably no.  Yes, it's architecturally correct because the memory
will be mapped only once, thereby avoiding the aliasing issue.

Probably no, because the memory is mapped strongly as device memory by
ioremap.  ISTR whether memory remains accessible when mapped as a device
is not something covered by the architecture, but I guess is more to do
with how the interconnect on the SoC is setup.

In other words, we probably have gremlins lurking in
dma_declare_coherent_memory() which could bite us at a later date.

> I assume sending a patch to remove the <4> is just a waste of time,
> isn't it?

Hmm, someone changed the behaviour of printk - it used to require the
tag after each newline.  It seems that it only requires it as the first
few characters now, which is a pain in the backside if you split
printk's.

IOW:

	printk(KERN_ERR "foo bar baz ");
	printk("buz\n" KERN_WARNING "fiz\n");

used to result in "foo bar baz buz" being printed at error level, and
"fiz" at warning level.  Today, you'll get "foo bar baz buz" at error
level, and "<4>fiz" at the default level.

Note that it's not as simple as deleting the KERN_WARNING, because:
	printk(KERN_ERR "foo bar baz ");
	printk("buz\nfiz\n");

will result in the same as above except for the missing <4> - which means
"fiz" still ends up at the wrong severity level.

Confusingly:

	printk(KERN_ERR "foo bar baz");
	printk(KERN_WARNING "buz\nfiz\n");

will do as per the original, but is silly.  Wonder how many other places
are broken by this change.
