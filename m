From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 26 Jan 2012 22:17:25 +0800
Subject: [PATCH] ARM: mx28evk: Simplify GPIO requests
In-Reply-To: <20257.19440.497133.535581@ipc1.ka-ro>
References: <1327329709-25545-1-git-send-email-fabio.estevam@freescale.com>
 <20120126121938.GB3523@S2101-09.ap.freescale.net>
 <20257.19440.497133.535581@ipc1.ka-ro>
Message-ID: <20120126141722.GA18552@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 26, 2012 at 01:49:52PM +0100, Lothar Wa?mann wrote:
> Hi,
> 
> Shawn Guo writes:
> > On Mon, Jan 23, 2012 at 12:41:49PM -0200, Fabio Estevam wrote:
> > > Requesting all the GPIOs on a single array (mx28evk_gpios[]) can make the 
> > > error handling of gpio_requests much simpler.
> > > 
> > > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> > 
> > Looks good.  A couple trivial comments below though.
> > 
> > > ---
> > > This approach was suggested by Sascha Hauer:
> > > http://patchwork.ozlabs.org/patch/124661/
> > > 
> > >  arch/arm/mach-mxs/mach-mx28evk.c |   72 ++++++++-----------------------------
> > >  1 files changed, 16 insertions(+), 56 deletions(-)
> > > 
> > > diff --git a/arch/arm/mach-mxs/mach-mx28evk.c b/arch/arm/mach-mxs/mach-mx28evk.c
> > > index fdb0a56..6260ec3 100644
> > > --- a/arch/arm/mach-mxs/mach-mx28evk.c
> > > +++ b/arch/arm/mach-mxs/mach-mx28evk.c
> > > @@ -223,7 +223,6 @@ static const struct gpio_led_platform_data mx28evk_led_data __initconst = {
> > >  /* fec */
> > >  static void __init mx28evk_fec_reset(void)
> > >  {
> > > -	int ret;
> > >  	struct clk *clk;
> > >  
> > >  	/* Enable fec phy clock */
> > > @@ -231,32 +230,6 @@ static void __init mx28evk_fec_reset(void)
> > >  	if (!IS_ERR(clk))
> > >  		clk_prepare_enable(clk);
> > >  
> > > -	/* Power up fec phy */
> > > -	ret = gpio_request(MX28EVK_FEC_PHY_POWER, "fec-phy-power");
> > > -	if (ret) {
> > > -		pr_err("Failed to request gpio fec-phy-%s: %d\n", "power", ret);
> > > -		return;
> > > -	}
> > > -
> > > -	ret = gpio_direction_output(MX28EVK_FEC_PHY_POWER, 0);
> > > -	if (ret) {
> > > -		pr_err("Failed to drive gpio fec-phy-%s: %d\n", "power", ret);
> > > -		return;
> > > -	}
> > > -
> > > -	/* Reset fec phy */
> > > -	ret = gpio_request(MX28EVK_FEC_PHY_RESET, "fec-phy-reset");
> > > -	if (ret) {
> > > -		pr_err("Failed to request gpio fec-phy-%s: %d\n", "reset", ret);
> > > -		return;
> > > -	}
> > > -
> > > -	gpio_direction_output(MX28EVK_FEC_PHY_RESET, 0);
> > > -	if (ret) {
> > > -		pr_err("Failed to drive gpio fec-phy-%s: %d\n", "reset", ret);
> > > -		return;
> > > -	}
> > > -
> > >  	mdelay(1);
> > 
> > This delay is supposed to be in the middle of the two calls here.  As
> > we are moving around the first call, can you give it a test to see if
> > the mdelay is still mandatory?  I would remove it if it's not necessary.
> > 
> "Empirical Programming Part One"? The HW will have some timing
> requirements that need to be fullfilled. That cannot be done by
> 'giving it a test' but by reading the appropriate datasheet and
> implementing the code accordingly.
> 
I was thinking that the period of code execution between
gpio_request_array() and this point may have fulfilled the timing
requirement of LAN8720 reset (100us minimum).  But you are right,
this mdelay should not be removed simply by a testing.

But the way that the patch moves thing around leaves this mdelay
a little unreadable to me.  I would like see an explicit call of
gpio_set_value(MX28EVK_FEC_PHY_RESET, 0) before the mdelay.

-- 
Regards,
Shawn
