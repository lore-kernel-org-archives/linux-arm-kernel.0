From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 8 Dec 2015 16:08:22 +0000
Subject: ARM64: kernel oops in 4.4-rc4+
In-Reply-To: <20151208134951.GI19612@arm.com>
References: <CACVXFVPnmKzv-mnDyjOnoQtxZ4kyWLtkymK1XhDThO8ibi7f7w@mail.gmail.com>
 <20151208103013.GA19612@arm.com>
 <CACVXFVPgTPYzHj0E7cSx=X+=t=0Am_yBSk6FnTZHeG0hyY6ipg@mail.gmail.com>
 <20151208134951.GI19612@arm.com>
Message-ID: <20151208160821.GB26759@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 08, 2015 at 01:49:52PM +0000, Will Deacon wrote:
> On Tue, Dec 08, 2015 at 09:08:32PM +0800, Ming Lei wrote:
> > On Tue, Dec 8, 2015 at 6:30 PM, Will Deacon <will.deacon@arm.com> wrote:
> > > On Tue, Dec 08, 2015 at 02:30:33PM +0800, Ming Lei wrote:
> > >> The attached kernel oops can be triggered immediately after
> > >> running the following command on APM Mustang:
> > >>
> > >>         $stress-ng --all 8 -t 10m
> > >>
> > >> [1] kernel oops log
> > >> stress-ng: info:  [5220] 5 failures reached, aborting stress process
> > >> [  265.782659] kernel BUG at ./arch/arm64/include/asm/pgtable.h:282!
> > >
> > > Yikes, this means we're replacing a writable pte with a clean pte, so
> > > there's a potential race w/ hardware DBM.
> > >
> > > Could you dump pte and *ptep please?
> > 
> > They are dumped as so:
> > 
> > set_pte_at: addr 470000, ptep fffffe00bc870238, *ptep 680047348a0bd3,
> > pte 680047348a0fd3
> 
> Thanks for dumping these.
> 
> It looks like we're trying to set the access flag in the pte, so its
> got nothing to do with swp entries (although they may well be broken
> anyway with these BUG_ONs). With H/W DBM enabled, we shouldn't be doing
> software management of the access flag, so the BUG_ON looks like a red
> herring in this case.

Setting the access flag is fine, clearing it is a potential problem (the
first BUG_ON). If the line numbers match mainline, 282 means the second
BUG_ON in set_pte_at(). The ptep_set_access_flags() is meant to update
the access or dirty flags without corrupting the state. I think the
scenario is:

1. *ptep is writable and clean and old (PTE_WRITE && PTE_RDONLY && !PTE_AF)
2. ptep_set_access_flags() tries to set PTE_AF while keeping the rest
   unchanged
3. BUG_ON triggers because a writable PTE is overridden with a writeable
   && clean PTE, potentially overriding a hardware-updated dirty entry

Point 3 could easily cause us problems if you mix DBM and non-DBM agents
in the same system.

Another scenario when all agents can do DBM is for two CPUs to take a
read fault on a non-present PTE. The first CPU that takes the mm
semaphore updates the PTE from non-present to valid && writable && clean
&& young. The second CPU comes in and finds the PTE present in
handle_pte_fault() and goes on to do a ptep_set_access_flags(). At this
point we have a race with any other agent updating the dirty status.

I think the BUG_ON check is still useful, we just need at atomic
implementation of ptep_set_access_flags(). I'll post something and take
it from there (I need to think some more about how this would interact
with the set_pte_at() checks for the dirty bit).

BTW, I don't think the check for pte_valid(pte) is needed in
set_pte_at() as we should never go from valid pte to file without
break-before-make. With proper b-b-m, pte_valid(*ptep) is false, so no
BUG_ON checks.

-- 
Catalin
