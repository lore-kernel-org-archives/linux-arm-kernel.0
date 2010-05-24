From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 24 May 2010 13:08:31 +0100
Subject: [PATCH 0/4] Patches for -next
In-Reply-To: <1274700664.4720.7.camel@e102109-lin.cambridge.arm.com>
References: <20100520142715.22202.33516.stgit@e102109-lin.cambridge.arm.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C5667016@dbde02.ent.ti.com>
	<1274435541.11965.18.camel@e102109-lin.cambridge.arm.com>
	<20100521190456.GB11042@n2100.arm.linux.org.uk>
	<1274700664.4720.7.camel@e102109-lin.cambridge.arm.com>
Message-ID: <20100524120831.GC21117@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 24, 2010 at 12:31:04PM +0100, Catalin Marinas wrote:
> On Fri, 2010-05-21 at 20:04 +0100, Russell King - ARM Linux wrote:
> > On Fri, May 21, 2010 at 10:52:21AM +0100, Catalin Marinas wrote:
> > > +     if (cache_is_vivt())
> > > +             make_coherent(mapping, vma, addr, ptep, pfn);
> > > +     else if (vma->vm_flags & VM_EXEC) {
> > > +             __flush_icache_all();
> > > +#ifdef CONFIG_SMP
> > > +             set_pte_ext(ptep, __pte(pte_val(*ptep) | L_PTE_EXEC),
> > > +                         addr >= TASK_SIZE ? 0 : PTE_EXT_NG);
> > 
> > You don't need this test - pages which have VMAs are userspace pages,
> > and therefore the address is always < TASK_SIZE.  Therefore, they're
> > always non-global:
> > 
> >                 set_pte_ext(ptep, __pte(pte_val(*ptep) | L_PTE_EXEC),
> >                             PTE_EXT_NG);
> 
> Good point. Thanks.
> 
> So, are you ok for me to push these patches to -next?

I don't think these patches are quite ready for -next just yet.  Apart
from my comment on patch 1, I think patch 4 is buggy in three other
ways:

1. VIVT cached CPUs end up with L_PTE_EXEC clear on their mappings
   with this patch.  Luckily for us, nothing tests for this (there
   used to be a pte_exec() helper for testing this, but I removed it
   as there were no users in the kernel) - but even so, I think it
   should be documented that this is the case.

2. L_PTE_EXEC is also forced-clear on non-page cache pages by this
   patch, even if executable permission was requested.  I'm guessing
   this will be bad for tasks which generate code on the fly.

3. Kernel mappings are also created with set_pte_at(), and so module
   mappings will have L_PTE_EXEC cleared, resulting in kernel modules
   being non-executable - which is rather bad.

Not sure what the right fix for this is at the moment - and if we're
going to make set_pte_at() more complicated, it should be moved out
of line.
