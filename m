From: balbi@ti.com (Felipe Balbi)
Date: Mon, 28 Apr 2014 18:58:16 -0500
Subject: [PATCH v18 3/4] ata: Add APM X-Gene SoC AHCI SATA host
 controller driver
In-Reply-To: <CAPw-ZTmGA5rtVmHx5jZedkey2iJD7L+3-905W=4G4rAJ=BeWgA@mail.gmail.com>
References: <1394841201-29495-1-git-send-email-lho@apm.com>
 <1394841201-29495-3-git-send-email-lho@apm.com>
 <1394841201-29495-4-git-send-email-lho@apm.com>
 <201403151019.49316.arnd@arndb.de>
 <CAPw-ZTksg3z8GY55jb7-yP1wfq2BF6apB9KBgbokpshKbiiAaw@mail.gmail.com>
 <CAPw-ZTmGA5rtVmHx5jZedkey2iJD7L+3-905W=4G4rAJ=BeWgA@mail.gmail.com>
Message-ID: <20140428235816.GC18010@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 28, 2014 at 04:12:02PM -0700, Loc Ho wrote:
> Hi Kishon/Felipe,
> 
> > >> This patch adds support for the APM X-Gene SoC AHCI SATA host controller
> > >> driver. It requires the corresponding APM X-Gene SoC PHY driver. This
> > >> initial version only supports Gen3 speed.
> > >
> > > This version seems workable, thanks for the quick follow-up.
> > >
> > > The comment about Gen3 speed above reminds me that you took some
> > > shortcuts to get here and you removed support for some features
> > > as well as some bug workarounds in the process. I'm guessing some
> > > of them won't be necessary because they are only for prototype
> > > hardware or for early boot loader versions that don't yet set up
> > > the hardware right, but others actually need to come back.
> > >
> > > That is usually a good approach, but I'd also like to make sure we can
> > > deal with them nicely when you have to add them back later, and don't
> > > have to add ugly extensions to the DT binding to support the old dtb
> > > files.
> > >
> > > Can you list (also in the changelog) the parts of the driver that you
> > > have taken out for now and that you expect to add back at later
> > > stage? I think that would be helpful for perspective.
> > >
> >
> > Here is an list of patches that we will be preparing for once the
> > basic driver is completed. Do you want me to re-generate the patch
> > change log with this info?
> >
> > 1. Support for Gen1/Gen2/Gen3
> > Solution: The simplest solution is to have the PHY framework support
> > setting the desire speed. I had argued with the TI folks but they are
> > reluctant to add this function to the framework. They argued that this
> > is still not generic enough. I will start the discussion again later
> > on. The other possibility (but not sure if this is doable) is to have
> > the PHY init function to be smarter and do the necessary operation
> > assuming the underlying PHY is capable in detecting the link up speed.
> > I will need to check the spec of this.
> 
> 
> In order for the X-Gene SATA PHY to support SATA Gen1 and Gen2 speed,
> we need an method to instruct the underlying PHY driver to switch to
> an specified setting after link up. For this errata, Suman Tripathi
> had submitted the patch [1]. It is not possible to hide this within
> the PHY driver. Each instance of the PHY driver controls two ports. By
> calling the exit function and then init function, it will affect the
> other ports - which is not the correct behavior. At this point, we
> don't see any solution besides introduce an PHY framework function
> set_rate. Can you let us know if this solution is acceptable?
> 
> [1] https://lkml.org/lkml/2014/4/18/491

that 'lane' argument isn't acceptable. If one PHY talks to two Links,
your PHY driver should register two providers, then the lane argument
can be ignored.

Rate can be reused for different things depending on the underlying Bus;
in case of USB, it could be for switching among
Superspeed10/Superspeed5Highspeed; or 1Gbit/100Mbit switch on Networking
interfaces; or Gen1/2/3 selection for PCI controllers and so on. The
only thing I can't find a way to abstract is that 'lane' argument which
isn't even specific to SATA, it's particular to how you guys wrote your
driver. Should you have one PHY per SATA link, you wouldn't have added
that 'lane' argument at all.

cheers

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140428/cf8a8180/attachment.sig>
