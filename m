From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Wed, 16 Jul 2014 11:27:40 +0300
Subject: [PATCH 2/6] clk: tegra: make tegra_clocks_apply_init_table
 arch_initcall
In-Reply-To: <20140716071932.GB7978@ulmo>
References: <1405437890-6468-1-git-send-email-pdeschrijver@nvidia.com>
 <1405437890-6468-3-git-send-email-pdeschrijver@nvidia.com>
 <20140716071932.GB7978@ulmo>
Message-ID: <20140716082740.GK23218@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 16, 2014 at 09:19:33AM +0200, Thierry Reding wrote:
> * PGP Signed by an unknown key
> 
> On Tue, Jul 15, 2014 at 06:24:32PM +0300, Peter De Schrijver wrote:
> [...]
> > diff --git a/drivers/clk/tegra/clk.c b/drivers/clk/tegra/clk.c
> > index d081732..65cde4e 100644
> > --- a/drivers/clk/tegra/clk.c
> > +++ b/drivers/clk/tegra/clk.c
> > @@ -290,10 +290,13 @@ struct clk ** __init tegra_lookup_dt_id(int clk_id,
> >  
> >  tegra_clk_apply_init_table_func tegra_clk_apply_init_table;
> >  
> > -void __init tegra_clocks_apply_init_table(void)
> > +static int __init tegra_clocks_apply_init_table(void)
> >  {
> >  	if (!tegra_clk_apply_init_table)
> > -		return;
> > +		return 0;
> 
> Shouldn't this be an error? Or perhaps WARN()? To make sure this gets

An arch_initcall will be called for every ARM platform I think? In case
this gets called on a non-Tegra platform, tegra_clk_apply_init_table will not
be set and therefore a silent return 0; seems the most appropriate thing to do
to me?

Cheers,

Peter.
