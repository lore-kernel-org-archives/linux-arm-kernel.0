From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 14 Jan 2011 16:23:12 +0000
Subject: [PATCH] ARM: vfp: Fix up exception location in Thumb mode
In-Reply-To: <20110114154919.GE15996@n2100.arm.linux.org.uk>
References: <1294990949-2729-1-git-send-email-ccross@android.com>
	<AANLkTimqiqABxCejdeOQWZZ62DVUZW2v-yMpdu1aNDQT@mail.gmail.com>
	<20110114120229.GA15996@n2100.arm.linux.org.uk>
	<1295014231.7901.41.camel@e102109-lin.cambridge.arm.com>
	<20110114154919.GE15996@n2100.arm.linux.org.uk>
Message-ID: <1295022193.7901.56.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-01-14 at 15:49 +0000, Russell King - ARM Linux wrote:
> On Fri, Jan 14, 2011 at 02:10:31PM +0000, Catalin Marinas wrote:
> > On Fri, 2011-01-14 at 12:02 +0000, Russell King - ARM Linux wrote:
> > > I don't think this is correct.  On entry to the undefined instruction
> > > handler, we get the uncorrected PC value, so PC points to the
> > > instruction after the faulting instruction.
> > >
> > > If it was an ARM instruction, that is located at PC-4.  If it was a
> > > Thumb instruction, it is located at PC-2.  This PC value is passed
> > > unmodified to the VFP entry code, and the passed r2 reflect the
> > > value in regs->ARM_pc.
> >
> > The entry-armv.S code adds 2 to the r2 register in case of a 32-bit
> > Thumb instruction, so it is no longer the same as the ARM_pc.
> 
> That's something that should be fixed - the entry conditions should be
> the same irrespective of thumb or arm encoding.

But in this case you have to fix the vfphw.S code to check for Thumb and
subtract 2 rather than 4 from r2.

> > Since the VFP instructions in Thumb mode are always 32-bit, Colin's
> > patch made sense to me.
> 
> I looked up the VADD instruction in the ARM ARM.  It has both a 16-bit
> and 32-bit encoding.

Are you sure? The Thumb encoding is made up of two 16-bit values but it
is still 32-bit in total.

> > > I think that the undefined instruction handling needs reworking for
> > > Thumb entirely as we could be dealing with a 16-bit or 32-bit thumb
> > > instruction, and we have no way of knowing without repeatedly
> > > decoding that instruction.
> >
> > We already handle the r2 for in __und_usr. We don't deal with ARM_pc but
> > we could either do it in __und_usr or let the code handling the undef
> > fix it up.
> 
> At the moment its just confusing as things stand, as some things are
> changed in one place and not the other.  Let's kill the pointless
> addition of 2 in the undefined instruction handler so that in every
> case we enter handlers with r2 == regs->ARM_pc, and regs->ARM_pc
> as per the ARM ARM undefined exception entry LR.
> 
> Undefined instruction exception handlers can then rely on the meaning
> of both of these.

That's an alternative, though we may end up with checking the encoding
twice. The Undef handler already reads the instruction opcode and it
needs to know whether it is a 16 or a 32-bit wide instruction.

But I agree that the current implementation is a bit confusing.

-- 
Catalin
