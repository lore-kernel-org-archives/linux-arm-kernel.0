From: icenowy@aosc.io (Icenowy Zheng)
Date: Wed, 04 Apr 2018 14:45:02 +0800
Subject: [PATCH net-next 02/12] clk: sunxi-ng: r40: export a regmap to
 access the GMAC register
In-Reply-To: <20180403095005.skflxb7m2qzbhjix@flea>
References: <20180317092857.4396-1-wens@csie.org>
 <20180317092857.4396-3-wens@csie.org>
 <20180318213129.ucwslzvwq6khxrcd@flea>
 <CAGb2v67Fp20wkmqWyRowpAmm4EDwENnKFG+mccqWaPa5Jj4zBw@mail.gmail.com>
 <20180403094845.le2hfuxktlv66lre@flea>
 <20180403095005.skflxb7m2qzbhjix@flea>
Message-ID: <1522824302.2049.7.camel@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2018-04-03?? 11:50 +0200?Maxime Ripard???
> On Tue, Apr 03, 2018 at 11:48:45AM +0200, Maxime Ripard wrote:
> > On Tue, Mar 20, 2018 at 03:15:02PM +0800, Chen-Yu Tsai wrote:
> > > On Mon, Mar 19, 2018 at 5:31 AM, Maxime Ripard
> > > <maxime.ripard@bootlin.com> wrote:
> > > > On Sat, Mar 17, 2018 at 05:28:47PM +0800, Chen-Yu Tsai wrote:
> > > > > From: Icenowy Zheng <icenowy@aosc.io>
> > > > > 
> > > > > There's a GMAC configuration register, which exists on
> > > > > A64/A83T/H3/H5 in
> > > > > the syscon part, in the CCU of R40 SoC.
> > > > > 
> > > > > Export a regmap of the CCU.
> > > > > 
> > > > > Read access is not restricted to all registers, but only the
> > > > > GMAC
> > > > > register is allowed to be written.
> > > > > 
> > > > > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > > > > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > > > 
> > > > Gah, this is crazy. I'm really starting to regret letting that
> > > > syscon
> > > > in in the first place...
> > > 
> > > IMHO syscon is really a better fit. It's part of the glue layer
> > > and
> > > most other dwmac user platforms treat it as such and use a
> > > syscon.
> > > Plus the controls encompass delays (phase), inverters (polarity),
> > > and even signal routing. It's not really just a group of clock
> > > controls,
> > > like what we poorly modeled for A20/A31. I think that was really
> > > a
> > > mistake.
> > > 
> > > As I mentioned in the cover letter, a slightly saner approach
> > > would
> > > be to let drivers add custom syscon entries, which would then
> > > require
> > > less custom plumbing.
> > 
> > A syscon is convenient, sure, but it also bypasses any abstraction
> > layer we have everywhere else, which means that we'll have to
> > maintain
> > the register layout in each and every driver that uses it.
> > 
> > So far, it's only be the GMAC, but it can also be others (the SRAM
> > controller comes to my mind), and then, if there's any difference
> > in
> > the design in a future SoC, we'll have to maintain that in the GMAC
> > driver as well.
> 
> I guess I forgot to say something, I'm fine with using a syscon we
> already have.

As we finally need the SRAM controller on these new SoCs (for VE on all
SoCs targeted by dwmac-sun8i, and for DE on A64), should we deprecate
the syscon and all switch to device regmap (and let sunxi-dram driver
to export a regmap)? (As in the A64 DE2 thread discussed, two device
nodes shouldn't cover the same MMIO region.)

In addition, there might be multiple registers in the syscon/sram zone
that are needed (for example, if a version driver is written, it will
need the "0x24 Version Register"; and GMAC needs "0x30 EMAC Clock
Register"). How to deal with this if we export the syscon/sram zone as
a generic device regmap?

> 
> I'm just questionning if merging any other driver using one is the
> right move.
> 
> Maxime
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
