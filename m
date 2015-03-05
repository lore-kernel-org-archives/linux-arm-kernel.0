From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 05 Mar 2015 16:42:31 +0000
Subject: [RFC PATCH 0/5] arm64: IOMMU-backed DMA mapping
In-Reply-To: <54F868A8.7070103@samsung.com>
References: <cover.1421086706.git.robin.murphy@arm.com>
 <54F868A8.7070103@samsung.com>
Message-ID: <54F88777.3090404@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On 05/03/15 14:31, Marek Szyprowski wrote:
> Hello,
>
> On 2015-01-12 21:48, Robin Murphy wrote:
>> Hi all,
>>
>> Whilst it's a long way off perfect, this has reached the point of being
>> functional and stable enough to be useful, so here it is. The core
>> consists of the meat of the arch/arm implementation modified to remove
>> the assumption of PAGE_SIZE pages and ported over to the Intel IOVA
>> allocator instead of the bitmap-based one. For that, this series depends
>> on my "Genericise the IOVA allocator" series posted earlier[1].
>
> I've tested your patches on Exynos 5433 based system and I have a few
> comments. To get them working I had to do some fixes. Most of them
> are already reported in this thread, the remaining I will send in a few
> minutes.

Thanks!

> Do you plan to send an updated patchset?

I already sent a v2 which addressed some of the major issues here:

http://thread.gmane.org/gmane.linux.kernel.iommu/8773

Following some of the feedback there I've currently got a v3 in 
development, which reworks a lot of it more in favour of scatterlists, 
and fills in some of the gaps needed to move arch/arm over (I still need 
to look at how to handle the drivers currently making use of 
dma_iommu_mapping directly).

Robin.

>
>> There are plenty of obvious things still to do, including:
>>
>>    * Domain and group handling is all wrong, but that's a bigger problem.
>>      For the moment it does more or less the same thing as the arch/arm
>>      code, which at least works for the one-IOMMU-per-device situation.
>>    * IOMMU domains and IOVA domains probably want to be better integrated
>>      with devices and each other, rather than having a proliferation of
>>      arch-specific structs.
>>    * The temporary map_sg implementation - I have a 'proper' iommu_map_sg
>>      based one in progress, but since the simple one works it's not been
>>      as high a priority.
>
> Well, for ARM arch this was the main feature of IOMMU and DMA-mapping
> integration. It is heavily used by some multimedia devices and dma-buf
> realted stuff to get a scattered buffer mapped into contiguous IO address
> space.
>
>>    * Port arch/arm over to it. I'd guess it might be preferable to merge
>>      this through arm64 first, though, rather than overcomplicate matters.
>
> I think that the code in arch/arm is already quite well tested and can be
> almost directly reused for common dma-mapping helpers.
>
>>    * There may well be scope for streamlining and tidying up the copied
>>      parts - In general I've simply avoided touching anything I don't
>>      fully understand.
>>    * In the same vein, I'm sure lots of it is fairly ARM-specific, so will
>>      need longer-term work to become truly generic.
>>
>> [1]:http://thread.gmane.org/gmane.linux.kernel.iommu/8208
>
> Best regards
>
