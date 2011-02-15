From: per.forlin@linaro.org (Per Forlin)
Date: Tue, 15 Feb 2011 14:54:21 +0100
Subject: [RFC] ARM: dma-mapping: outer cache is invalidated twice
In-Reply-To: <20110215134134.GA17208@n2100.arm.linux.org.uk>
References: <AANLkTi=rZJq0CPQD0Q1HMgih7UP0Tqoh9sPEYb2NEV_X@mail.gmail.com>
	<20110215133232.GI4152@n2100.arm.linux.org.uk>
	<20110215134134.GA17208@n2100.arm.linux.org.uk>
Message-ID: <AANLkTi=Fs5+3yG-_4u0oU8WK4K4FU_8zN38H=RNcgRNU@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 February 2011 14:41, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Feb 15, 2011 at 01:32:32PM +0000, Russell King - ARM Linux wrote:
>> On Tue, Feb 15, 2011 at 02:14:55PM +0100, Per Forlin wrote:
>> > outer_inv_range () is called twice for DMA_FROM_DEVICE.
>> > The first time to "get rid of potential writebacks" and the second
>> > time to "get rid of any stale speculative prefetches"
>>
>> Correct.
>>
>> > outer_inv_range() is a rather expensive operation. In the first case
>> > isn't it enough to just call cache_sync()?
>>
>> No. ?If the CPU speculatively fetches data from the DMA buffer after
>> it's been mapped for DMA, it will bring data into the L2 cache. ?This
>> data may or may not be up to date with the DMA buffer contents once
>> DMA has completed.
>>
>> As there is no way to know, we have to invalidate the L2 cache (and the
>> L1 cache) after the DMA has completed to avoid any possibility of data
>> corruption.
>
> I should add: the solution to all of this is to have cache coherent DMA.
>
> As the CPUs become more complex and start playing tricks like speculative
> prefetching, we have seen cache maintainence for DMA becomes more expensive.
> The only way to reduce the cost of that is to have cache coherency for DMA.
>
> There is no way to safely avoid the double-invalidate for DMA_FROM_DEVICE.
>
I don't fully understand this yet. I think you are right but I need a
little help
to get there myself.
I agree, the cache (L1 and L2) must be invalidated after the DMA has completed.
Before starting the DMA the write buffers must be drained (cache_sync).

Why invalidate the cache before starting the DMA?

The user shouldn't care about the cache until the DMA has finished and
the cache is
invalidated.
I don't unsderstand how the DMA transfered data can be corrupt from a
CPU perspective
if the cache is invalidated after DMA transfer is done, but _not_
before DMA is started?

Thanks for your fast response
/Per
