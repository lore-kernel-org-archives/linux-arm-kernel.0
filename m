From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 24 Aug 2009 18:41:49 +0100
Subject: LDREX/STREX and pre-emption on SMP hardware
In-Reply-To: <1251134043.31975.23.camel@david-laptop>
References: <4A8EB836.3000406@plxtech.com>
	<1250869355.10642.10.camel@pc1117.cambridge.arm.com>
	<20090821155011.GB8583@shareable.org>
	<1250870319.10642.23.camel@pc1117.cambridge.arm.com>
	<1250890146.29685.18.camel@david-laptop>
	<1251128692.28977.17.camel@pc1117.cambridge.arm.com>
	<1251134043.31975.23.camel@david-laptop>
Message-ID: <1251135709.28977.40.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2009-08-24 at 10:14 -0700, David Xiao wrote:
> On Mon, 2009-08-24 at 08:44 -0700, Catalin Marinas wrote:
> > On Fri, 2009-08-21 at 14:29 -0700, David Xiao wrote:
> > > The DDI0406A ARM V7 Architecture Reference Manual (section A3.4.1) seems
> > > to indicate that the exclusive monitor is tagging/matching the physical
> > > memory address accessed by the LDREX/STREX instructions.
> > > 
> > > And in the same document (section A3.4.5), it seems to suggest that the
> > > reason we need to do CLREX during the context switch is that because the
> > > IsExclusiveLocal() implementation does not have to do memory
> > > address/size check, but just the exclusive state check.
> > 
> > Yes, that's correct. And the reason we don't need this in interrupt
> > handlers is that we would never call a STREX without a preceding LDREX
> > or just a LDREX without a being followed by a STREX and interrupt
> > handlers are in the worst case nested rather than freely preemptible.
> 
> If an IRQ handler is registered with IRQF_DISABLED, then the handling of
> this IRQ will not be preempted by any other IRQ handlers; however, if it
> is not using that flag, which is the common case, that IRQ handler could
> be interrupted/preempted by another different IRQ handler though.

Yes, but the exclusives are not affected (see below).

> Meanwhile, if we could assume that interrupt handlers are always using
> the LDREX/CLREX in pairs, then the same thing could be assumed for any
> other contexts in the system, kernel/user threads. Therefore, I do not
> think that we can make that assumption.

In user space you can get (T1, T2 are threads):

T1			T2
LDREX
			LDREX
STREX (succeeds)
			STREX (fails)


So the STREX in T1 shouldn't really succeed because there was a context
switch and LDREX in T2 (this particular case may not be a problem but if
you create a situation with 3 threads that is incorrect).

With interrupts (I1, I2 interrupt handlers)

I1			I2
LDREX
			LDREX
			STREX (succeeds)
STREX (fails)

In the interrupt case, they are nested so the STREX in I2 is always
executed before STREX in I1 (you can extrapolate with several nested
interrupts).

-- 
Catalin
