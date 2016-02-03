From: tony@atomide.com (Tony Lindgren)
Date: Wed, 3 Feb 2016 09:01:28 -0800
Subject: PM regression with commit 5de85b9d57ab PM runtime re-init in
 v4.5-rc1
In-Reply-To: <CAPDyKFoNY8xP11n6mFVicYwdy49sB4=H0fTm53754HukFX4HBQ@mail.gmail.com>
References: <CAPDyKFpNRc3Nf9ofXhZrfBa54vXMxWboDScCrYFrZy97m8Y5gg@mail.gmail.com>
 <Pine.LNX.4.44L0.1602031034360.2041-100000@iolanthe.rowland.org>
 <20160203160951.GF19432@atomide.com>
 <CAPDyKFoNY8xP11n6mFVicYwdy49sB4=H0fTm53754HukFX4HBQ@mail.gmail.com>
Message-ID: <20160203170128.GK19432@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ulf Hansson <ulf.hansson@linaro.org> [160203 08:25]:
> Okay, so I understand that you decided to not pick up the omap hwmod
> patch I posted.

I just suggested a solution of patching both drivers and omap_device
to make it easy for people to fix new drivers, so assuming that sounds
OK to you..

> If you want some further help in fixing the omap drivers, please just
> tell me I am at your service. :-)

Heh me too :) It's probably worth checking the non omap_device drivers
thouhg.

I can check and fix up the omap_device using drivers. So roughly it's
these ones:

$ git grep pm_runtime_use_autosuspend drivers | cut -d: -f1 | \
	sort | uniq | grep omap
drivers/i2c/busses/i2c-omap.c
drivers/mmc/host/omap_hsmmc.c
drivers/spi/spi-omap2-mcspi.c
drivers/tty/serial/8250/8250_omap.c
drivers/tty/serial/omap-serial.c

> Also, we must not forget to also update their runtime PM calls in
> their ->remove() callbacks, as those seems to suffer from the same
> problem as in the -EPROBE_DEFER case.

Yes and any sections within the driver code where clocks really
should be disabled we must use pm_runtime_put_sync_suspend() if
pm_runtime_set_autoidle() is set.

Regards,

Tony
