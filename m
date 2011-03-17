From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 17 Mar 2011 13:57:25 -0400 (EDT)
Subject: [PATCH v2] arm: cmpxchg syscall should data abort if page not
	write
In-Reply-To: <AANLkTik1oEkLX3R-adK9-_2W+ku4j9YDikr+Z4vzfGtb@mail.gmail.com>
References: <1300098516-1601-1-git-send-email-ratbert.chuang@gmail.com>
	<1300169637-1628-1-git-send-email-ratbert.chuang@gmail.com>
	<alpine.LFD.2.00.1103171301030.26889@xanadu.home>
	<AANLkTik1oEkLX3R-adK9-_2W+ku4j9YDikr+Z4vzfGtb@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1103171344270.26889@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 17 Mar 2011, Ashwin Chaugule wrote:

> On Thu, Mar 17, 2011 at 1:01 PM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> > On Tue, 15 Mar 2011, Po-Yu Chuang wrote:
> >
> >> From: Po-Yu Chuang <ratbert@faraday-tech.com>
> >>
> >> If the page to cmpxchg is user mode read only (not write),
> >> we should simulate a data abort first.
> >>
> >> Signed-off-by: Po-Yu Chuang <ratbert@faraday-tech.com>
> >
> > Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> >
> >> ---
> >> v2:
> >> remove !pte_young() check
> >>
> >> ?arch/arm/kernel/traps.c | ? ?2 +-
> >> ?1 files changed, 1 insertions(+), 1 deletions(-)
> >>
> >> diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
> >> index 446aee9..eac7c05 100644
> >> --- a/arch/arm/kernel/traps.c
> >> +++ b/arch/arm/kernel/traps.c
> >> @@ -563,7 +563,7 @@ asmlinkage int arm_syscall(int no, struct pt_regs *regs)
> >> ? ? ? ? ? ? ? if (!pmd_present(*pmd))
> >> ? ? ? ? ? ? ? ? ? ? ? goto bad_access;
> >> ? ? ? ? ? ? ? pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
> >> - ? ? ? ? ? ? if (!pte_present(*pte) || !pte_dirty(*pte)) {
> >> + ? ? ? ? ? ? if (!pte_present(*pte) || !pte_write(*pte) || !pte_dirty(*pte)) {
> >> ? ? ? ? ? ? ? ? ? ? ? pte_unmap_unlock(pte, ptl);
> >> ? ? ? ? ? ? ? ? ? ? ? goto bad_access;
> >> ? ? ? ? ? ? ? }
> >> --
> >> 1.6.3.3
> >>
> 
> 
> Just beginning to understand the subtleties involved, so please
> correct me if I'm wrong.
> Wont this patch also fix the problem that was brought up with futexes
> on ARM SMP ?

Nope.  The code being fixed here was suptly broken so it needs fixing.  
However this code is almost never used, if at all, as it is a fall-back 
solution for when all the better alternatives are not available for some 
reasons (and I'm still wondering what those reasons are for Po-Yu Chuang 
to actually use that code).  In practice this bug should have affected 
no one.

If you have SMP then this code is definitively not what you should be 
using.


Nicolas
