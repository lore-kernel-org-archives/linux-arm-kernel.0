From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 26 Feb 2016 09:48:30 +0100
Subject: [PATCH v3 3/3] ARM: imx6: Fix procedure to switch the parent
 of, LDB_DI_CLK
In-Reply-To: <56CF5ABC.8040109@timesys.com>
References: <56CF5ABC.8040109@timesys.com>
Message-ID: <1456476510.3383.19.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Akshay,

Am Donnerstag, den 25.02.2016, 14:49 -0500 schrieb Akshay Bhat:
> Hi Fabio, Phillip,
> 
> Philipp Zabel <p.zabel <at> pengutronix.de> writes:
> 
>  >
>  > From: Fabio Estevam <fabio.estevam <at> freescale.com>
>  >
> 
> <snip>
>  > +		sel[i][2] = sel[i][3] | 4;
>  > +
>  > +		pr_debug("ccm: switching ldb_di0_sel: %d->%d->%d->%d\n",
>  > +			 sel[i][0], sel[i][1], sel[i][2], sel[i][3]);
> 
> Change ldb_di0_sel to ldb_di%d_sel
> 
> <snip>

Will do.

>  > +	if (sel[0][0] == sel[0][3] && sel[1][0] == sel[1][3])
>  > +		return;
>  > +
>  > +	mmdc_ch1_disable(ccm_base);
>  > +
>  > +	for (i = 1; i < 4; i++) {
>  > +		reg = readl_relaxed(ccm_base + CCM_CS2CDR);
>  > +		reg &= ~((7 << CS2CDR_LDB_DI0_CLK_SEL_SHIFT) |
>  > +			 (7 << CS2CDR_LDB_DI1_CLK_SEL_SHIFT));
>  > +		reg |= ((sel[0][i] << CS2CDR_LDB_DI0_CLK_SEL_SHIFT) |
>  > +			(sel[1][i] << CS2CDR_LDB_DI0_CLK_SEL_SHIFT));
> 
> Needs to be CS2CDR_LDB_DI1_CLK_SEL_SHIFT in the last line; otherwise the 
> ldb_di1_clock is set to have incorrect source.

Thanks for spotting this!

regards
Philipp
