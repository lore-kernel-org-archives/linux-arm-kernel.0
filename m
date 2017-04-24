From: jnair@caviumnetworks.com (Jayachandran C)
Date: Mon, 24 Apr 2017 17:45:26 +0000
Subject: [PATCH] arm64: pmuv3: Support v8.1 PMUv3 extension
In-Reply-To: <20170424164507.GB5972@leverpostej>
References: <1493033503-4712-1-git-send-email-jnair@caviumnetworks.com>
 <20170424125747.GA5767@leverpostej>
 <20170424133929.GA4952@localhost>
 <20170424140348.GB5767@leverpostej>
 <20170424164008.GA4657@localhost>
 <20170424164507.GB5972@leverpostej>
Message-ID: <20170424174526.GB4657@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 24, 2017 at 05:45:08PM +0100, Mark Rutland wrote:
> On Mon, Apr 24, 2017 at 04:40:09PM +0000, Jayachandran C wrote:
> > On Mon, Apr 24, 2017 at 03:03:48PM +0100, Mark Rutland wrote:
> > > On Mon, Apr 24, 2017 at 01:39:30PM +0000, Jayachandran C wrote:
> > > > The v8.1 supplement is quite clear on the field definition:
> > > >
> > > > PMUVer, bits [11:8]
> > > > ....
> > > > Defined values are:
> > > >       0000 Performance Monitors extension System registers not implemented.
> > > >       0001 Performance Monitors extension System registers implemented, PMUv3.
> > > >       0100 Performance Monitors extension System registers implemented, PMUv3, with a 16-bit
> > > >            evtCount field, and if EL2 is implemented, the addition of the MDCR_EL2.HPMD bit.
> > > >       1111 IMPLEMENTATION DEFINED form of performance monitors supported, PMUv3 not
> > > >            supported.
> > > >         All other values are reserved.
> > > >         In ARMv8-A the permitted values are 0b0000, 0b0001 and 0b1111.
> > > >         In ARMv8.1 the permitted values are 0b0000, 0b0100 and 0b1111.
> > > >
> > > > I changed the code to strictly do this. We have to exclude 0xf, since that is not PMUv3.
> > > > And we cannot predict what the reserved values will represent, so it is best to skip them
> > > > until they are defined to be PMUv3 compatible.
> > > 
> > > My understanding is that ID_AA64DFR0.PMUVer is intended to be covered by
> > > the usual ID register principles, and thus at least 0x2-0x7 are reserved
> > > for architected backwards compatible extensions to PMUv3.
> > > 
> > > See ARM DDI 0487B.a, D7.1.4, "Principles of the ID scheme for fields in
> > > ID registers". It is explicitly stated that the scheme applies to
> > > ID_AA64DFR0.
> > > 
> > > Per those rules, we should check >= the minimum PMUv3 implemented value,
> > > i.e. val >= 1. Due to both 0x0 and 0xF meaning PMUv3 isn't implemented,
> > > it's not clear if the fields should be treated as if it were signed or
> > > unsigned, and I'm awaiting clarification on this.
> > 
> > Thanks for the reference. Since 0xf means that there is a PMU (but it is
> > not PMUv3), this looks like an unsigned ID with a special case.
> > 
> > > Either way, I believe that 0x1-0x7 must all be compatible with baseline
> > > PMUv3 per the ID scheme principles.
> > 
> > In case you don't get authoritative information on this, can you please
> > merge a version which does either 'if (pmuver < 1 || pmuver == 0xf)' or
> > 'if (pmuver < 1 || pmuver > 7)' to the patchset?
> 
> Sure, that's what I proposed:
> 
>         pmuver = cpuid_feature_extract_signed_field(dfr0,
>                         ID_AA64DFR0_PMUVER_SHIFT);
>         if (pmuver < 1)
>                 return;
> 
> Note that it treats the value as signed, so it will accept 0x1-0x7, and
> return for 0x0 or 0x8-0xf.

Ok, we will need to change the type of pmuver to int as well.

But even then, I think the reasonable interpretation of the current spec
is that the field is unsigned. Your original 'if (pmuver < 1 || pmuver == 0xf)'
is the least surprising way of writing it.

JC.
