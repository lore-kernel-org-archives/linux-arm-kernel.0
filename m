From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 14 Jun 2011 22:42:24 +0200
Subject: [Linaro-mm-sig] [PATCH 08/10] mm: cma: Contiguous Memory
	Allocator added
In-Reply-To: <BANLkTi=cJisuP8=_YSg4h-nsjGj3zsM7sg@mail.gmail.com>
References: <1307699698-29369-1-git-send-email-m.szyprowski@samsung.com>
	<20110614170158.GU2419@fooishbar.org>
	<BANLkTi=cJisuP8=_YSg4h-nsjGj3zsM7sg@mail.gmail.com>
Message-ID: <201106142242.25157.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 14 June 2011 20:58:25 Zach Pfeffer wrote:
> I've seen this split bank allocation in Qualcomm and TI SoCs, with
> Samsung, that makes 3 major SoC vendors (I would be surprised if
> Nvidia didn't also need to do this) - so I think some configurable
> method to control allocations is necessarily. The chips can't do
> decode without it (and by can't do I mean 1080P and higher decode is
> not functionally useful). Far from special, this would appear to be
> the default.

Thanks for the insight, that's a much better argument than 'something
may need it'. Are those all chips without an IOMMU or do we also
need to solve the IOMMU case with split bank allocation?

I think I'd still prefer to see the support for multiple regions split
out into one of the later patches, especially since that would defer
the question of how to do the initialization for this case and make
sure we first get a generic way.

You've convinced me that we need to solve the problem of allocating
memory from a specific bank eventually, but separating it from the
one at hand (contiguous allocation) should help getting the important
groundwork in at first.

The possible conflict that I still see with per-bank CMA regions are:

* It completely destroys memory power management in cases where that
  is based on powering down entire memory banks.

* We still need to solve the same problem in case of IOMMU mappings
  at some point, even if today's hardware doesn't have this combination.
  It would be good to use the same solution for both.

	Arnd
