From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 19 Nov 2015 16:35:16 +0100
Subject: [PATCH 04/19] clk: sunxi: Add TCON channel1 clock
In-Reply-To: <CAGb2v65MUrBKA=pAC95evdiSBMaewRcnLUhBcqCbx_Pc6Jutnw@mail.gmail.com>
References: <1446214865-3972-1-git-send-email-maxime.ripard@free-electrons.com>
 <1446214865-3972-5-git-send-email-maxime.ripard@free-electrons.com>
 <CAGb2v650S8+8SNNBqx7u8k8wxHm2fSKdht=W3yA9Mh=rpU+hOA@mail.gmail.com>
 <20151107000139.GP6114@lukather>
 <CAGb2v65MUrBKA=pAC95evdiSBMaewRcnLUhBcqCbx_Pc6Jutnw@mail.gmail.com>
Message-ID: <20151119153516.GP32142@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 09, 2015 at 11:36:15AM +0800, Chen-Yu Tsai wrote:
> >> > +       sclk1_parents[0] = sclk2_name;
> >> > +       sclk1_parents[1] = sclk2d2_name;
> >>
> >> Is there any need to expose these 2 clocks via DT using of_clk_add_provider?
> >
> > No, as far as I'm aware, there's no user external to this clock
> > driver.
> >
> >> Note that these complex clock trees within a clock node breaks the
> >> assigned-clock-parents mechanism, as you can no longer specify the output
> >> clock's direct parents.
> >
> > There's no point of changing the parent either. Hardware blocks are
> > always connected to the leaf clock (sclk1). We could also model it as
> > an extra 1-bit divider, which would simplify a bit the logic though.
> 
> Probably not. You still have a gate to handle. It's just moving the
> divider from 1 clock to the other. I think the current approach of
> modeling it like the hardware is better.

Not really if you model it using sclk2 being a mux + gate, and sclk1
being a divider + gate. It works great using the composite clocks.

> About reparenting, what I meant was if sclk2 is not exposed through
> of_clk_add_provider, then we can't do assigned-clocks stuff on it,
> like setting a default parent or making each channel use a different
> source pll.

And we don't really want to. Using the divider allow us to simply set
the rate of sclk1, and the mux / divider will do the rest. Since only
sclk1 is exposed to the rest of the system, we do not really care
about the rate of sclk2 anyway.

> What I'm saying is if it is not expected to work with another core
> binding, we should probably note it somewhere.

Indeed.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151119/a439163e/attachment.sig>
