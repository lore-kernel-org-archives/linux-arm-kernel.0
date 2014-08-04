From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 05 Aug 2014 01:12:18 +0200
Subject: DMA engine API issue
In-Reply-To: <20140804183225.GJ30282@n2100.arm.linux.org.uk>
References: <1406032431-3807-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <53DFCB01.5050703@metafoo.de> <20140804183225.GJ30282@n2100.arm.linux.org.uk>
Message-ID: <2551209.TdCRpqdDzh@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Monday 04 August 2014 19:32:25 Russell King - ARM Linux wrote:
> On Mon, Aug 04, 2014 at 08:03:45PM +0200, Lars-Peter Clausen wrote:
> > If the hardware has scatter gather support it allows the driver to chain
> > the descriptors before submitting them, which reduces the latency between
> > the transfers as well as the IO over overhead.
> 
> While partially true, that's not the full story...
> 
> BTW, you're talking about stuff in DMA engine not being clear, but you're
> using confusing terminology.  Descriptors vs transactions.  The prepare
> functions return a transaction.  Descriptors are the hardware data
> structures which describe the transaction.  I'll take what you're talking
> about above as "chain the previous transaction descriptors to the next
> transaction descriptors".

Well, the prep_* functions return a struct dma_async_tx_descriptor, documented 
as an "async transaction descriptor".

There are several types of descriptors, transactions and transfers involved, 
with different names depending on where you look at.

- At the highest level, we have the DMA engine representation of a transaction 
in the form of a struct dma_async_tx_descriptor (even this is slightly 
misleading, as tx is a common abbreviation of transmit or transmission, but 
not of transaction).

- One level lower, when the high level transaction targets non contiguous 
memory (from the device point of view) the transaction is split into 
contiguous chunks. The device might be able to execute a list (or table, 
depending of the implementation) of chunks on its own without requiring 
software intervention. If it isn't the driver will need to submit the next 
chunk in the completion interrupt of the previous chunk. Even when the device 
supports executing multiple chunks on its own, it might be limited in the 
number of chunks it can chain, requiring software intervention to handle one 
transaction descriptor.

- At the lowest level, the hardware will perform the transfer by repeating 
transfer cycles, reading a data unit from the source and writing to the 
destination. When the source or destination supports it, the read and/or write 
operations can also be grouped in bursts.

If we want to lower the confusion we should decide on names for those 
different levels and stick to them.

The highest level unit is called a transaction by (at least some parts of) the 
API, the name sounds good enough to me. "Transaction" could thus refer to that 
operation, and "transaction descriptor" to the struct dma_async_tx_descriptor 
instance.

We could then say that a transaction is split into transfers, each of them 
targeting a contiguous piece of memory of both the source and the destination, 
and that transfers are split into transfer cycles, each of them transferring 
one data unit or element. I'm also open to other proposals (including using 
the name "chunk" for one of the elements).

> > The flaw with the current implementation is that there is only one global
> > chain per channel instead of e.g. having the possibility to build up a
> > chain in a driver and then submit and start the chain.

Well, that's not completely true, the API supports scatterlists, so you could 
create a single transaction descriptor that spans several unrelated transfers 
(as long as they can use the same channel, for instance targeting the same 
device for slave transactions).

> > Some drivers have virtual channels where each channel basically acts as
> > the chain and once issue pending is called it is the chain is mapped to a
> > real channel which then executes it.
> 
> Most DMA engines are unable to program anything except the parameters for
> the next stage of the transfer.  In order to switch between "channels",
> many DMA engine implementations need the help of the CPU to reprogram the
> physical channel configuration.  Chaining two different channels which
> may ultimately end up on the same physical channel would be a bug in that
> case.

I'm mostly familiar with DMA engines designed for slave transfers. The ones 
I've seen have channels that are programmed and run independently, usually 
with some logic to arbitrate bus access. When they support executing lists or 
arrays of transfers the hardware transfer descriptors include the source and 
destination addresses and the number of elements to be transfered. The 
identifier of the slave device (basically the DMA request line to which the 
slave is connected) is constant across all chained transfers.

I'm not sure what you mean by "switching between channels". Could you please 
explain that ?

> Where the real flaw exists is the way that a lot of people write their
> DMA engine drivers - in particular how they deal with the end of a
> transfer.
> 
> Many driver implementations receive an interrupt from the DMA controller,
> and either queue a tasklet, or they check the existing transfer, mark it
> as completed in some way, and queue a tasklet.
> 
> When the tasklet runs, they then look to see if there's another transfer
> which they can start, and they then start it.
> 
> That is horribly inefficient - it is much better to do all the DMA
> manipulation in IRQ context.  So, when the channel completes the
> existing transfer, you move the transaction to the queue of completed
> transfers and queue the tasklet, check whether there's a transaction for
> the same channel pending, and if so, start it immediately.
> 
> This means that your inter-transfer gap is reduced down from the
> interrupt latency plus tasklet latency, to just the interrupt latency.

I totally agree. This should be documented to avoid this kind of mistake in 
the future. Maxime, if you can find time for it, could you add this to the 
next version of your documentation patch ?

> Controllers such as OMAP (if their hardware scatter chains were used)
> do have the ability to reprogram the entire channel configuration from
> an appropriate transaction, and so /could/ start the next transfer
> entirely automatically - but I never added support for the hardware
> scatterlists as I have been told that TI measurements indicated that
> it did not gain any performance to use them.  Had this been implemented,
> it would mean that OMAP would only need to issue an interrupt to notify
> completion of a transfer (so the driver would only have to work out
> how many dma transactions had been completed.)
> 
> In this case, it is important that we do batch up the entries (since
> an already in progress descriptor should not be modified), but I
> suspect in the case of slave DMA, it is rarely the case that there
> is more than one or two descriptors queued at any moment.

I agree, in most cases there's only one or a few transaction descriptors 
queued for slave DMA. There could then be a larger number of hardware transfer 
descriptors to represent one transaction descriptor, but those would have been 
created by the DMA engine driver from a single transaction descriptor, so 
there would be no problem chaining the transfers.

How about the memcpy (non-slave) DMA ? Do client drivers submit lots of small 
DMA transactions that should be chained for optimal performances ?

-- 
Regards,

Laurent Pinchart
