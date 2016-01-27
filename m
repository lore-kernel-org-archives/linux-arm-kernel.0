From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 27 Jan 2016 22:50:51 +0100
Subject: [PATCH RFC 1/2] clk: sunxi: Add sun8i display support
In-Reply-To: <20160119090901.17c64bc4afb7095bb8bd291c@free.fr>
References: <cover.1452021349.git.moinejf@free.fr>
 <9cc33c3701844a07c43ee6c0c1072be4e2073cc1.1452021349.git.moinejf@free.fr>
 <20160118190904.GP4581@lukather>
 <20160119090901.17c64bc4afb7095bb8bd291c@free.fr>
Message-ID: <20160127215051.GW4317@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jan 19, 2016 at 09:09:01AM +0100, Jean-Francois Moine wrote:
> On Mon, 18 Jan 2016 20:09:04 +0100
> Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
> 
> > > +static const struct clk_ops clk_sun8i_pll3_fact_ops = {
> > > +	.recalc_rate = sun8i_pll3_recalc_rate,
> > > +	.round_rate = sun8i_pll3_round_rate,
> > > +	.set_rate = sun8i_pll3_set_rate,
> > > +};
> > 
> > We have the clk-factors stuff to handle this easily, could you use
> > that instead ?
> 
> No, the sun6i/8i pll3 offers direct 297MHz and 270MHz.

That's true, but so far it's something that never has been really
needed. This PLL is not the same one using the fractional mode, so I
guess we could extend the clk-factors to be able to deal with
that. The video pll in the A10 (pll3) is also in this case, so does
the A31 PLL3 and PLL4.

Also note that all these clocks can reach those frequencies through
what allwinner calls the integer mode, so apart from the hardware
readout, we don't really need it anyway.

> > As part of my DRM patches, I've added a clk-display clock that can
> > handle that easily.
> > 
> > And actually, as part of bringing up the display engine on the A33, I
> > already did it:
> > https://github.com/mripard/linux/commit/92b6843b5ee5b70cb2be3638df31d3eca28a4dba
> > https://github.com/mripard/linux/commit/81e8ea74be5e72124eb584432bb79ff75f90d9ed
> 
> I don't remember any patch request from yours in the Linux
> mailing-lists about these developments.

Indeed, I was waiting for the first DRM developments to get in before
sending those for review.

> 
> Otherwise, about this old RFC, Chen-Yu Tsai replied:
> 
> > > Add the clock types which are used by the sun8i family for video.
> > 
> > These clocks first appeared in the A31.

The video PLL is, the display engine and tcon clocks are a bit
different (mostly because of their weird parent configuration that
need a muxing table). Note that I'm talking about the A23 / A33. I
haven't checked for the H3.

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160127/0cf1a529/attachment.sig>
