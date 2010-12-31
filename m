From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 31 Dec 2010 21:50:18 +0000
Subject: [PATCH 06/13] DMAENGINE: driver for the ARM PL080/PL081 PrimeCells
In-Reply-To: <AANLkTikP+JZkN7AjqaNfHY8jZ7bVsV-af=YR=MTdfnNU@mail.gmail.com>
References: <1276270031-1607-1-git-send-email-linus.walleij@stericsson.com>
	<20101221182037.GA4783@n2100.arm.linux.org.uk>
	<20101222122904.GC14693@n2100.arm.linux.org.uk>
	<AANLkTikpyAggDCPef1pS=_QHnu9-FyLcpddGyVHnGwWx@mail.gmail.com>
	<20101223001012.GF29368@n2100.arm.linux.org.uk>
	<AANLkTimirgsuoM2che_ocrkvCZqGu6xEJjrjdmt9-69p@mail.gmail.com>
	<AANLkTikP+JZkN7AjqaNfHY8jZ7bVsV-af=YR=MTdfnNU@mail.gmail.com>
Message-ID: <20101231215018.GB5012@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 22, 2010 at 05:31:25PM -0800, Dan Williams wrote:
> On Wed, Dec 22, 2010 at 5:11 PM, Dan Williams <dan.j.williams@intel.com> wrote:
> > Drivers that do not
> > want to meet the constraints expected by the opportunistic offload
> > clients should do what ste_dma40 does and add "depends on !(NET_DMA ||
> > ASYNC_TX_DMA)"
> 
> Sorry I was looking at a local change it does not do this today, but I
> recommended it to workaround the broken >64k transfer support that was
> reported recently.

Dan,

Is there any documentation on the DMA engine APIs than what's in
crypto/async-tx-api.txt?

Reason for asking is that there's no way at the moment to tell what the
expectations are from a lot of the DMA engine support code - and that is
_very_ bad news if you want DMA engine drivers to behave the same.

I can already see that drivers on both sides of the DMA engine API have
different expectations between their respective implementations, and this
is just adding to confusion.

For instance, the sequence in a driver:

	desc = dmadev->device_prep_slave_sg(chan, ...);
	if (!desc)
		/* what DMA engine cleanup is expected here? */

	cookie = dmaengine_submit(desc);
	if (dma_submit_error(cookie))
		/* what DMA engine cleanup of desc is expected here? */

Note: I don't trust what's written in 3.3 of async-tx-api.txt, because
that seems to be talking about the the async_* APIs rather than the
DMA engine API. (see below.)

1. Is it valid to call dmaengine_terminate_all(chan) in those paths?

2. What is the expectations wrt the callback of a previously submitted
   job at the point that dmaengine_terminate_all() returns?

3. What if the callback is running on a different CPU, waiting for a
   spinlock you're holding at the time you call dmaengine_terminate_all()
   within that very same spinlock?

4. What if dmaengine_terminate_all() is running, but parallel with it
   the tasklet runs on a different CPU, and queues another DMA job?

These can all be solved by requiring that the termination implementations
call tasklet_disable(), then clean up the DMA state, followed by
tasklet_enable().  tasklet_disable() will prevent the tasklet being
scheduled, and wait for the tasklet to finish running before proceeding.
This means that (2) becomes "the tasklet will not be running", (3)
becomes illegal (due to deadlock), and (4) becomes predictable as we
know that after tasklet_disable() we have consistent DMA engine state
and we can terminate everything that's been queued.

That still leaves the issue of (1), and also what cleanup is expected.


I'm not entirely clear about the usage of DMA_CTRL_ACK:
 * @DMA_CTRL_ACK - if clear, the descriptor cannot be reused until the client
 *  acknowledges receipt, i.e. has has a chance to establish any dependency
 *  chains

Some DMA engine using drivers set DMA_CTRL_ACK, others don't.

Should drivers using prep_slave_sg() be requesting their descriptors
with DMA_CTRL_ACK in the flags argument?  Doesn't that mean that the
DMA engine driver is free to re-use this descriptor beneath the driver?

Almost no one checks the result of dmaengine_submit() (or its open-coded
equivalent).  Are all such drivers potentially leaking descriptors?  If
not, how are the failed descriptors re-used?

Also, I think that the DMA engine core code needs to provide some
essential helper functions to prevent buggy bodgerations such as
what's happening in amba-pl08x.c, such as:

dma_cookie_t dmaengine_alloc_cookie(struct dma_async_tx_descriptor *tx)
{
	struct dma_chan *chan = tx->chan;

	chan->cookie += 1;
	if (chan->cookie < 0)
		chan->cookie = 1;
	return (tx->cookie = chan->cookie);
}

What should be the initial value of tx->cookie after a successful
prep_slave_sg() call?

Also a helper function for dmaengine drivers to call when a descriptor
is complete to handle all the tx descriptor cleanup on completion, so
that all dmaengine drivers don't have to re-implement the cleanup in
their own ways, each with differing behaviour.  (Can the TX desciptor
structure be expanded to hold all the information needed so that core
code can implement the DMA unmapping for the asynctx stuff there?)

I think that's enough to think about for the time being - I'm sure
there's lots more...

As it is, even if I thought trying to fix the PL08x driver was worth the
effort (in spite of the hardware issues), I don't think there's enough
documentation on the DMA engine API to be able to do so at the present
time.

So, given all these questions (some of which can lead to deadlocks), and
we're now at -rc8, I see no way that I can sanely (or safely) queue up
the PL011 UART and PL180 MMCI DMA engine code for this coming merge
window.  (Sorry Linus.)
