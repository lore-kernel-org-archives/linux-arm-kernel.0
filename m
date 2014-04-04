From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 4 Apr 2014 16:42:23 +0100
Subject: [PATCH 5/5] arm: Enable IRQs before attempting to read user
 space in __und_usr
In-Reply-To: <CAKZGPAOLeg1vP+4eHHAkbz0M6th8dhscUaNHUiqHFdK2_-Qhyg@mail.gmail.com>
References: <1394734552-4704-1-git-send-email-catalin.marinas@arm.com>
 <1394734552-4704-6-git-send-email-catalin.marinas@arm.com>
 <CAKZGPAP=9wvUd-oSEYKwBz6LKX6vXcRuiRVUpg2k47ui-=YgQw@mail.gmail.com>
 <20140401144815.GA7528@n2100.arm.linux.org.uk>
 <CAKZGPAOLeg1vP+4eHHAkbz0M6th8dhscUaNHUiqHFdK2_-Qhyg@mail.gmail.com>
Message-ID: <20140404154223.GH23488@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arun,

On Fri, Apr 04, 2014 at 12:29:04PM +0100, Arun KS wrote:
> On Tue, Apr 1, 2014 at 8:18 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Tue, Apr 01, 2014 at 05:54:15PM +0530, Arun KS wrote:
> >> As the data abort is now handled in normal way, can we remove the
> >> fixup handler for ldrt?
> >
> > No, because all instructions which access userspace, and therefore may
> > fault, must be given a fixup handler so the kernel knows what to do
> > should it not be able to supply the page.
> >
> > Omitting that marking means the only other option in that case is for
> > the kernel to oops.
> 
> I have a concern regarding the fixup handler.
> Fixup handler returns to the next instruction which has caused the
> undef execption, rather than going to the same instruction.
> 
> ARM ARM says that after undefined exception, the pc will be pointing
> to the next instruction.
> ie +4 offset in case of ARM and +2 in case of Thumb.
> 
> And there is no correction offset passed to vector_stub in case of
> undef exception.
> 
> File: arch/arm/kernel/entry-armv.S +1085
> vector_stub     und, UND_MODE
> 
> During an undefined exception, in normal scenario(ie when ldrt
> instruction does not cause an abort) after resorting the context in
> VFP hardware, the PC is modified as show below before jumping to
> ret_from_exception which is in r9.
> 
> File: arch/arm/vfp/vfphw.S +169
> @ The context stored in the VFP hardware is up to date with this thread
> vfp_hw_state_valid:
>         tst     r1, #FPEXC_EX
>         bne     process_exception       @ might as well handle the pending
>                                         @ exception before retrying branch
>                                         @ out before setting an FPEXC that
>                                         @ stops us reading stuff
>         VFPFMXR FPEXC, r1               @ Restore FPEXC last
>         sub     r2, r2, #4              @ Retry current instruction - if Thumb
>         str     r2, [sp, #S_PC]         @ mode it's two 16-bit instructions,
>                                         @ else it's one 32-bit instruction, so
>                                         @ always subtract 4 from the following
>                                         @ instruction address.
> 
> But if ldrt results in an abort, we reach the fixup handler and return
> to ret_from_execption without correcting the pc.

If ldrt results in an abort, with my patches for enabling the IRQ we
should not execute the fixup handler. The in-kernel page fault would
handled and the ldrt instruction re-executed.

I think we could still get to the fixup handler if one thread is
triggering the undef while another thread (different CPU) is munmap'ing
the page (very unlikely case though). The fault caused by ldrt in
__und_usr wouldn't be fully handled, falling back to the fixup.

> From d72e15d92c1016ce3b1c7c7da01ca60cf21340d5 Mon Sep 17 00:00:00 2001
> From: Arun KS <getarunks@gmail.com>
> Date: Fri, 4 Apr 2014 16:42:58 +0530
> Subject: Modify fixup handler to re-execute the original instruction
> 
> Signed-off-by: Danesh Petigara <dpetigara@broadcom.com>
> Signed-off-by: Vinayak Menon <vinayakm.list@gmail.com>

Some more text here is useful, like what you explained above, just add
it to the commit log.

> ---
>  arch/arm/kernel/entry-armv.S |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
> index 1879e8d..e801c7d 100644
> --- a/arch/arm/kernel/entry-armv.S
> +++ b/arch/arm/kernel/entry-armv.S
> @@ -484,7 +484,8 @@ ENDPROC(__und_usr)
>   */
>         .pushsection .fixup, "ax"
>         .align  2
> -4:     mov     pc, r9
> +4:     str     r4, [sp, #S_PC]
> +       mov     pc, r9
>         .popsection
>         .pushsection __ex_table,"a"
>         .long   1b, 4b

I think this patch should cover the above case and a subsequent
re-execution of the address in user space would trigger the prefetch
abort.

On its own, I think the above patch would also work without my other
patches. But the effect is that on ldrt fault we re-execute the user
instruction hoping that it will trigger the prefetch abort, fix it up in
the kernel and return to that instruction again. It may be worth as
cc: stable (assuming that anyone tests it properly).

Otherwise:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
