From: tony@atomide.com (Tony Lindgren)
Date: Tue, 20 Sep 2011 15:33:12 -0700
Subject: [GIT PULL] omap cleanup part1 for v3.2 merge window
In-Reply-To: <201109202346.11393.arnd@arndb.de>
References: <20110917014623.GC2937@atomide.com>
	<201109202334.43213.arnd@arndb.de>
	<201109202346.11393.arnd@arndb.de>
Message-ID: <20110920223311.GK2937@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [110920 14:12]:
> On Tuesday 20 September 2011, Arnd Bergmann wrote:
> > 
> > One more thing: my randconfig tests are running now and
> > have spit out a new error after merging lost of stuff
> > today:

Good to hear you got "arndconfig" running :)

Do you think we could also add support for something
like this:

$ echo CONFIG_ARCH_OMAP=y > .config
$ make randconfig

or

$ make --force=CONFIG_ARCH_OMAP randconfig

Where randconfig would keep the forced CONFIG_ARCH_OMAP
static while randomly selecting the others?

This would allow targeted randconfig for each patch more
or less..
 
> > arch/arm/mach-omap2/built-in.o: In function `omap_zoom_init':
> > /home/arnd/linux-arm/arch/arm/mach-omap2/board-zoom.c:117: undefined reference to `board_nand_init'
> > make[1]: *** [.tmp_vmlinux1] Error 1
> > make[1]: Target `_all' not remade because of errors.
> > make: *** [sub-make] Error 2
> > make: Target `_all' not remade because of errors.
> 
> Found it: the offending patch is:
> 
>       omap2+: Use Kconfig symbol in Makefile instead of obj-y
> 
> 
> It seems that you replace the #ifdef in the board-flash.c file
> with a similar #ifdef in the header that replaces this with an
> empty inline function when the object is not built.

Oops. I'll do a fix for that. Those should be now inline
functions in the header.

As various other omap branches are based on the cleanup I'd
rather not go mess with the original patch unless you insist.

Regards,

Tony
