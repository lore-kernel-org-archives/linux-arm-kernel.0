From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 13 Jan 2015 11:45:25 +0000
Subject: [RFC PATCH 0/5] arm64: IOMMU-backed DMA mapping
In-Reply-To: <alpine.DEB.2.02.1501131102540.3058@kaball.uk.xensource.com>
References: <cover.1421086706.git.robin.murphy@arm.com>
 <alpine.DEB.2.02.1501131102540.3058@kaball.uk.xensource.com>
Message-ID: <54B50555.6090803@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/01/15 11:08, Stefano Stabellini wrote:
> On Mon, 12 Jan 2015, Robin Murphy wrote:
>> Hi all,
>>
>> Whilst it's a long way off perfect, this has reached the point of being
>> functional and stable enough to be useful, so here it is. The core
>> consists of the meat of the arch/arm implementation modified to remove
>> the assumption of PAGE_SIZE pages and ported over to the Intel IOVA
>> allocator instead of the bitmap-based one. For that, this series depends
>> on my "Genericise the IOVA allocator" series posted earlier[1].
>>
>> There are plenty of obvious things still to do, including:
>>
>>   * Domain and group handling is all wrong, but that's a bigger problem.
>>     For the moment it does more or less the same thing as the arch/arm
>>     code, which at least works for the one-IOMMU-per-device situation.
>>   * IOMMU domains and IOVA domains probably want to be better integrated
>>     with devices and each other, rather than having a proliferation of
>>     arch-specific structs.
>>   * The temporary map_sg implementation - I have a 'proper' iommu_map_sg
>>     based one in progress, but since the simple one works it's not been
>>     as high a priority.
>>   * Port arch/arm over to it. I'd guess it might be preferable to merge
>>     this through arm64 first, though, rather than overcomplicate matters.
>>   * There may well be scope for streamlining and tidying up the copied
>>     parts - In general I've simply avoided touching anything I don't
>>     fully understand.
>>   * In the same vein, I'm sure lots of it is fairly ARM-specific, so will
>>     need longer-term work to become truly generic.
>>
>> [1]:http://thread.gmane.org/gmane.linux.kernel.iommu/8208
>
> I tried to git-am and build a v3.19-rc4 kernel with this series (config
> file attached), but I get:
>
> In file included from include/linux/dma-mapping.h:82:0,
>                   from arch/arm64/kernel/asm-offsets.c:23:
> ./arch/arm64/include/asm/dma-mapping.h: In function ?phys_to_dma?:
> ./arch/arm64/include/asm/dma-mapping.h:69:2: error: ?struct dev_archdata? has no member named ?mapping?
> ./arch/arm64/include/asm/dma-mapping.h: In function ?dma_to_phys?:
> ./arch/arm64/include/asm/dma-mapping.h:81:19: error: ?struct dev_archdata? has no member named ?mapping?
> make[1]: *** [arch/arm64/kernel/asm-offsets.s] Error 1
>

Oops, looks like I've been relying on having an actual IOMMU driver 
select CONFIG_IOMMU_API - enabling the ARM SMMU driver as well as "IOMMU 
hardware support" makes everything build, even if it doesn't actually 
work with the new framework (the patches for that exist, but are 
currently a big ugly mess).

The nested #include guard in arch/arm64/include/asm/device.h in patch 4 
is to blame - on reflection, I guess that isn't a great idea regardless 
of the logical dependency (I don't think my Kconfig-fu is strong enough 
to guarantee that dependency is enforced).

Robin.
