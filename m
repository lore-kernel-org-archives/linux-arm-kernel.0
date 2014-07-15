From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Tue, 15 Jul 2014 14:54:19 +0100
Subject: [PATCH] efi/arm64: efistub: don't abort if base of DRAM is
 occupied
In-Reply-To: <1405429860.25580.25.camel@deneb.redhat.com>
References: <1405351521-12010-1-git-send-email-ard.biesheuvel@linaro.org>
 <1405363248.25580.12.camel@deneb.redhat.com>
 <20140715100221.GU4179@bivouac.eciton.net>
 <1405429860.25580.25.camel@deneb.redhat.com>
Message-ID: <20140715135418.GV4179@bivouac.eciton.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 15, 2014 at 09:11:00AM -0400, Mark Salter wrote:
> On Tue, 2014-07-15 at 11:02 +0100, Leif Lindholm wrote:
> > > @@ -273,6 +282,10 @@ static void __init free_boot_services(void)
> > >                       continue;
> > >               }
> > >  
> > > +             /* Don't free anything below kernel */
> > > +             if (md->phys_addr < PHYS_OFFSET)
> > > +                     continue;
> > > +
> > 
> > Is the spin table area really allocated as BOOT_SERVICES_*?
> 
> No. It is EFI_RESERVED_TYPE. But if UEFI is allowed below the kernel,
> then there could be BS code/data memory which we'd want to ignore.

Well, if it is boot service code/data - then there is no need for us
to keep it around after ExitBootServices().

/
    Leif
