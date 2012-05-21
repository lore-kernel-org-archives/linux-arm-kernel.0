From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 21 May 2012 11:35:59 -0400
Subject: [PATCH] arm: Add basic support for new Marvell Armada SoC family
In-Reply-To: <20120521093042.GE25344@n2100.arm.linux.org.uk>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <alpine.LFD.2.02.1205192042140.13185@xanadu.home>
 <20120520095502.GB25344@n2100.arm.linux.org.uk>
 <201205201058.38144.arnd@arndb.de>
 <20120520111025.GC25344@n2100.arm.linux.org.uk>
 <20120521013050.GL24238@titan.lakedaemon.net>
 <20120521093042.GE25344@n2100.arm.linux.org.uk>
Message-ID: <20120521153559.GN24238@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 21, 2012 at 10:30:42AM +0100, Russell King - ARM Linux wrote:
> On Sun, May 20, 2012 at 09:30:50PM -0400, Jason Cooper wrote:
> > On Sun, May 20, 2012 at 12:10:25PM +0100, Russell King - ARM Linux wrote:
> > > On Sun, May 20, 2012 at 10:58:37AM +0000, Arnd Bergmann wrote:
> > > > On Sunday 20 May 2012, Russell King - ARM Linux wrote:
> > > > > And try to avoid putting anything in the include/mach/ directory which
> > > > > isn't needed by any code outside of arch/arm/{plat,mach}-* directory.
> > > > > 
> > > > > In other words, headers needed only for code in arch/arm/plat-mvvebu/
> > > > > should be in that very same directory.
> > > > 
> > > > Ok, so let me make sure I got it all right:
> > > > 
> > > > * all *.c files that are used for multiple boards go to plat-mvebu
> > > > * all *-setup.c files go to mach-mvebu
> > > > * only headers that are used outside of {mach,plat}-mvebug go to
> > > >   plat-mvebu/include/mach
> > 
> > plat-mvebu/include/plat ?
> 
> Better.
> 
> > > > * headers used to inteface between the first two go to
> > > >   plat-mvebu/include/plat (?)
> > 
> > plat-mvebu/include ?
> 
> No, we don't put include files in that directory, always a subdirectory.
> But note - any header file used _only_ by files in plat-mvebu should be
> in plat-mvebu itself and not some subdirectory.  Locality of reference
> is the key idea there.

Got it, thanks for the clarification.

> > > That sounds reasonable.  The only eyebrow raising thing is having an
> > > include/mach inside a plat-* directory... that seems an odd way to do
> > > things as mach/ includes normally come from the mach-* directory.
> > > 
> > > So I wonder whether Nicolas' idea of "dt-only stuff in arch/arm/plat-*"
> > > is the right idea.  It just makes plat-* the same as a mach-* but with
> > > a different name, whereas it is _supposed_ to be for stuff shared
> > > between a bunch of mach-* directories.
> > 
> > In an ideal (dt) world, plat-*/ would hold all the dt source files, and
> > arch/arm/boot/dts/ would become the new mach-*/.  mach-*/ is kept around
> > for the few legacy, unconverted boards.
> 
> At that point I'd suggest the plat-* is renamed to mach-* ;)
> 
> plat-* was only invented to allow SoC folk to have some place to put
> common code shared between a set of mach-*, and nothing more.

So lets follow that to it's logical end.  How about we rename
plat-orion/ to mach-mvebu/, put all dt-compatible code in mach-mvebu/,
and empty the remaining mach-*/'s as they get converted?

mach-mvebu/'s directory tree structure could be:
	include/	# no headers
	include/mach/	# headers used by drivers, etc
	include/board/	# common headers used by legacy board files
	board/		# common source code for legacy board files

The end goal being to empty and remove the board/'s and remove the other
mach-*/ directories.

Alternatively, in this scenario we could name 'board' -> 'legacy' to
make it more obvious.

thx,

Jason.
