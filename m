From: roy.pledge@nxp.com (Roy Pledge)
Date: Tue, 27 Jun 2017 18:59:38 +0000
Subject: [GIT PULL v3] updates to qbman (soc drivers) to support arm/arm64
References: <HE1PR0401MB17071A7853695DB6546FE28C8FC50@HE1PR0401MB1707.eurprd04.prod.outlook.com>
 <CAK8P3a2EvCvs57hE_X9J5jg6jW8jPh6gxaTOUYntbnHdb_cMZA@mail.gmail.com>
 <20170623152227.GA21989@leverpostej>
 <DB6PR04MB2999E8FFBE0FE708A003637986D80@DB6PR04MB2999.eurprd04.prod.outlook.com>
 <CAK8P3a0mhWTRriGYB6aHS28dm842d-0OeGRmRYzMS4ZYY9=YCQ@mail.gmail.com>
Message-ID: <DB6PR04MB2999164C01F65D6BFAA8D93A86DC0@DB6PR04MB2999.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/27/2017 3:17 AM, Arnd Bergmann wrote:
> On Fri, Jun 23, 2017 at 8:58 PM, Roy Pledge <roy.pledge@nxp.com> wrote:
>> On 6/23/2017 11:23 AM, Mark Rutland wrote:
>>> On Fri, Jun 23, 2017 at 04:56:10PM +0200, Arnd Bergmann wrote:
>>>> On Tue, Jun 20, 2017 at 7:27 PM, Leo Li <leoyang.li@nxp.com> wrote:
>>>>
>>>> 2. I know we have discussed the unusual way this driver accesses MMIO
>>>> registers in the past, using ioremap_wc() to map them and the manually
>>>> flushing the caches to store the cache contents into the MMIO registers.
>>>> What I don't know is whether there was any conclusion on this topic whether
>>>> this is actually allowed by the architecture or at least the chip, based on
>>>> implementation-specific features that make it work even when the architecture
>>>> doesn't guarantee it.
>>> From prior discussions, my understanding was that the region in question
>>> was memory reserved for the device, rather than MMIO registers.
>
> Ok.
>
>>> The prior discussion on that front were largely to do with teh
>>> shareability of that memory, which is an orthogonal concern.
>>>
>>> If these are actually MMIO registers, a Device memory type must be used,
>>> rather than a Normal memory type. There are a number of things that
>>> could go wrong due to relaxations permitted for Normal memory, such as
>>> speculative reads, the potential set of access sizes, memory
>>> transactions that the endpoint might not understand, etc.
>> The memory for this device (what we refer to as Software Portals) has 2
>> regions. One region is MMIO registers and we access it using
>> readl()/writel() APIs.
>
> Ok, good.
>
>> The second region is what we refer to as the cacheable area.  This is
>> memory implemented as part of the QBMan device and the device accepts
>> cacheline sized transactions from the interconnect. This is needed
>> because the descriptors read and written by SW are fairly large (larger
>> that 64 bits/less than a cacheline) and in order to meet the data rates
>> of our high speed ethernet ports and other accelerators we need the CPU
>> to be able to form the descriptor in a CPU cache and flush it safely
>> when the device is read to consume it.  Myself and the system architect
>> have had many discussions with our design counterparts in ARM to ensure
>> that our interaction with the core/interconnect/device are safe for the
>> set of CPU cores and interconnects we integrate into our products.
>>
>> I understand there are concerns regarding our shareablity proposal
>> (which is not enabled in this patch set). We have been collecting some
>> information and talking to ARM and I do intend to address these concerns
>> but I was delaying confusing things more until this basic support gets
>> accepted and merged.
>
> Can you summarize what the constraints are that we have for mapping
> this area? E.g. why can't we just have an uncached write-combining
> mapping and skip the flushes?

For ARM/ARM64 we can (and currently do) map as uncached write-combing 
but for PPC we cannot do this as the device only accepts cacheline sized 
transactions in the cache enabled area. The device requirements were 
relaxed for ARM since the interconnect had different behavior than the 
PPC interconnect we were using. The goal for ARM is to map this memory 
as non-shareable as it gives a significant performance increase over 
write combine. We intended to work on acceptance of this mode more once 
basic support is in.

The flushes in the code for ARM can be removed but the PPC calls are 
needed.  In the dpaa_flush() code below I think the ARM variants could 
be removed for now (I would want to run some tests of course).

>
>>>> Can I have an Ack from the architecture maintainers (Russell, Catalin,
>>>> Will) on the use of these architecture specific interfaces?
>>>>
>>>> static inline void dpaa_flush(void *p)
>>>> {
>>>> #ifdef CONFIG_PPC
>>>>         flush_dcache_range((unsigned long)p, (unsigned long)p+64);
>>>> #elif defined(CONFIG_ARM32)
>>>>         __cpuc_flush_dcache_area(p, 64);
>>>> #elif defined(CONFIG_ARM64)
>>>>         __flush_dcache_area(p, 64);
>>>> #endif
>>>> }
>>> Assuming this is memory, why can't the driver use the DMA APIs to handle
>>> this without reaching into arch-internal APIs?
>>
>> I agree this isn't pretty - I think we could use
>> dma_sync_single_for_device() here but I am concerned it will be
>> expensive and hurt performance significantly. The DMA APIs have a lot of
>> branches. At some point we were doing 'dc cvac' here and even switching
>> to the above calls caused a measurable drop in throughput at high frame
>> rates.
>
> I'd suggest we start out by converting this to some standard API
> first, regardless of performance, to get it working properly with code
> that should be maintainable at least, and make progress with your
> hardware enablement.
>
> In parallel, we can discuss what kind of API we actually need and
> how to fit that into the existing frameworks. This may take a while
> as it depends on your other patch set, and perhaps input from
> other parties that may have similar requirements. I could imagine
> that e.g. Marvell, Cavium or Annapurna (Amazon) do something
> similar in their hardware, so if we find that we need a new API,
> we should define it in a way that works for everyone.

I'm happy that your open to extending the API for these types of 
devices. I will reply to another email shortly but I think using the 
memremap() API for the Cache Enabled area is a good change for this 
device and will address the __iomem concerns.

>
>         Arnd
>
