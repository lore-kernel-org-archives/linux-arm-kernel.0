From: roy.pledge@nxp.com (Roy Pledge)
Date: Thu, 2 Feb 2017 17:21:53 +0000
Subject: [PATCH 06/10] soc/qbman: Add ARM equivalent for
 flush_dcache_range()
References: <1484779180-1344-1-git-send-email-roy.pledge@nxp.com>
 <CAK8P3a1Gd4bd7GjEp_a9WXc_mTPk0XmP7DH8aPWhbn2K3MMuDQ@mail.gmail.com>
 <20170130151933.GA27312@n2100.armlinux.org.uk> <123833427.MmK6vFAXzK@wuerfel>
 <20170201231649.GR27312@n2100.armlinux.org.uk>
Message-ID: <HE1PR0401MB263653605F9A2B38160F5E94864C0@HE1PR0401MB2636.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/1/2017 6:17 PM, Russell King - ARM Linux wrote:
> On Wed, Feb 01, 2017 at 01:47:46PM +0100, Arnd Bergmann wrote:
>> Ah right, so since there is no interface to map as "device writeback",
>> the driver would likely end up with an MMIO register in a
>> "normal writeback", with these properties (among others listed there):
> It's not about there being no _interface_, there's no support in the
> architecture for it.  The use of the "device" memory type does not
> allow for any form of cache hints to be specified.
>
>>  * - writes can be repeated (in certain cases) with no side effects
>>  * - writes can be merged before accessing the target
>>  * - unaligned accesses can be supported
>>  * - ordering is not guaranteed without explicit dependencies or barrier
>>  *   instructions
>>  * - writes may be delayed before they hit the endpoint memory
>>
>> I think the ordering is the most critical here, as IIRC the driver
>> expects a whole cache line to be written into the MMIO register
>> in a single bus cycle specifically when we issue the flush from the
>> driver, but we can actually have partial writebacks at any time.
> I don't think that's achievable, unless your data bus is as wide as
> a cache line (iow, for a 32-byte cache line, your data bus all the
> way to the peripheral would need to be 256 bits wide to write the
> cache line in a single bus cycle.)
>
The device doesn't expect a whole cache line to be written at once.  The
protocol protects against cast outs/write backs by using an alternating
valid bit that is set after a memory barrier is executed.  The driver
ensures that the valid bit is flipped last and the ARM architecture
protects that the device sees the writes in the proper order due to the
barrier. In this case portal memory is on device memory so the writes
from the CPU are backed by the device - there is no read transaction
from the device for any portal memory.

I also want to point out that the memory we've been discussion for the
flush has nothing to do with the software portal mechanism, the memory
here is for queue storage when queues grow in length.  All this patch is
trying to do is zero memory obtained from the of_reserved memory systems
and ensure it isn't in the cache once the device starts using it. I will
try looking at the dma_alloc_coherent() suggestions from Robin but I
beleive when we tried that before it couldn't deal with the multiple
megabyte allocations due to fragmentation.
