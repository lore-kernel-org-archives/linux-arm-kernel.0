From: dan.j.williams@intel.com (Dan Williams)
Date: Mon, 3 Jan 2011 13:26:05 -0800
Subject: dmaengine: fix dma_unmap (was: Re: [PATCH 06/13] DMAENGINE:
	driver for the ARM PL080/PL081 PrimeCells)
In-Reply-To: <20110103165227.GC32508@n2100.arm.linux.org.uk>
References: <AANLkTinJAULeb1EsWk=S=b32h69X1x-noRw73Ok0uyfx@mail.gmail.com>
	<20110103165227.GC32508@n2100.arm.linux.org.uk>
Message-ID: <AANLkTinMCLC8j=AvzaCQ+Uuyk75T=rAkaLUz0jHPOJ-d@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 3, 2011 at 8:52 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Jan 03, 2011 at 08:36:00AM -0800, Dan Williams wrote:
>> For raid this will have implications for architectures that split
>> operation types on to different physical channels. ?Preparing the
>> entire operation chain ahead of time is not possible on such
>> configuration because we need to remap the buffers for each channel
>> transition.
>
> That's not entirely true. ?You will only need to remap buffers if
> old_chan->device != new_chan->device, as the underlying struct device
> will be the different and could possibly have a different IOMMU or
> DMA-able memory parameters.
>

Yes, but currently operation capabilities are organized per dma device
(i.e. all channels on a dma device share the same set of
capabilities).  The channel allocator will keep the chain on a single
channel where possible, but if it determines we need to switch to a
channel with a different capability set then we have also switched dma
devices at that point.

iop3xx and ppc4xx have this dma_device-per-dma_chan
organization.currently.  They could switch to a model of hiding
multiple hw channels behind a single dma_chan, but then they would
need to handle the operation ordering and channel transitions
internally.


> So, when changing channels, the optimization is not engine specific,
> but can be effected when the chan->device points to the same dma_device
> structure. ?That means it should still be possible to chain several
> operations together, even if it means that they occur on different
> channels on the same device.
>
> One passing idea is the async_* operations need to chain buffers in
> terms of <virtual page+offset, len, dma_addr_t, struct dma_device *>, or
> maybe <struct dma_device *, scatterlist>. ?If the dma_device pointer is
> initialized, the scatterlist is already mapped. ?If this differs from
> the dma_device for the next selected operation, the previous operations
> need to be run, then unmap and remap for the new device.
>
> Does that sound possible?

Yes, but the dma driver still does not have enough information to
determine when it is finally safe to unmap / allow speculative reads.
The raid driver can make a much cleaner guarantee of "this stripe now
belongs to a dma device" and "all dma operations have completed this
stripe can be returned to the cpu / rescheduled on a new channel".

>> > I'd also like to see DMA_COMPL_SKIP_*_UNMAP always set by prep_slave_sg()
>> > in tx->flags so we don't have to end up with "is this a slave operation"
>> > tests in the completion handler.
>>
>> Longer term I do not see these flags surviving, but yes a 2.6.38
>> change along these lines makes sense.
>
> Well, if the idea is to kill those flags, then it would be a good idea
> not to introduce new uses of them as that'll only complicate matters.
>
> I do have an untested patch which adds the unmap to pl08x, but I'm
> wondering if it's worth it, or whether to disable the memcpy support
> for the time being.

We could disable the driver if NET_DMA or ASYNC_TX_DMA are selected.
 That still allows the driver to be exercised with dmatest.  Although
I notice the driver is already marked experimental, do we need
something stronger for 37-final?

--
Dan
