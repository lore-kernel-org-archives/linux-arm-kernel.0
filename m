From: tony@atomide.com (Tony Lindgren)
Date: Mon, 20 Oct 2014 15:29:43 -0700
Subject: USB Ethernet gadget on Nokia n900
In-Reply-To: <20141020220338.GA19314@amd>
References: <20141019090107.GA19132@amd> <201410191658.45851@pali>
 <20141019205033.GA4738@amd> <201410192300.20625@pali>
 <20141020130855.GA1067@amd> <20141020164542.GD5192@atomide.com>
 <20141020220338.GA19314@amd>
Message-ID: <20141020222942.GA2560@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Pavel Machek <pavel@ucw.cz> [141020 15:04]:
> On Mon 2014-10-20 09:45:42, Tony Lindgren wrote:
> > * Pavel Machek <pavel@ucw.cz> [141020 06:10]:
> > > Hi!
> > > 
> > > > My N900 can boot kernel from v3.12-rc5-n900 branch compiled with 
> > > > arch/arm/configs/rx51_defconfig. Also it can boot full Maemo5 
> > > > system (with CSSU and some minor system changes) and usb network 
> > > > via g_nokia.ko gadget working fine...
> > > > 
> > > > So if it does not working for you then kernel usb subsystem could 
> > > > have problems with using gadgets directly from zimage.
> > > 
> > > After some hand-bisecting and real-bisecting, I found two commits that
> > > cause problems for 3.13: With these reverted, I get usb networking
> > > back in 3.13 on nokia n900.
> > > 
> > > (Pali, if you revert these, you should get working usb networking in
> > > your 3.13 branch, too.)
> > > 
> > > Any ideas?
> > 
> > Hmm maybe check if current stable kernels work for you without
> > reverting anything ? Few weeks ago I did the the following two fixes
> > with cc stable v3.13+:
> > 
> > 96be39ab34b7 usb: phy: twl4030-usb: Fix regressions to runtime PM on omaps
> > 85601b8d81e2 usb: phy: twl4030-usb: Fix lost interrupts after ID pin goes down
> 
> I tried these on top of 3.14 (where my revert fixes stuff) and no, it
> does not seem to help. (Trying stable would be a bit more work).
> 
> Do you want me to try on 3.13, too?

Sounds like there's something else missing too then. Maybe give
v3.18-rc1 and device tree based boot a try?

FYI, there's some PM support there too since v3.16-rc7, so using
anything pre v3.17 is probably not fun on the battery. Well it works
with omap2plus_defconfig long as serial port timeouts are configured,
no USB cable is connected and and the screen is blanked. When it works,
both keyboard debug LEDs will go off during idle, which really should
be most of the time if you plan to use it as a phone. The left debug
LED goes off for retention idle, when both go off it's hitting
off-idle.

I'm using the following test script here, if it does not idle for
you, there are probably some other drivers loaded that currently
block deeper idle states.

Regards,

Tony

8< ---------------
#!/bin/bash

uarts=$(find /sys/class/tty/ttyO*/device/power/ -type d)
for uart in $uarts; do
        echo 3000 > $uart/autosuspend_delay_ms
        #echo -1 > $uart/autosuspend_delay_ms
done

uarts=$(find /sys/class/tty/ttyO*/power/ -type d)
for uart in $uarts; do
        echo enabled > $uart/wakeup
        echo auto > $uart/control
done

echo 255 > /sys/devices/68000000.ocp/48098000.spi/spi_master/spi1/spi1.2/backlight/acx565akm/brightness
echo 1 > /sys/devices/platform/omapfb/graphics/fb0/blank

echo 1 > /sys/kernel/debug/pm_debug/enable_off_mode
