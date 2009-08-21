From: dxiao@broadcom.com (David Xiao)
Date: Fri, 21 Aug 2009 14:29:06 -0700
Subject: LDREX/STREX and pre-emption on SMP hardware
In-Reply-To: <1250870319.10642.23.camel@pc1117.cambridge.arm.com>
References: <4A8EB836.3000406@plxtech.com>
	<1250869355.10642.10.camel@pc1117.cambridge.arm.com>
	<20090821155011.GB8583@shareable.org>
	<1250870319.10642.23.camel@pc1117.cambridge.arm.com>
Message-ID: <1250890146.29685.18.camel@david-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2009-08-21 at 08:58 -0700, Catalin Marinas wrote:
> On Fri, 2009-08-21 at 16:50 +0100, Jamie Lokier wrote:
> > Catalin Marinas wrote:
> > > On Fri, 2009-08-21 at 16:07 +0100, Richard Crewe wrote:
> > > > Section A2.9.3 of the ARM architecture ref. manual seems to imply that 
> > > > ldrex/strex instruction pairs won't work correctly if they are nested 
> > > > due to pre-emption.
> > > > 
> > > > Should a strex instruction be added to the low-level interrupt handler 
> > > > or should all ldrex/strex instruction pairs be protected from 
> > > > pre-emption by disabling interrupts?
> > > 
> > > There is no need to since preemption means rescheduling which implies a
> > > call to the __switch_to function in entry-armv.S. This function clears
> > > the exclusive monitor state explicitly.
> > 
> > What about when an interrupt handler uses ldrex/strex?  There is no
> > call to __switch_to.
> 
> I don't see any issues with interrupt handlers, the exclusives should
> work as expected.
> 
> The problem is with user apps using the exclusives and the same virtual
> address could be used with LDREX/STREX in two different applications.
> The (local) exclusive monitor may consider a LDREX in the one app and
> STREX in the other app are part of the same pair and store the data
> successfully.
> 
The DDI0406A ARM V7 Architecture Reference Manual (section A3.4.1) seems
to indicate that the exclusive monitor is tagging/matching the physical
memory address accessed by the LDREX/STREX instructions.

And in the same document (section A3.4.5), it seems to suggest that the
reason we need to do CLREX during the context switch is that because the
IsExclusiveLocal() implementation does not have to do memory
address/size check, but just the exclusive state check.

Could you confirm that, Catalin? Thanks.

David
