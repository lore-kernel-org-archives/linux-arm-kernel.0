From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 16 Dec 2016 14:40:41 +0800
Subject: [PATCH 2/2] clk: zte: add audio clocks for zx296718
In-Reply-To: <20161208210453.GH5423@codeaurora.org>
References: <1481189157-8995-1-git-send-email-shawnguo@kernel.org>
 <1481189157-8995-2-git-send-email-shawnguo@kernel.org>
 <20161208210453.GH5423@codeaurora.org>
Message-ID: <20161216064039.GB8787@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 08, 2016 at 01:04:53PM -0800, Stephen Boyd wrote:
> > +	if (of_clk_add_hw_provider(np, of_clk_hw_onecell_get, &audio_hw_onecell_data))
> > +		panic("could not register clk provider\n");
> 
> Why don't we return error? We returned errors before if we
> couldn't map the ioregion.

Yes.  Rather than panic, we should check return and give an error
message in case of failure.

> 
> > +	pr_info("audio-clk init over, nr:%d\n", AUDIO_NR_CLKS);
> 
> debug noise?

Agreed.  I will just clean it up.

<snip>

> > +static unsigned long audio_calc_rate(struct clk_zx_audio_divider *audio_div,
> > +				     u32 reg_frac, u32 reg_int,
> > +				     unsigned long parent_rate)
> > +{
> > +	unsigned long rate, m, n;
> > +
> > +	if (audio_div->table) {
> > +		const struct zx_clk_audio_div_table *divt = audio_div->table;
> > +
> > +		for (; divt->rate; divt++) {
> > +			if ((divt->int_reg == reg_int) && (divt->frac_reg == reg_frac))
> 
> Please remove extra parenthesis here.

The whole hunk of the code will be dropped, since the divider lookup
table is not actually used.

> 
> > +				return divt->rate;
> > +		}
> > +	}
> > +	if (audio_div->table)
> > +		pr_warn("cannot found the config(int_reg:0x%x, frac_reg:0x%x) in table, we will caculate it\n",
> > +			reg_int, reg_frac);

<snip>

> > +	div_table->rate = (ulong)(parent_rate * n) / ((ulong)reg_int * n + m);
> 
> Please don't use ulong, use unsigned long. Also consider using
> local variables so the line isn't overly long.

It seems to me that none of the type casts is really necessary.  So I
will just drop them.

> 
> > +	div_table->int_reg = reg_int;
> > +	div_table->frac_reg = reg_frac;
> > +}
> [...]
> > +
> > +static int zx_audio_div_set_rate(struct clk_hw *hw, unsigned long rate,
> > +				    unsigned long parent_rate)
> > +{
> > +	struct clk_zx_audio_divider *zx_audio_div = to_clk_zx_audio_div(hw);
> > +	struct zx_clk_audio_div_table divt;
> > +	unsigned int val;
> > +
> > +	audio_calc_reg(zx_audio_div, &divt, rate, parent_rate);
> > +	if (divt.rate != rate)
> > +		pr_info("the real rate is:%ld", divt.rate);
> 
> Debug noise?

I will change it to pr_debug.

Shawn
