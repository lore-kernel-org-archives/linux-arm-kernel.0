From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 22 Jun 2015 18:23:48 +0000
Subject: SERIAL_OF_PLATFORM default setting for DT headless systems
In-Reply-To: <1434995000.5657.42.camel@dolka.fr>
References: <97db3502cd014faf1c710b1cc0fe8848@dolka.fr>
 <55827D64.1090307@free-electrons.com>
 <1434678624.4767.22.camel@dolka.fr>
 <5583E1D9.2010002@free-electrons.com>
 <20150619114152.GA2936@io.lakedaemon.net>
 <1434760119.5177.6.camel@dolka.fr> <20150620143609.GE1116@lunn.ch>
 <1434908164.5657.15.camel@dolka.fr>
 <20150621200757.GA12665@lunn.ch>
 <1434995000.5657.42.camel@dolka.fr>
Message-ID: <20150622182348.GP2936@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 22, 2015 at 07:43:20PM +0200, Benjamin Cama wrote:
> Le dimanche 21 juin 2015 ?? 22:07 +0200, Andrew Lunn a ??crit :
> > On Sun, Jun 21, 2015 at 07:36:04PM +0200, Benjamin Cama wrote:
> > > Le samedi 20 juin 2015 ?? 16:36 +0200, Andrew Lunn a ??crit :
> > > > > 
> > > > > > SERIAL_OF_PLATFORM?
> > > > > 
> > > > > Oh, and that was it!
> > > > 
> > > > This used to catch us all out a lot. What configuration are you using?
> > > > orion5x_defconfig? Very likely a patch adding it to that would be
> > > > accepted.
> > > 
> > > None. Sorry, I am used to the x86 world where I almost never used
> > > default configs (and it's been a long time, too). I admit I never fully
> > > understood the logic behind the defconfigs, apart from it meaning some
> > > kind of ???less important??? dependency on some specific options. Shouldn't
> > > the main UART be a ???hard??? dependency on every board?!
> > 
> > You say you are from the x86 world. When did you last use a serial
> > console on an x86?
> 
> Almost daily on my headless VMs ;-) But more seriously, yes, this is
> very uncommon today. But on x86 you have virtual terminals on your
> graphic output; NAS boxes don't have them (well, maybe some high-end
> model, but it is uncommon).
> 
> > Anyway, the thinking at the time was that for most
> > NAS boxes, there is no DB-9 on the back. You have to open up the case,
> > and connect to a header, or even solder wires to the board, in order
> > to use a TTL-Serial converter. Very few people actually do that, so
> > why make the kernel a bit bigger?
> 
> Is this really a size problem? Because having a serial port on a
> *headless* machine is the most useful thing I can think of. So, to me,
> this option should definitely be activated on headless systems by
> default, even if the kernel grows a bit because of it. But I agree that
> it is useless without some advanced access to the serial port, which is
> not very common. OTOH, I think only people who have such access run non
> -stock kernels (i.e. the very one we are integrating right here,
> because vendors don't care after they shipped their device).
> 
> > But we have moved on since then, mostly because we ourselves have
> > forgotten this option too many times. We have SERIAL_OF_PLATFORM
> > enabled in the _defconfig.
> 
> That is nice to have it in the defconfig, thanks for that. But I really
> think one should consider again having some dependency on it for some
> headless platforms. I would really like to have other arguments against
> my view apart from size problems.

Well, it really comes down to the roles for Kconfig vice defconfigs.  If
we say a driver or a board 'selects' or 'depends' on something, then we
are saying either "The build will break without it", or "The board will
fail to boot without it".  Neither is true for SERIAL_OF_PLATFORM.

The defconfigs have a much looser accepted definition of "a generally
minimal, but useful set of features for an SoC, platform or
multi-platform".

Since the Kconfigs make something a hard requirement for *all* users, we
try to avoid setting those unless necessary.  I know I can't predict all
the various usecases for an arm kernel, so we try to avoid forcing
decisions on users.

The defconfigs fill the gap nicely because a user can start with a
defconfig, then enable/disable features according to their specific
use-case.

As for arguments other than size (which I think is a good one, but
still), I like security posture.  I have implemented several systems,
where the design criteria was to remove everything not actually in use.
The serial port driver was one of many features removed from the system.
The physical serial port remained if we needed to run the debug image on
a board.  If SERIAL_OF_PLATFORM was a depend, then I would have had to
carry yet another patch outside of mainline.

thx,

Jason.
