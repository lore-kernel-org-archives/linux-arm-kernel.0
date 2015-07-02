From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 2 Jul 2015 09:46:50 +0200
Subject: [RFC PATCH 12/15] pwm: rockchip: add initial state retrieval
In-Reply-To: <3258341.kaLi8uDfLr@diego>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
 <1435738921-25027-13-git-send-email-boris.brezillon@free-electrons.com>
 <3258341.kaLi8uDfLr@diego>
Message-ID: <20150702094650.2f934b22@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 01 Jul 2015 23:44:46 +0200
Heiko St?bner <heiko@sntech.de> wrote:

> Hi Boris,
> 
> Am Mittwoch, 1. Juli 2015, 10:21:58 schrieb Boris Brezillon:
> > Implement the ->init_state() function to expose initial state.
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > ---
> 
> [...]
> 
> > @@ -98,6 +110,36 @@ static void rockchip_pwm_set_enable_v2(struct pwm_chip
> > *chip, writel_relaxed(val, pc->base + pc->data->regs.ctrl);
> >  }
> > 
> > +static void rockchip_pwm_init_state(struct pwm_chip *chip,
> > +				    struct pwm_device *pwm)
> > +{
> > +	struct rockchip_pwm_chip *pc = to_rockchip_pwm_chip(chip);
> > +	unsigned long clk_rate;
> > +	u64 tmp;
> > +	int ret;
> > +
> > +	ret = clk_enable(pc->clk);
> > +	if (ret)
> > +		return;
> > +
> > +	clk_rate = clk_get_rate(pc->clk);
> > +
> > +	tmp = readl(pc->base + pc->data->regs.period);
> > +	tmp *= pc->data->prescaler * NSEC_PER_SEC;
> > +	tmp = do_div(tmp, clk_rate);
> 
> I guess you want to have the division result here and not the remainder, so
> -       tmp = do_div(tmp, clk_rate);
> +       do_div(tmp, clk_rate);
> 

Oh crap. I make the same mistake over and over again.

[...]
> >  static const struct rockchip_pwm_data pwm_data_v2 = {
> > @@ -207,6 +252,7 @@ static const struct rockchip_pwm_data pwm_data_v2 = {
> >  	.prescaler = 1,
> >  	.ops = &rockchip_pwm_ops_v2,
> >  	.set_enable = rockchip_pwm_set_enable_v2,
> > +	.init = rockchip_pwm_init_v2,
> 
> you're referencing the v2 init here, but only add it in the next patch?
> [pwm: rockchip: add support for atomic update]

Yep, this function should be added in this patch.

Thanks,

Boris


-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
