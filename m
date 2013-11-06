From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Tue, 05 Nov 2013 16:54:31 -0800 (PST)
Subject: [PATCH 3/3] clk: shmobile: Add R8A7790 clocks support
In-Reply-To: <2199055.1gOuVSSAtq@avalon>
References: <1383058511-26046-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1383058511-26046-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <87r4avnsc6.wl%kuninori.morimoto.gx@renesas.com>
 <2199055.1gOuVSSAtq@avalon>
Message-ID: <874n7q1ha3.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Laurent

> > > +	for (i = 0; i < CPG_NUM_CLOCKS; ++i) {
> > > +		const struct clk_div_table *table = NULL;
> > > +		const char *parent_name = "main";
> > > +		const char *name;
> > > +		unsigned int shift;
> > > +		unsigned int mult = 1;
> > > +		unsigned int div = 1;
> > > +		struct clk *clk;
> > > +
> > > +		of_property_read_string_index(np, "clock-output-names", i,
> > > +					      &name);
> > > +
> > > +		switch (i) {
> > > +		case R8A7790_CLK_MAIN:
> > > +			parent_name = of_clk_get_parent_name(np, 0);
> > > +			div = config->extal_div;
> > > +			break;
> > > +		case R8A7790_CLK_PLL1:
> > > +			mult = config->pll1_mult / 2;
> > > +			break;
> > > +		case R8A7790_CLK_PLL3:
> > > +			mult = config->pll3_mult;
> > > +			break;
> > > +		case R8A7790_CLK_LB:
> > > +			div = cpg_mode & BIT(18) ? 36 : 24;
> > > +			break;
> > > +		case R8A7790_CLK_QSPI:
> > > +			div = (cpg_mode & (BIT(3) | BIT(2) | BIT(1))) == BIT(2)
> > > +			    ? 16 : 20;
> > > +			break;
> > > +		case R8A7790_CLK_SDH:
> > > +			table = cpg_sdh_div_table;
> > > +			shift = 8;
> > > +			break;
> > > +		case R8A7790_CLK_SD0:
> > > +			table = cpg_sd01_div_table;
> > > +			shift = 4;
> > > +			break;
> > > +		case R8A7790_CLK_SD1:
> > > +			table = cpg_sd01_div_table;
> > > +			shift = 0;
> > > +			break;
> > > +		}
> > 
> > Is this clock-output-names realy "Required" property ?
> > The "name" and "order" seem fixed, then,
> > I guess it can simply use "name array" ?
> 
> The clock-output-names property is required by the of_clk_get_parent_name() 
> function. The property is mandatory for all clocks that need to be referenced 
> by name, which is the case of all non-leaf clocks on our platforms. We thus 
> need it.

Please correct me if my understanding was wrong.
Does your "of_clk_get_parent_name()" means "case R8A7790_CLK_MAIN"'s one ?
If Yes, it is needed on "parent" clock side, not here ?
If No,  who need/call of_clk_get_parent_name() for this ?
does "qspi", "sdh", "sd0", "sd1" can be parent clock for some device ??

And, parent of main clock is fixed by MD pin settings.
SW can't exchange it.

Best regards
---
Kuninori Morimoto
