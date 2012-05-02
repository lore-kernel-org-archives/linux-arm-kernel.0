From: richard.zhao@freescale.com (Richard Zhao)
Date: Wed, 2 May 2012 19:00:11 +0800
Subject: [PATCH 10/11] ARM: imx6q_sabrelite: clkdev_add cko1 for sgtl5000
In-Reply-To: <20120501124706.GF2194@S2101-09.ap.freescale.net>
References: <1335510185-7906-1-git-send-email-richard.zhao@freescale.com>
 <1335510185-7906-11-git-send-email-richard.zhao@freescale.com>
 <20120501124706.GF2194@S2101-09.ap.freescale.net>
Message-ID: <20120502110011.GD2982@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 01, 2012 at 08:47:10PM +0800, Shawn Guo wrote:
> On Fri, Apr 27, 2012 at 03:03:04PM +0800, Richard Zhao wrote:
> > Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> > ---
> >  arch/arm/mach-imx/clk-imx6q.c  |    3 +++
> >  arch/arm/mach-imx/mach-imx6q.c |   28 ++++++++++++++++++++++++++++
> >  2 files changed, 31 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
> > index 9a03dcc..4ea0de0 100644
> > --- a/arch/arm/mach-imx/clk-imx6q.c
> > +++ b/arch/arm/mach-imx/clk-imx6q.c
> > @@ -419,6 +419,9 @@ int __init mx6q_clocks_init(void)
> >  	clk_register_clkdev(clk[dummy], NULL, "20bc000.wdog");
> >  	clk_register_clkdev(clk[dummy], NULL, "20c0000.wdog");
> >  	clk_register_clkdev(clk[ssi1], NULL, "2028000.ssi");
> > +	clk_register_clkdev(clk[cko1_sel], "cko1_sel", NULL);
> > +	clk_register_clkdev(clk[ahb], "ahb", NULL);
> > +	clk_register_clkdev(clk[cko1], "cko1", NULL);
> >  
> >  	for (i = 0; i < ARRAY_SIZE(clks_init_on); i++) {
> >  		c = clk_get_sys(clks_init_on[i], NULL);
> > diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
> > index d25c5d8..e9b2522 100644
> > --- a/arch/arm/mach-imx/mach-imx6q.c
> > +++ b/arch/arm/mach-imx/mach-imx6q.c
> > @@ -10,6 +10,8 @@
> >   * http://www.gnu.org/copyleft/gpl.html
> >   */
> >  
> > +#include <linux/clkdev.h>
> > +#include <linux/clk.h>
> 
> Nit: I would have <linux/clk.h> put before <linux/clkdev.h>.
ok
> 
> >  #include <linux/delay.h>
> >  #include <linux/init.h>
> >  #include <linux/io.h>
> > @@ -75,10 +77,36 @@ static int ksz9021rn_phy_fixup(struct phy_device *phydev)
> >  	return 0;
> >  }
> >  
> > +static void __init imx6q_cko1_setup(void)
> 
> I would say this is a sabrelite specific setup so far.
ok
> 
> > +{
> > +	struct clk *cko1_sel, *ahb, *cko1;
> > +	unsigned long rate;
> > +
> > +	cko1_sel = clk_get_sys(NULL, "cko1_sel");
> > +	ahb = clk_get_sys(NULL, "ahb");
> > +	cko1 = clk_get_sys(NULL, "cko1");
> > +	if (IS_ERR(cko1_sel) || IS_ERR(ahb) || IS_ERR(cko1)) {
> > +		printk(KERN_ERR "cko1 setup failed!\n");
> 
> pr_err
ok

Thanks
Richard
> 
> > +		goto put_clk;
> > +	}
> > +	clk_set_parent(cko1_sel, ahb);
> > +	rate = clk_round_rate(cko1, 16000000);
> > +	clk_set_rate(cko1, rate);
> > +	clk_register_clkdev(cko1, NULL, "0-000a");
> 
> This dev_id looks a little strange to me.  I understand that's the
> consequence of having sgtl5000 clock managed in ASoC machine driver
> imx-sgtl5000.  IMO, having sgtl5000 driver manages its clock and
> looking up the clock with dev_id simply as "sgtl5000" makes more
> sense to me.  Will put more comment on your imx-sgtl5000 clock patch.
> 
> Regards,
> Shawn
> 
> > +put_clk:
> > +	if (!IS_ERR(cko1_sel))
> > +		clk_put(cko1_sel);
> > +	if (!IS_ERR(ahb))
> > +		clk_put(ahb);
> > +	if (!IS_ERR(cko1))
> > +		clk_put(cko1);
> > +}
> > +
> >  static void __init imx6q_sabrelite_init(void)
> >  {
> >  	phy_register_fixup_for_uid(PHY_ID_KSZ9021, MICREL_PHY_ID_MASK,
> >  				ksz9021rn_phy_fixup);
> > +	imx6q_cko1_setup();
> >  }
> >  
> >  static void __init imx6q_init_machine(void)
> > -- 
> > 1.7.5.4
> > 
> > 
> 
