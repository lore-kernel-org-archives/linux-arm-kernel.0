From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 12 May 2014 12:29:16 -0600
Subject: [RFC] Describing arbitrary bus mastering relationships in DT
In-Reply-To: <25333129.urqEa0mCI8@wuerfel>
References: <20140501173248.GD3732@e103592.cambridge.arm.com>
 <20140509105638.GB3921@e103592.cambridge.arm.com>
 <5370F484.9030209@wwwdotorg.org> <25333129.urqEa0mCI8@wuerfel>
Message-ID: <537112FC.1040204@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/12/2014 12:10 PM, Arnd Bergmann wrote:
> On Monday 12 May 2014 10:19:16 Stephen Warren wrote:
>> On 05/09/2014 04:56 AM, Dave Martin wrote:
>>> On Fri, May 02, 2014 at 09:06:43PM +0200, Arnd Bergmann wrote:
>>>> On Friday 02 May 2014 12:50:17 Stephen Warren wrote:
>> ...
>>>>> Now, perhaps there are devices which themselves control whether
>>>>> transactions are sent to the IOMMU or direct to RAM, but I'm not
>>>>> familiar with them. Is the GPU in that category, since it has its own
>>>>> GMMU, albeit chained into the SMMU IIRC?
>>>>
>>>> Devices with a built-in IOMMU such as most GPUs are also easy enough
>>>> to handle: There is no reason to actually show the IOMMU in DT and
>>>> we can just treat the GPU as a black box.
>>>
>>> It's impossible for such a built-in IOMMU to be shared with other
>>> devices, so that's probably reasonable.
>>
>> I don't believe that's true.
>>
>> For example, on Tegra, the CPU (and likely anything that can bus-master
>> the relevant bus) can send transactions into the GPU, which can then
>> turn them around towards RAM, and those likely then go through the MMU
>> inside the GPU.
>>
>> IIRC, the current Nouveau support for Tegra even makes use of that
>> feature, although I think that's a temporary thing that we're hoping to
>> get rid of once the Tegra support in Nouveau gets more mature.
> 
> But the important point here is that you wouldn't use the dma-mapping
> API to manage this. First of all, the CPU is special anyway, but also
> if you do a device-to-device DMA into the GPU address space and that
> ends up being redirected to memory through the IOMMU, you still wouldn't
> manage the I/O page tables through the interfaces of the device doing the
> DMA, but through some private interface of the GPU.

Why not? If something wants to DMA to a memory region, irrespective of
whether the GPU MMU (or any MMU) is in between those master transactions
and the RAM or not, surely the driver should always use the DMA mapping
API to set that up? Anything else just means using custom APIs, and
isn't the whole point of the DMA mapping API to provide a standard API
for that purpose?
