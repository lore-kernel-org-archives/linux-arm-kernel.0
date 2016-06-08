From: thommyj@gmail.com (Thommy Jakobsson)
Date: Wed, 8 Jun 2016 09:47:46 +0200
Subject: [PATCH 2/2] arm-smmu: Add possibillity to mask streamIDs
In-Reply-To: <575570D9.6030700@arm.com>
References: <1464640806-3942-1-git-send-email-thommyj@gmail.com>
 <1464640806-3942-3-git-send-email-thommyj@gmail.com>
 <575570D9.6030700@arm.com>
Message-ID: <CAOTQ16KCKw3UiN+oFC8PH=1YYw7xfNhoJgM2ozTCf8RGYvEbpw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 June 2016 at 14:47, Robin Murphy <robin.murphy@arm.com> wrote:
> That rationale doesn't hold, since "necessary" is clearly untrue - devices
> with multiple IDs work just fine even with the current behaviour of the
> driver provided there are sufficient SMRs. The third option of generating a
> mask dynamically from a set of IDs is also perfectly possible (which reminds
> me I must dig up the code I prototyped a while back...), although an
> explicitly specified mask can still be beneficial for optimal allocation in
> certain cases (by being able to express the non-existence of IDs outside the
> set).
Thanks for your time Robin. I was probably unclear in my comment. You're
right and devices with multiple IDs do work already today. Its more the second
part that you talk about that limits me, "provided there are
sufficient SMRs". In
the ZynqMPSoC, 6 of the AXI ID bits are copied into the stream id for FPGA
IPs, so I have 2^6 IDs per master and there is 6 masters. Besides the FPGA
there is also ethernet and dma masters (also gpu and sata, but I don't use
those). The SMMU implementation only has 48 register groups to play with, so
without mask I'm screwed =)

> But this directly contradicts the example in the binding doc? (Which
> incidentally wasn't sent to the devicetree mailing list.)
Not sure that I follow, what contradicts? My intention was that for masters that
explicitly is configured with a mask, all of its IDs should have a mask. Without
specifying a mask it should be same behavior as before. The doc example
shows a master, dma2, with one ID and one mask.

> What if the DT is wrong and the SMMU doesn't support stream matching at all,
> or the mask uses unimplemented SMR bits? Bogus stream IDs or stream match
> conflicts are annoyingly subtle to debug.
Point taken.

> Either way, if you insist on wanting to build on the legacy binding that
> doesn't work for PCI, can't integrate with DMA mapping, and everyone else
> would rather get away from in favour of the generic IOMMU bindings[1],
Generic IOMMU bindings would be great, but I'm not sure that it solves
my problem
with too many IDs vs SMRs. For a smaller

> there's still no need for yet another binding to support. You can easily
> extend "mmu-masters" to encode an SMR mask in the upper halfword of a cell
> without ambiguity and without breaking compatibility with existing DTs.
How do you mean breaking compatibility with existing DTs? It was my
intention not
to do so but instead adding an optional mask for cases when actually needed.
>From a user perspective I would personally consider it a bit easier to
understand
with separate bindings for mask and ID, but to be honest I haven't worked that
much with DT bindings before (which is also why I missed sending it to the DT
mailinglist). So if you see a problem with an increasing mass of
bindings to support,
and consider using the upper halfword of the ID-cell a better way,
then sure I'll buy
that.

BR,
Thommy Jakobsson
