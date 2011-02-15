From: per.forlin@linaro.org (Per Forlin)
Date: Tue, 15 Feb 2011 16:11:09 +0100
Subject: [RFC] ARM: dma-mapping: outer cache is invalidated twice
In-Reply-To: <20110215141253.GJ4152@n2100.arm.linux.org.uk>
References: <AANLkTi=rZJq0CPQD0Q1HMgih7UP0Tqoh9sPEYb2NEV_X@mail.gmail.com>
	<20110215133232.GI4152@n2100.arm.linux.org.uk>
	<20110215134134.GA17208@n2100.arm.linux.org.uk>
	<AANLkTi=Fs5+3yG-_4u0oU8WK4K4FU_8zN38H=RNcgRNU@mail.gmail.com>
	<20110215141253.GJ4152@n2100.arm.linux.org.uk>
Message-ID: <AANLkTinpcYoHKKDhqy9mKpqOEGtMpNc1BSukNWH-GVBX@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 February 2011 15:12, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Feb 15, 2011 at 02:54:21PM +0100, Per Forlin wrote:
>> I don't fully understand this yet. I think you are right but I need a
>> little help to get there myself.
>> I agree, the cache (L1 and L2) must be invalidated after the DMA has completed.
>> Before starting the DMA the write buffers must be drained (cache_sync).
>>
>> Why invalidate the cache before starting the DMA?
>
> Think about what happens if you have dirty cache lines in the DMA region.
> These can be evicted when other cache lines are loaded, which will result
> in them overwriting contents of memory. ?If the DMA device has already
> written to that memory, the result is data corruption.
>
> So, the invalidate prior to DMA is to get rid of any dirty cache lines
> which could be written back to memory.
>
True. In my case write back is disable but read back is enable, that's
why I didn't consider it.
Do you think it is feasible to let dma-mapping detect the cache
configurations in runtime in order to prevent "unnecessary" cache
operations? I can see some FIXME comments in the code which indicates
you may have plans to change it.

I can try to think of a proposal if you agree.

Thanks again,
/Per
