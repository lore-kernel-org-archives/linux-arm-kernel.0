From: kmpark@infradead.org (Kyungmin Park)
Date: Mon, 18 Apr 2011 21:55:56 +0900
Subject: [PATCH] OMAP: iommu flush page table entries from L1 and L2 cache
In-Reply-To: <201104181358.53521.arnd@arndb.de>
References: <1302817968-28516-1-git-send-email-fernando.lugo@ti.com>
	<201104180929.33569.arnd@arndb.de>
	<20110418110502.GI12272@atomide.com>
	<201104181358.53521.arnd@arndb.de>
Message-ID: <BANLkTimc20N0nh9O0FaSXizW+bYOMx9Ddw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 18, 2011 at 8:58 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 18 April 2011, Tony Lindgren wrote:
>> * Arnd Bergmann <arnd@arndb.de> [110418 10:26]:
>> > On Friday 15 April 2011, Russell King - ARM Linux wrote:
>> > > On Thu, Apr 14, 2011 at 04:52:48PM -0500, Fernando Guzman Lugo wrote:
>> > > > From: Ramesh Gupta <grgupta@ti.com>
>> > > >
>> > > > This patch is to flush the iommu page table entries from L1 and L2
>> > > > caches using dma_map_single. This also simplifies the implementation
>> > > > by removing the functions ?flush_iopgd_range/flush_iopte_range.
>> > >
>> > > No. ?This usage is just wrong. ?If you're going to use the DMA API then
>> > > unmap it, otherwise the DMA API debugging will go awol.
>> >
>> >
>> > It's also completely upside-down: The iommu support should provide interfaces
>> > using the dma-mapping API, not use that API to provide a machine specific
>> > version of the generic interface.
>> >
>> > As far as I can tell, nothing actually uses these drivers, maybe we should just
>> > remove them before we get any code in the mainline kernel that depends on it.
>>
>> There is drivers/media/video/omap3isp/isp.c.
>
> Ah, I didn't see that, was looking at an older version.
>
>> But if we now have a generic replacement for this code we should start
>> using it.
>
> To give some background:
>
> Historically, the dma-mapping API has been used for all IOMMUs on
> architectures that need it. This interface is rather flexible,
> but ARM currently only uses it for managing static mappings.
> One thing that it cannot do is mapping memory to an arbitrary
> (driver-chosen) bus address. The generic iommu API was added in order
> to do that, and is mostly used for virtual machines with KVM.
>
> The MSM platform in ARM also added support for the generic iommu
> API, and now the exynos4 is gaining support for it as well.

You can find a exynos4 patches.
http://comments.gmane.org/gmane.linux.drivers.video-input-infrastructure/31613

>
> One missing piece is still a way for a platform to provide both
> the iommu and the dma-mapping API in a unified driver. Right now,
> you have to export both interface for a generic solution.

Actually MSM and we (Michal, Marek) tried to merge the generic IOMMU
implementation into mm, but MM did't accept it.
So now it's implemented at each SoCs. I think it's good chance to make
a generic IOMMU feature for ARM consolidation.

>
> On ARM, we don't yet use include/asm-generic/dma-mapping-common.h,
> which allows overriding the dma-mapping API per device. This would
> have to change if you want to export the IOMMU functionality using
> the dma-mapping API, but that would also allow abstracting the
> various ways we currently have (dmabounce, swiotlb, linear map,
> custom __arch_page_to_dma, iommu, coherent or noncoherent DMA)
> in a nicer way per device.

Before this idea, can you review our implementation at above URL?

Thank you,
Kyungmin Park
>
> ? ? ? ?Arnd
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
