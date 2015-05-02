From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 2 May 2015 17:12:26 +0100
Subject: Bug#782364: linux-image-3.16.0-4-armmp: please configure drivers
 for both Cubox i4pro real time clocks
In-Reply-To: <1430582464.15640.186.camel@hellion.org.uk>
References: <20150410232854.23367.58862.reportbug@cube.rcthomas.org>
 <1428710930.29665.17.camel@decadent.org.uk>
 <20150429085705.GG12732@n2100.arm.linux.org.uk>
 <1430582464.15640.186.camel@hellion.org.uk>
Message-ID: <20150502161226.GS12732@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 02, 2015 at 05:01:04PM +0100, Ian Campbell wrote:
> On Wed, 2015-04-29 at 09:57 +0100, Russell King - ARM Linux wrote:
> > On Sat, Apr 11, 2015 at 01:08:50AM +0100, Ben Hutchings wrote:
> > > If this RTC is not battery backed, it seems like it ought to be disabled
> > > in this board's device tree.
> > 
> > It's not that simple.
> > 
> > On the lower-end models, the on-SoC RTC is the only RTC there is.  If
> > it were disabled, there would be no RTC available at all, so there
> > would be no preservation of time-of-day across reboots.
> > 
> > On the Pro models, the battery backed RTC is fitted.  However, the
> > battery backed RTC has no wakeup facility.
> > 
> > Only the on-SoC RTC has that ability, so in order to perform time-based
> > wakeup, the on-SoC RTC needs to be synchronised with the current ToD
> > and its alarm set.
> > 
> > Not having the on-SoC RTC enabled means that there is no ToD based
> > wakeup possible.
> 
> So is your advice for a multi platform kernel supporting all Cubox
> devices to just enable both and to sort out any syncing/naming etc in
> userspace?

I don't see a problem locally, because I have both built in to my kernel:

hub 2-0:1.0: USB hub found
hub 2-0:1.0: 1 port detected
mousedev: PS/2 mouse device common for all mice
rtc-pcf8523 0-0068: rtc core: registered rtc-pcf8523 as rtc0
snvs_rtc 20cc034.snvs-rtc-lp: rtc core: registered 20cc034.snvs-rtc-lp as rtc1
i2c /dev entries driver

and so the battery-backed one gets the primary RTC device.

I guess the problem comes when you have them as modules, and then systemd
or udev, or whatever init daemon flavour you're using can load the modules
in a random order (or even in parallel) so you've no idea which RTC is
which.

Yes, I believe this is a userspace problem, because:

1. You need the snvs_rtc if you wish to do wakeup-by-RTC time.
2. You need pcf8523 if you want time to be preserved across power cycles.

One use case is "I want time preserved across power cycles" which means
you want the pcf8523.  Another use case is "I want to do time of day
based wakeup" in which case you need snvs_rtc.

Disabling one RTC or the other just because someone doesn't like it
really isn't a valid argument - what you're effectively saying is that
your use-case is somehow more important than other use cases, which is
grossly unfair.

Ideally, you always want the PCF8523 to be the "primary" or "default"
RTC if it is present (the one which will be used for hctosys/systohc
stuff) and fallback to snvs_rtc if it's not present.  But you also
must have snvs_rtc if we are to offer wakeup by ToD.

I'm not sure that we have any good way to expose whether a RTC is
properly wakeup-capable to userspace (in that it's an I2C RTC and we
correctly set device_can_wakeup() according to the entire system
capabilities.)  That would be a bug since in this case, it's something
that userspace needs to know so that it can program the appropriate
RTC.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
