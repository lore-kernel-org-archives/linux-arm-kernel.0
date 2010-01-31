From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 31 Jan 2010 10:28:29 +0100
Subject: [PATCH] staging/dream: add missing include files/fix compilation
In-Reply-To: <20100131084421.GG2238@elf.ucw.cz>
References: <20091225205917.GA25761@elf.ucw.cz>
	<20100115002419.GA25643@kroah.com>
	<20100119054516.GB22153@elf.ucw.cz>
	<1263914079.1951.43.camel@m0nster>
	<20100131084421.GG2238@elf.ucw.cz>
Message-ID: <20100131092829.GJ2238@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > > > > This adds missing include files, so it should now compile. ifdef
> > > > > guards were added to Kconfig, so it should not cause problems on
> > > > > non-arch-msm machines.
> > > > > 
> > > > > Signed-off-by: Pavel Machek <pavel@ucw.cz>
> > > > 
> > > > Odd, this doesn't apply to the linux-next tree, some of the files are
> > > > already there.
> > > 
> > > Strange, it seems it is almost all already in. Well, good :-).
> > > 
> > > But there's small problem. linux-next now contains dwalker's tree, and
> > > I could not get it to compile, even with staging disabled. I'll need
> > > to look into that.
> > 
> > I worked on it a little, but I won't have time to really start cleaning
> > up that tree till next week, or this weekend.
> > 
> > I pushed a new tree for next that should compile for dream with the
> > attached config. I also included the patch that I added to get it to
> > compile (you'll need the machine types too which I didn't include).
> 
> Thanks! I checked out linux-next version, and it seems to include
> 
> > commit cdf6c137865357112aa31666b65b938ab29fa736
> >     msm: compile fixes for dream.
> 
> this patch. It still fails with:
> 
> arch/arm/mach-msm/rpc_hsusb.c: In function 'msm_chg_rpc_connect':
> arch/arm/mach-msm/rpc_hsusb.c:156: error: implicit declaration of
> function 'machine_is_msm7201a_surf'
> arch/arm/mach-msm/rpc_hsusb.c:156: error: implicit declaration of
> function 'machine_is_msm7x27_surf'
> arch/arm/mach-msm/rpc_hsusb.c:157: error: implicit declaration of
> function 'machine_is_qsd8x50_surf'
> make[1]: *** [arch/arm/mach-msm/rpc_hsusb.o] Error 1
> make: *** [arch/arm/mach-msm] Error 2
> 
> (and similar error further down). This fixes it, but you probably want
> to add machine_is_* to your git. (Aha, is that what you meant by
> "machine types"?
> 
> With this patch it compiles.

Ok, it compiles, but I do not see it booting. You config has:

CONFIG_MSM_DEBUG_UART=3
# CONFIG_MSM_DEBUG_UART_NONE is not set
# CONFIG_MSM_DEBUG_UART1 is not set
# CONFIG_MSM_DEBUG_UART2 is not set
CONFIG_MSM_DEBUG_UART3=y
...
CONFIG_DEBUG_LL=y
CONFIG_EARLY_PRINTK=y

set, so I'd expect it to say something on the serial line... (right?
Or do I still need to patch printk.c to get that?). And I see nothing
:-(.

I'm using

./fastboot -c "console=ttyMSM2 root=/dev/mmcblk0p1 rootdelay=5 fbcon=rotate:1" boot /data/l/linux-dwalker/arch/arm/boot/zImage

...with different kernel, it works (as in "I get most of the boot on
serial line; it will not actually mount root").
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
