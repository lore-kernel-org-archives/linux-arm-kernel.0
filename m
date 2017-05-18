From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 18 May 2017 17:11:34 +0100
Subject: crash after receiving SIGCHLD during system call
In-Reply-To: <CALnQHM23aTPcmWy0p6=ffdZUX1jb7H-mKmZJ6L7GyvXWikhPAg@mail.gmail.com>
References: <CALnQHM3wjH1CWwUUJX7KhGOOhoW-0r22nyBWmBUJYCUFe-JEtw@mail.gmail.com>
 <20170517170940.GJ22219@n2100.armlinux.org.uk>
 <CALnQHM0tUDkjbX+oBW5pEeuBWUoX2eOmA9Qrc9V2-RsnDV3d6Q@mail.gmail.com>
 <20170517230236.GK22219@n2100.armlinux.org.uk>
 <CALnQHM2ocw5ETbwsRF_c43tweHruunOjsfaBOT5Qxgt2K6Ww1g@mail.gmail.com>
 <CALnQHM1WpXmvkK8eCqd8G=6Ny-O=PD=nSaa1kwQBAB6dNwa1Hg@mail.gmail.com>
 <CALnQHM23aTPcmWy0p6=ffdZUX1jb7H-mKmZJ6L7GyvXWikhPAg@mail.gmail.com>
Message-ID: <20170518161134.GO22219@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 18, 2017 at 09:28:00AM -0600, David Mosberger wrote:
> On Wed, May 17, 2017 at 11:34 PM, David Mosberger <davidm@egauge.net> wrote:
> 
> > I also confirmed that at the end of sys_rt_sigreturn(), the T bit in
> > regs->ARM_cpsr is NEVER set.
> 
> Similarly, regs->ARM_lr does not have bit 0 set (expect when it's
> obviously used as a scratch registers, with values of 0x1 or 0x10d).

Yea, that'll possibly matter for when the function returns, rather than
the execution of the function itself.

> To me, it looks like bit 0 of a return address gets corrupted
> (possibly a register state corruption or an on-stack corruption).
> That would in turn cause the "bx rl" instruction to turn on Thumb mode
> and things go south from there.  It's interesting that only one bit
> get corrupted since the address overall looks plausible.

The bit 0 value of the mcontext PC shouldn't matter, as we're restoring
the full system state including the PSR value, rather than performing
a normal function return.  The return sequence is:

	mov     r2, sp				@ save current svc stack pointer
	ldr     r1, [r2, #\offset + S_PSR]	@ get calling cpsr
	ldr     lr, [r2, #\offset + S_PC]!	@ get pc
	msr     spsr_cxsf, r1			@ save in spsr_svc
	ldmdb   r2, {r0 - lr}^			@ get calling r0 - lr
	add     sp, sp, #\offset + PT_REGS_SIZE	@ balance svc stack
	movs    pc, lr                          @ return & move spsr_svc into cpsr

The only possible issue there is that ARMv7 deprecates "movs pc, lr"
preferring "subs pc, lr, #0" instead.  May be worth seeing whether
that makes any difference:

 arch/arm/kernel/entry-header.S   | 4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
index 6391728c8f03..9ee5825b4507 100644
--- a/arch/arm/kernel/entry-header.S
+++ b/arch/arm/kernel/entry-header.S
@@ -312,7 +312,7 @@
 	mov	r0, r0				@ ARMv5T and earlier require a nop
 						@ after ldm {}^
 	add	sp, sp, #\offset + PT_REGS_SIZE
-	movs	pc, lr				@ return & move spsr_svc into cpsr
+	subs	pc, lr, #0			@ return & move spsr_svc into cpsr
 #elif defined(CONFIG_CPU_V7M)
 	@ V7M restore.
 	@ Note that we don't need to do clrex here as clearing the local
@@ -339,7 +339,7 @@
 	ldmdb	sp, {r0 - r12}			@ get calling r0 - r12
 	.endif
 	add	sp, sp, #PT_REGS_SIZE - S_SP
-	movs	pc, lr				@ return & move spsr_svc into cpsr
+	subs	pc, lr, #0			@ return & move spsr_svc into cpsr
 #endif	/* !CONFIG_THUMB2_KERNEL */
 	.endm
 


-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
