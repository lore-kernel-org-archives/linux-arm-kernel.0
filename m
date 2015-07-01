From: tony@atomide.com (Tony Lindgren)
Date: Wed, 1 Jul 2015 03:34:22 -0700
Subject: n900 in 4.2-rc0: repeating oopses
In-Reply-To: <20150701095954.GD7969@amd>
References: <20150416093234.GA17423@amd> <20150629091146.GA5103@amd>
 <20150630092404.GA19285@amd> <20150630095310.GF27720@pali>
 <20150701065932.GS4156@atomide.com> <20150701072255.GA17577@pali>
 <20150701095954.GD7969@amd>
Message-ID: <20150701103421.GV4156@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Pavel Machek <pavel@ucw.cz> [150701 03:02]:
> On Wed 2015-07-01 09:22:55, Pali Roh?r wrote:
> > On Tuesday 30 June 2015 23:59:33 Tony Lindgren wrote:
> > > * Pali Roh?r <pali.rohar@gmail.com> [150630 02:55]:
> > > > 
> > > > I will try 4.2 at the end of week.
> > > 
> > > At least today's 4.1.0-11549-g05a8256 boots just fine on my n900.
> > > 
> > > Regards,
> > > 
> > > Tony
> > 
> > So, Pavel can you re-test? Maybe there can be problem with some driver
> > which Tony did not compiled into zImage? Just speculation...
> 
> I re-tested with today's git, and it seems to boot. Thanks for help...

OK good to hear.
 
> Now. "echo mem > /sys/power/state" is broken, as in "returns
> immediately in about 50% cases". The messages are
> 
> Powerdomain (per_pwrdm) didn't enter target state 1
> Powerdomain (core_pwerdm) didn't enter target state 1
> 
> Any ideas? Thanks,

Works for me after enabling the idle timeouts with the following
script and blanking the screen and disconnecting USB:

Also both keyboard LEDs should start blinking after the idle
timeout with screen blanked and USB disconnected. If not, you
have some module loaded that blocks the deeper idle states.

Regrads,

Tony

8< ----
#!/bin/bash

modprobe leds-gpio
modprobe ledtrig-default-on

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

echo 255 > /sys/class/backlight/acx565akm/brightness
echo 1 > /sys/devices/platform/omapfb/graphics/fb0/blank

echo 1 > /sys/kernel/debug/pm_debug/enable_off_mode
