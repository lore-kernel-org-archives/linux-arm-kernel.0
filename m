From: will.deacon@arm.com (Will Deacon)
Date: Fri, 9 Oct 2015 11:53:09 +0100
Subject: [PATCH v2 10/10] ARM: software-based priviledged-no-access support
In-Reply-To: <CACRpkdZhJfsH0wU0VBotT=yomDqBkKWrz3MNFOin=CCz62v_nw@mail.gmail.com>
References: <20150825154026.GT7557@n2100.arm.linux.org.uk>
 <E1ZUGMS-0000BG-8B@rmk-PC.arm.linux.org.uk>
 <CACRpkdZhJfsH0wU0VBotT=yomDqBkKWrz3MNFOin=CCz62v_nw@mail.gmail.com>
Message-ID: <20151009105309.GM26278@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 09, 2015 at 10:28:14AM +0200, Linus Walleij wrote:
> On Tue, Aug 25, 2015 at 5:42 PM, Russell King
> <rmk+kernel@arm.linux.org.uk> wrote:
> 
> > Provide a software-based implementation of the priviledged no access
> > support found in ARMv8.1.
> >
> > Userspace pages are mapped using a different domain number from the
> > kernel and IO mappings.  If we switch the user domain to "no access"
> > when we enter the kernel, we can prevent the kernel from touching
> > userspace.
> >
> > However, the kernel needs to be able to access userspace via the
> > various user accessor functions.  With the wrapping in the previous
> > patch, we can temporarily enable access when the kernel needs user
> > access, and re-disable it afterwards.
> >
> > This allows us to trap non-intended accesses to userspace, eg, caused
> > by an inadvertent dereference of the LIST_POISON* values, which, with
> > appropriate user mappings setup, can be made to succeed.  This in turn
> > can allow use-after-free bugs to be further exploited than would
> > otherwise be possible.
> >
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> For some reason this patch explodes on my ARM PB11MPCore, it
> is a weird beast and corner case machine so I guess that is why
> it wasn't noticed. This happens a bit into the boot when freeing
> unused pages:
> 
> Freeing unused kernel memory: 2672K (c0448000 - c06e4000)
> Unable to handle kernel paging request at virtual address b6f069f4
> pgd = c6e58000
> [b6f069f4] *pgd=76e09831, *pte=77ff759f, *ppte=77ff7e6e
> Internal error: Oops: 17 [#1] SMP ARM
> Modules linked in:
> CPU: 2 PID: 1 Comm: init Not tainted 4.3.0-rc4-00015-gf6702681a0af #48
> Hardware name: ARM-RealView PB11MPCore
> task: c7827bc0 ti: c782c000 task.ti: c782c000
> PC is at v6wbi_flush_user_tlb_range+0x28/0x48
> LR is at on_each_cpu_mask+0x58/0x60
> pc : [<c001abf0>]    lr : [<c007c18c>]    psr: 20000093
> sp : c782deb8  ip : 00000000  fp : 00000000
> r10: c6e5adc8  r9 : 00000001  r8 : b6f02000
> r7 : c7a17180  r6 : c782ded4  r5 : c0015118  r4 : 20000013
> r3 : 00000002  r2 : 00100075  r1 : b6f02000  r0 : b6f01002
> Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
> Control: 00c5787d  Table: 76e5800a  DAC: 00000051

It looks like we're faulting on the TLBI instruction, because it's
targetting a userspace address (r0 == 0xb6f01002) and the DAC prohibits
access to userspace. It's weird that this only seems to happen on 11MPCore
though; if this core was one of the guys getting cross-called, then I
could understand the bug, but the lr suggests that CPU 2 is initiating
the flush, so I'd expect the same problem to appear on any ARMv6 part.

Russell, have you tried the s/w PAN stuff on any v6 CPUs?

Will
