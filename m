From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Mon, 6 Aug 2012 11:55:38 +0100
Subject: [Xen-devel] [PATCH 01/24] arm: initial Xen support
In-Reply-To: <20120801104237.GB7227@phenom.dumpdata.com>
References: <alpine.DEB.2.02.1207251741470.26163@kaball.uk.xensource.com>
 <1343316846-25860-1-git-send-email-stefano.stabellini@eu.citrix.com>
 <20120726163020.GB9222@phenom.dumpdata.com>
 <alpine.DEB.2.02.1207271246080.26163@kaball.uk.xensource.com>
 <20120801104237.GB7227@phenom.dumpdata.com>
Message-ID: <alpine.DEB.2.02.1208061146480.4645@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 1 Aug 2012, Konrad Rzeszutek Wilk wrote:
> > > > +struct pvclock_wall_clock {
> > > > +	u32   version;
> > > > +	u32   sec;
> > > > +	u32   nsec;
> > > > +} __attribute__((__packed__));
> > > 
> > > That is weird. It is 4+4+4 = 12 bytes? Don't you want it to be 16 bytes?
> > 
> > I agree that 16 bytes would be a better choice, but it needs to match
> > the struct in Xen that is defined as follow:
> > 
> >     uint32_t wc_version;      /* Version counter: see vcpu_time_info_t. */
> >     uint32_t wc_sec;          /* Secs  00:00:00 UTC, Jan 1, 1970.  */
> >     uint32_t wc_nsec;         /* Nsecs 00:00:00 UTC, Jan 1, 1970.  */
> 
> Would it make sense to add some paddigin then at least? In both
> cases? Or is it too late for this?

I can see why adding some padding would be useful if the structs were
not packed and we wanted to enforce 32/64 bit compatibility on x86.
However on ARM the field alignments on 32 and 64 bits are the same for
integer values so the padding wouldn't make a difference.
In any case both structs are packed, so the alignment is forced to be the
same by the compiler.
