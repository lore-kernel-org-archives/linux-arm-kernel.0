From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 18 May 2017 00:02:36 +0100
Subject: crash after receiving SIGCHLD during system call
In-Reply-To: <CALnQHM0tUDkjbX+oBW5pEeuBWUoX2eOmA9Qrc9V2-RsnDV3d6Q@mail.gmail.com>
References: <CALnQHM3wjH1CWwUUJX7KhGOOhoW-0r22nyBWmBUJYCUFe-JEtw@mail.gmail.com>
 <20170517170940.GJ22219@n2100.armlinux.org.uk>
 <CALnQHM0tUDkjbX+oBW5pEeuBWUoX2eOmA9Qrc9V2-RsnDV3d6Q@mail.gmail.com>
Message-ID: <20170517230236.GK22219@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 17, 2017 at 04:28:44PM -0600, David Mosberger wrote:
> OK, since I see various faults, including SIGILL, I used
> user_debug=63.  Here is one example:
> 
> 2017-05-17 22:12:20: (log.c.217) server started
> [  129.810000] pgd = cf0b4000
> [  129.810000] [00000073] *pgd=2f903831, *pte=00000000, *ppte=00000000
> [  129.820000] CPU: 0 PID: 701 Comm: lighttpd Not tainted 4.9.28+ #58
> [  129.820000] Hardware name: Atmel SAMA5
> [  129.830000] task: cecfcd80 task.stack: cf102000
> [  129.830000] PC is at 0x18af4 <-- points to "movle r6, r3" instruction
> [  129.830000] LR is at 0xb6c04510
> [  129.840000] pc : [<00018af4>]    lr : [<b6c04510>]    psr: 00070030
> [  129.840000] sp : bee098ec  ip : ffffffff  fp : 01ee4740
> [  129.850000] r10: 00000008  r9 : 00000000  r8 : b6d12c40
> [  129.850000] r7 : 00034684  r6 : 00000062  r5 : ffffffff  r4 : 00000000
> [  129.860000] r3 : ff000000  r2 : bee09978  r1 : bee098f8  r0 : 00000073
> [  129.870000] Flags: nzcv  IRQs on  FIQs on  Mode USER_32  ISA Thumb
> Segment user
...
> Program received signal SIGSEGV, Segmentation fault.
> 
> I'm not very good at reading ARM tombstones but if I read this right,
> the kernel got a page fault due to a data access but a "movle r6, r3"
> instruction doesn't access data memory.  Are we dealing with a
> instruction cache issue?
> 
> And it says we're in "Thumb" mode?  That shouldn't be the case.

That does appear to be the case - the PSR value confirms it.

The segfault is at address 0x73, and an ARM "movle r6, r3" instruction
assembles to 0xd1a06003, which would correspond with Thumb:

   0:   d1a0            bne.n   ffffff44 <.text+0xffffff44>
   2:   6003            str     r3, [r0, #0]

Since r0 is 0x00000073, this ties up.

So, the problem seems to be the T bit in the PSR is somehow getting
set.

The kernel signal handling merely saves the PSR value it got on entry
(in the pt_regs structure) onto the userspace stack as part of the
mcontext (see setup_sigframe in arch/arm/kernel/signal.c).  I think
you've confirmed that the saved information looks correct.

The question then becomes what happens after the signal handler
returns.  If there is no sigreturn or rt_sigreturn syscall, then the
return is being done entirely by userspace, which means userspace is
responsible for unstacking the mcontext, including switching to the
correct ISA.

If there is a sigreturn syscall, the kernel will unstack the mcontext,
(see sys_*sigreturn in arch/arm/kernel/signal.c) replacing the syscall's
pt_regs with the saved mcontext registers.  The resulting state is
validated (to prevent userspace gaining privileged modes) before
returning.  So the T bit should be restored, unless something in
userspace decided to set it.

The validation will fix up the CPSR state if it looks bad (as a belt
and braces) before returning zero to indicate illegal state, which
will result in a forced SIGSEGV being delivered to the program.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
