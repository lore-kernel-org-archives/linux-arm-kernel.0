From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Fri, 17 Feb 2017 07:53:05 -0800
Subject: [PATCH v2] arm64: print a fault message when attempting to write
 RO memory
In-Reply-To: <58A6D7D7.1030704@arm.com>
References: <20170217011959.26754-1-stephen.boyd@linaro.org>
 <58A6D7D7.1030704@arm.com>
Message-ID: <148734678579.30076.8827985106565313944@sboyd-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting James Morse (2017-02-17 03:00:39)
> On 17/02/17 01:19, Stephen Boyd wrote:
> > diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> > index 156169c6981b..8bd4e7f11c70 100644
> > --- a/arch/arm64/mm/fault.c
> > +++ b/arch/arm64/mm/fault.c
> 
> >  /*
> >   * The kernel tried to access some page that wasn't present.
> >   */
> >  static void __do_kernel_fault(struct mm_struct *mm, unsigned long addr,
> >                             unsigned int esr, struct pt_regs *regs)
> >  {
> > +     const char *msg;
> >       /*
> >        * Are we prepared to handle this kernel fault?
> >        * We are almost certainly not prepared to handle instruction faults.
> > @@ -177,9 +193,19 @@ static void __do_kernel_fault(struct mm_struct *mm, unsigned long addr,
> >        * No handler, we'll have to terminate things with extreme prejudice.
> >        */
> >       bust_spinlocks(1);
> > -     pr_alert("Unable to handle kernel %s at virtual address %08lx\n",
> > -              (addr < PAGE_SIZE) ? "NULL pointer dereference" :
> > -              "paging request", addr);
> > +
> > +     if (is_permission_fault(esr, regs)) {
> 
> is_permission_fault() was previously guarded with a 'addr<USER_DS' check, this
> is because it assumes software-PAN is relevant.
> 
> The corner case is when the kernel accesses TTBR1-mapped memory while
> software-PAN happens to have swivelled TTBR0. Translation faults will be matched
> by is_permission_fault(), but permission faults won't.

If I understand correctly, and I most definitely don't because there are
quite a few combinations, you're saying that __do_kernel_fault() could
be called if the kernel attempts to access some userspace address with
software PAN? That won't be caught in do_page_fault() with the previous
is_permission_fault() check?

> 
> Juggling is_permission_fault() to look something like:
> ---%<---
>         if (fsc_type == ESR_ELx_FSC_PERM)
>                 return true;
> 
>         if (addr < USER_DS && system_uses_ttbr0_pan())
>                 return fsc_type == ESR_ELx_FSC_FAULT &&
>                         (regs->pstate & PSR_PAN_BIT);
> 
>         return false;
> ---%<---
> ... should fix this.

But we don't need to check ec anymore?

	if (ec != ESR_ELx_EC_DABT_CUR && ec != ESR_ELx_EC_IABT_CUR)
		return false;

> 
> 
> > +             if (esr & ESR_ELx_WNR)
> > +                     msg = "write to read-only memory";
> > +             else
> > +                     msg = "read from unreadable memory";
> > +     } else if (addr < PAGE_SIZE)
> > +             msg = "NULL pointer dereference";
> > +     else
> > +             msg = "paging request";
> 
> Nit: {} all the way down!

Ok.
