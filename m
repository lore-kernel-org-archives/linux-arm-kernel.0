From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 7 Nov 2012 10:11:00 -0500 (EST)
Subject: [RFC PATCH 4/4] ARM: gic: use a private mapping for CPU target
 interfaces
In-Reply-To: <20121107102357.GD23305@mudshark.cambridge.arm.com>
References: <1350393709-23546-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1350393709-23546-5-git-send-email-lorenzo.pieralisi@arm.com>
 <20121106221651.GE21764@mudshark.cambridge.arm.com>
 <alpine.LFD.2.02.1211061755260.21033@xanadu.home>
 <20121107102357.GD23305@mudshark.cambridge.arm.com>
Message-ID: <alpine.LFD.2.02.1211070950250.21033@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 7 Nov 2012, Will Deacon wrote:

> On Tue, Nov 06, 2012 at 10:59:35PM +0000, Nicolas Pitre wrote:
> > On Tue, 6 Nov 2012, Will Deacon wrote:
> > > >  	/*
> > > > +	 * Get what the GIC says our CPU mask is.
> > > > +	 */
> > > > +	BUG_ON(cpu >= 8);
> > > > +	cpu_mask = readl_relaxed(dist_base + GIC_DIST_TARGET + 0);
> > > 
> > > Making the mask a u8 and using readb_relaxed here makes this bit of code
> > > clearer to me (and the GIC apparently allows such an access to this
> > > register).
> > 
> > Not always.  At least RTSM throws an exception if you do so.
> > Been there.
> 
> That would be a bug in the RTSM then. Have you reported it to support? (if
> not, I can chase this one up). I'd rather we just fix the model than work
> around it in Linux.

I have no problem with you chasing it down with the support people.

I don't want to wait for fixed RTSM versions to be released and the 
whole world to migrate to them though.

While the readl is maybe marginally unintuitive compared to a readb 
here, the code is always using readl everywhere else already, even using 
bit masking and shifting when a readb/writeb could have made the code 
much simpler (see gic_set_affinity() for example).  I therefore much 
prefer to stick to a proven 32-bit access than risking regression on 
some possible implementation where the 8-bit access wasn't properly 
implemented as the doc says it should and never exercised before.

In other words, I prefer erring on the safe side here.


Nicolas
