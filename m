From: benoit.thebaudeau@advansee.com (=?utf-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?=)
Date: Thu, 6 Sep 2012 21:09:42 +0200 (CEST)
Subject: [PATCH 7/9] pwm i.MX: fix clock lookup
In-Reply-To: <20120906184256.GJ26594@pengutronix.de>
Message-ID: <1355578446.3801048.1346958582085.JavaMail.root@advansee.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, September 6, 2012 8:42:56 PM, Sascha Hauer wrote:
> On Thu, Sep 06, 2012 at 08:31:58PM +0200, Beno?t Th?baudeau wrote:
> > On Thursday, September 6, 2012 2:48:13 PM, Sascha Hauer wrote:
> > > 
> > > +	int ret;
> > > +
> > > +	ret = clk_prepare_enable(imx->clk_ipg);
> > > +	if (ret)
> > > +		return ret;
> > >  
> > > -	return imx->config(chip, pwm, duty_ns, period_ns);
> > > +	ret = imx->config(chip, pwm, duty_ns, period_ns);
> > > +
> > > +	clk_disable_unprepare(imx->clk_ipg);
> > > +
> > > +	return ret;
> > >  }
> > >  
> > >  static int imx_pwm_enable(struct pwm_chip *chip, struct
> > >  pwm_device
> > >  *pwm)
> > > @@ -169,7 +179,7 @@ static int imx_pwm_enable(struct pwm_chip
> > > *chip,
> > > struct pwm_device *pwm)
> > >  	struct imx_chip *imx = to_imx_chip(chip);
> > >  	int ret;
> > >  
> > > -	ret = clk_prepare_enable(imx->clk);
> > > +	ret = clk_prepare_enable(imx->clk_per);
> > >  	if (ret)
> > >  		return ret;
> > 
> > Have you tested that this actually works on i.MX53?
> > 
> > I have tested it successfully on i.MX35 (with a few additions to
> > platform code).
> > But i.MX35 has a single bit controlling both PWM IPG and PER clock
> > gates.
> > 
> > On i.MX53, there are 2 separate control bits for these. So, if ipg
> > clk is
> > strictly required to access PWM registers, even if per clk is
> > enabled, this code
> > should not work without adding
> 
> I tested this on i.MX53, but you're right, this seems to be wrong.
> I'll
> recheck tomorrow.

I've performed a few more tests with bare register accesses in the bootloader to
see how the PWM IP behaves.

On i.MX25, i.MX35 and i.MX51, read accesses always work, whatever the state of
the IPG and PER clock gates.

On i.MX25 and i.MX51, write accesses always work, whatever the state of the IPG
and PER clock gates.

On i.MX35, write accesses work if and only if the IPG and PER clocks are not
gated off (single control bit for both).

I don't have i.MX53 or i.MX6Q platforms to test that.

Best regards,
Beno?t
