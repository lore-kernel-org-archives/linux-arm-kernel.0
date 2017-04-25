From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 25 Apr 2017 14:42:30 +0100
Subject: [PATCH 1/3] arm64: extend ioremap for cacheable non-shareable
 memory
In-Reply-To: <7C745CC3-3E91-4A8A-8DAB-0FA4E50DF08B@nxp.com>
References: <1492716858-24509-1-git-send-email-Haiying.Wang@nxp.com>
 <1492716858-24509-2-git-send-email-Haiying.Wang@nxp.com>
 <20170421091156.GA6406@leverpostej>
 <7C745CC3-3E91-4A8A-8DAB-0FA4E50DF08B@nxp.com>
Message-ID: <20170425134229.GD3792@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 21, 2017 at 02:30:32PM +0000, Roy Pledge wrote:
> These transactions are done in HW via an ACP port which if I remember
> correctly only supports non coherent transactions.  I will need to go
> back and check through email conversations I had with Catalin last
> year when debugging an issue using this mechanism
> (cacheable/nonshareable mapping) but it was deemed to be valid ARM
> setup architecturally for this type of device.
>
> Just for some background the page the QBMan device presented to a core
> is only accessed by a single core (i.e. SW portals are core affine).
> In this model each page is always mapped as non shareable and another
> core will never access it.

You cannot guarantee this given the page tables are used by multiple
CPUs.

The problem is not explicit memory accesses performed by code. As you
suggest, you can enforce that instructions accessing memory are only
architecturally executed on certain CPUs.

The problem is that even without any explicit access, a CPU can
implicitly access any region of Normal memory, at any time, for any
reason the microarchitecture sees fit to do so.

For example, the core may speculate some arbitrary instruction sequence,
which (perhaps by chance) generates an address falling in the
Non-shareable region, and attempts to load from it. The results might be
thrown away (i.e. the sequence wasn't architecturally executed), but the
speculated accesses will affect the memory system, and can result in
problems such as what I described previously.

Further, a cache maintenance op on a VA is only guaranteed to affect
caches scoped to the shareability domain of that VA. So no amount of
cache maintenance can provide the guarantees you require.

Practically speaking, because of such issues, it does not make sense for
Linux to use Non-shareable mappings.

> The important factor is that it is not DDR memory being mapped non
> sharable, but a non-coherent master on the bus in our SoC.  I agree
> regular RAM shouldn?t be mapped this way but we cannot map this device
> as cacheable/shareable (coherent) on CCN-504 devices without getting
> exceptions from the CCN-504. 

The problem is that multiple CPUs have a Non-shareable mapping for the
same physical address. What in particular is being mapped is immaterial.

> Treating it as non cacheable is functionally OK but performance
> suffers in that case.

Given that mapping these regions as Non-shareable is not functionally
OK, and given that you are unable to use coherent transactions, the only
option is to use a Non-cacheable mapping.

Thanks,
Mark.
