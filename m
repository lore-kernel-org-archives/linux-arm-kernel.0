From: magnus.damm@gmail.com (Magnus Damm)
Date: Fri, 29 Jan 2010 16:23:54 +0900
Subject: IRQF_VALID
In-Reply-To: <20100128174455.GA21426@n2100.arm.linux.org.uk>
References: <aec7e5c31001280134r50b46b0ay809a125989651197@mail.gmail.com>
	<20100128174455.GA21426@n2100.arm.linux.org.uk>
Message-ID: <aec7e5c31001282323l60bae560yc3e0d082fa48fc80@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Fri, Jan 29, 2010 at 2:44 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Jan 28, 2010 at 06:34:24PM +0900, Magnus Damm wrote:
>> I'm trying to understand the idea behind IRQF_VALID. Ideally I'd like
>> to submit a patch to remove IRQF_VALID to make it easier to share
>> interrupt code between architectures. Perhaps IRQF_VALID is a left
>> over from good old times, or maybe it has some hidden use that only
>> more experienced hackers are aware or. Can anyone please shed some
>> light?
>
> On ARM, there are no IRQ tables, there is no hardware IRQ demultiplexing.
> It's all done by software. ?ARM systems tend to have chained interrupt
> controllers, and as such NR_IRQS is normally greater than the actual
> number of IRQs in the system.

Most SuperH boards only make use of the INTC controller built-in the
SoC, and in that case NR_IRQS map to the number of INTC vectors. Some
boards also hook up chained interrupt handlers and in that case the
NR_IRQS may be larger than the number of INTC vectors. The INTC
vectors are often pretty sparsely populated though, so on SuperH there
are quite a few IRQs without any chip backing which means that they
make use of &no_irq_chip and handle_bad_irq. Same thing goes for the
SuperH Mobile ARM implementation.

> We also have some situations where IRQs are supported by the controller,
> but must never be requested (eg, there are some controllers where the
> IRQ is permanently asserted and unmasking it will result in a screaming
> interrupt.)
>
> So, in order to make things sane, we need to tell the IRQ layer which
> IRQs are valid for each platform.

But isn't the call to set_irq_chip_and_handler_name() just that?

Is there any reason why we want a chip handler installed but marked
with IRQ_NOREQUEST?

Maybe you explained just that and I'm being slow. =)

Perhaps this feature is for some shared interrupt code that installs a
bunch of contiguous IRQs and then each board/cpu can select which that
are valid? If so, wouldn't it make more sense to tell the shared
interrupt code which IRQs that should be installed and which that
should be masked and left out?

> Asking each platform to tell the core which IRQs are not valid is totally
> the wrong thing to do - expecting platform X to deal with N additional
> IRQs because platform Y is also configured is just insane.

Yeah, that's no good.

I wonder if the issue that IRQF_VALID tries to solve is something
unique to ARM, and if not, perhaps it's already there in the generic
code. I believe that the state of an unused IRQ is quite similar to
the non-valid ARM IRQ.

Or maybe ARM platforms so far have a "chip" installed to be able to
mask and unmask, but other platforms just mask the interrupt and keep
it as an unused IRQ by not doing set_irq_chip_and_handler_name()?

>> Is there any point in keeping IRQF_VALID on ARM, or shall I submit a
>> patch to clean things up?
>
> I have no real idea - in this respect, the forced conversion of ARM to
> this genirq stuff was a half-botched job. ?I really can't comment, and
> from my point of view what we have we _know_ works for us, and I really
> really really do not want to go and change it.
>
> In order to make any change, there's a _huge_ platform base that would
> need to be tested.

Thanks for your comments. It sounds like you prefer to keep things as-is. =)

Either way is fine with me, I'd be happy to drop this right now, but I
also don't mind spending a bit of time and cleaning up things if you
guys think it's the right way forward.

How about something small to begin with and per-mach incremental
changes? The default would be to keep things as-is but also let each
mach implement their own set_irq_flags(). SuperH Mobile ARM will just
have a nop version.

ARM-specific prototype code and a hack for mach-pxa below:

 arch/arm/include/asm/hw_irq.h         |    6 ------
 arch/arm/include/asm/irq.h            |    8 ++++++++
 arch/arm/kernel/irq.c                 |    4 +++-
 arch/arm/mach-pxa/include/mach/irqs.h |    3 +++
 4 files changed, 14 insertions(+), 7 deletions(-)

--- 0001/arch/arm/include/asm/hw_irq.h
+++ work/arch/arm/include/asm/hw_irq.h	2010-01-29 15:16:30.000000000 +0900
@@ -18,10 +18,4 @@ static inline void desc_handle_irq(unsig
 	desc->handle_irq(irq, desc);
 }

-void set_irq_flags(unsigned int irq, unsigned int flags);
-
-#define IRQF_VALID	(1 << 0)
-#define IRQF_PROBE	(1 << 1)
-#define IRQF_NOAUTOEN	(1 << 2)
-
 #endif
--- 0001/arch/arm/include/asm/irq.h
+++ work/arch/arm/include/asm/irq.h	2010-01-29 15:17:16.000000000 +0900
@@ -22,6 +22,14 @@ extern void migrate_irqs(void);
 extern void asm_do_IRQ(unsigned int, struct pt_regs *);
 void init_IRQ(void);

+#ifndef __arch_set_irq_flags
+void set_irq_flags(unsigned int irq, unsigned int flags);
+
+#define IRQF_VALID	(1 << 0)
+#define IRQF_PROBE	(1 << 1)
+#define IRQF_NOAUTOEN	(1 << 2)
+#endif
+
 #endif

 #endif
--- 0001/arch/arm/kernel/irq.c
+++ work/arch/arm/kernel/irq.c	2010-01-29 14:10:02.000000000 +0900
@@ -128,6 +128,7 @@ asmlinkage void __exception asm_do_IRQ(u
 	set_irq_regs(old_regs);
 }

+#ifndef __arch_set_irq_flags
 void set_irq_flags(unsigned int irq, unsigned int iflags)
 {
 	struct irq_desc *desc;
@@ -149,13 +150,14 @@ void set_irq_flags(unsigned int irq, uns
 		desc->status &= ~IRQ_NOAUTOEN;
 	raw_spin_unlock_irqrestore(&desc->lock, flags);
 }
+#endif

 void __init init_IRQ(void)
 {
 	int irq;

 	for (irq = 0; irq < NR_IRQS; irq++)
-		irq_desc[irq].status |= IRQ_NOREQUEST | IRQ_NOPROBE;
+		set_irq_flags(irq, IRQF_NOAUTOEN);

 	init_arch_irq();
 }
--- 0001/arch/arm/mach-pxa/include/mach/irqs.h
+++ work/arch/arm/mach-pxa/include/mach/irqs.h	2010-01-29
15:21:44.000000000 +0900
@@ -310,4 +310,7 @@

 #endif /* CONFIG_PCI_HOST_ITE8152 */

+#define __arch_set_irq_flags
+#define set_irq_flags(irq, flags) do {} while(0)
+
 #endif /* __ASM_MACH_IRQS_H */
