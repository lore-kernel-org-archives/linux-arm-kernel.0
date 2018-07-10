From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 10 Jul 2018 14:36:49 +0200
Subject: [PATCH v4] driver core: add a debugfs entry to show deferred
 devices
In-Reply-To: <20180710100152.bb562zgbv7yimb7r@earth.universe>
References: <20180708133459.24883-1-javierm@redhat.com>
 <20180710100152.bb562zgbv7yimb7r@earth.universe>
Message-ID: <20180710123648.GA4227@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > With Device Trees (DT), the dependencies of the devices are defined in the
> > DT, then the drivers parse that information to lookup the needed resources
> > that have as dependencies.
> > 
> > Since drivers and devices are registered in a non-deterministic way, it is
> > possible that a device that is a dependency has not been registered yet by
> > the time that is looked up.
> > 
> > In this case the driver that requires this dependency cannot probe and has
> > to defer it. So the driver core adds it to a list of deferred devices that
> > is iterated again every time that a new driver is probed successfully.
> > 
> > For debugging purposes it may be useful to know what are the devices whose
> > probe function was deferred. Add a debugfs entry showing that information.
> > 
> >   $ cat /sys/kernel/debug/devices_deferred
> >   48070000.i2c:twl at 48:bci
> >   musb-hdrc.0.auto
> >   omapdrm.0
> > 
> > This information could be obtained partially by enabling debugging, but it
> > means that the kernel log has to be parsed and the probe deferral balanced
> > with the successes. This can be error probe and has to be done in a ad-hoc
> > manner by everyone who needs to debug these kind of issues.
> > 
> > Since the information is already known by the kernel, just show it to make
> > it easier to debug.
> > 
> > Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Reviewed-by: Mark Brown <broonie@kernel.org>
> 
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

Thanks for doing this.

Note that it rejects on current -rc4, but solution is trivial.

Tested-by: Pavel Machek <pavel@ucw.cz>

Unfortunately, it does not help with pwm problem on Droid4, as nothing
is deffered:

user at devuan:/sys/bus/platform/drivers$ cat
/sys/kernel/debug/devices_deferred
user at devuan:/sys/bus/platform/drivers$

									Pavel



-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180710/8cb18740/attachment.sig>
