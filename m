From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 23 Dec 2010 12:30:28 +0000
Subject: [PATCH 06/13] DMAENGINE: driver for the ARM PL080/PL081 PrimeCells
In-Reply-To: <AANLkTinOMOkY6AUW8Z6FWMMWU9u0_sNjA2r_31u9-A8v@mail.gmail.com>
References: <1276270031-1607-1-git-send-email-linus.walleij@stericsson.com>
	<20101221182037.GA4783@n2100.arm.linux.org.uk>
	<20101222122904.GC14693@n2100.arm.linux.org.uk>
	<AANLkTikpyAggDCPef1pS=_QHnu9-FyLcpddGyVHnGwWx@mail.gmail.com>
	<AANLkTinOMOkY6AUW8Z6FWMMWU9u0_sNjA2r_31u9-A8v@mail.gmail.com>
Message-ID: <20101223123028.GI3636@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 23, 2010 at 09:17:07AM +0100, Linus Walleij wrote:
> 2010/12/23 Dan Williams <dan.j.williams@intel.com>:
> >?It looks like this driver needs a full scrub
> > which seems unreasonable to complete and test over the holidays before
> > .37 lands. ?Linus we either need to mark this "depends on BROKEN" or
> > revert it.
> 
> Isn't it really as simple as to release the spinlock during callbacks?
> That lock is only intended to protect the plchan variables, not to block
> anyone from queueing new stuff during the callback (as happens now).
> 
> It can release that lock, make a callback where a new descriptor
> gets queued, and then take it again and start looking at the queue,
> at which point it discovers the new desc and process it.

Is it actually safe to do this?  The answer seems to be no - if we happen
to terminate all transfers (as your PL011 uart code does) when we fail to
setup a new DMA transaction, then bad stuff happens due to this:

                /*
                 * Device callbacks should NOT clear
                 * the current transaction on the channel
                 * Linus: sometimes they should?
                 */
                if (!plchan->at)
                        BUG();

We really need a saner approach here - maybe the list approach described
by Jassie.

> diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
> index b605cc9..7879a22 100644
> --- a/drivers/dma/amba-pl08x.c
> +++ b/drivers/dma/amba-pl08x.c
> @@ -1651,8 +1651,11 @@ static void pl08x_tasklet(unsigned long data)
>  		/*
>  		 * Callback to signal completion
>  		 */
> -		if (callback)
> -			callback(callback_param);
> +		if (callback) {
> +                        spin_unlock(&plchan->lock);
> +                        callback(callback_param);
> +                        spin_lock(&plchan->lock);

Plus, of course, that tasklets run with IRQs enabled.  This means we're
taking this spinlock in an interruptible context.  If we have some other
path which also takes this lock from an IRQ context, then we're asking
for deadlock.  See my previous mails on this subject.

I'm currently splitting my dirty patch, and attacking this driver to
clean up some of it into a more reasonable shape, so this is one area
which I'm going to be sorting out.

Patches later.
