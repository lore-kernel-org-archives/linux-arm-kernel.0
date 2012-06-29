From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Fri, 29 Jun 2012 11:29:26 +0200
Subject: [PATCH 3/3] mtd: gpmi: change the code for clocks
In-Reply-To: <20120629063329.GE5844@shlinux2.ap.freescale.net>
References: <1340941925-14591-1-git-send-email-shijie8@gmail.com>
 <1340941925-14591-3-git-send-email-shijie8@gmail.com>
 <20120629020650.GB28932@S2101-09.ap.freescale.net>
 <20120629063329.GE5844@shlinux2.ap.freescale.net>
Message-ID: <20461.30070.771087.830745@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Dong Aisheng writes:
> On Fri, Jun 29, 2012 at 10:06:52AM +0800, Shawn Guo wrote:
> > On Thu, Jun 28, 2012 at 11:52:05PM -0400, Huang Shijie wrote:
> > > From: Huang Shijie <b32955@freescale.com>
> > > 
> > > The gpmi nand driver may needs several clocks(MX6Q needs five clocks).
> > > 
> > > In the old clock framework, all these clocks are chained together,
> > > all you need is to manipulate the first clock.
> > > 
> > > But the kernel uses the common clk framework now, which forces us to
> > > get the clocks one by one. When we use them, we have to enable them
> > > one by one too.
> > > 
[...]
> > > +static char *extra_clks_for_mx6q[] = {
> > > +	"gpmi_apb", "gpmi_bch", "gpmi_bch_apb", "per1_bch",
> > > +};
> > > +
> > > +static int __devinit gpmi_get_clks(struct gpmi_nand_data *this)
> > > +{
> > > +	struct resources *r = &this->resources;
> > > +	char **extra_clks = NULL;
> > > +	struct clk *clk;
> > > +	int i;
> > > +
> > > +	r->clock[0] = clk_get(&this->pdev->dev, NULL);
> > > +	if (IS_ERR(r->clock[0]))
> > > +		goto err_clock;
> > > +
> > > +	/* Get extra clocks */
> > > +	if (GPMI_IS_MX6Q(this))
> > > +		extra_clks = extra_clks_for_mx6q;
> > 
> > We probably do not need this tweaking.  We can have the driver always
> > take all those 5 clocks, and I think the current imx28 clock driver
> > can just work with it, because the gpmi-nand clkdev lookup has NULL
> > con_id and all those 5 clocks can match the same one on imx28.
> > 
> Will mx28 fail if doing like that?
> clk_get will fail if no clock found.
> struct clk *clk_get_sys(const char *dev_id, const char *con_id)
> {
>         struct clk_lookup *cl;
> 
>         mutex_lock(&clocks_mutex);
>         cl = clk_find(dev_id, con_id);
>         if (cl && !__clk_get(cl->clk))
>                 cl = NULL;
>         mutex_unlock(&clocks_mutex);
> 
>         return cl ? cl->clk : ERR_PTR(-ENOENT);
> }
> EXPORT_SYMBOL(clk_get_sys);
> 
> Furthermore, find unnecessary clock for mx28 seems not a good choice.
> Probably a better way is to define each SoC required clocks and get them
> respectively. It's explicit and clear.
> 
No, that's silly. You would have to change the driver for each
new platform that the driver can support.

Instead the driver should request the maximum number of clocks that
the existing set of platforms provide and all platforms with fewer
clocks should provide an appropriate number of dummy clocks.

This way new platforms can be supported without any change to the
driver and only if a platform requires even more clocks (like in this
particular case) would some code outside that platform have to be
changed at all.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
