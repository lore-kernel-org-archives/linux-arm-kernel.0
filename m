From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 23 Aug 2016 11:57:32 +0200
Subject: [PATCH v2 2/5] clk: sunxi-ng: mux: support fixed pre-dividers on
 multiple parents
In-Reply-To: <CAGb2v67gaQX_CEtysfDh+8sgo7L=zeRw2TSDbXnPnHA1awZF3w@mail.gmail.com>
References: <1471248795-17951-1-git-send-email-wens@csie.org>
 <1471248795-17951-3-git-send-email-wens@csie.org>
 <20160823085534.GC2598@lukather>
 <CAGb2v67gaQX_CEtysfDh+8sgo7L=zeRw2TSDbXnPnHA1awZF3w@mail.gmail.com>
Message-ID: <20160823095732.GH2598@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 23, 2016 at 05:52:59PM +0800, Chen-Yu Tsai wrote:
> >>  static const char * const ahb2_parents[] = { "ahb1" , "pll-periph0" };
> >> +static const struct ccu_mux_fixed_prediv ahb2_fixed_predivs[] = {
> >> +     { .index = 1, .div = 2 },
> >> +     { },
> >> +};
> >>
> >> [...]
> >>
> >> --- a/drivers/clk/sunxi-ng/ccu_mux.h
> >> +++ b/drivers/clk/sunxi-ng/ccu_mux.h
> >> @@ -5,15 +5,18 @@
> >>
> >>  #include "ccu_common.h"
> >>
> >> +struct ccu_mux_fixed_prediv {
> >> +     u8      index;
> >> +     u16     div;
> >> +};
> >> +
> >>  struct ccu_mux_internal {
> >>       u8              shift;
> >>       u8              width;
> >>       const u8        *table;
> >>
> >> -     struct {
> >> -             u8      index;
> >> -             u16     div;
> >> -     } fixed_prediv;
> >> +     const struct ccu_mux_fixed_prediv       *fixed_predivs;
> >> +     u8              n_predivs;
> >
> > I don't think you're using it anywhere (at least you don't define it
> > in ahb2_clk, and the extra item in the array will introduce an
> > off-by-one error.
> 
> The truth is I forgot to update the change in ccu-sun8i-h3.c
> It is used correctly in the subsequent a31 patch. Sorry.
> 
> I'm not sure what you mean by the off-by-one error though. IIRC
> we initialize the structure using named fields.

What I meant was that remember to also remove the second empty field
in ahb2_fixed_predivs.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160823/cfdc3b3f/attachment.sig>
