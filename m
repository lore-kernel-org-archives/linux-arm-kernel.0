From: akshay.bhat@timesys.com (Akshay Bhat)
Date: Thu, 25 Feb 2016 14:49:16 -0500
Subject: [PATCH v3 3/3] ARM: imx6: Fix procedure to switch the parent of,
 LDB_DI_CLK
In-Reply-To: 1453461088-31549-4-git-send-email-p.zabel@pengutronix.de
Message-ID: <56CF5ABC.8040109@timesys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio, Phillip,

Philipp Zabel <p.zabel <at> pengutronix.de> writes:

 >
 > From: Fabio Estevam <fabio.estevam <at> freescale.com>
 >

<snip>
 > +		sel[i][2] = sel[i][3] | 4;
 > +
 > +		pr_debug("ccm: switching ldb_di0_sel: %d->%d->%d->%d\n",
 > +			 sel[i][0], sel[i][1], sel[i][2], sel[i][3]);

Change ldb_di0_sel to ldb_di%d_sel

<snip>

 > +	if (sel[0][0] == sel[0][3] && sel[1][0] == sel[1][3])
 > +		return;
 > +
 > +	mmdc_ch1_disable(ccm_base);
 > +
 > +	for (i = 1; i < 4; i++) {
 > +		reg = readl_relaxed(ccm_base + CCM_CS2CDR);
 > +		reg &= ~((7 << CS2CDR_LDB_DI0_CLK_SEL_SHIFT) |
 > +			 (7 << CS2CDR_LDB_DI1_CLK_SEL_SHIFT));
 > +		reg |= ((sel[0][i] << CS2CDR_LDB_DI0_CLK_SEL_SHIFT) |
 > +			(sel[1][i] << CS2CDR_LDB_DI0_CLK_SEL_SHIFT));

Needs to be CS2CDR_LDB_DI1_CLK_SEL_SHIFT in the last line; otherwise the 
ldb_di1_clock is set to have incorrect source.

With the above change the patch works great for me. Without this patch 
we were having an issue on some boards where the LVDS would lockup 
sometimes when the clock source was being changed. This patch fixes our 
issue.

Thanks,
Akshay
