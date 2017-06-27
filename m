From: roy.pledge@nxp.com (Roy Pledge)
Date: Tue, 27 Jun 2017 18:36:27 +0000
Subject: [GIT PULL v3] updates to qbman (soc drivers) to support arm/arm64
References: <HE1PR0401MB17071A7853695DB6546FE28C8FC50@HE1PR0401MB1707.eurprd04.prod.outlook.com>
 <CAK8P3a2EvCvs57hE_X9J5jg6jW8jPh6gxaTOUYntbnHdb_cMZA@mail.gmail.com>
 <20170623152227.GA21989@leverpostej>
 <DB6PR04MB2999E8FFBE0FE708A003637986D80@DB6PR04MB2999.eurprd04.prod.outlook.com>
 <20170624121037.GA4902@n2100.armlinux.org.uk>
Message-ID: <DB6PR04MB29996DB665E31A7A7A9E6D1C86DC0@DB6PR04MB2999.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/24/2017 8:10 AM, Russell King - ARM Linux wrote:
> On Fri, Jun 23, 2017 at 06:58:17PM +0000, Roy Pledge wrote:
>> On 6/23/2017 11:23 AM, Mark Rutland wrote:
>>> On Fri, Jun 23, 2017 at 04:56:10PM +0200, Arnd Bergmann wrote:
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
>> I agree this isn't pretty - I think we could use
>> dma_sync_single_for_device() here but I am concerned it will be
>> expensive and hurt performance significantly. The DMA APIs have a lot of
>> branches. At some point we were doing 'dc cvac' here and even switching
>> to the above calls caused a measurable drop in throughput at high frame
>> rates.
>
> Well...
>
> __cpuc_flush_dcache_area() is used to implement flush_dcache_page() and
> flush_anon_page().  The former is about ensuring coherency between
> multiple mappings of a kernel page cache page and userspace.  The latter
> is about ensuring coherency between an anonymous page and userspace.
>
> Currently, on ARMv7, this is implemented using "mcr p15, 0, r0, c7, c14, 1"
> but we _could_ decide that is too heavy for these interfaces, and instead
> switch to a lighter cache flush if one were available in a future
> architecture revision (since the use case of this only requires it to
> flush to the point of unification, not to the point of coherence.)
>
> The overall effect is that changing the behaviour of this would introduce
> a regression into your driver, which would have to be reverted - and that
> makes my job as architecture maintainer difficult.
>
> It may make sense to explicitly introduce a "flush data cache to point
> of coherence" function - we already have gicv3 and kvm wanting this, and
> doing it the right way, via:
>
> #define gic_flush_dcache_to_poc(a,l)    __cpuc_flush_dcache_area((a), (l))
> #define kvm_flush_dcache_to_poc(a,l)     __cpuc_flush_dcache_area((a), (l))
>
> So, how about we introduce something like:
>
> 	void flush_dcache_to_poc(void *addr, size_t size)
>
> which is defined to ensure that data is visible to the point of coherence
> on all architectures?
>
This would be very useful and would help with this issue. To be 
completely honest an invalidate variant would be useful for us as well 
as we currently use flush in cases that we really just need to 
invalidate. The extra unneeded write back to the device can shows a 
small performance cost. I understand that exposing invalidate to users 
is potentially dangerous as you need to be 100% sure you're willing to 
through away any data in that cacheline so I won't be surprised if 
people aren't willing to expose an API for this.
