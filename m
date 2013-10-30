From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Thu, 31 Oct 2013 00:19:32 +0200
Subject: [PATCH] clk: tegra: use pll_ref as the pll_e parent
In-Reply-To: <1383147850.4095.3.camel@weser.hi.pengutronix.de>
References: <1383093707-10312-1-git-send-email-pdeschrijver@nvidia.com>
 <527128B5.2020101@wwwdotorg.org>
 <1383147850.4095.3.camel@weser.hi.pengutronix.de>
Message-ID: <20131030221932.GR22111@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 30, 2013 at 04:44:10PM +0100, Lucas Stach wrote:
> Am Mittwoch, den 30.10.2013, 09:41 -0600 schrieb Stephen Warren:
> > On 10/29/2013 06:41 PM, Peter De Schrijver wrote:
> > > Use pll_ref instead of pll_re_vco as the pll_e parent on Tegra114 and
> > > Tegra124. Also add a pll_ref table entry for pll_e for Tegra114.
> > 
> > Why? What benefit does this give, or what bug does this fix?
> > 
> > > diff --git a/drivers/clk/tegra/clk-pll.c b/drivers/clk/tegra/clk-pll.c
> > 
> > >  	val_aux = pll_readl(pll_params->aux_reg, pll);
> > >  
> > >  	if (val & PLL_BASE_ENABLE) {
> > > -		if (!(val_aux & PLLE_AUX_PLLRE_SEL))
> > > +		if ((val_aux & PLLE_AUX_PLLRE_SEL) || (val_aux & val_aux))
> > 
> > Isn't "|| (val_aux & val_aux)" always true, at least if the value is
> > non-zero? Either this should be simply "|| val_aux", or one of those two
> > "val_aux" is the wrong thing.
> > 
> > >  			WARN(1, "pll_e enabled with unsupported parent %s\n",
> > > -			  (val & PLLE_AUX_PLLP_SEL) ? "pllp_out0" : "pll_ref");
> > > +			  (val_aux & PLLE_AUX_PLLP_SEL) ? "pllp_out0" :
> > > +					"pll_re_vco");
> > >  	} else {
> > > -		val_aux |= PLLE_AUX_PLLRE_SEL;
> > > +		val_aux &= ~(PLLE_AUX_PLLRE_SEL | PLLE_AUX_PLLP_SEL);
> > >  		pll_writel(val, pll_params->aux_reg, pll);
> > >  	}
> > 
> > > diff --git a/drivers/clk/tegra/clk-tegra114.c b/drivers/clk/tegra/clk-tegra114.c
> > 
> > > @@ -560,6 +560,7 @@ static struct tegra_clk_pll_freq_table pll_e_freq_table[] = {
> > >  	/* PLLE special case: use cpcon field to store cml divider value */
> > >  	{336000000, 100000000, 100, 21, 16, 11},
> > >  	{312000000, 100000000, 200, 26, 24, 13},
> > > +	{12000000, 100000000, 200,  1,  24, 13},
> > 
> > Presumably this is because pll_ref is the crystal, which runs at 12MHz.
> > What if it doesn't; Tegra supports a bunch of other crystal rates. Don't
> > we need entries for all the other potential crystal rates too?
> 
> The TRM states that PCIe and thus PLLE are only supported with 12MHz
> external crystal rate.
> 

This is has been different for Tegra114 at least (where PLLE is used for USB3)

Cheers,

Peter.
