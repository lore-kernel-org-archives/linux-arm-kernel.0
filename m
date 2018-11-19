From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Mon, 19 Nov 2018 11:35:40 +0000
Subject: [PATCH v2] mm: improve/fix ARM v7_dma_inv_range() unaligned
 address handling
In-Reply-To: <1541787300.537.67.camel@sageembedded.com>
References: <1541626010.537.49.camel@sageembedded.com>
 <16a08785-4999-ea6c-83cd-3e15775ef641@arm.com>
 <1541787300.537.67.camel@sageembedded.com>
Message-ID: <31e2fb79-c9b3-802c-9826-26e3b3e1f8fa@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,

On 09/11/18 18:15, Chris Cole wrote:
> Hi Vladimir,
> 
> On Thu, 2018-11-08 at 09:34 +0000, Vladimir Murzin wrote:
>> Hi Chris,
>>
>> On 07/11/18 21:26, Chris Cole wrote:
>>> This patch addresses possible memory corruption when
>>> v7_dma_inv_range(start_address, end_address) address parameters are not
>>> aligned to whole cache lines. This function issues "invalidate" cache
>>> management operations to all cache lines from start_address (inclusive)
>>> to end_address (exclusive). When start_address and/or end_address are
>>> not aligned, the start and/or end cache lines are first issued "clean &
>>> invalidate" operation. The assumption is this is done to ensure that any
>>> dirty data addresses outside the address range (but part of the first or
>>> last cache lines) are cleaned/flushed so that data is not lost, which
>>> could happen if just an invalidate is issued.
>>>
>>> The problem is that these first/last partial cache lines are issued
>>> "clean & invalidate" and then "invalidate". This second "invalidate" is
>>> not required and worse can cause "lost" writes to addresses outside the
>>> address range but part of the cache line. If another component writes to
>>> its part of the cache line between the "clean & invalidate" and
>>> "invalidate" operations, the write can get lost. This fix is to remove
>>> the extra "invalidate" operation when unaligned addressed are used.
>>>
>>> A kernel module is available that has a stress test to reproduce the
>>> issue and a unit test of the updated v7_dma_inv_range(). It can be
>>> downloaded from
>>> http://ftp.sageembedded.com/outgoing/linux/cache-test-20181107.tgz.
>>>
>>> v7_dma_inv_range() is call by dmac_[un]map_area(addr, len, direction)
>>> when the direction is DMA_FROM_DEVICE. One can (I believe) successfully
>>> argue that DMA from a device to main memory should use buffers aligned
>>> to cache line size, because the "clean & invalidate" might overwrite
>>> data that the device just wrote using DMA. But if a driver does use
>>> unaligned buffers, at least this fix will prevent memory corruption
>>> outside the buffer.
>>>
>>> Signed-off-by: Chris Cole <chris@sageembedded.com>
>>> Cc: Russell King - ARM Linux <linux@armlinux.org.uk>
>>> ---
>>>
>>> V2: Use simpler assembly code suggested by Russel King
>>
>> I'm wondering if you can update v7m_dma_inv_range as well? The whole
>> cache-v7m.S was lifted form cache-v7.S, so it is likely suffers from
>> the same issue.
> 
> My preference would be to have someone else create a separate patch
> for v7m. I am not totally comfortable including v7m since I don't
> have any hardware to test the changes.

Fair enough. I'll make diff below as a separate patch, so people can test
it.

> 
> But this is my first patch to Linux and not sure what the preference
> is. If this is strong desire include in the same patch, I can do that.

Well done!

I think you need to drop your patch into Russell's patch tracker [1]

[1] http://www.armlinux.org.uk/developer/patches/

Cheers
Vladimir
