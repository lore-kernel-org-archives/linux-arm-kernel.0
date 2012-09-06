From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 6 Sep 2012 20:42:56 +0200
Subject: [PATCH 7/9] pwm i.MX: fix clock lookup
In-Reply-To: <996111492.3799131.1346956318651.JavaMail.root@advansee.com>
References: <1346935695-25179-8-git-send-email-s.hauer@pengutronix.de>
 <996111492.3799131.1346956318651.JavaMail.root@advansee.com>
Message-ID: <20120906184256.GJ26594@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 06, 2012 at 08:31:58PM +0200, Beno?t Th?baudeau wrote:
> On Thursday, September 6, 2012 2:48:13 PM, Sascha Hauer wrote:
> > 
> > +	int ret;
> > +
> > +	ret = clk_prepare_enable(imx->clk_ipg);
> > +	if (ret)
> > +		return ret;
> >  
> > -	return imx->config(chip, pwm, duty_ns, period_ns);
> > +	ret = imx->config(chip, pwm, duty_ns, period_ns);
> > +
> > +	clk_disable_unprepare(imx->clk_ipg);
> > +
> > +	return ret;
> >  }
> >  
> >  static int imx_pwm_enable(struct pwm_chip *chip, struct pwm_device
> >  *pwm)
> > @@ -169,7 +179,7 @@ static int imx_pwm_enable(struct pwm_chip *chip,
> > struct pwm_device *pwm)
> >  	struct imx_chip *imx = to_imx_chip(chip);
> >  	int ret;
> >  
> > -	ret = clk_prepare_enable(imx->clk);
> > +	ret = clk_prepare_enable(imx->clk_per);
> >  	if (ret)
> >  		return ret;
> 
> Have you tested that this actually works on i.MX53?
> 
> I have tested it successfully on i.MX35 (with a few additions to platform code).
> But i.MX35 has a single bit controlling both PWM IPG and PER clock gates.
> 
> On i.MX53, there are 2 separate control bits for these. So, if ipg clk is
> strictly required to access PWM registers, even if per clk is enabled, this code
> should not work without adding

I tested this on i.MX53, but you're right, this seems to be wrong. I'll
recheck tomorrow.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
