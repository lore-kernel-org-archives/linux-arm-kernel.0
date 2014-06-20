From: thierry.reding@gmail.com (Thierry Reding)
Date: Sat, 21 Jun 2014 00:29:54 +0200
Subject: [PATCH 1/3] pwm: add Rockchip SoC PWM support
In-Reply-To: <20140620220034.GA927@gmail.com>
References: <1399504115-16257-1-git-send-email-b.galvani@gmail.com>
 <1399504115-16257-2-git-send-email-b.galvani@gmail.com>
 <20140617214253.GA24743@mithrandir>
 <20140620220034.GA927@gmail.com>
Message-ID: <20140620222953.GC29400@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 21, 2014 at 12:00:36AM +0200, Beniamino Galvani wrote:
> On Tue, Jun 17, 2014 at 11:42:58PM +0200, Thierry Reding wrote:
> > On Thu, May 08, 2014 at 01:08:33AM +0200, Beniamino Galvani wrote:
[...]
> > > diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
[...]
> > > +static int rockchip_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
> > > +			       int duty_ns, int period_ns)
> > > +{
> > > +	struct rockchip_pwm_chip *pc = to_rockchip_pwm_chip(chip);
> > > +	unsigned long clk_rate, period, duty;
> > > +	u64 div;
> > > +	int ret;
> > > +
> > > +	clk_rate = clk_get_rate(pc->clk);
> > > +
> > > +	/*
> > > +	 * Since period and duty cycle registers have a width of 32
> > > +	 * bits, every possible input period can be obtained using the
> > > +	 * default prescaler value for all practical clock rate values.
> > > +	 */
> > > +	div = clk_rate;
> > > +	div *= period_ns;
> > 
> > Perhaps shorten this to "div = clk_rate * period_ns;"?
> 
> I will change this, adding a cast to avoid the truncation of the
> result to 32 bits: "div = (u64)clk_rate * period_ns;"

Alternatively you could simply make clk_rate a u64 since it's only used
in this context anyway.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140621/7a94349a/attachment.sig>
