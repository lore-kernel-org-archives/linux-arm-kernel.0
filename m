From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 14 Nov 2016 19:08:40 +0000
Subject: specifying order of /dev/mmcblk devices via device-tree?
In-Reply-To: <CAJ+vNU26tx-1bLKNpzYJ0UCeFJ-SczZOca1dYdt5mCGDxAuKTQ@mail.gmail.com>
References: <CAJ+vNU1g8nQedd06LeaD10YWUQ_UmdRToUMFKaTNT1aNY56b0g@mail.gmail.com>
 <20161028153755.GL5806@leverpostej>
 <CAJ+vNU26tx-1bLKNpzYJ0UCeFJ-SczZOca1dYdt5mCGDxAuKTQ@mail.gmail.com>
Message-ID: <20161114190839.GS1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So, someone merged a patch which makes mmcblk devices follow the
host controller numbering.

Now my cubox-i fails to boot correctly because the SD card in the
_only_ SD card slot now gets called "mmcblk1" and not "mmcblk0".

USDHC1 is wired to the on-microsom WiFi, and never has anything
remotely near a SD card or eMMC present.  So, this change is
confusing on these platforms.

Moreover, this is _going_ to break SolidRun distros if people upgrade
their kernels.

It may be appropriate for eMMC, but it's not appropriate everywhere.

This is a user visible _regression_ in 4.9-rc.  Whoever did this,
please revert whatever change caused this, and next time limit it
to only eMMC.

Thanks.

On Fri, Oct 28, 2016 at 09:45:00AM -0700, Tim Harvey wrote:
> On Fri, Oct 28, 2016 at 8:37 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Fri, Oct 28, 2016 at 08:23:04AM -0700, Tim Harvey wrote:
> >> Greetings,
> >>
> >> I have an IMX6 board that has the following:
> >> sdhc1: mmc0: sdio radio
> >> sdhc2: mmc1: /dev/mmcblk1: microSD connector
> >> sdhc3: mmc2: /dev/mmcblk2: on-board eMMC
> >>
> >> I would like to have sdhc3 registered as /dev/mmcblk0 and sdhc2
> >> registered as /dev/mmcblk1 so that permanent storage is the first
> >> mmcblk device as I think this is more intuitive however currently
> >> these get instanced in the order they appear in the imx6qdl.dtsi
> >> device-tree configuration and are not able to be mapped the way I want
> >> them in my dts file.
> >>
> >> Is there a way, or if not is there a desire for a way, to specify the
> >> order of /dev/mmcblk devices via device-tree?
> >
> > As with many other devices, there is no standard way of controlling the
> > Linux enumeration (and given the ID space is shared with other dynamic
> > devices it's not something that could generally work).
> >
> > These should be refererd to by UUID if possible.
> >
> > If not, we could cosider adding a by-dt-path or something like that.
> >
> > Thanks,
> > Mark.
> 
> Mark / Javier/ Fabio,
> 
> Thanks - this is very useful.
> 
> Yes, I agree that using UUID's is the way to go and now I see how that
> can be easily accessed via uboot 'part' command.
> 
> Regards,
> 
> Tim
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
