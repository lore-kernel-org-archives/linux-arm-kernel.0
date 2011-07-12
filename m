From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 12 Jul 2011 20:03:54 +0800
Subject: [GIT PULL] pxa: features for next
In-Reply-To: <201107112319.38768.arnd.bergmann@linaro.org>
References: <CAMPhdO8uQR4km9szkuGDjuym-hViE9+zxtie6D2WGJmf1_9rUg@mail.gmail.com>
	<201107112319.38768.arnd.bergmann@linaro.org>
Message-ID: <CAMPhdO9ibczzuyoyyQBi=MntkWaAfAGRtfvORDYw0En7MWLwhQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 12, 2011 at 5:19 AM, Arnd Bergmann <arnd.bergmann@linaro.org> wrote:
> On Monday 11 July 2011, Eric Miao wrote:
>> The following changes since commit fe0d42203cb5616eeff68b14576a0f7e2dd56625:
>>
>> ? Linux 3.0-rc6 (2011-07-04 15:56:24 -0700)
>>
>> are available in the git repository at:
>> ? git://git.kernel.org/pub/scm/linux/kernel/git/ycmiao/pxa-linux-2.6.git devel
>
> I'll wait for the next version on this one, until you fixed the problem
> pointed out by Russell, ok?
>

Hi Arnd,

I'm OK with that.

And Russell kindly provided a better fix, and I've merged and rebased
the whole series. Please consider re-pull (just pushed, sync to git.k.o
is in still in progress I guess).

I posted the patch as below, with the name changed to handle_IRQ for
non-exception stack dump use (as the original handle_irq_event conflicts
with the one in kernel/irq/).

commit a4841e39f7ca85ee2a40803ebac6221c6d8822c0
Author: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date:   Mon Jul 11 22:25:43 2011 +0100

    ARM: introduce handle_IRQ() not to dump exception stack

    On Mon, Jul 11, 2011 at 3:52 PM, Russell King - ARM Linux
    <linux@arm.linux.org.uk> wrote:

    ...

    > The __exception annotation on a function causes this to happen:
    >
    > [<c002406c>] (asm_do_IRQ+0x6c/0x8c) from [<c0024b84>]
    > (__irq_svc+0x44/0xcc)
    > Exception stack(0xc3897c78 to 0xc3897cc0)
    > 7c60:
4022d320 4022e000
    > 7c80: 08000075 00001000 c32273c0 c03ce1c0 c2b49b78 4022d000
c2b420b4 00000001
    > 7ca0: 00000000 c3897cfc 00000000 c3897cc0 c00afc54 c002edd8
00000013 ffffffff
    >
    > Where that stack dump represents the pt_regs for the exception which
    > happened.  Any function found in while unwinding will cause this to
    > be printed.
    >
    > If you insert a C function between the IRQ assembly and asm_do_IRQ,
    > the
    > dump you get from asm_do_IRQ will be the stack for your function,
    > not
    > the pt_regs.  That makes the feature useless.
    >

    When __irq_svc - or any of the other exception handling assembly code -
    calls the C code, the stack pointer will be pointing at the pt_regs
    structure.

    All the entry points into C code from the exception handling code are
    marked with __exception or __exception_irq_enter to indicate that they
    are one of the functions which has pt_regs above them.

    Normally, when you've entered asm_do_IRQ() you will have this stack
    layout (higher address towards top):

           pt_regs
           asm_do_IRQ frame

    If you insert a C function between the exception assembly code and
    asm_do_IRQ, you end up with this stack layout instead:

           pt_regs
           your function frame
           asm_do_IRQ frame

    This means when we unwind, we'll get to asm_do_IRQ, and rather than
    dumping out the pt_regs, we'll dump out your functions stack frame
    instead, because that's what is above the asm_do_IRQ stack frame
    rather than the expected pt_regs structure.

    The fix is to introduce handle_IRQ() for no exception stack dump, so
    it can be called with MULTI_IRQ_HANDLER is selected and a C function
    is between the assembly code and the actual IRQ handling code.

    Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

diff --git a/arch/arm/include/asm/irq.h b/arch/arm/include/asm/irq.h
index 2721a58..5a526af 100644
--- a/arch/arm/include/asm/irq.h
+++ b/arch/arm/include/asm/irq.h
@@ -23,6 +23,7 @@ struct pt_regs;
 extern void migrate_irqs(void);

 extern void asm_do_IRQ(unsigned int, struct pt_regs *);
+void handle_IRQ(unsigned int, struct pt_regs *);
 void init_IRQ(void);

 #endif
diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
index 83bbad0..dbc1f41 100644
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -67,12 +67,12 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 }

 /*
- * do_IRQ handles all hardware IRQ's.  Decoded IRQs should not
- * come via this function.  Instead, they should provide their
- * own 'handler'
+ * handle_IRQ handles all hardware IRQ's.  Decoded IRQs should
+ * not come via this function.  Instead, they should provide their
+ * own 'handler'.  Used by platform code implementing C-based 1st
+ * level decoding.
  */
-asmlinkage void __exception_irq_entry
-asm_do_IRQ(unsigned int irq, struct pt_regs *regs)
+void handle_IRQ(unsigned int irq, struct pt_regs *regs)
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);

@@ -97,6 +97,15 @@ asm_do_IRQ(unsigned int irq, struct pt_regs *regs)
 	set_irq_regs(old_regs);
 }

+/*
+ * asm_do_IRQ is the interface to be used from assembly code.
+ */
+asmlinkage void __exception_irq_entry
+asm_do_IRQ(unsigned int irq, struct pt_regs *regs)
+{
+	handle_IRQ(irq, regs);
+}
+
 void set_irq_flags(unsigned int irq, unsigned int iflags)
 {
 	unsigned long clr = 0, set = IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN;
