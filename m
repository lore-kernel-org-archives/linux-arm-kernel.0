From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 09 Jun 2010 20:56:28 -0400 (EDT)
Subject: [PATCH v2 1/4] ARM: Remove the domain switching on ARMv6k/v7 CPUs
In-Reply-To: <1276122405.17056.47.camel@toshiba-laptop>
References: <20100602164459.17783.9741.stgit@e102109-lin.cambridge.arm.com>
	<20100602164841.17783.94825.stgit@e102109-lin.cambridge.arm.com>
	<alpine.LFD.2.00.1006091447460.30664@xanadu.home>
	<1276122405.17056.47.camel@toshiba-laptop>
Message-ID: <alpine.LFD.2.00.1006092039000.30664@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 9 Jun 2010, Catalin Marinas wrote:

> On Wed, 2010-06-09 at 20:10 +0100, Nicolas Pitre wrote:
> > Sorry for the delay... I'm just starting to seriously look at this.
> > 
> > On Wed, 2 Jun 2010, Catalin Marinas wrote:
> > 
> > > This patch removes the domain switching functionality via the set_fs and
> > > __switch_to functions on cores that have a TLS register.
> > [...]
> > > The user pages access rights are also modified for kernel read-only
> > > access rather than read/write so that the copy-on-write mechanism still
> > > works. CPU_USE_DOMAINS gets disabled only if HAS_TLS_REG is defined
> > > since writing the TLS value to the high vectors page isn't possible.
> > 
> > I don't like this limitation much.
> > 
> > Since the vector page has to be accessed somehow for FIQs anyway, and
> > the current solution for that involves accesses through the direct
> > mapping of the vector page, then this patch could be made to work on
> > pre-ARMv6 systems too simply by adding the necessary cache ops around
> > the TLS and FIQ updates.
> 
> Getting rid of domains in Linux requires that several functions no
> longer use LDRT/STRT but LDR/STR. This implies that RO user pages should
> also have RO permissions for the kernel. I don't have the old ARM ARM at
> hand now but I recall there were some issues with user RO kernel RO
> permission on pre-ARMv6 processors (there is an R bit in the CP15
> control register which may help, I need to check the documentation).

I just checked.  It says:

   The access permission bits in section and page descriptors control 
   access to the corresponding section or page. The access permissions 
   are modified by the System (S) and ROM (R) control bits in CP15 
   register 1.

But those bits are of no use as they are effective only when the MMU 
access permission bits are all 0, otherwise they're ignored.

What I mean, though, is for this patch to work as well on VIVT systems 
by using the domain switching _only_ when updating the TLS value or the 
FIQ handler in the vector page.  So it is simply:

 1) disable IRQs and FIQs

 2) switch domain to manager mode

 3) store data into the vector page

 4) switch the domain back

 5) restore IRQs and FIQs states

On VIPT systems you need only to access the vector page through its 
direct mapping in kernel memory without any domain switching.


Nicolas
