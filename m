From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 6 Nov 2015 12:00:24 +0000
Subject: [PATCH v11 1/5] xen: move xen_setup_runstate_info and
 get_runstate_snapshot to drivers/xen/time.c
In-Reply-To: <alpine.DEB.2.02.1511061110220.13541@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1511051502270.13541@kaball.uk.xensource.com>
 <1446737696-9749-1-git-send-email-stefano.stabellini@eu.citrix.com>
 <20151105164820.GF32247@leverpostej>
 <alpine.DEB.2.02.1511061110220.13541@kaball.uk.xensource.com>
Message-ID: <20151106120024.GB23038@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 06, 2015 at 11:11:40AM +0000, Stefano Stabellini wrote:
> On Thu, 5 Nov 2015, Mark Rutland wrote:
> > Hi,
> > 
> > > +static u64 get64(const u64 *p)
> > > +{
> > > +	u64 ret;
> > > +
> > > +	if (BITS_PER_LONG < 64) {
> > > +		u32 *p32 = (u32 *)p;
> > > +		u32 h, l;
> > > +
> > > +		/*
> > > +		 * Read high then low, and then make sure high is
> > > +		 * still the same; this will only loop if low wraps
> > > +		 * and carries into high.
> > > +		 * XXX some clean way to make this endian-proof?
> > > +		 */
> > > +		do {
> > > +			h = p32[1];
> > > +			barrier();
> > > +			l = p32[0];
> > > +			barrier();
> > > +		} while (p32[1] != h);
> > 
> > I realise this is simply a move of existing code, but it may be better
> > to instead have:
> > 
> > do {
> > 	h = READ_ONCE(p32[1]);
> > 	l = READ_ONCE(p32[0]);
> > } while (READ_ONCE(p32[1] != h);
> > 
> > Which ensures that each load is a single access (though it almost
> > certainly would be anyway), and prevents the compiler from having to
> > reload any other memory locations (which the current barrier() usage
> > forces).
> 
> I am happy to make these changes, however for code clarity and review
> simplicity I'll keep them on a separate patch (I like code movement to
> remain code movement). I can squash the two patches together when
> committing, if necessary.

Sure, I also prefer to separate code movement from code rework, so that
makes sense to me.

Thanks,
Mark.
