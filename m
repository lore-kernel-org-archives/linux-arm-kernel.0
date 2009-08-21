From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 21 Aug 2009 16:58:39 +0100
Subject: LDREX/STREX and pre-emption on SMP hardware
In-Reply-To: <20090821155011.GB8583@shareable.org>
References: <4A8EB836.3000406@plxtech.com>
	<1250869355.10642.10.camel@pc1117.cambridge.arm.com>
	<20090821155011.GB8583@shareable.org>
Message-ID: <1250870319.10642.23.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2009-08-21 at 16:50 +0100, Jamie Lokier wrote:
> Catalin Marinas wrote:
> > On Fri, 2009-08-21 at 16:07 +0100, Richard Crewe wrote:
> > > Section A2.9.3 of the ARM architecture ref. manual seems to imply that 
> > > ldrex/strex instruction pairs won't work correctly if they are nested 
> > > due to pre-emption.
> > > 
> > > Should a strex instruction be added to the low-level interrupt handler 
> > > or should all ldrex/strex instruction pairs be protected from 
> > > pre-emption by disabling interrupts?
> > 
> > There is no need to since preemption means rescheduling which implies a
> > call to the __switch_to function in entry-armv.S. This function clears
> > the exclusive monitor state explicitly.
> 
> What about when an interrupt handler uses ldrex/strex?  There is no
> call to __switch_to.

I don't see any issues with interrupt handlers, the exclusives should
work as expected.

The problem is with user apps using the exclusives and the same virtual
address could be used with LDREX/STREX in two different applications.
The (local) exclusive monitor may consider a LDREX in the one app and
STREX in the other app are part of the same pair and store the data
successfully.

Interrupt handlers only use the kernel mapping which doesn't change with
context switches.

BTW, some time ago I sent a patch to clear the exclusive monitor at
every exception entry (interrupt, aborts etc.) but wasn't accepted. The
main reason for that was to be able to only use STR for atomic_set()
rather than the combination of LDREX/STREX we have now. A similar reason
for STR used in application signal handlers which are usually invoked
without a __switch_to call (unless the signal handler is in a different
application from the running one).

-- 
Catalin
