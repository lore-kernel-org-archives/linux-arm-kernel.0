From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 30 Jan 2017 15:31:26 +0000
Subject: [PATCH 06/10] soc/qbman: Add ARM equivalent for
 flush_dcache_range()
In-Reply-To: <1485570872.9266.22.camel@buserror.net>
References: <1484779180-1344-1-git-send-email-roy.pledge@nxp.com>
 <VI1PR0401MB2430DA6BD2F857C30EC86A50917F0@VI1PR0401MB2430.eurprd04.prod.outlook.com>
 <HE1PR0401MB263638F320470CA216990BCC86720@HE1PR0401MB2636.eurprd04.prod.outlook.com>
 <5414359.8GMja3pNrI@wuerfel>
 <VI1PR0401MB24303C4A5C0042005E17F1A391770@VI1PR0401MB2430.eurprd04.prod.outlook.com>
 <CAK8P3a1Gd4bd7GjEp_a9WXc_mTPk0XmP7DH8aPWhbn2K3MMuDQ@mail.gmail.com>
 <1485570872.9266.22.camel@buserror.net>
Message-ID: <d5ca6bcd-1d1a-2a61-1f5c-9086a67f629a@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/01/17 02:34, Scott Wood wrote:
> On Fri, 2017-01-27 at 17:41 +0100, Arnd Bergmann wrote:
>> On Thu, Jan 26, 2017 at 6:08 AM, Scott Wood <scott.wood@nxp.com> wrote:
>>>
>>> On 01/25/2017 03:20 PM, Arnd Bergmann wrote:
>>>>
>>>> On Monday, January 23, 2017 7:24:59 PM CET Roy Pledge wrote:
>>>
>>>>
>>>> If this is normal RAM, you should be able to just write zeroes, and then
>>>> do a dma_map_single() for initialization.
>>> The DMA API on PPC currently has no way of knowing that the device
>>> accesses this memory incoherently.
>> Ah, this is because PPC doesn't use the 'dma-coherent' property on devices
>> but just assumes that coherency is a global property of the platform,right?
> 
> Right.
> 
>>> If that were somehow fixed, we still couldn't use dma_map_single() as it
>>> doesn't accept virtual addresses that come from memremap() or similar
>>> dynamic mappings.  We'd have to convert the physical address to an array
>>> of struct pages and pass each one to dma_map_page().
>> Sorry for my ignorance, but where does the memory come from to start
>> with? Is this in the normal linearly mapped RAM, in a carveout outside
>> of the linear mapping but the same memory, or in some on-chip buffer?
> 
> It's RAM that comes from the device tree reserved memory mechanism
> (drivers/of/of_reserved_mem.c).  On a 32-bit kernel it is not guaranteed (or
> likely) to be lowmem.

Wouldn't dma_declare_coherent_memory() be the appropriate tool for that
job, then (modulo the PPC issue)? On ARM that should result in
dma_alloc_coherent() giving back a non-cacheable mapping if the device
is non-coherent, wherein a dmb_wmb() after writing the data from the CPU
side should be enough to ensure it is published to the device.

Robin.

>>> And even if we did all that, there would still be other manual cache
>>> manipulation left in this driver, to deal with its cacheable register
>>> interface.
>> I thought we had concluded that "cacheable register" is something
>> that cannot work reliably on ARM at all when this came up before.
>> Any updates on that?
> 
> I'm not familiar with the details there...  My understanding is that the
> hardware people at NXP are convinced that it can work on these specific chips
> due to implementation details.
> 
> -Scott
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
