From: r.schwebel@pengutronix.de (Robert Schwebel)
Date: Mon, 26 Jul 2010 08:56:11 +0200
Subject: ARM Machine SoC I/O setup and PAD initialization code
In-Reply-To: <AANLkTin=uThThNaUxCP4qEJjO2TYMzpHfmZ6jLokQxCD@mail.gmail.com>
References: <201007211029.29529.david.jander@protonic.nl>
	<201007221531.58744.david.jander@protonic.nl>
	<20100722142043.GK4737@rakim.wolfsonmicro.main>
	<201007231218.07379.david.jander@protonic.nl>
	<20100723141712.GC12300@rakim.wolfsonmicro.main>
	<61396.213.84.91.226.1279910330.squirrel@protonic.xs4all.nl>
	<20100723210347.GO20855@pengutronix.de>
	<AANLkTin=uThThNaUxCP4qEJjO2TYMzpHfmZ6jLokQxCD@mail.gmail.com>
Message-ID: <20100726065611.GR20855@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 26, 2010 at 10:37:20AM +0900, Magnus Damm wrote:
> On Sat, Jul 24, 2010 at 6:03 AM, Robert Schwebel
> <r.schwebel@pengutronix.de> wrote:
> > kexec is a good idea only in theory. Last time we tried it, it
> > needed something like 6 s additional boot time. Inacceptable - we
> > bring Qt based GUI systems into the application in 6 s, and
> > automotive systems into userspace in 336 ms. Not to mention that the
> > first kernel needs to be brought up as well.
>
> I disagree with your "in theory only" stamp on kexec. I've used kexec
> for rebooting and crash dumping on i386, x86_64, ia64, ARM and SH.

That's a good usecase, I agree.

> The two presentations pointed out earlier in this thread clearly show
> how to build kexec based boot loaders which boot in one second. The
> overhead of kexec itself is almost nothing. I'm sure you can discuss
> the details of the kexec implementation with Eric Biederman if you'd
> like.

We'll re-do the tests, in order to measure some hard facts. It may turn
out that we have learned more things since we made the last numbers :)

> That aside, the 6 s number looks familiar from earlier Barebox
> presentations that I've eyed through before. When did you test it? Do
> you remember what platform and which kernel version? Are you using a
> full Gnome desktop in your boot loader? =)

On MX35 we boot a naked kernel into a custom /sbin/init application in
336 ms with barebox, starting the measurement at the first assembler
instruction which can be influenced in software.

I think it's a question of what you want to have. The 6 s boot is with:

- Barebox from NAND
- booting the kernel from NAND
- kernel config with everything built in which is needed in the system
- init based userspace
- dbus + some related services
- Qt
- system based on ipkg packages

and it is measured up to the point where the qt application is fully
operational.

> From my point of view it always makes sense to optimize the kernel
> boot up time. This because it will improve the start up time of your
> final kernel _and_ your boot loader as well if you use kexec.

Seconded. What can be done in the kernel should be done in the kernel.

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
