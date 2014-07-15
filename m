From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 15 Jul 2014 15:31:11 +0100
Subject: [PATCH] efi/arm64: efistub: don't abort if base of DRAM is
 occupied
In-Reply-To: <1405434206.25580.31.camel@deneb.redhat.com>
References: <1405351521-12010-1-git-send-email-ard.biesheuvel@linaro.org>
 <1405363248.25580.12.camel@deneb.redhat.com>
 <20140715100221.GU4179@bivouac.eciton.net>
 <1405429860.25580.25.camel@deneb.redhat.com>
 <20140715135418.GV4179@bivouac.eciton.net>
 <1405434206.25580.31.camel@deneb.redhat.com>
Message-ID: <20140715143110.GB26465@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 15, 2014 at 03:23:26PM +0100, Mark Salter wrote:
> On Tue, 2014-07-15 at 14:54 +0100, Leif Lindholm wrote:
> > On Tue, Jul 15, 2014 at 09:11:00AM -0400, Mark Salter wrote:
> > > On Tue, 2014-07-15 at 11:02 +0100, Leif Lindholm wrote:
> > > > > @@ -273,6 +282,10 @@ static void __init free_boot_services(void)
> > > > >                       continue;
> > > > >               }
> > > > >  
> > > > > +             /* Don't free anything below kernel */
> > > > > +             if (md->phys_addr < PHYS_OFFSET)
> > > > > +                     continue;
> > > > > +
> > > > 
> > > > Is the spin table area really allocated as BOOT_SERVICES_*?
> > > 
> > > No. It is EFI_RESERVED_TYPE. But if UEFI is allowed below the kernel,
> > > then there could be BS code/data memory which we'd want to ignore.
> > 
> > Well, if it is boot service code/data - then there is no need for us
> > to keep it around after ExitBootServices().
> > 
> > /
> >     Leif
> 
> One would think, but EFI has proven to be less than strictly compliant
> in that regard in the past. I'm inclined to keep the boot services
> around until after SetVirtualAddressMap just in case.

Why should we add a work around for a potential bug that doesn't exist
yet?

That just provides fertile ground for such a bug to spring into
existence and for people to ignore it when bringing up their SoC. The
comment doesn't explain the rationale and the code doesn't make sense
given a sane implementation.

For the moment it's better to be strict, IMO. Otherwise there are plenty
of other potential bugs we could attempt to work around to enable people
to write firmware with even lower standards...

If we have to work around something then we should have an actual issue
to work around first.

Thanks,
Mark.
