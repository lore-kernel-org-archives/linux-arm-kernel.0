From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 3 Apr 2018 11:48:45 +0200
Subject: [PATCH net-next 02/12] clk: sunxi-ng: r40: export a regmap to
 access the GMAC register
In-Reply-To: <CAGb2v67Fp20wkmqWyRowpAmm4EDwENnKFG+mccqWaPa5Jj4zBw@mail.gmail.com>
References: <20180317092857.4396-1-wens@csie.org>
 <20180317092857.4396-3-wens@csie.org>
 <20180318213129.ucwslzvwq6khxrcd@flea>
 <CAGb2v67Fp20wkmqWyRowpAmm4EDwENnKFG+mccqWaPa5Jj4zBw@mail.gmail.com>
Message-ID: <20180403094845.le2hfuxktlv66lre@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 20, 2018 at 03:15:02PM +0800, Chen-Yu Tsai wrote:
> On Mon, Mar 19, 2018 at 5:31 AM, Maxime Ripard
> <maxime.ripard@bootlin.com> wrote:
> > On Sat, Mar 17, 2018 at 05:28:47PM +0800, Chen-Yu Tsai wrote:
> >> From: Icenowy Zheng <icenowy@aosc.io>
> >>
> >> There's a GMAC configuration register, which exists on A64/A83T/H3/H5 in
> >> the syscon part, in the CCU of R40 SoC.
> >>
> >> Export a regmap of the CCU.
> >>
> >> Read access is not restricted to all registers, but only the GMAC
> >> register is allowed to be written.
> >>
> >> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> >> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> >
> > Gah, this is crazy. I'm really starting to regret letting that syscon
> > in in the first place...
> 
> IMHO syscon is really a better fit. It's part of the glue layer and
> most other dwmac user platforms treat it as such and use a syscon.
> Plus the controls encompass delays (phase), inverters (polarity),
> and even signal routing. It's not really just a group of clock controls,
> like what we poorly modeled for A20/A31. I think that was really a
> mistake.
> 
> As I mentioned in the cover letter, a slightly saner approach would
> be to let drivers add custom syscon entries, which would then require
> less custom plumbing.

A syscon is convenient, sure, but it also bypasses any abstraction
layer we have everywhere else, which means that we'll have to maintain
the register layout in each and every driver that uses it.

So far, it's only be the GMAC, but it can also be others (the SRAM
controller comes to my mind), and then, if there's any difference in
the design in a future SoC, we'll have to maintain that in the GMAC
driver as well.

> > And I'm not really looking forward the time where SCPI et al. will be
> > mature and we'll have the clock controller completely outside of our
> > control.
> 
> I don't think it's going to happen for any of the older SoCs. The R40
> only stands out because the GMAC controls are in the clock controller
> address space, presumably to be like the A20.

SCPI (or equivalent) is a really nice feature to have when it comes to
virtualization, so even if it's less likely, it doesn't make it less
relevant on other SoCs.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180403/dec2efee/attachment.sig>
