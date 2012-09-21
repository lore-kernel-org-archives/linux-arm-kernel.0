From: will.deacon@arm.com (Will Deacon)
Date: Fri, 21 Sep 2012 10:32:57 +0100
Subject: [PATCH 0/4] Fix PROT_NONE page permissions when	!CPU_USE_DOMAINS
In-Reply-To: <20120920221215.GA1837@n2100.arm.linux.org.uk>
References: <1348156605-30398-1-git-send-email-will.deacon@arm.com>
 <20120920221215.GA1837@n2100.arm.linux.org.uk>
Message-ID: <20120921093257.GC24613@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 20, 2012 at 11:12:15PM +0100, Russell King - ARM Linux wrote:
> On Thu, Sep 20, 2012 at 04:56:41PM +0100, Will Deacon wrote:
> > Hello,
> > 
> > After laughing at Ben H during LPC when it emerged that the PPC PROT_NONE
> > protection bits don't prevent kernel access to the protected pages, I
> > looked at the ARM code and, to my dismay, found that we have the same
> > problem when not using domains.
> > 
> > This patch series addresses the issue with the following points worth
> > noting:
> > 
> > 	- We use the last available software bit (11) for 2-level PTEs.
> > 	  Whilst this is somewhat of a pity, I can't think of a better
> > 	  reason to allocate it than to fix an outstanding bug.
> 
> But you don't - you've defined it to be bit 0, which is the same as the
> present bit, and clearing the present bit is not a good idea as it turns
> the entry into something like a swap entry.

Sorry, my patches may have been in a slightly confusing order. L_PTE_VALID
is a red herring, required simply to allow present, faulting entries. The
new software bit is L_PTE_NONE (I can rename this to L_PTE_KERNEL if you
prefer) and is introduced in patch 4/4.

> So, let's go back and restart the analysis (and document it).  What
> happens is we call pte_modify() on each present page, setting the new
> protection - __PAGE_NONE.

Thanks for this in-depth analysis, you've hit the problem on the head and
it's good to have that archived.

> On ARMv6+ without domains, only one of these changes:
> 
> L_PTE_RDONLY	L_PTE_USER	AP
> 1		0		101	(user n/a, system r/o)
> 0		0		001	(user n/a, system r/w)
> 1		1		111	(user r/o, system r/o)
> 0		1		011	(user r/w, system r/w)
> 
> However, now we perform user accesses using kernel-mode loads/stores,
> so the access permissions which are checked are the 'system'
> permissions, and as we can see from the above, when there is no state
> when the kernel is denied access to the page.
> 
> Why not make system access permissions reflect user access permissions?
> Well, that's easy to answer - you want your kernel data and code to be
> protected against reading/writing by userspace... so we need a
> combination of permissions to permit those encodings - and not
> surprisingly, clearing the L_PTE_USER bit gives us that.
> 
> What wasn't thought about properly was the effect of removing domains
> and converting the kernel-initiated userspace accesses to use kernel-mode
> accesses.  Yes, the obvious was changed (so that user r/o also became
> kernel r/o) but that's not enough.

Agreed.

> The only solution I can see is to have L_PTE_KERNEL which indicates
> whether this is a kernel mapping.  If both L_PTE_KERNEL and L_PTE_USER
> are clear, then we zero out the hardware PTE entry - and that would be
> the case for a userspace PROT_NONE entry.  Otherwise, we fall back to
> our current behaviour.
> 
> So, essentially we change from ignoring the PTE value when
> 
> 	(val & (PRESENT | YOUNG)) != (PRESENT | YOUNG))
> 
> to:
> 
> 	(val & (PRESENT | YOUNG | USER)) != (PRESENT | YOUNG | USER)) &&
> 	(val & (PRESENT | YOUNG | KERNEL)) != (PRESENT | YOUNG | KERNEL))

This is basically what I've done in the final patch, just with a different
name for the bit. The reason I added the VALID stuff before is because
the software bits overlap the hardware bits for LPAE, so you can't just
write #0 to the pte if you want it be treated as present. Instead, I make
use of L_PTE_PRESENT being 2 bits wide and just clear the bottom bit (which
causes the hardware to fault on access). For 2 levels, L_PTE_VALID ==
L_PTE_PRESENT so everything is as before.

You *could* do this slightly differently and check for L_PTE_NONE in
pte_present, but this doesn't help us for section mappings in userspace,
which I have working with hugetlb (I'll post this soon).

> That'll make the set_pte assembly more horrid, but I guess that's the
> price you pay for removing useful features which architecture folk don't
> like from CPUs... and it gets more horrid because you can't encode some
> of those bit patterns with the standard 8-bit and shift opcode
> representation.

It's not too bad. PROT_NONE pages are pretty rare, so you can just add the
check after the YOUNG and PRESENT checks with the appropriate condition
flags.

Cheers,

Will
