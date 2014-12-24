From: tony@atomide.com (Tony Lindgren)
Date: Wed, 24 Dec 2014 11:04:01 -0800
Subject: [PATCH] arm: omap: reduce zImage size on omap2plus_defconfig
In-Reply-To: <20141224154948.GA423@saruman>
References: <1419271535-4057-1-git-send-email-balbi@ti.com>
 <54991A25.2030804@compulab.co.il> <20141223161936.GA9147@saruman>
 <549AA94A.8030209@compulab.co.il> <20141224154948.GA423@saruman>
Message-ID: <20141224190401.GN23854@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [141224 07:52]:
> Hi,
> 
> On Wed, Dec 24, 2014 at 01:53:46PM +0200, Igor Grinberg wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> > 
> > On 12/23/14 18:19, Felipe Balbi wrote:
> > > On Tue, Dec 23, 2014 at 09:30:45AM +0200, Igor Grinberg wrote:
> > >> Hi Felipe,
> > >>
> > >> On 12/22/14 20:05, Felipe Balbi wrote:
> > >>
> > >> [...]
> > >>
> > >>>  CONFIG_SCSI_SCAN_ASYNC=y
> > >>> -CONFIG_ATA=y
> > >>> -CONFIG_SATA_AHCI_PLATFORM=y
> > >>> -CONFIG_MD=y
> > >>> +CONFIG_ATA=m
> > >>> +CONFIG_SATA_AHCI_PLATFORM=m
> > >>
> > >> Isn't this needed for the rootfs on SATA devices?
> > > 
> > > there's no known boards with rootfs on SATA. Until then, we can reduce
> > > the size.
> > 
> > What makes you say so?
> > The decision for rootfs on SATA is taken dynamically.
> > OMAP5 boards (specifically cm-t54) can have rootfs on SATA...
> 
> I'll leave the decision to Tony. Even though they _can_, they really
> don't and IIRC, OMAP5's SATA has so many silicon errata that it'd be
> annoying to find that special device which works (e.g it can't negotiate
> lower speeds with SATA III devices and it won't support SATA I).
> 
> As of today, we don't know of anybody really shipping anything with
> rootfs on SATA and distros would rather ship initiramfs than a giant
> zImage anyway.
> 
> Tony, your call.

I think we should move omap2plus_defconfig to be mostly modular and
usable for distros as a base. Most distros prefer to build almost
everything as loadable modules. And my preference is that we should
only keep the minimum rootfs for devices and serial support as
built-in and rely on initramfs for most drivers. And slowly move
also the remaining built-in drivers to be loadable modules.

The reasons for having drivers as loadable modules are many. It
allows distros to use the same kernel for all the devices without
bloating the kernel. It makes developing drivers easier as just the
module needs to be reloaded. And loadable modules protect us from
cross-framework spaghetti calls in the kernel as the interfaces are 
clearly defined.

Are there people really using SATA as rootfs right now on omaps?

If it's only something that will be more widely used in the future,
then I suggest we make it into a loadable module, and presume
initramfs and loadable module also for any new devices. The same
way x86 has been doing with distros for years.

Regards,

Tony
