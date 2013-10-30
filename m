From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Thu, 31 Oct 2013 00:18:33 +0200
Subject: [PATCH] clk: tegra: use pll_ref as the pll_e parent
In-Reply-To: <527128B5.2020101@wwwdotorg.org>
References: <1383093707-10312-1-git-send-email-pdeschrijver@nvidia.com>
 <527128B5.2020101@wwwdotorg.org>
Message-ID: <20131030221833.GQ22111@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 30, 2013 at 04:41:41PM +0100, Stephen Warren wrote:
> On 10/29/2013 06:41 PM, Peter De Schrijver wrote:
> > Use pll_ref instead of pll_re_vco as the pll_e parent on Tegra114 and
> > Tegra124. Also add a pll_ref table entry for pll_e for Tegra114.
> 
> Why? What benefit does this give, or what bug does this fix?
> 

Otherrwise Tegra114 will crash on boot.

> > diff --git a/drivers/clk/tegra/clk-pll.c b/drivers/clk/tegra/clk-pll.c
> 
> >  	val_aux = pll_readl(pll_params->aux_reg, pll);
> >  
> >  	if (val & PLL_BASE_ENABLE) {
> > -		if (!(val_aux & PLLE_AUX_PLLRE_SEL))
> > +		if ((val_aux & PLLE_AUX_PLLRE_SEL) || (val_aux & val_aux))
> 
> Isn't "|| (val_aux & val_aux)" always true, at least if the value is
> non-zero? Either this should be simply "|| val_aux", or one of those two
> "val_aux" is the wrong thing.
> 

It should have been val_aux & PLLE_AUX_PLLP_SEL...

Cheers,

Peter.
