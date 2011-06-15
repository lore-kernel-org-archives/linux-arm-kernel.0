From: subashrp@gmail.com (Subash Patel)
Date: Wed, 15 Jun 2011 11:59:01 +0530
Subject: [Linaro-mm-sig] [PATCH 08/10] mm: cma: Contiguous Memory Allocator
	added
In-Reply-To: <201106142242.25157.arnd@arndb.de>
References: <1307699698-29369-1-git-send-email-m.szyprowski@samsung.com>	<20110614170158.GU2419@fooishbar.org>	<BANLkTi=cJisuP8=_YSg4h-nsjGj3zsM7sg@mail.gmail.com>
	<201106142242.25157.arnd@arndb.de>
Message-ID: <4DF8512D.4020902@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 06/15/2011 02:12 AM, Arnd Bergmann wrote:
> On Tuesday 14 June 2011 20:58:25 Zach Pfeffer wrote:
>> I've seen this split bank allocation in Qualcomm and TI SoCs, with
>> Samsung, that makes 3 major SoC vendors (I would be surprised if
>> Nvidia didn't also need to do this) - so I think some configurable
>> method to control allocations is necessarily. The chips can't do
>> decode without it (and by can't do I mean 1080P and higher decode is
>> not functionally useful). Far from special, this would appear to be
>> the default.
>
> Thanks for the insight, that's a much better argument than 'something
> may need it'. Are those all chips without an IOMMU or do we also
> need to solve the IOMMU case with split bank allocation?

In exynos4, the IP's can work with/without IOMMU. So contiguous 
allocator like CMA needs to have provision for this as well (now or 
sometime in future). I hope someone will throw light on the other SoC's 
as well (and I hope they aren't different either)

>
> I think I'd still prefer to see the support for multiple regions split
> out into one of the later patches, especially since that would defer
> the question of how to do the initialization for this case and make
> sure we first get a generic way.
>
> You've convinced me that we need to solve the problem of allocating
> memory from a specific bank eventually, but separating it from the
> one at hand (contiguous allocation) should help getting the important
> groundwork in at first.
>
> The possible conflict that I still see with per-bank CMA regions are:
>
> * It completely destroys memory power management in cases where that
>    is based on powering down entire memory banks.

I agree. But what if we release the per-bank buffers after we use it? 
Shouldn't the memory power management switch-off the un-used banks then?

>
> * We still need to solve the same problem in case of IOMMU mappings
>    at some point, even if today's hardware doesn't have this combination.
>    It would be good to use the same solution for both.
>
> 	Arnd
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Regards,
Subash
SISO-SLG
