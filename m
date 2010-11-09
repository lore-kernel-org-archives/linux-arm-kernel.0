From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 9 Nov 2010 10:38:36 +0000
Subject: [PATCH 1/2] Fix the I-cache invalidation on ARMv6 and later CPUs
In-Reply-To: <AANLkTikhi3znQs32Qc=ACuH0Kz-WV0xmD-4-JjQv8OqZ@mail.gmail.com>
References: <20080606114622.15520.49929.stgit@pc1117.cambridge.arm.com>
	<AANLkTik0_0Eb8G5hEb+DGvE2BDM_mJwwF-Pt1ErTz=Lr@mail.gmail.com>
	<AANLkTim3O9HaOZp7VD3s1+FRU0KmPUrDei9NFDoXWK3y@mail.gmail.com>
	<1289297870.11461.7.camel@e102109-lin.cambridge.arm.com>
	<AANLkTikhi3znQs32Qc=ACuH0Kz-WV0xmD-4-JjQv8OqZ@mail.gmail.com>
Message-ID: <20101109103836.GC2869@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 09, 2010 at 07:34:45PM +0900, Minchan Kim wrote:
> On Tue, Nov 9, 2010 at 7:17 PM, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > Note that these functions are changed slightly in 2.6.37-rc1, but we
> > still do the I-cache flushing.
> >
> > There reason is that the page being modified may already be mapped in
> > user space and may be a code page as well. The kernel may call this
> 
> Yes. That's my point. We can't know code or not in that context(ie,
> flush_dcache_page).

And because we don't know, we have to assume that the page does contain
code, so we have to flush the I cache.

> In 2.6.37-rc1, we flushes icache without VM_EXEC check in set_pte_at
> which doesn't have VMA, either.
> Could we move the icache flush to update_mmu_cache again?

No.  We moved it to fix a race on SMP - between the PTE being established
and the caches being coherent.  Moving it later reintroduces that race
again.
