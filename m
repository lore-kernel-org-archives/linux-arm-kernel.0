From: horms@verge.net.au (Simon Horman)
Date: Tue, 5 Mar 2013 11:05:30 +0900
Subject: [PATCH v4 2/3] ARM: mach-shmobile: r8a7779: add SATA support
In-Reply-To: <CANqRtoR2kZ2+GfVqPc0EbO2+4AFvvXtugQAyZX1RC3=qRT2HEA@mail.gmail.com>
References: <201302272339.15402.sergei.shtylyov@cogentembedded.com>
 <20130301014148.GB9232@quad.lixom.net>
 <20130301072345.GD14376@verge.net.au>
 <CANqRtoR2kZ2+GfVqPc0EbO2+4AFvvXtugQAyZX1RC3=qRT2HEA@mail.gmail.com>
Message-ID: <20130305020529.GH16128@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 05, 2013 at 10:28:09AM +0900, Magnus Damm wrote:
> Hi Simon
> 
> On Fri, Mar 1, 2013 at 4:23 PM, Simon Horman <horms@verge.net.au> wrote:
> > On Thu, Feb 28, 2013 at 05:41:48PM -0800, Olof Johansson wrote:
> >> On Wed, Feb 27, 2013 at 11:39:14PM +0300, Sergei Shtylyov wrote:
> >> > From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> >> >
> >> > Add SATA clock for r8a7779 SoC (for both device tree and usual cases).
> >> > Register SATA controller as a "late" platform device on r8a7779 SoC.
> >>
> >> Hi,
> >>
> >> If you have the a binding in the device tree (which you do through patch 1/3),
> >> then there's no reason to have a platform device for it.
> >
> > Hi Olof,
> >
> > the DT exists but currently the marzen board brings up all
> > of its devices using platform devices. Which if nothing else is
> > internally consistent.
> >
> > I suppose it would be possible to add a call to
> > r8a7779_add_standard_devices_dt() and have the board bring
> > up this device using DT and the rest using platform drivers
> > (until the drivers are migrated to DT).
> >
> > Would that be your preferred option?
> >
> > Magnus, how do you feel about this idea?
> 
> I fail to see the upside I'm afraid.
> 
> I believe the best way forward is for us to keep on following the same
> style as we have done so far. So for drivers they should begin by
> interfacing as regular platform devices drivers and then add DT
> support incrementally. This allows us to try out things in a non-ABI
> kind of way and it also allows us to add support for various hardware
> feature that do not yet support DT like in the case of DMA Engine.
> With platform devices we can also use the driver with the SH
> architecture.

Sure, but in this case the DT bindings are set (by virtue of having been
merged) and it is my understanding that they offer the same features as
the platform device.

As it is a new device driver I lean towards Olof's suggestion.

> You can of course do some mixed DT and platform device support on a
> board-level, but I don't really see what would be good about it.
> Actually, I believe that will just make things overly complicated
> without giving us the possibility to try out certain experimental
> features with platform-device-only interface.

I think that what would be good about it is:

* The DT code would be exercised by people using the default board file.
* The platform device would not need to be added.

> Of course Simon, if you prefer to follow your proposal above then go
> ahead. However, please consider the case when this code will be back
> ported to LTSI-3.4.

With regards to backporting, the platform driver patch still exists
(e.g. on the ML) so it can be used for backporting as needed.
