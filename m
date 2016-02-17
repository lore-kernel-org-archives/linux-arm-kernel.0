From: jan.glauber@caviumnetworks.com (Jan Glauber)
Date: Wed, 17 Feb 2016 11:47:35 +0100
Subject: [PATCH v3 5/5] arm64/perf: Extend event mask for ARMv8.1
In-Reply-To: <20160216151252.GG14509@arm.com>
References: <cover.1454516082.git.jglauber@cavium.com>
 <fa91eaedf581e6a7053899f25b1b08458dbd4b8e.1454516082.git.jglauber@cavium.com>
 <20160215200404.GX6298@arm.com> <20160216080015.GA3490@hardcore>
 <20160216151252.GG14509@arm.com>
Message-ID: <20160217104735.GA3318@hardcore>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 16, 2016 at 03:12:53PM +0000, Will Deacon wrote:
> On Tue, Feb 16, 2016 at 09:00:15AM +0100, Jan Glauber wrote:
> > On Mon, Feb 15, 2016 at 08:04:04PM +0000, Will Deacon wrote:
> > 
> > [...]
> > 
> > > On Wed, Feb 03, 2016 at 06:12:00PM +0100, Jan Glauber wrote:
> > > > +		cpu_pmu->event_mask = 0xffff;	/* ARMv8.1 extended events */
> > > > +	else
> > > > +		cpu_pmu->event_mask = ARMV8_EVTYPE_EVENT;
> > > 
> > > ... although can't we just update ARMV8_EVTYPE_EVENT to be 0xffff now?
> > > AFAICT, that just eats into bits that used to be RES0, so we shouldn't
> > > see any problems. That should make your patch *much* simpler!
> > 
> > That would of course be easier, but I just can't assess the implications.
> > 
> > Probably I'm missing something but to me it looks like the event mask is the
> > only verification we do for the user-space selectable events. Is it safe for
> > implementations that only support 0x3ff events to allow access to the
> > whole 0xffff range? What memory would be accessed for non-existing
> > events?
> 
> Which memory? The worst-case is that we end up writing to some bits in
> a register (e.g. PMXEVTYPER) that are RES0 in ARMv8 afaict.

OK, I see. Than I'm happy to drop 99% of that patch and just increase
the mask.

Jan

> Will
