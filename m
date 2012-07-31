From: karl.beldan@gmail.com (Karl Beldan)
Date: Tue, 31 Jul 2012 21:31:13 +0200
Subject: About dma_sync_single_for_{cpu,device}
In-Reply-To: <20120731090931.GP6802@n2100.arm.linux.org.uk>
References: <20120730202401.GA4947@gobelin> <20120731064557.GA4676@gobelin>
 <20120731090931.GP6802@n2100.arm.linux.org.uk>
Message-ID: <CACYmx9MnEn_XOosBn2-YJ=ny9FiLPADMNa6okwG08xrSpCUSpA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/31/12, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> On Tue, Jul 31, 2012 at 08:45:57AM +0200, Karl Beldan wrote:
>> I was expecting the following to work:
>> 	addr = dma_map_single(dev, buffer, size, DMA_TO_DEVICE);
>> 	dma_sync_single_for_device(dev, buffer, pattern_size, DMA_FROM_DEVICE);
>> 	dev_send(buffer);
>> 	// wait for irq (don't peek in the buffer) ... got irq
>> 	dma_sync_single_for_cpu(dev, buffer, pattern_size, DMA_FROM_DEVICE);
>> 	if (!xfer_done(buffer)) // not RAM value
>> 		dma_sync_single_for_device(dev, buffer, pattern_size, DMA_FROM_DEVICE);
>> 	[...]
>

Hi Russell,


> First point is that you clearly do not understand the DMA API at all.  The
> DMA API has the idea of buffer ownership.  Only the owner may access the
> buffer:
>
Are you saying that this scenario does not work ?
We are taking some liberties with the DMA API, we're more using some
of its funcs rather than _using_ it ;).
The question was not whether this was a proper usage of the API, but
why that scenario would not lead to the expected results .. and now
I've found the culprit peek I am happy.


[...]
> So, there is absolutely no noeed what so ever to follow dma_map_single()
> with dma_sync_single_for_device().
>
Cleaning a wide address range while invalidating a small one ?

[...]
> Fourthly, remember that the CPU deals with cache lines, and dirty cache
> lines may be written back in their _entirety_ - which means that data
> DMA'd from a device in the same cache line that you've modified via the
> CPU will not work (either the data in the cache line has to be invalidated
> and therefore the CPU update discarded, or the cache line has to be flushed
> back to RAM and the DMA'd data is overwritten.)  Hence why the buffer
> ownership rules are extremely important.
>
Of course.

> The solution for this fourth point is to use coherent DMA memory for things
> like ring buffers and the like, which does not suffer from this.
>
I might use something different in a not so distant future, yet, for
the time being, this way of doing as its advantages.

[...]
> Even with that comment, the idea of buffer ownership must be preserved by
> drivers, and they must follow that rule.  The fact that some ARM CPU
> do not respect the ownership entirely is worked around inside the DMA API
> and is of no interest to drivers.  Feroceon is not one CPU which does this
> though.
>
It was kind of a last resort explanation for a cache line filled out
of the blue .. before I spotted the culprit peek this morning.

Thanks for your input,



Karl
