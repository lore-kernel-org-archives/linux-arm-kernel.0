From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 28 Sep 2012 09:38:19 +0100
Subject: [PATCH 2/2] arm: Add ARM ERRATA 782773 workaround
In-Reply-To: <20120928010246.GA13133@verge.net.au>
References: <1347434097-7924-1-git-send-email-horms@verge.net.au>
 <1347434097-7924-3-git-send-email-horms@verge.net.au>
 <5050CD87.4020800@codeaurora.org>
 <20120913010041.GD7622@verge.net.au>
 <CAHkRjk500KGTeBD67YMWy2qSdaoO_=Y9WBT_Q78n9Zxgqtmo4w@mail.gmail.com>
 <20120921010037.GI21660@verge.net.au>
 <20120928010246.GA13133@verge.net.au>
Message-ID: <20120928083819.GA21542@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 28, 2012 at 02:02:46AM +0100, Simon Horman wrote:
> On Fri, Sep 21, 2012 at 10:00:37AM +0900, Simon Horman wrote:
> > On Thu, Sep 20, 2012 at 10:35:50AM +0100, Catalin Marinas wrote:
> > > On 13 September 2012 02:00, Simon Horman <horms@verge.net.au> wrote:
> > > > On Wed, Sep 12, 2012 at 10:59:35AM -0700, Stephen Boyd wrote:
> > > >> On 09/12/12 00:14, Simon Horman wrote:
> > > >> > @@ -1423,6 +1423,15 @@ config ARM_ERRATA_775420
> > > >> >           deadlock. This workaround puts DSB before executing ISB at the
> > > >> >           beginning of the abort exception handler.
> > > >> >
> > > >> > +config ARM_ERRATA_782773
> > > >> > +   bool "ARM errata: Updating a translation entry might cause an unexpected translation fault"
> > > >> > +   depends on CPU_V7
> > > >> > +   help
> > > >> > +     This option enables the workaround for the 782773 Cortex-A9 (all r0,
> > > >> > +     ,r2 and r3 revisions) erratum. It might cause MMU exception in case
> > > >>
> > > >> Seems to be an extra comma here.
> > > >
> > > > Thanks, here is an updated version.
> > > >
> > > > From: Kouei Abe <kouei.abe.cp@rms.renesas.com>
> > > >
> > > > arm: Add ARM ERRATA 782773 workaround
> > > >
> > > > Signed-off-by: Kouei Abe <kouei.abe.cp@rms.renesas.com>
> > > > Signed-off-by: Simon Horman <horms@verge.net.au>
> > > 
> > > I would add some text to the commit log as well, even though it
> > > matches the Kconfig entry.
> > 
> > Sure, an updated patch is below.
> > I also reworded the text to make it easier on my eyes,
> > I don't think the meaning has been altered.
> > 
> > > Have you hit this in practice? In general the kernel shouldn't access
> > > kernel virtual address corresponding to a page table that is being
> > > changed. For user address space it is possible but the kernel can
> > > handle use translation faults, even though they may be spurious.
> > 
> > I believe that Abe-san's team have come up against this,
> > I can confirm that if it is important.
> 
> I was wondering if I could get an Ack on this as you indicated
> in another email that you feel that the implementation is an
> appropriate workaround.

I'd like to know whether this is actually hit in practice and the
conditions. The only time when we write live (i.e. translation that's
currently in use) kernel mappings is during boot, alloc_init_section()
replacing (though with the same value) the initial memory map. But if
that's the scenario you are getting, I would rather add another
flush_pmd_entry() call before setting the pmd in alloc_init_section().

I'm not convinced a costly run-time workaround in set_pte is needed.

-- 
Catalin
