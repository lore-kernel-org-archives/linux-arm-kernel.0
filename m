From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 15 May 2016 21:04:15 +0200
Subject: [PATCH 12/16] clk: sunxi-ng: Add N-M-factor clock support
In-Reply-To: <20160509092421.a36252139fd6b00b2cd32f24@free.fr>
References: <1462737711-10017-1-git-send-email-maxime.ripard@free-electrons.com>
 <1462737711-10017-13-git-send-email-maxime.ripard@free-electrons.com>
 <20160509092421.a36252139fd6b00b2cd32f24@free.fr>
Message-ID: <20160515190415.GC27618@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, May 09, 2016 at 09:24:21AM +0200, Jean-Francois Moine wrote:
> On Sun,  8 May 2016 22:01:47 +0200
> Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
> 
> > Introduce support for clocks that multiply and divide using linear factors.
> > 
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  drivers/clk/sunxi-ng/Makefile |   1 +
> >  drivers/clk/sunxi-ng/ccu_nm.c | 103 ++++++++++++++++++++++++++++++++++++++++++
> >  drivers/clk/sunxi-ng/ccu_nm.h |  41 +++++++++++++++++
> >  3 files changed, 145 insertions(+)
> >  create mode 100644 drivers/clk/sunxi-ng/ccu_nm.c
> >  create mode 100644 drivers/clk/sunxi-ng/ccu_nm.h
> 	[snip]
> > diff --git a/drivers/clk/sunxi-ng/ccu_nm.c b/drivers/clk/sunxi-ng/ccu_nm.c
> > new file mode 100644
> > index 000000000000..268637db137b
> > --- /dev/null
> > +++ b/drivers/clk/sunxi-ng/ccu_nm.c
> > @@ -0,0 +1,103 @@
> 	[snip]
> > +static long ccu_nm_round_rate(struct clk_hw *hw, unsigned long rate,
> > +			      unsigned long *parent_rate)
> > +{
> > +	struct ccu_nm *nm = hw_to_ccu_nm(hw);
> > +	unsigned long n, m;
> > +
> > +	rational_best_approximation(rate, *parent_rate,
> > +				    nm->n.width, nm->m.width, &n, &m);
> 
> Should be
> 			1 << nm->n.width, 1 << nm->m.width, &n, &m);
> 
> > +
> > +	return *parent_rate * n / m;
> > +}
> > +
> > +static int ccu_nm_set_rate(struct clk_hw *hw, unsigned long rate,
> > +			   unsigned long parent_rate)
> > +{
> > +	struct ccu_nm *nm = hw_to_ccu_nm(hw);
> > +	unsigned long flags;
> > +	unsigned long n, m;
> > +	u32 reg;
> > +
> > +	rational_best_approximation(rate, parent_rate,
> > +				    nm->n.width, nm->m.width, &n, &m);
> 
> Idem

Indeed, fixed.

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
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160515/3b0e96e4/attachment.sig>
