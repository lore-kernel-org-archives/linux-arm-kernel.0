From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 19 Mar 2012 12:28:58 +0100
Subject: [PATCH v7 2/3] clk: introduce the common clock framework
In-Reply-To: <4F6716DD.5090900@ti.com>
References: <1331878280-2758-1-git-send-email-mturquette@linaro.org>
 <1331878280-2758-3-git-send-email-mturquette@linaro.org>
 <4F6716DD.5090900@ti.com>
Message-ID: <20120319112858.GX3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 19, 2012 at 04:52:05PM +0530, Rajendra Nayak wrote:
> Hi Mike,
> 
> >+/*
> >+ * calculate the new rates returning the topmost clock that has to be
> >+ * changed.
> >+ */
> >+static struct clk *clk_calc_new_rates(struct clk *clk, unsigned long rate)
> >+{
> >+	struct clk *top = clk;
> >+	unsigned long best_parent_rate = clk->parent->rate;
> 
> Shouldn't you check for a valid parent before dereferencing it? A
> clk_set_rate() on a root clock might throw up some issues otherwise.
>

Yes, should be checked.

> >+	unsigned long new_rate;
> >+
> >+	if (!clk->ops->round_rate&&  !(clk->flags&  CLK_SET_RATE_PARENT)) {
> >+		clk->new_rate = clk->rate;
> >+		return NULL;
> 
> So does this mean a clk_set_rate() fails for a clk which does not have
> a valid .round_rate and does not have a CLK_SET_RATE_PARENT flag set?
> I was thinking this could do a..
> 		clk->new_rate = rate;
> 		top = clk;
> 		goto out;
> ..instead.

The core should make sure that either both set_rate and round_rate are
present or none of them.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
