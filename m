From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Thu, 16 Feb 2017 11:06:20 -0800
Subject: [PATCH] arm64: print a fault message when attempting to write RO
 memory
In-Reply-To: <20170216110612.GA32039@leverpostej>
References: <20170216015408.12933-1-stephen.boyd@linaro.org>
 <20170216110612.GA32039@leverpostej>
Message-ID: <148727198031.14561.5684949806976862329@sboyd-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Mark Rutland (2017-02-16 03:06:12)
> Hi,
> 
> On Wed, Feb 15, 2017 at 05:54:08PM -0800, Stephen Boyd wrote:
> > If a page is marked read only we should print out that fact,
> > instead of printing out that there was a page fault. Right now we
> > get a cryptic error message that something went wrong with an
> > unhandled fault, but we don't evaluate the esr to figure out that
> > it was a read/write permission fault.
> >
> > Instead of seeing:
> >
> >   Unable to handle kernel paging request at virtual address ffff000008e460d8
> >   pgd = ffff800003504000
> >   [ffff000008e460d8] *pgd=0000000083473003, *pud=0000000083503003, *pmd=0000000000000000
> >   Internal error: Oops: 9600004f [#1] PREEMPT SMP
> >
> > we'll see:
> >
> >   Internal error: Attempting to write read-only memory: 9600004f [#1] PREEMPT SMP
> 
> It's less than ideal to lose the fault address here. Arguably we should
> also log that for the userspace cases.

Agreed. I can look into fixing the userspace case too with another
patch.

> 
> It would also be nice to keep the table dump for the kernel fault case,
> since dodgy page tables are a likely case there.

Ok.

> 
> > @@ -331,6 +331,11 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
> >
> >               if (!search_exception_tables(regs->pc))
> >                       die("Accessing user space memory outside uaccess.h routines", regs, esr);
> > +     } else if (is_permission_fault(esr, regs)) {
> > +             if (esr & ESR_ELx_WNR)
> > +                     die("Attempting to write read-only memory", regs, esr);
> > +             else
> > +                     die("Attempting to read unreadable memory", regs, esr);
> >       }
> 
> We won't have looked at the exception tables yet, so won't this make
> probe_kernel_{read,write}(), or any other extable users unsafe?
> 
> Could we update __do_kernel_fault() to report faults more thoroughly
> instead?
> 

Sounds like a plan. I'll move this hunk there and rework the message
printed there a bit.
