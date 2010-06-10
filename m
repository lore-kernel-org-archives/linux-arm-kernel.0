From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 10 Jun 2010 14:14:37 -0400 (EDT)
Subject: [PATCH v2 1/4] ARM: Remove the domain switching on ARMv6k/v7 CPUs
In-Reply-To: <1276169316.24535.32.camel@e102109-lin.cambridge.arm.com>
References: <20100602164459.17783.9741.stgit@e102109-lin.cambridge.arm.com>
	<20100602164841.17783.94825.stgit@e102109-lin.cambridge.arm.com>
	<alpine.LFD.2.00.1006091447460.30664@xanadu.home>
	<1276122405.17056.47.camel@toshiba-laptop>
	<alpine.LFD.2.00.1006092039000.30664@xanadu.home>
	<1276169316.24535.32.camel@e102109-lin.cambridge.arm.com>
Message-ID: <alpine.LFD.2.00.1006101411160.30664@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 10 Jun 2010, Catalin Marinas wrote:

> On Thu, 2010-06-10 at 01:56 +0100, Nicolas Pitre wrote:
> > On Wed, 9 Jun 2010, Catalin Marinas wrote:
> > 
> > > On Wed, 2010-06-09 at 20:10 +0100, Nicolas Pitre wrote:
> > > > Sorry for the delay... I'm just starting to seriously look at this.
> > > >
> > > > On Wed, 2 Jun 2010, Catalin Marinas wrote:
> > > >
> > > > > This patch removes the domain switching functionality via the set_fs and
> > > > > __switch_to functions on cores that have a TLS register.
> > > > [...]
> > > > > The user pages access rights are also modified for kernel read-only
> > > > > access rather than read/write so that the copy-on-write mechanism still
> > > > > works. CPU_USE_DOMAINS gets disabled only if HAS_TLS_REG is defined
> > > > > since writing the TLS value to the high vectors page isn't possible.
> > > >
> > > > I don't like this limitation much.
> > > >
> > > > Since the vector page has to be accessed somehow for FIQs anyway, and
> > > > the current solution for that involves accesses through the direct
> > > > mapping of the vector page, then this patch could be made to work on
> > > > pre-ARMv6 systems too simply by adding the necessary cache ops around
> > > > the TLS and FIQ updates.
> > >
> > > Getting rid of domains in Linux requires that several functions no
> > > longer use LDRT/STRT but LDR/STR. This implies that RO user pages should
> > > also have RO permissions for the kernel. I don't have the old ARM ARM at
> > > hand now but I recall there were some issues with user RO kernel RO
> > > permission on pre-ARMv6 processors (there is an R bit in the CP15
> > > control register which may help, I need to check the documentation).
> > 
> > I just checked.  It says:
> > 
> >    The access permission bits in section and page descriptors control
> >    access to the corresponding section or page. The access permissions
> >    are modified by the System (S) and ROM (R) control bits in CP15
> >    register 1.
> > 
> > But those bits are of no use as they are effective only when the MMU
> > access permission bits are all 0, otherwise they're ignored.
> 
> OK. So for read-only user pages we could set AP to 00 and R to 1 so that
> pages are read-only for kernel as well. For the other cases we just use
> a non-zero AP.

But what about non existing pages?  They can't go through with a read 
access from the first memory page.

> > What I mean, though, is for this patch to work as well on VIVT systems
> > by using the domain switching _only_ when updating the TLS value or the
> > FIQ handler in the vector page.
> 
> And all the other times the domain would be set to client. That would
> work but we still need to change set_pte_ext() for all the pre-ARMv6
> processors since we need the user RO kernel RO permission (otherwise we
> break the copy-on-write mechanism which is currently handled correctly
> because we use STRT).

Agreed.


Nicolas
