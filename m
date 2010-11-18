From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 18 Nov 2010 13:04:50 +0100
Subject: [PATCH 3/5] mx51: Add mx51 processor to the pwm driver
In-Reply-To: <20101118101541.GW6017@pengutronix.de>
References: <766471.7361.qm@web51008.mail.re2.yahoo.com>
	<20101116195032.GU8942@pengutronix.de>
	<20101118101541.GW6017@pengutronix.de>
Message-ID: <20101118120450.GM8942@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 18, 2010 at 11:15:41AM +0100, Sascha Hauer wrote:
> On Tue, Nov 16, 2010 at 08:50:32PM +0100, Uwe Kleine-K?nig wrote:
> > On Tue, Nov 16, 2010 at 10:36:35AM -0800, Fabio Estevam wrote:
> > > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> > > ---
> > >  arch/arm/plat-mxc/pwm.c |? ? 8 +++++---
> > >  1 files changed, 5 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/arch/arm/plat-mxc/pwm.c b/arch/arm/plat-mxc/pwm.c
> > > index c36f263..c6cdced 100644
> > > --- a/arch/arm/plat-mxc/pwm.c
> > > +++ b/arch/arm/plat-mxc/pwm.c
> > > @@ -26,7 +26,7 @@
> > >  #define MX1_PWMP? ? 0x08???/* PWM Period Register */
> > >  
> > >  
> > > -/* i.MX27, i.MX31, i.MX35 share the same PWM function block: */
> > > +/* i.MX25/27/31/35/51 share the same PWM function block: */
> > If this is correct, ...
> > >  
> > >  #define MX3_PWMCR? ? ? ? ? ? ? ???0x00? ? /* PWM Control Register */
> > >  #define MX3_PWMSAR? ? ? ? ? ? ? ? 0x0C? ? /* PWM Sample Register */
> > > @@ -57,7 +57,7 @@ int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
> > >  ??? if (pwm == NULL || period_ns == 0 || duty_ns > period_ns)
> > >  ??? ??? return -EINVAL;
> > >  
> > > -??? if (cpu_is_mx27() || cpu_is_mx3() || cpu_is_mx25()) {
> > > +??? if (cpu_is_mx27() || cpu_is_mx3() || cpu_is_mx25() || cpu_is_mx51()) {
> > >  ??? ??? unsigned long long c;
> > >  ??? ??? unsigned long period_cycles, duty_cycles, prescale;
> > >  ??? ??? u32 cr;
> > > @@ -79,7 +79,7 @@ int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
> > >  
> > >  ??? ??? cr = MX3_PWMCR_PRESCALER(prescale) | MX3_PWMCR_EN;
> > >  
> > > -??? ??? if (cpu_is_mx25())
> > > +??? ??? if (cpu_is_mx25() || cpu_is_mx51())
> > I wonder why mx27 and mx3 are missing here.
> 
> Look at the code. We are already inside a mx27/3/25 block and we have to
> do this only on mx25.
My intention was to point out, that the statement above
"i.MX25/27/31/35/51 share the same PWM function block" isn't correct.
 
> > 
> > >  ??? ??? ??? cr |= MX3_PWMCR_CLKSRC_IPG;
> > >  ??? ??? else
> > >  ??? ??? ??? cr |= MX3_PWMCR_CLKSRC_IPG_HIGH;
> > > @@ -198,6 +198,7 @@ static int __devinit mxc_pwm_probe(struct platform_device *pdev)
> > >  
> > >  ??? if (IS_ERR(pwm->clk)) {
> > >  ??? ??? ret = PTR_ERR(pwm->clk);
> > > +??? ??? dev_err(&pdev->dev, "can't get PWM clock\n");
> > >  ??? ??? goto err_free;
> > >  ??? }
> > >  
> > > @@ -233,6 +234,7 @@ static int __devinit mxc_pwm_probe(struct platform_device *pdev)
> > >  ??? mutex_unlock(&pwm_lock);
> > >  
> > >  ??? platform_set_drvdata(pdev, pwm);
> > > +??? dev_info(&pdev->dev, "i.MX PWM Driver Enabled\n");
> > >  ??? return 0;
> > >  
> > >  err_free_mem:
> > Some general comments for this driver:
> > 
> >  - should move to drivers/something
> >  - IMHO should use platform ids to get rid of the cpu_is_ stuff
> 
> Agreed, but this of course should be the scope of another patch.
Ack, that's why I called it "general comments for this driver" :-)

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
