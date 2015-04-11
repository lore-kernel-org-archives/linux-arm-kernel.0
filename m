From: ben@decadent.org.uk (Ben Hutchings)
Date: Sat, 11 Apr 2015 01:08:50 +0100
Subject: Bug#782364: linux-image-3.16.0-4-armmp: please configure
 drivers for both Cubox i4pro real time clocks
In-Reply-To: <20150410232854.23367.58862.reportbug@cube.rcthomas.org>
References: <20150410232854.23367.58862.reportbug@cube.rcthomas.org>
Message-ID: <1428710930.29665.17.camel@decadent.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Control: severity -1 important

On Fri, 2015-04-10 at 16:28 -0700, Rick Thomas wrote:
> Package: src:linux
> Version: 3.16.7-ckt7-1
> Severity: wishlist
> Tags: newcomer
> 
> Whenever I reset my cubox-i4Pro by disconnecting the power plug, the hardware real-time-clock gets
> reset to midnight UTC, Dec 31, 1970.
> Even though the SolidRun literature says that the i4Pro has a battery backed RTC.
> 
> A bit of googling reveals that this is related to the following fact (Quoted from the SolidRun forums)
> 
> >There are two RTC inside CuBox-i 
> >1. One connected to the SNVS rail (internal i.MX6) which is not battery backed and typically goes to /dev/rtc0

If this RTC is not battery backed, it seems like it ought to be disabled
in this board's device tree.

> >2. Second is NXP PFC8523 based and that one has battery backup (/dev/rtc1)
> >SolidRun Engineering
> >user rabeeh in #cubox on Freenode IRC
> >by rabeeh  Sat Jan 25, 2014 7:04 pm 
> 
> >It's a standard non rechargeable lithium 3.3v coin cell.
> >Available only on the models that has RTC.
> >SolidRun Engineering
> >user rabeeh in #cubox on Freenode IRC
> 
> Curiously, when I look at the Debian Jessie system running on the box, I find that there is only one /dev/rtc* device,
> and that seems to be associated with the SNVS clock.  The PFC8523 clock is not available
> 
> Checking /boot/config-3.16.0-4-armmp, I see what I think is an explanation, because
> 
> # CONFIG_RTC_DRV_PCF8523 is not set
> 
> and
> 
> CONFIG_RTC_DRV_SNVS=y
> 
> Other Linux systems (e.g. Arch) appear (according to the above mentioned googling) to have their kernel compiled so as to
> provide both /dev/rtc0 attached to the SNVS clock, and /dev/rtc1 attached to the PFC8523 clock.
> 
> Would it be possible to configure the default Debian Jessie kernel to do the same?

Yes, we can do that.

> Ideally, the PFC8523 clock should show up as /dev/rtc0, linked to /dev/rtc,
> so that the battery backed clock is used by default to set the system clock at boot-time.
> Failing that, it may be possible to address this by setting HCTOSYS_DEVICE in /etc/default/hwclock appropriately.
> Or maybe one could tweak a rule in /etc/udev ?

I wonder about that.  I think it would make more sense to disable the
useless RTC so there's no need to treat this board specially in
userland.

> Karsten Merker commented via email:
> 
> Yes, that should just need enabling the appropriate module.
> The device-tree instantiates the pcf8523 clock chip:
> 
> &i2c3 {
>        pinctrl-names = "default";
>        pinctrl-0 = <&pinctrl_cubox_i_i2c3>;
> 
>        status = "okay";
> 
>        rtc: pcf8523 at 68 {
>                compatible = "nxp,pcf8523";
>                reg = <0x68>;
>        };
> };
> 
> So if the module is available, it should be loaded automatically.
> 
> Please file a wishlist bug against "Source: linux, Version: 
> 3.16.7-ckt9-1" so that the kernel maintainers can enable the
> module for the next kernel upload.

Actually we consider missing hardware support as severity 'important'.

Ben.

-- 
Ben Hutchings
compatible: Gracefully accepts erroneous data from any source
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 811 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150411/6fa7f376/attachment-0001.sig>
