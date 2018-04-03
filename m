From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 3 Apr 2018 13:36:16 +0200
Subject: [PATCH net-next 02/12] clk: sunxi-ng: r40: export a regmap to
 access the GMAC register
In-Reply-To: <CAGb2v65c0wFKecrNtLhJvP71iMPxio4xJ835hD91GdwtFZKXBQ@mail.gmail.com>
References: <20180317092857.4396-1-wens@csie.org>
 <20180317092857.4396-3-wens@csie.org>
 <20180318213129.ucwslzvwq6khxrcd@flea>
 <CAGb2v67Fp20wkmqWyRowpAmm4EDwENnKFG+mccqWaPa5Jj4zBw@mail.gmail.com>
 <20180403094845.le2hfuxktlv66lre@flea>
 <20180403095005.skflxb7m2qzbhjix@flea>
 <CAGb2v67NO0hbATReq11Y_-2M_yF4hbj_sOtK3D_8yUQb1xi2ww@mail.gmail.com>
 <9982975F-0911-48F2-BEEB-CE93AB561A55@aosc.io>
 <CAGb2v65c0wFKecrNtLhJvP71iMPxio4xJ835hD91GdwtFZKXBQ@mail.gmail.com>
Message-ID: <20180403113616.7nam6rfq44bwcatk@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 03, 2018 at 05:58:05PM +0800, Chen-Yu Tsai wrote:
> On Tue, Apr 3, 2018 at 5:54 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> >
> >
> > ? 2018?4?3? GMT+08:00 ??5:53:08, Chen-Yu Tsai <wens@csie.org> ??:
> >>On Tue, Apr 3, 2018 at 5:50 PM, Maxime Ripard
> >><maxime.ripard@bootlin.com> wrote:
> >>> On Tue, Apr 03, 2018 at 11:48:45AM +0200, Maxime Ripard wrote:
> >>>> On Tue, Mar 20, 2018 at 03:15:02PM +0800, Chen-Yu Tsai wrote:
> >>>> > On Mon, Mar 19, 2018 at 5:31 AM, Maxime Ripard
> >>>> > <maxime.ripard@bootlin.com> wrote:
> >>>> > > On Sat, Mar 17, 2018 at 05:28:47PM +0800, Chen-Yu Tsai wrote:
> >>>> > >> From: Icenowy Zheng <icenowy@aosc.io>
> >>>> > >>
> >>>> > >> There's a GMAC configuration register, which exists on
> >>A64/A83T/H3/H5 in
> >>>> > >> the syscon part, in the CCU of R40 SoC.
> >>>> > >>
> >>>> > >> Export a regmap of the CCU.
> >>>> > >>
> >>>> > >> Read access is not restricted to all registers, but only the
> >>GMAC
> >>>> > >> register is allowed to be written.
> >>>> > >>
> >>>> > >> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> >>>> > >> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> >>>> > >
> >>>> > > Gah, this is crazy. I'm really starting to regret letting that
> >>syscon
> >>>> > > in in the first place...
> >>>> >
> >>>> > IMHO syscon is really a better fit. It's part of the glue layer
> >>and
> >>>> > most other dwmac user platforms treat it as such and use a syscon.
> >>>> > Plus the controls encompass delays (phase), inverters (polarity),
> >>>> > and even signal routing. It's not really just a group of clock
> >>controls,
> >>>> > like what we poorly modeled for A20/A31. I think that was really a
> >>>> > mistake.
> >>>> >
> >>>> > As I mentioned in the cover letter, a slightly saner approach
> >>would
> >>>> > be to let drivers add custom syscon entries, which would then
> >>require
> >>>> > less custom plumbing.
> >>>>
> >>>> A syscon is convenient, sure, but it also bypasses any abstraction
> >>>> layer we have everywhere else, which means that we'll have to
> >>maintain
> >>>> the register layout in each and every driver that uses it.
> >>>>
> >>>> So far, it's only be the GMAC, but it can also be others (the SRAM
> >>>> controller comes to my mind), and then, if there's any difference in
> >>>> the design in a future SoC, we'll have to maintain that in the GMAC
> >>>> driver as well.
> >>>
> >>> I guess I forgot to say something, I'm fine with using a syscon we
> >>> already have.
> >>>
> >>> I'm just questionning if merging any other driver using one is the
> >>> right move.
> >>
> >>Right. So in this case, we are not actually going through the syscon
> >>API. Rather we are exporting a regmap whose properties we actually
> >>define. If it makes you more acceptable to it, we could map just
> >>the GMAC register in the new regmap, and also have it named. This
> >>is all plumbing within the kernel so the device tree stays the same.
> >
> > I think my driver has already restricted the write permission
> > only to GMAC register.
> 
> Correct, but it still maps the entire region out, which means the
> consumer needs to know which offset to use. Maxime is saying this
> is something that is troublesome to maintain. So my proposal was
> to create a regmap with a base at the GMAC register offset. That
> way, the consumer doesn't need to use an offset to access it.

I guess this is something we can keep in mind if it gets out of
control yse.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180403/d5250545/attachment.sig>
