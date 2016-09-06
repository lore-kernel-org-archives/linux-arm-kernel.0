From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 06 Sep 2016 21:28:17 +0200
Subject: [PATCH] ARM: mmp: replace NO_IRQ
In-Reply-To: <20160906142442.GY1041@n2100.armlinux.org.uk>
References: <20160906140808.2883875-1-arnd@arndb.de>
 <20160906142442.GY1041@n2100.armlinux.org.uk>
Message-ID: <6239709.hYdxF7WW9G@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, September 6, 2016 3:24:42 PM CEST Russell King - ARM Linux wrote:
> On Tue, Sep 06, 2016 at 04:07:56PM +0200, Arnd Bergmann wrote:
> > The mmp platform has its own definitions with the old NO_IRQ meaning,
> > but compares against the global NO_IRQ macro that we should have
> > removed long ago.
> > 
> > The specific usage in arch/arm/mach-mmp/devices.c is awkward, but
> > fixing it properly would require a larger scale rewrite of the entire
> > file, or even using devicetree for all machines. As I'm not able to
> > do that any time soon, let's make the current behavior more explit
> > instead and avoid the literal use of NO_IRQ.
> 
> So this probably continues to be a problem, but we hide it from the
> NO_IRQ brigade.  I think it would be better to leave it as-is until
> it can be fixed up correctly, rather than trying to hide it.

Linus explicitly asked for NO_IRQ to be finally killed off last week[1],
and I've prepared all patches for that now, this is the last one
aside from removing the macro.

The patches I sent last week for this have already been accepted into
linux-next, these are the remaining ones:

001d34e3d6e1 ARM: remove NO_IRQ definition
106bee9d4f69 [SUBMITTED 20160906] ARM: mmp: replace NO_IRQ
96d744cef97a [SUBMITTED 20160906] ARM: orion5x: remove extraneous NO_IRQ
0dadcd937ef8 [SUBMITTED 20160906] ARM: orion5x: avoid NO_IRQ in orion_ge00_switch_init
fb0558152b70 [SUBMITTED 20160906] ARM: mvebu/orion: remove NO_IRQ check from device init
309ac9ebb2eb [SUBMITTED 20160906] ARM: mv78xx0: simplify ethernet device creation
c50d19cfb4c8 [SUBMITTED 20160906] pcmcia: soc-common: remove incorrect NO_IRQ use
c9f05678577e [SUBMITTED 20160906] mfd: ucb1x00: remove NO_IRQ check
393ce6162224 [SUBMITTED 20160906] ARM: common/locomo: remove NO_IRQ check
1c78db6236a8 [SUBMITTED 20160906] ARM: common/sa1111: remove NO_IRQ check
ed8f68ba549b [SUBMITTED 20160906] ptp: ixp46x: remove NO_IRQ handling
ed4cdcd25a34 [SUBMITTED 20160906] mmc: davinci: remove incorrect NO_IRQ use
95ddf97fc805 [SUBMITTED 20160903] crypto: mv_cesa: remove NO_IRQ reference

I'm experimenting with cleaning up the file some more, but it's unclear
if doing it another way is an actual improvement, or if a larger change
is worth the risk for regressions, given how little interest there is
in this platform in general.

	Arnd

[1] https://lists.linuxfoundation.org/pipermail/ksummit-discuss/2016-September/003803.html
