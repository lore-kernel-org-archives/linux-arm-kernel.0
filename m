From: will.deacon@arm.com (Will Deacon)
Date: Fri, 9 Oct 2015 13:32:54 +0100
Subject: [PATCH v2 10/10] ARM: software-based priviledged-no-access support
In-Reply-To: <20151009112418.GN32532@n2100.arm.linux.org.uk>
References: <20150825154026.GT7557@n2100.arm.linux.org.uk>
 <E1ZUGMS-0000BG-8B@rmk-PC.arm.linux.org.uk>
 <CACRpkdZhJfsH0wU0VBotT=yomDqBkKWrz3MNFOin=CCz62v_nw@mail.gmail.com>
 <20151009105309.GM26278@arm.com>
 <20151009112418.GN32532@n2100.arm.linux.org.uk>
Message-ID: <20151009123254.GN26278@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 09, 2015 at 12:24:18PM +0100, Russell King - ARM Linux wrote:
> On Fri, Oct 09, 2015 at 11:53:09AM +0100, Will Deacon wrote:
> > It looks like we're faulting on the TLBI instruction, because it's
> > targetting a userspace address (r0 == 0xb6f01002) and the DAC prohibits
> > access to userspace.
> 
> That's kind'a weird - I'd have expected _cache_ operations to fault,
> but not TLB operations.  From a quick search of the ARM ARM, I can't
> find anything that says that TLB operations are allowed to fault.

Yes, you're right. I was concentrating on the cross-call scenario and
forgot this was TLB not cache maintenance, so faulting is indeed bizarre.

> > It's weird that this only seems to happen on 11MPCore
> > though; if this core was one of the guys getting cross-called, then I
> > could understand the bug, but the lr suggests that CPU 2 is initiating
> > the flush, so I'd expect the same problem to appear on any ARMv6 part.
> 
> It sounds to me like a CPU bug, but one which we need to work around.
> ipi_flush_tlb_range() will be the function concerned, we need to
> save-and-enable, and then restore the user access state around that
> call.
> 
> > Russell, have you tried the s/w PAN stuff on any v6 CPUs?
> 
> No.  I have considered having the Realview EB board as part of the test
> farm, but as that board is hassle to get going, I deem the hardware to
> be too unreliable for that.  (I reported the problem at the time.)
> 
> Linus, can you try the patch below to see if it resolves the problem
> you're seeing please?

If this fixes things, I'll dig up the errata document to see if this is
a known hardware issue.

Will
