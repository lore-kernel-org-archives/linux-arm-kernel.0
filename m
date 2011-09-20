From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 20 Sep 2011 23:46:11 +0200
Subject: [GIT PULL] omap cleanup part1 for v3.2 merge window
In-Reply-To: <201109202334.43213.arnd@arndb.de>
References: <20110917014623.GC2937@atomide.com>
	<201109202334.43213.arnd@arndb.de>
Message-ID: <201109202346.11393.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 20 September 2011, Arnd Bergmann wrote:
> On Saturday 17 September 2011, Tony Lindgren wrote:
> > Hi Arnd,
> > 
> > Please pull the first part of omap cleanup from:
> > 
> > git://github.com/tmlind/linux.git cleanup
> > 
> > This series cleans up early_init functions and removes
> > CHIP_IS macro usage. This makes it easier to have SoC
> > specific init functions so adding support for new omap
> > variants does not require patching all over the place.
> 
> One more thing: my randconfig tests are running now and
> have spit out a new error after merging lost of stuff
> today:
> 
> arch/arm/mach-omap2/built-in.o: In function `omap_zoom_init':
> /home/arnd/linux-arm/arch/arm/mach-omap2/board-zoom.c:117: undefined reference to `board_nand_init'
> make[1]: *** [.tmp_vmlinux1] Error 1
> make[1]: Target `_all' not remade because of errors.
> make: *** [sub-make] Error 2
> make: Target `_all' not remade because of errors.

Found it: the offending patch is:

      omap2+: Use Kconfig symbol in Makefile instead of obj-y


It seems that you replace the #ifdef in the board-flash.c file
with a similar #ifdef in the header that replaces this with an
empty inline function when the object is not built.

	Arnd
