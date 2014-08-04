From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 4 Aug 2014 19:32:25 +0100
Subject: DMA engine API issue
In-Reply-To: <53DFCB01.5050703@metafoo.de>
References: <1406032431-3807-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <18522523.T2zy7HfoJ2@avalon> <20140801170744.GD8181@intel.com>
 <1621896.RqTTnmY7rK@avalon> <53DFCB01.5050703@metafoo.de>
Message-ID: <20140804183225.GJ30282@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 04, 2014 at 08:03:45PM +0200, Lars-Peter Clausen wrote:
> If the hardware has scatter gather support it allows the driver to chain 
> the descriptors before submitting them, which reduces the latency between 
> the transfers as well as the IO over overhead.

While partially true, that's not the full story...

BTW, you're talking about stuff in DMA engine not being clear, but you're
using confusing terminology.  Descriptors vs transactions.  The prepare
functions return a transaction.  Descriptors are the hardware data
structures which describe the transaction.  I'll take what you're talking
about above as "chain the previous transaction descriptors to the next
transaction descriptors".

> The flaw with the current  
> implementation is that there is only one global chain per channel instead 
> of e.g. having the possibility to build up a chain in a driver and then 
> submit and start the chain. Some drivers have virtual channels where each 
> channel basically acts as the chain and once issue pending is called it 
> is the chain is mapped to a real channel which then executes it.

Most DMA engines are unable to program anything except the parameters for
the next stage of the transfer.  In order to switch between "channels",
many DMA engine implementations need the help of the CPU to reprogram the
physical channel configuration.  Chaining two different channels which
may ultimately end up on the same physical channel would be a bug in that
case.

Where the real flaw exists is the way that a lot of people write their
DMA engine drivers - in particular how they deal with the end of a
transfer.

Many driver implementations receive an interrupt from the DMA controller,
and either queue a tasklet, or they check the existing transfer, mark it
as completed in some way, and queue a tasklet.

When the tasklet runs, they then look to see if there's another transfer
which they can start, and they then start it.

That is horribly inefficient - it is much better to do all the DMA
manipulation in IRQ context.  So, when the channel completes the
existing transfer, you move the transaction to the queue of completed
transfers and queue the tasklet, check whether there's a transaction for
the same channel pending, and if so, start it immediately.

This means that your inter-transfer gap is reduced down from the
interrupt latency plus tasklet latency, to just the interrupt latency.

Controllers such as OMAP (if their hardware scatter chains were used)
do have the ability to reprogram the entire channel configuration from
an appropriate transaction, and so /could/ start the next transfer
entirely automatically - but I never added support for the hardware
scatterlists as I have been told that TI measurements indicated that
it did not gain any performance to use them.  Had this been implemented,
it would mean that OMAP would only need to issue an interrupt to notify
completion of a transfer (so the driver would only have to work out
how many dma transactions had been completed.)

In this case, it is important that we do batch up the entries (since
an already in progress descriptor should not be modified), but I
suspect in the case of slave DMA, it is rarely the case that there
is more than one or two descriptors queued at any moment.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
