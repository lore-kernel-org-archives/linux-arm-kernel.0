From: robert.richter@caviumnetworks.com (Robert Richter)
Date: Tue, 7 Jul 2015 11:55:33 +0200
Subject: [PATCH 3/4] irqchip, gicv3: Implement Cavium ThunderX erratum
 23154
In-Reply-To: <20150706104812.GD7557@n2100.arm.linux.org.uk>
References: <1435673643-31676-1-git-send-email-rric@kernel.org>
 <1435673643-31676-4-git-send-email-rric@kernel.org>
 <20150706104812.GD7557@n2100.arm.linux.org.uk>
Message-ID: <20150707095533.GM10428@rric.localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

thanks for your comments.

On 06.07.15 11:48:12, Russell King - ARM Linux wrote:
> On Tue, Jun 30, 2015 at 04:14:02PM +0200, Robert Richter wrote:
> > +static u64 gic_read_iar_cavium_thunderx(void)
> >  {
> >  	u64 irqstat;
> >  
> > +	asm volatile("nop;nop;nop;nop;");
> > +	asm volatile("nop;nop;nop;nop;");
> >  	asm volatile("mrs_s %0, " __stringify(ICC_IAR1_EL1) : "=r" (irqstat));
> > +	asm volatile("nop;nop;nop;nop;");
> > +	mb();
> 
> NAK.  Please read the GCC manual for proper use of asm().  Even with
> "volatile" there, it doesn't stop GCC from inserting instructions
> between these.
> 
> If you need an instruction sequence to be consecutive, then it _must_
> be one single asm().

I will update this section.

> There should also be a comment explaining why that code is necessary
> here.  Please think about the future when you've forgotten why those
> nops are there.  The kernel is a long term project, and it's important
> that people understand why things are coded the way they are so that
> the kernel can be properly maintained into the future.

I will add a comment to the code with a brief description. Would the
current text from the patch description including the erratum number
be sufficient for that?

Thanks,

-Robert
