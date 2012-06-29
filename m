From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Fri, 29 Jun 2012 14:33:30 +0800
Subject: [PATCH 3/3] mtd: gpmi: change the code for clocks
In-Reply-To: <20120629020650.GB28932@S2101-09.ap.freescale.net>
References: <1340941925-14591-1-git-send-email-shijie8@gmail.com>
 <1340941925-14591-3-git-send-email-shijie8@gmail.com>
 <20120629020650.GB28932@S2101-09.ap.freescale.net>
Message-ID: <20120629063329.GE5844@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 29, 2012 at 10:06:52AM +0800, Shawn Guo wrote:
> On Thu, Jun 28, 2012 at 11:52:05PM -0400, Huang Shijie wrote:
> > From: Huang Shijie <b32955@freescale.com>
> > 
> > The gpmi nand driver may needs several clocks(MX6Q needs five clocks).
> > 
> > In the old clock framework, all these clocks are chained together,
> > all you need is to manipulate the first clock.
> > 
> > But the kernel uses the common clk framework now, which forces us to
> > get the clocks one by one. When we use them, we have to enable them
> > one by one too.
> > 
> > Signed-off-by: Huang Shijie <b32955@freescale.com>
> > Signed-off-by: Huang Shijie <shijie8@gmail.com>
> > ---
> >  drivers/mtd/nand/gpmi-nand/gpmi-lib.c  |   43 ++++++++++++++++++----
> >  drivers/mtd/nand/gpmi-nand/gpmi-nand.c |   63 +++++++++++++++++++++++++++-----
> >  drivers/mtd/nand/gpmi-nand/gpmi-nand.h |    3 +-
> >  3 files changed, 91 insertions(+), 18 deletions(-)
> > 
> > diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-lib.c b/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
> > index a1f4332..c3778c0 100644
> > --- a/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
> > +++ b/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
> > @@ -124,12 +124,40 @@ error:
> >  	return -ETIMEDOUT;
> >  }
> >  
> > +static int __gpmi_enable_clk(struct gpmi_nand_data *this, bool v)
> > +{
> > +	struct clk *clk;
> > +	int ret;
> > +	int i;
> > +
> > +	for (i = 0; i < GPMI_CLK_MAX; i++) {
> > +		clk = this->resources.clock[i];
> > +		if (!clk)
> > +			break;
> > +
> > +		if (v) {
> > +			ret = clk_prepare_enable(clk);
> > +			if (ret)
> > +				goto err_clk;
> > +		} else {
> > +			clk_disable_unprepare(clk);
> > +		}
> > +	}
> > +	return 0;
> > +
> > +err_clk:
> > +	return ret;
> > +}
> > +
> > +#define gpmi_enable_clk(x) __gpmi_enable_clk(x, true)
> > +#define gpmi_disable_clk(x) __gpmi_enable_clk(x, false)
> > +
> >  int gpmi_init(struct gpmi_nand_data *this)
> >  {
> >  	struct resources *r = &this->resources;
> >  	int ret;
> >  
> > -	ret = clk_prepare_enable(r->clock);
> > +	ret = gpmi_enable_clk(this);
> >  	if (ret)
> >  		goto err_out;
> >  	ret = gpmi_reset_block(r->gpmi_regs, false);
> > @@ -149,7 +177,7 @@ int gpmi_init(struct gpmi_nand_data *this)
> >  	/* Select BCH ECC. */
> >  	writel(BM_GPMI_CTRL1_BCH_MODE, r->gpmi_regs + HW_GPMI_CTRL1_SET);
> >  
> > -	clk_disable_unprepare(r->clock);
> > +	gpmi_disable_clk(this);
> >  	return 0;
> >  err_out:
> >  	return ret;
> > @@ -205,7 +233,7 @@ int bch_set_geometry(struct gpmi_nand_data *this)
> >  	ecc_strength  = bch_geo->ecc_strength >> 1;
> >  	page_size     = bch_geo->page_size;
> >  
> > -	ret = clk_prepare_enable(r->clock);
> > +	ret = gpmi_enable_clk(this);
> >  	if (ret)
> >  		goto err_out;
> >  
> > @@ -240,7 +268,7 @@ int bch_set_geometry(struct gpmi_nand_data *this)
> >  	writel(BM_BCH_CTRL_COMPLETE_IRQ_EN,
> >  				r->bch_regs + HW_BCH_CTRL_SET);
> >  
> > -	clk_disable_unprepare(r->clock);
> > +	gpmi_disable_clk(this);
> >  	return 0;
> >  err_out:
> >  	return ret;
> > @@ -716,7 +744,7 @@ void gpmi_begin(struct gpmi_nand_data *this)
> >  	int ret;
> >  
> >  	/* Enable the clock. */
> > -	ret = clk_prepare_enable(r->clock);
> > +	ret = gpmi_enable_clk(this);
> >  	if (ret) {
> >  		pr_err("We failed in enable the clk\n");
> >  		goto err_out;
> > @@ -727,7 +755,7 @@ void gpmi_begin(struct gpmi_nand_data *this)
> >  		gpmi_regs + HW_GPMI_TIMING1);
> >  
> >  	/* Get the timing information we need. */
> > -	nfc->clock_frequency_in_hz = clk_get_rate(r->clock);
> > +	nfc->clock_frequency_in_hz = clk_get_rate(r->clock[0]);
> >  	clock_period_in_ns = 1000000000 / nfc->clock_frequency_in_hz;
> >  
> >  	gpmi_nfc_compute_hardware_timing(this, &hw);
> > @@ -784,8 +812,7 @@ err_out:
> >  
> >  void gpmi_end(struct gpmi_nand_data *this)
> >  {
> > -	struct resources *r = &this->resources;
> > -	clk_disable_unprepare(r->clock);
> > +	gpmi_disable_clk(this);
> >  }
> >  
> >  /* Clears a BCH interrupt. */
> > diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
> > index 941cfb7..edda3b1 100644
> > --- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
> > +++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
> > @@ -464,9 +464,59 @@ acquire_err:
> >  	return -EINVAL;
> >  }
> >  
> > +static void gpmi_put_clks(struct gpmi_nand_data *this)
> > +{
> > +	struct resources *r = &this->resources;
> > +	struct clk *clk;
> > +	int i;
> > +
> > +	for (i = 0; i < GPMI_CLK_MAX; i++) {
> > +		clk = r->clock[i];
> > +		if (clk) {
> > +			clk_put(clk);
> > +			r->clock[i] = NULL;
> > +		}
> > +	}
> > +}
> > +
> > +static char *extra_clks_for_mx6q[] = {
> > +	"gpmi_apb", "gpmi_bch", "gpmi_bch_apb", "per1_bch",
> > +};
> > +
> > +static int __devinit gpmi_get_clks(struct gpmi_nand_data *this)
> > +{
> > +	struct resources *r = &this->resources;
> > +	char **extra_clks = NULL;
> > +	struct clk *clk;
> > +	int i;
> > +
> > +	r->clock[0] = clk_get(&this->pdev->dev, NULL);
> > +	if (IS_ERR(r->clock[0]))
> > +		goto err_clock;
> > +
> > +	/* Get extra clocks */
> > +	if (GPMI_IS_MX6Q(this))
> > +		extra_clks = extra_clks_for_mx6q;
> 
> We probably do not need this tweaking.  We can have the driver always
> take all those 5 clocks, and I think the current imx28 clock driver
> can just work with it, because the gpmi-nand clkdev lookup has NULL
> con_id and all those 5 clocks can match the same one on imx28.
> 
Will mx28 fail if doing like that?
clk_get will fail if no clock found.
struct clk *clk_get_sys(const char *dev_id, const char *con_id)
{
        struct clk_lookup *cl;

        mutex_lock(&clocks_mutex);
        cl = clk_find(dev_id, con_id);
        if (cl && !__clk_get(cl->clk))
                cl = NULL;
        mutex_unlock(&clocks_mutex);

        return cl ? cl->clk : ERR_PTR(-ENOENT);
}
EXPORT_SYMBOL(clk_get_sys);

Furthermore, find unnecessary clock for mx28 seems not a good choice.
Probably a better way is to define each SoC required clocks and get them
respectively. It's explicit and clear.

Regards
Dong Aisheng
