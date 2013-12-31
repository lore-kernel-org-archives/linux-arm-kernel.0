From: gsi@denx.de (Gerhard Sittig)
Date: Tue, 31 Dec 2013 14:20:03 +0100
Subject: [PATCH 2/3] mmc: dw_mmc: add dw_mmc-k3 for k3 platform
In-Reply-To: <201312292205.02135.arnd@arndb.de>
References: <1388241295-20051-1-git-send-email-zhangfei.gao@linaro.org>
 <1388241295-20051-3-git-send-email-zhangfei.gao@linaro.org>
 <201312292205.02135.arnd@arndb.de>
Message-ID: <20131231132003.GR8064@book.gsilab.sittig.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 29, 2013 at 22:05 +0100, Arnd Bergmann wrote:
> 
> On Saturday 28 December 2013, Zhangfei Gao wrote:
> 
> > +static void dw_mci_k3_set_ios(struct dw_mci *host, struct mmc_ios *ios)
> > +{
> > +	struct dw_mci_k3_priv_data *priv = host->priv;
> > +	u32 rate = priv->clk_table[ios->timing];
> > +	int ret;
> 
> [ ... ]
> 
> > +
> > +	ret = clk_set_rate(host->ciu_clk, rate);
> > +	if (ret)
> > +		dev_warn(host->dev, "failed to set clock rate %uHz\n", rate);
> > +
> > +	host->bus_hz = clk_get_rate(host->ciu_clk);
> > +}
> 
> Why do you call clk_get_rate() here, shouldn't it always be the same
> rate that you have just set?

Not necessarily.  What you pass to clk_set_rate() is the
rate/frequency that you _want_, while what you get from
clk_get_rate() is the rate you _got_ taking the specific input
clock rate and the available sets of multipliers/dividers into
consideration.  Both values should be similar (roughly the same),
but they need not be identical.  The order of the difference
depends on the granularity of the hardware dividers or whether
PLLs are used.

So, re-fetching the resulting rate after setting up a desired
rate actually better reflects the status-quo for diagnostics or
for subsequent processing.


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office at denx.de
