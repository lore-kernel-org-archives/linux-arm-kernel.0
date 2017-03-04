From: stern@rowland.harvard.edu (Alan Stern)
Date: Sat, 4 Mar 2017 10:51:19 -0500 (EST)
Subject: Panic in quirk_usb_early_handoff
In-Reply-To: <CAKv+Gu_M6aMMfeCy7ZUM46Ptei1suvX+F_KtWG2_QFp_6jbCWw@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1703041049340.6026-100000@netrider.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 4 Mar 2017, Ard Biesheuvel wrote:

> On 4 March 2017 at 00:24, Mason <slash.tmp@free.fr> wrote:
> > On 03/03/2017 20:02, Robin Murphy wrote:
> >
> >> On 03/03/17 17:15, Mason wrote:
> >>
> >>> [    1.261813] Unable to handle kernel paging request at virtual address d08611e4
> >>> [    1.269167] pgd = c0004000
> >>> [    1.271979] [d08611e4] *pgd=8f804811, *pte=00000000, *ppte=00000000
> >>> [    1.278394] Internal error: Oops: 7 [#1] PREEMPT SMP ARM
> >>> [    1.283815] Modules linked in:
> >>> [    1.286970] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.9.7-1-rc2 #157
> >>> [    1.293614] Hardware name: Sigma Tango DT
> >>> [    1.297726] task: cf82c9c0 task.stack: cf838000
> >>> [    1.302364] PC is at quirk_usb_early_handoff+0x3e8/0x790
> >>> [    1.307790] LR is at ioremap_page_range+0xf8/0x1a8
> >>> [    1.312688] pc : [<c039fe44>]    lr : [<c02d0a10>]    psr: 000e0013
> >>> [    1.312688] sp : cf839d78  ip : 00000000  fp : cf839e38
> >>> [    1.324399] r10: c10248a0  r9 : 00000000  r8 : d08611e4
> >>> [    1.329733] r7 : d084e000  r6 : 00002000  r5 : 000c0300  r4 : cfb4e800
> >>> [    1.336377] r3 : 000131e4  r2 : 00000000  r1 : 91001e13  r0 : d084e000
> >>
> >> ...and again. And always at the same PC, too.
> >
> > By the way, isn't LR supposed to point to the caller of the
> > current function? ("LR is at ioremap_page_range")
> >
> > If so, why does it not appear in the back trace?
> >
> 
> lr is supposed to point to the return address at function entry. After
> that, all bets are off, really, since ARM usually pops the return
> address from the stack straight into the pc register. So in this case,
> it looks like it still contains the address that the most recent leaf
> function returned to (or another function that actually restores the
> return address into lr before branching to it). But it could easily
> contain garbage as well.

Besides, the compiler often inlines static subroutines that are called
from only one place.  As a result there is no hardware stack frame for 
these subroutine calls, and they don't show up in the back trace.

Alan Stern
