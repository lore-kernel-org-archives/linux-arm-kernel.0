From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 9 Nov 2015 10:50:42 +0000
Subject: [PATCH] ARM:dma-mapping: Handle DMA_BIDIRECTIONAL in
 _dma_page_cpu_to_dev()
In-Reply-To: <FDC088D3B5555644AE135ED28A7ABDE98636BE5D@EU-MBX-02.mgc.mentorg.com>
References: <1446631008-5854-1-git-send-email-sanjeev_sharma@mentor.com>
 <20151104103913.GC5405@arm.com>
 <20151104105420.GL8644@n2100.arm.linux.org.uk>
 <FDC088D3B5555644AE135ED28A7ABDE98636B41D@EU-MBX-02.mgc.mentorg.com>
 <CAGUYZuQDiH_xzinEJ952rw9GuA9oUQSNASaNdOE1x_i97XCBrw@mail.gmail.com>
 <20151109100804.GA24936@arm.com>
 <FDC088D3B5555644AE135ED28A7ABDE98636BE5D@EU-MBX-02.mgc.mentorg.com>
Message-ID: <56407A82.6010504@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/11/15 10:15, Sharma, Sanjeev wrote:
> On Mon, Nov 09, 2015 at 11:29:17AM +0530, sanjeev sharma wrote:
>>      On Wed, Nov 04, 2015 at 10:39:13AM +0000, Will Deacon wrote:
>>      > On Wed, Nov 04, 2015 at 03:26:48PM +0530, Sanjeev Sharma wrote:
>>      > > _dma_page_cpu_to_dev() treat DMA_BIDIRECTIONAL similar to
>>      > > DMA_TO_DEVICE which means that destination buffer is device
>>      > > memory,means cpu may have written some data to source buffer and
>>      > > data may be in cache line.For cleaner operation we need to call
>>      > > outer_flush_range() which will clean and invalidate outer cache lines.
>>      >
>>      > Why isn't the clean sufficient in this case? We're mapping the buffer
>>      > to the device, so we clean the dirty lines in the CPU caches and make
>>      > them visible to the device. If the CPU later wants to read the buffer
>>      > (i.e. after the device has DMA'd into it), you'll need to map the
>>      > buffer to the CPU, which will perform the invalidation of the CPU caches.
>>
>>      Indeed.  bidirectional mode is already handled prefectly well by this
>>      code.  No patches are required.
>>
>>      Thanks Russell & Will for providing input.
>>
>>      Let's assume , CPU don't read the buffer then there could be the problem
>>      correct ? IMO, to handle every use case outer_flush_range can be used ?
>>      If still it doesn't make sense to use flush on bidirectional mappings, then
>>      FIXME comment should be removed from the function to avoid any
>>      Confusion.
>>
>>
>>
>> Please let me know what you think on above comment ?
>
> I still don't understand the problem that you're trying to fix.
>
> It may cause the following issue.
> 1.we create the buffer with cache, and in some cases, the cache may be dirty.
> 2.then we call the sync_for_device function with flag DMA_BIDIRECTIONAL to avoid some cache problems.

This performs a cache clean, so the dirty lines are flushed out and 
cache and memory contents now match.

> 3. however __dma_page_cpu_to_dev() just see DMA_BIDIRECTIONAL the same as
> DMA_TO_DEVICE, which means the kernel will not invalid the cache if we use the flag DMA_BIDIRECTIONAL.

The CPU doesn't need to invalidate the cache at this point, since a) 
it's valid, and, crucially b) it will now refrain from accessing the 
buffer until the device has finished writing.

> 4.since the dirty cache is not invalid, the dirty content may be showed on the buffer in the future rendering.

The CPU _must_ call *_sync_for_cpu before it either reads or writes the 
buffer again. In this case, DMA_BIDIRECTIONAL is equivalent to 
DMA_FROM_DEVICE, thus will invalidate what the CPU still thinks are 
clean cache lines, so that whatever the device wrote to memory is then 
visible.

If you're seeing wrong data anywhere, that implies you have some 
necessary sync calls missing.

Robin.
