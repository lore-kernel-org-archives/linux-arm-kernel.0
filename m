From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 16 Nov 2015 10:57:26 +0000
Subject: [PATCH v3 0/6] arm64 UEFI early FDT handling
In-Reply-To: <20151116104352.GB1719@arm.com>
References: <1442881288-13962-1-git-send-email-ard.biesheuvel@linaro.org>
 <CAKv+Gu8m2M9920yPRcrjmPeJPXKj=xd7ypH+ZFcYEm+_t5a5ig@mail.gmail.com>
 <20151116104352.GB1719@arm.com>
Message-ID: <20151116105725.GB6556@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 16, 2015 at 10:43:52AM +0000, Will Deacon wrote:
> On Tue, Sep 29, 2015 at 08:38:57AM +0100, Ard Biesheuvel wrote:
> > On 22 September 2015 at 02:21, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> > > This is a followup to the "arm64: update/clarify/relax Image and FDT placement
> > > rules" series I sent a while ago:
> > > (http://article.gmane.org/gmane.linux.ports.arm.kernel/407148)
> > >
> > > This has now been split in two series: this first series deals with the
> > > early FDT handling, primarily in the context of UEFI, but not exclusively.
> > >
> > > A number of minor issues exist in the early UEFI/FDT handling path, such as:
> > > - when booting via UEFI, memreserve entries are removed from the device tree but
> > >   the /reserved-memory node is not
> > 
> > After reading Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
> > again, I think simply ignoring the reserved-memory node is not the way
> > to go. The reason is that it may contain dynamic allocations that are
> > referenced by other nodes in the DT, and there is no good technical
> > reason IMO to disallow those. OTOH, static allocations may conflict
> > with the UEFI memory map, so those need to be dropped or at least
> > checked against the memory map. The problem here is that static nodes
> > may also be referenced by phandle, so we need to handle the referring
> > node in some way as well.
> > 
> > So I think we have a number of options:
> > - ignore /memreserve/s and reject static allocations in
> > /reserved-memory (*) but honor dynamic ones
> > - ignore /memreserve/s and honor all of /reserved-memory after
> > checking that static allocations don't conflict
> > - honor all /memreserve/s and /reserved-memory nodes and check all for conflicts
> > - ...
> > 
> > (*) static allocations for regions that the UEFI memory map does not
> > describe should be OK, though
> > 
> > I personally prefer the first one, since a dynamic allocation
> > implicitly conveys that the region does not contain anything special
> > when coming out of boot, and there is very little we need to do other
> > than perform the actual reservation. Static allocations are ambiguous
> > in the sense that there is no annotation that explains the choice of
> > address.
> > 
> > Thoughts, please?
> 
> What's the status of this series? It was on my "list of patches to watch"
> that I'm just refreshing for 4.5, but I can't see any comments on-list
> about it.

I thought it's being taken over by this series:

http://lkml.kernel.org/r/1446126059-25336-1-git-send-email-ard.biesheuvel at linaro.org

-- 
Catalin
