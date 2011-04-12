From: george@znau.edu.ua (George Kashperko)
Date: Tue, 12 Apr 2011 22:12:29 +0300
Subject: [RFC][PATCH] axi: add AXI bus driver
In-Reply-To: <BANLkTi=0sM2+nPYyd09G=Uy9rcEvaFErnA@mail.gmail.com>
References: <1302566227-23788-1-git-send-email-zajec5@gmail.com>
	<20110412133633.GR15130@legolas.emea.dhcp.ti.com>
	<1302634039.14216.10.camel@dev.znau.edu.ua>
	<BANLkTi=0sM2+nPYyd09G=Uy9rcEvaFErnA@mail.gmail.com>
Message-ID: <1302635550.14216.21.camel@dev.znau.edu.ua>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> 2011/4/12 George Kashperko <george@znau.edu.ua>:
> >
> >> Hi,
> >>
> >> On Tue, Apr 12, 2011 at 01:57:07AM +0200, Rafa? Mi?ecki wrote:
> >> > Cc: Michael B?sch <mb@bu3sch.de>
> >> > Cc: Larry Finger <Larry.Finger@lwfinger.net>
> >> > Cc: George Kashperko <george@znau.edu.ua>
> >> > Cc: Arend van Spriel <arend@broadcom.com>
> >> > Cc: linux-arm-kernel at lists.infradead.org
> >> > Cc: Russell King <rmk@arm.linux.org.uk>
> >> > Cc: Arnd Bergmann <arnd@arndb.de>
> >> > Cc: Andy Botting <andy@andybotting.com>
> >> > Cc: linuxdriverproject <devel@linuxdriverproject.org>
> >> > Cc: linux-kernel at vger.kernel.org <linux-kernel@vger.kernel.org>
> >> > Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
> >> > ---
> >> > V2: Rename to axi
> >> >     Use DEFINE_PCI_DEVICE_TABLE in bridge
> >> >     Make use of pr_fmt and pr_*
> >> >     Store core class
> >> >     Rename bridge to not b43 specific
> >> >     Replace magic 0x1000 with BCMAI_CORE_SIZE
> >> >     Remove some old "ssb" names and defines
> >> >     Move BCMAI_ADDR_BASE def
> >> >     Add drvdata field
> >> > V3: Fix reloading (kfree issue)
> >> >     Add 14e4:0x4331
> >> >     Fix non-initialized struct issue
> >> >     Drop useless inline functions wrappers for pci core drv
> >> >     Proper pr_* usage
> >> > V3.1: Include forgotten changes (pr_* and include related)
> >> >     Explain why we dare to implement empty release function
> >>
> >> I'm not sure we need this. If you have an IP Core which talks AXI and
> >> you want to put it on a PCI bus, you will have a PCI Bus wrapper around
> >> that IP Core, so you should go and let the kernel know about that. See
> >> [1] for a core IP which talks AXI and [2] for a PCI bus glue layer.
> >>
> >> Besides, if you introduce this bus layer, it'll be more difficult for
> >> other licensees of the same core to re-use the same driver, since it's
> >> now talking a PCI emulated on top of AXI. The same can be achieved with
> >> the platform_bus which is more widely used, specially on ARM SoCs.
> >>
> >> [1] http://gitorious.org/usb/usb/blobs/dwc3/drivers/usb/dwc3/core.c
> >> [2] http://gitorious.org/usb/usb/blobs/dwc3/drivers/usb/dwc3/dwc3-haps.c
> >>
> >
> > Already noticed earlier that AXI isnt really good name for
> > Broadcom-specific axi bus customization. As of tech docs available from
> > arm, corelink AXI cores use own identification registers which feature
> > different format and layout comparing to that we use for Broadcom cores.
> >
> > Maybe there is something "standartized" by the DMP specs? If so I'm
> > curious if that DMP is obligatory for every axi bus ?
> >
> > Naming particular Broadcom's implementation just axi limits other
> > licensees in reusing axi bus name/code or will require hacks/workarounds
> > from them to fit Broadcom-like core scanning/identificating techniques.
> > You use bus named AXI to group and manage Broadcom cores, while never
> > even publish device records for native axi cores Broadcom use to talk to
> > the interconnect through. Yet again, something like bcmb/bcmai looks
> > like better name for this bus.
> 
> I don't know, I'm really tired of this. Earlier I was told to not use
> anything like bcmai, because it is not Broadcom specific. Now it seems
> (and I'm afraid I agree) there is quite a lot of Broadcom specific
> stuff.
Well, _if_ that "magic" EROM core layout is arm's "standard" for axi
ports identification _and_ _if_ that EROM core is obligatory axi
component then sure axi name is good one as soon as you consider
registering master port (agent) cores with device subsystem as well.
I have no clue here about how resolve those _if_'s, hopefully Broadcom
guys can enlighten us on the subject.

> 
> 
> > Also can't figure out how is this implementation supposed to manage
> > multicore devices.
> 
> We have got ideas, but let's first find (wait for) such a device ;)
bcm4716 usb host ? Don't really know if there are any other multicores.

> 
> 
> > Any plans on embeddables' support ?
> 
> Sure, if noone will come before me, I'll try to provide support for
> embedded devices. However basic support for PCI host in higher on my
> priority list. First I want to know it is working at all ;)
> 

Have nice day,
George
