From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 21 Sep 2010 23:45:47 +0200 (CEST)
Subject: Regarding hw irq to Linux irq mapping on ARM
In-Reply-To: <AANLkTimp7+BLNBwZyBiPS0JgB_mno+gp8+mK=VdOd3+_@mail.gmail.com>
References: <AANLkTi=6nCJnfLB1uc0uLGOvOm0CX_R=j-8GQWTzmmep@mail.gmail.com>
	<AANLkTimp7+BLNBwZyBiPS0JgB_mno+gp8+mK=VdOd3+_@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1009212342580.2416@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 21 Sep 2010, Grant Likely wrote:
> On Tue, Sep 21, 2010 at 7:25 AM, Shaju Abraham <shaju.abraham@linaro.org> wrote:
> > Hi Grant
> >
> > Since there does not exist a mechanism to map the hw irq to linux irq
> > on ARM (device tree), I would like to discuss ?with you the plans or
> > ideas to implement the same.
> 
> I don't have any immediate plans, but this topic has come up a lot in
> the last two weeks, so I guess I need to focus on it.  :-)  [cc'ing
> devicetree-discuss and linux-arm-kernel as well as Lorenzo and Eric
> since this is a conversation that should be had publically]
> 
> > Can you share with me your thoughts on it?
> > I have browsed through the power pc code for the same. But not sure
> > the same approach is usable on ARM as well.
> 
> I haven't thought deeply about the powerpc implementation of virqs to
> determine if it is suitable for other architectures or not, but the
> concept behind it is sound.  We need a method of mapping controller
> specific IRQ (or hw irq) numbers into the global Linux irq space
> (referred to a virqs from this point on).  First it requires a
> per-controller reference which can be a pointer to a per-controller
> data structure, or any other unique identifier.  It could even be the
> interrupt controller device tree node pointer.  Just so long as there
> is a reliable method to derive the virq from the controller reference
> + hw irq number.
> 
> There also needs to be a method for each interrupt controller to
> register itself and allocate a portion of the virq range.  This
> shouldn't be too hard.  PowerPC handles this with the irq_map[] flat
> table.  This approach is limited to whatever NR_IRQs is set to, and
> could potentially be limited by that, but on the other hand the number
> of discrete IRQ sources in a system is limited so a flat table
> (instead of a dynamic hash table) is probably sufficient.  It is
> certainly simpler to implement.
> 
> I think the first step is to simply try generalizing the code in
> arch/powerpc/kernel/irq.c.  It isn't very complex and it would give a
> better impression of what needs to be done.  The ARM interrupt
> controller drivers would need to be modified to register with the virq
> infrastructure.  None of this is either ARM or OF specific; it would
> be useful for any system than need to dynamically allocate IRQ
> numbers.  I could see some x86 use cases (Xilinx FPGAs) where this
> would be useful.

Add all the I2C, SPI based irq extenders to that list. They seem to
pop up all over the place in rapid speed even in x86. We are happy
citizens of the embedded horror^Wuniverse now.

Thanks,

	tglx
