From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 8 Jul 2013 11:42:55 +0100
Subject: [PATCH V3] of: Set the DMA mask to 64 bits when dma_addr_t is
 64-bits
In-Reply-To: <51D71F81.5090503@codeaurora.org>
References: <1367008266-1431-1-git-send-email-lauraa@codeaurora.org>
 <517AF270.8040106@gmail.com>
 <CACVXFVPfkqP+UyoGd-+QFRzndSam_DtU=utrBPYCPjQCGQ_F6g@mail.gmail.com>
 <51D71F81.5090503@codeaurora.org>
Message-ID: <20130708104254.GS24642@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 05, 2013 at 12:33:21PM -0700, Laura Abbott wrote:
> On 7/3/2013 7:15 AM, Ming Lei wrote:
>> On Sat, Apr 27, 2013 at 5:32 AM, Rob Herring <robherring2@gmail.com> wrote:
>>> On 04/26/2013 03:31 PM, Laura Abbott wrote:
>>>> Currently, of_platform_device_create_pdata always sets the
>>>> coherent DMA mask to 32 bits. On ARM systems without CONFIG_ZONE_DMA,
>>>> arm_dma_limit gets set to ~0 or 0xFFFFFFFFFFFFFFFF on LPAE based
>>>> systems. Since arm_dma_limit represents the smallest dma_mask
>>>> on the system, the default of 32 bits prevents any dma_coherent
>>>> allocation from succeeding unless clients manually set the
>>>> dma mask first. Rather than make every client on an LPAE system set
>>>> the mask manually, account for the size of dma_addr_t when setting
>>>> the coherent mask.
>>>>
>>>> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
>>>> ---
>>>>   drivers/of/platform.c |    2 +-
>>>>   1 files changed, 1 insertions(+), 1 deletions(-)
>>>>
>>>> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
>>>> index 0970505..5f0ba94 100644
>>>> --- a/drivers/of/platform.c
>>>> +++ b/drivers/of/platform.c
>>>> @@ -214,7 +214,7 @@ struct platform_device *of_platform_device_create_pdata(
>>>>   #if defined(CONFIG_MICROBLAZE)
>>>>        dev->archdata.dma_mask = 0xffffffffUL;
>>>>   #endif
>>>> -     dev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
>>>> +     dev->dev.coherent_dma_mask = DMA_BIT_MASK(sizeof(dma_addr_t) * 8);
>>>
>>> This is going to change the mask from 32 to 64 bits on 64-bit powerpc
>>> and others possibly. Maybe it doesn't matter. I think it doesn't, but
>>> I'm not sure enough to apply for 3.10. So I'll queue it for 3.11.
>>
>> Without the patch, LPAE enabled board may not boot at all, but looks
>> it still isn't in -next tree.
>>
>> But I am wondering if it is a correct approach, because enabling LPAE
>> doesn't mean the I/O devices can support DMA to/from 64bit address, and
>> it is very probably devices can't do it at all.
>>
>
> The problem is the way the arm_dma_limit is set up, all dma allocations  
> are currently broken regardless of if the actual device supports 64-bit  
> addresses or not.

Please explain this statement.

> I previously asked about the arm_dma_limit and was told that the current  
> behavior is the correct approach (see  
> https://lists.ozlabs.org/pipermail/devicetree-discuss/2013-April/032729.html 
> and  
> https://lists.ozlabs.org/pipermail/devicetree-discuss/2013-April/032690.html) 
>
> The point here is to set the mask to something reasonable such that  
> allocations can succeed by default. If devices can't use part of the  
> memory space they can adjust the limit accordingly.

The point is arm_dma_limit is that it sets the limit of the memory you
get from the page allocators when you ask for a GFP_DMA allocation.

In the case of no GFP_DMA zone, all memory is available for allocations.
Hence, arm_dma_limit is set to the absolute maximum physical memory
address which an allocator could return.

In the case of a 32-bit only system, this is 32-bits.  In the case of a
LPAE system, it is 64-bit.  (This follows because arm_dma_limit is
phys_addr_t, and the size of this follows the bit size of the system.)

The only questionable case is where we have a LPAE system with a GFP_DMA
zone and arm_dma_limit is set to 0xfffffffff - this limit is probably
too low.

Now the reason for the arm_dma_limit is very simple: if the streaming
APIs are passed a buffer outside of the DMA mask, we must reallocate
that memory.  We must have a way to get memory which is within the DMA
mask.  That's what passing GFP_DMA does.  If you have no GFP_DMA zone,
then any memory could be returned.  In the case of a LPAE system with
memory both above and below the 32-bit address range, and you try to
allocate a buffer which happens to be above the 32-bit boundary, what
do you do?  Do you just retry the allocation and hope for the best?
What if that allocation also came out above the 32-bit boundary?  Do
you continue gobbling up system memory until you get a page which you
can DMA do and then free all those buffers you unsuccesfully obtained?

We have a massive problem with DMA masks in the Linux kernel, because
of the x86-ism of assuming that physical memory always starts at
address zero.  This assumption simply is not true on ARM, even more so
with LPAE, which is why people are starting to see a problem.

Consider this case: you have an existing 32-bit DMA controller.  This
controller sets a 32-bit DMA mask, because that's all it is capable of
addressing.  It gets used on 32-bit systems, and it works fine.

It gets put onto a LPAE system where memory starts at the 4GB boundary.
The DMA controller can address the first 4GB of memory because that's
how it's wired up.  The DMA controller still has a 32-bit DMA mask
because as far as the DMA controller is concerned, nothing has changed.
But now things fail because the kernel assumes that a DMA mask is
something to do with a physical address.

The solution to this is to fix the DMA masks and such like.  The problem
is getting the traction throughout the architectures, drivers, subsystem
maintainers etc to accept a change - and working out a way to do the
change without causing a lot of breakage.
