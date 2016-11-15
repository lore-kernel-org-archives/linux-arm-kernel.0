From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 15 Nov 2016 21:35:11 +0000
Subject: specifying order of /dev/mmcblk devices via device-tree?
In-Reply-To: <CAJ+vNU38XQBHt709S_z6Quvce6wcqLzRHFuN_bVZ_0eARa3=fw@mail.gmail.com>
References: <CAJ+vNU1g8nQedd06LeaD10YWUQ_UmdRToUMFKaTNT1aNY56b0g@mail.gmail.com>
 <20161028153755.GL5806@leverpostej>
 <CAJ+vNU26tx-1bLKNpzYJ0UCeFJ-SczZOca1dYdt5mCGDxAuKTQ@mail.gmail.com>
 <20161114190839.GS1041@n2100.armlinux.org.uk>
 <CAJ+vNU38XQBHt709S_z6Quvce6wcqLzRHFuN_bVZ_0eARa3=fw@mail.gmail.com>
Message-ID: <20161115213510.GY1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 15, 2016 at 12:27:53PM -0800, Tim Harvey wrote:
> On Mon, Nov 14, 2016 at 11:08 AM, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
> > So, someone merged a patch which makes mmcblk devices follow the
> > host controller numbering.
> >
> > Now my cubox-i fails to boot correctly because the SD card in the
> > _only_ SD card slot now gets called "mmcblk1" and not "mmcblk0".
> >
> > USDHC1 is wired to the on-microsom WiFi, and never has anything
> > remotely near a SD card or eMMC present.  So, this change is
> > confusing on these platforms.
> >
> > Moreover, this is _going_ to break SolidRun distros if people upgrade
> > their kernels.
> >
> > It may be appropriate for eMMC, but it's not appropriate everywhere.
> >
> > This is a user visible _regression_ in 4.9-rc.  Whoever did this,
> > please revert whatever change caused this, and next time limit it
> > to only eMMC.
> >
> > Thanks.
> 
> I see the same thing on newer kernels, which is why I asked the
> question. I didn't expect (or even want honestly) a non mmcblk0 boot
> device and was looking for a way to control that via dt. Now I'm
> understanding that to avoid this kind of bootloader/kernel dependence
> issue I should be using UUID's to identify the boot device.
> 
> >From my testing it looks like the change your looking for occurred
> some time ago and is somewhere between 4.5 and 4.6 and not a 4.9
> regression specifically.

That depends how you look at it.  Yes, there's a change in 4.5 to 4.6
which ties the block device number to the host device index, but that's
really only part of the story here.

4.8 definitely identifies the SD card in iMX6 usdhc2 as "mmcblk0".
4.9-rc identifies the SD card as "mmcblk1".  This makes it a 4.9 change
of behaviour - there can be no argument about that.

Now, digging further into this today, it appears that:

v4.8: usdhc2 was probed first, and is given mmc0.
      usdhc1 is probed second, and is given mmc1.

v4.9-rc: usdhc1 is probed first, and is given mmc0.
         usdhc2 is probed second, and is given mmc1.

I haven't yet been able to figure out why there's been this change
of probe order.  There's no change that I can see in the iMX6 DT
files that would account for this.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
