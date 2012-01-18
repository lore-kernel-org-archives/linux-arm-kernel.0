From: will.deacon@arm.com (Will Deacon)
Date: Wed, 18 Jan 2012 15:31:20 +0000
Subject: [PATCH] ARM: kexec: EOI active and mask all interrupts in kexec
 crash path
In-Reply-To: <20120118150724.GH1068@n2100.arm.linux.org.uk>
References: <1326898885-28105-1-git-send-email-will.deacon@arm.com>
 <20120118150724.GH1068@n2100.arm.linux.org.uk>
Message-ID: <20120118153120.GK29346@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Wed, Jan 18, 2012 at 03:07:24PM +0000, Russell King - ARM Linux wrote:
> On Wed, Jan 18, 2012 at 03:01:25PM +0000, Will Deacon wrote:
> > The kexec machine crash code can be called in interrupt context via a
> > sysrq trigger made using the magic key combination. If the irq chip
> > dealing with the serial interrupt is using the fasteoi flow handler,
> > then we will never EOI the interrupt because the interrupt handler will
> > be fatal. In the case of a GIC, this results in the crash kernel not
> > receiving interrupts on that CPU interface.
> > 
> > This patch adds code (based on the PowerPC implementation) to EOI any
> > pending interrupts on the crash CPU before masking and disabling all
> > interrupts. Secondary cores are not a problem since they are placed into
> > a cpu_relax() loop via an IPI.
> 
> So, what happens if we fault in an interrupt handler, we have
> panic_on_oops set, and we have panic configured to automatically
> reboot after a period?

If we fault in an interrupt handler, we'll end up with the faulting CPU in
machine_crash_shutdown, with the secondaries getting put into
machine_crash_nonpanic_core. Then the faulting CPU will EOI the interrupt it
was previously handling, before masking it. The interrupt may of course
remain asserted at the distributor, but it will be masked, so it means the
new crash kernel might receive a spurious interrupt when it unmasks it via
request_irq.

Or have you idenfified an issue that I'm missing?

> I think we actually want this to happen at boot to make sure that the
> CPU interfaces are properly initialized each time the kernel is brought
> up.

The problem with that is working out which interrupts to EOI, on which
CPU interfaces and in which order. The GIC manual states that EOIing an
interrupt which hasn't been previously acked on that interface is
UNPREDICTABLE.

> > @@ -53,6 +54,28 @@ void machine_crash_nonpanic_core(void *unused)
> >  		cpu_relax();
> >  }
> >  
> > +static void machine_kexec_mask_interrupts(void) {
> 
> Coding style error.

Will fix.

Cheers,

Will
