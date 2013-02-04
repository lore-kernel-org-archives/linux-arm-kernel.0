From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 4 Feb 2013 09:29:12 +0000
Subject: [PATCHv5 15/16] ARM: hyp: initialize CNTVOFF to zero
In-Reply-To: <20130201180753.GB1970@linaro.org>
References: <1359634539-9580-1-git-send-email-mark.rutland@arm.com>
 <1359634539-9580-16-git-send-email-mark.rutland@arm.com>
 <20130201111350.GA1970@linaro.org>
 <20130201114641.GB2094@e106331-lin.cambridge.arm.com>
 <20130201180753.GB1970@linaro.org>
Message-ID: <20130204092912.GA28464@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 01, 2013 at 06:07:53PM +0000, Dave Martin wrote:
> On Fri, Feb 01, 2013 at 11:46:41AM +0000, Mark Rutland wrote:
> > On Fri, Feb 01, 2013 at 11:13:50AM +0000, Dave Martin wrote:
> > > On Thu, Jan 31, 2013 at 12:15:38PM +0000, Mark Rutland wrote:
> > > > From: Marc Zyngier <Marc.Zyngier@arm.com>
> > > > 
> > > > In order to be able to use the virtual counter in a safe way,
> > > > make sure it is initialized to zero before dropping to SVC.
> > > > 
> > > > Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> > > > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > > > Cc: Dave Martin <dave.martin@arm.com>
> > > > ---
> > > >  arch/arm/kernel/hyp-stub.S | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > > 
> > > > diff --git a/arch/arm/kernel/hyp-stub.S b/arch/arm/kernel/hyp-stub.S
> > > > index 65b2417..455603a 100644
> > > > --- a/arch/arm/kernel/hyp-stub.S
> > > > +++ b/arch/arm/kernel/hyp-stub.S
> > > > @@ -152,6 +152,9 @@ THUMB(	orr	r7, #(1 << 30)	)	@ HSCTLR.TE
> > > >  	mrc	p15, 4, r7, c14, c1, 0	@ CNTHCTL
> > > >  	orr	r7, r7, #3		@ PL1PCEN | PL1PCTEN
> > > >  	mcr	p15, 4, r7, c14, c1, 0	@ CNTHCTL
> > > > +	mov	r6, #0
> > > > +	mov	r7, #0
> > > > +	mcrr	p15, 4, r6, r7, c14	@ CNTVOFF
> > > 
> > > Is this required for safety, or is it more a sanity feature?
> > 
> > This makes more sense with the next patch, which makes the arch_timer
> > driver always use the virtual counters (to avoid indirection in the fast
> > path and messy races with the setup of function pointers otherwise).
> > 
> > It's required for safety when hyp mode is enabled, and the arch_timer
> > driver uses the physical timers in combination with the virtual
> > counters. Either the driver has to apply CNTVOFF manually when setting
> > the physical timers, or the physical timers and virtual counters need
> > the same view of time (i.e. CNTVOFF == 0).
> > 
> > It also brings us in line with arm64, which always uses the virtual
> > counter for its vDSO.
> 
> OK.  This definitely sounds like the correct model.

Good to hear.

> 
> > 
> > > 
> > > The architected timer counters are supposed to be monotonic time sources
> > > only, so applying a random offset shouldn't really change anything.
> > 
> > This is true except when we want to use the physical timers as described above.
> > 
> > > 
> > > The main thing I can think of is that it is easier for the host to
> > > manage guests' virtual counter offsets if the host's offset is 0 (and
> > > we don't really want to be changing the host offset after the host kernel
> > > boots).
> > 
> > That's pretty much it. We don't want to have to further separate the handling
> > of the timer for host and guest. By having CNTVOFF as zero for the host, we
> > don't need to duplicate reading of the timers and/or incur an additional
> > overhead on reading them.
> 
> That all sounds sensible.  FWIW:
> 
> Reviewed-by: Dave Martin <dave.martin@linaro.org>

Thanks!

Mark.
