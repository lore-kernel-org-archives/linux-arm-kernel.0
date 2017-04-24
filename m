From: jnair@caviumnetworks.com (Jayachandran C)
Date: Mon, 24 Apr 2017 13:39:30 +0000
Subject: [PATCH] arm64: pmuv3: Support v8.1 PMUv3 extension
In-Reply-To: <20170424125747.GA5767@leverpostej>
References: <1493033503-4712-1-git-send-email-jnair@caviumnetworks.com>
 <20170424125747.GA5767@leverpostej>
Message-ID: <20170424133929.GA4952@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 24, 2017 at 01:57:47PM +0100, Mark Rutland wrote:
> Hi,
> 
> On Mon, Apr 24, 2017 at 11:31:43AM +0000, Jayachandran C wrote:
> > The PMUVer field can have a value 4 for PMUv3 which supports 16 bit
> > evtCount field (this is documented in ARM Architecture Reference Manual
> > Supplement ARMv8.1).
> >
> > The current check for PMUVer to be equal to 1 fails on ThunderX2 which
> > has value 4 in PMUVer field. Fix this.
> >
> > Signed-off-by: Jayachandran C <jnair@caviumnetworks.com>
> > ---
> >
> > This applies on top of the current arm64 tree and fixes a breakage due
> > to the  ACPI perf patches.
> 
> Sorry for the delay on this. I'm still awaiting an architectural
> clarification on how this field should be interpreted, as per my prior
> comments [1].
> 
> I realise that's not much consolation here, so I'm happy to take an
> intermediate fix. One comment on that below.

I thought I would sent this out since it was getting very late in the cycle.
I don't mind waiting if you are planning to fix this, feel free to drop this
patch and integrate your version.

The v8.1 supplement is quite clear on the field definition:

PMUVer, bits [11:8]
....
Defined values are:
	0000 Performance Monitors extension System registers not implemented.
	0001 Performance Monitors extension System registers implemented, PMUv3.
	0100 Performance Monitors extension System registers implemented, PMUv3, with a 16-bit
	     evtCount field, and if EL2 is implemented, the addition of the MDCR_EL2.HPMD bit.
	1111 IMPLEMENTATION DEFINED form of performance monitors supported, PMUv3 not
    	     supported.
        All other values are reserved.
        In ARMv8-A the permitted values are 0b0000, 0b0001 and 0b1111.
        In ARMv8.1 the permitted values are 0b0000, 0b0100 and 0b1111.

I changed the code to strictly do this. We have to exclude 0xf, since that is not PMUv3.
And we cannot predict what the reserved values will represent, so it is best to skip them
until they are defined to be PMUv3 compatible.
 
> >  arch/arm64/kernel/perf_event.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> > index 98c7493..5388ed8 100644
> > --- a/arch/arm64/kernel/perf_event.c
> > +++ b/arch/arm64/kernel/perf_event.c
> > @@ -972,7 +972,7 @@ static void __armv8pmu_probe_pmu(void *info)
> >       dfr0 = read_sysreg(id_aa64dfr0_el1);
> >       pmuver = cpuid_feature_extract_unsigned_field(dfr0,
> >                       ID_AA64DFR0_PMUVER_SHIFT);
> > -     if (pmuver != 1)
> > +     if (pmuver != 1 && pmuver != 4)
> >               return;
> 
> Can we please make this:
> 
>         pmuver = cpuid_feature_extract_signed_field(dfr0,
>                         ID_AA64DFR0_PMUVER_SHIFT);
>         if (pmuver < 1)
>                 return;
> 
> With that, I'm happy to take this while we await further clarification.

Please see above, I don't really think this is better.

JC.
