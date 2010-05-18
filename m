From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 18 May 2010 08:24:06 -0400 (EDT)
Subject: Boot interface for device trees on ARM
In-Reply-To: <20100518084954.GC25892@yookeroo>
References: <201005181054.32325.jeremy.kerr@canonical.com>
	<alpine.LFD.2.00.1005172341200.12758@xanadu.home>
	<201005181324.45701.jeremy.kerr@canonical.com>
	<20100518084954.GC25892@yookeroo>
Message-ID: <alpine.LFD.2.00.1005180802010.12758@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 18 May 2010, David Gibson wrote:

> On Tue, May 18, 2010 at 01:24:43PM +0800, Jeremy Kerr wrote:
> 
> > Nicolas Pitre wrote:
> > 
> > > Why one DT machine ID per subarchitecture?  Simply because a significant
> > > part of the DT handling code will have to be subarchitecture specific
> > > anyway.  The timer hardware, the GPIO configuration and muxing, SOC
> > > specific platform data handling, power management config, and many other
> > > things are simply too different from one SOC family to another and
> > > trying to have a single global DT support code to rule them all is
> > > insane.
> > 
> > The code for DT boot will be still subarch-specific, but I don't
> > think we need IDs for that. There is enough information in the
> > device tree to select the subarch-specific code to use for early
> > init, without needing to parameterise every element of the
> > machine. The machine-level "compatible" property allows us to do
> > this.
> 
> That's right.  On PowerPC currently we don't have any real concept of
> sub-architecture, but we do have platform level code to cover exactly
> the sorts of messy things you mention, and it is selected on the basis
> of the device tree's top-level compatible property.

Agreed.  However this is not PPC we're discussing here.  This is about 
ARM which has been structuring its wildly different subarchitectures 
around another model for over 15 years.

> The only reason you'd need a subarchitecture number or equivalent is
> if you need to do things differently in the very, very early asm boot
> code.  We may need a minimal form of this on PowerPC if we ever
> support multiple MMU families in the same kernel binary.

Exact.  For example, on ARM the machine ID is also used to figure out 
the MMU mapping needed to be able to simply be able to debug the very 
early assembly boot stage when there isn't even a stack available. While 
this info is stored in the machine record, it is actually 
subarchitecture specific and already half-digested for easy usage by 
that initial MMU setup.  I just don't want to imagine what the 
equivalent functionality with DT would look like.

> > Therefore, I don't think we need the machine ID at all: once the DT is 
> > available, we can use that for any machine-specific stuff. Even though we're 
> > not *configuring* it from the device tree, we can *select* it from there 
> > instead.
> 
> Yes, absolutely.

Please see above why I disagree.


Nicolas
