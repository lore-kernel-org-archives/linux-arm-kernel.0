From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Sat, 4 Jun 2016 08:26:08 +0200
Subject: [PATCH 05/14] pwm: rockchip: Avoid glitches on already running
 PWMs
In-Reply-To: <20160603202859.GD124478@google.com>
References: <1464942192-25967-1-git-send-email-boris.brezillon@free-electrons.com>
 <1464942192-25967-6-git-send-email-boris.brezillon@free-electrons.com>
 <20160603202859.GD124478@google.com>
Message-ID: <20160604082608.041925a7@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 3 Jun 2016 13:28:59 -0700
Brian Norris <briannorris@chromium.org> wrote:

> Hi,
> 
> Just noticed a few things:
> 
> On Fri, Jun 03, 2016 at 10:23:03AM +0200, Boris Brezillon wrote:
> > The current logic will disable the PWM clk even if the PWM was left
> > enabled by the bootloader (because it's controlling a critical device
> > like a regulator for example).
> > Keep the PWM clk enabled if the PWM is enabled to avoid any glitches.
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > ---
> >  drivers/pwm/pwm-rockchip.c | 24 +++++++++++++++++++++++-
> >  1 file changed, 23 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
> > index dfacf7d..798a787 100644
> > --- a/drivers/pwm/pwm-rockchip.c
> > +++ b/drivers/pwm/pwm-rockchip.c
> > @@ -299,6 +299,7 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
> >  {
> >  	const struct of_device_id *id;
> >  	struct rockchip_pwm_chip *pc;
> > +	struct pwm_state state;
> >  	struct resource *r;
> >  	int ret;
> >  
> > @@ -319,7 +320,7 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
> >  	if (IS_ERR(pc->clk))
> >  		return PTR_ERR(pc->clk);
> >  
> > -	ret = clk_prepare(pc->clk);
> > +	ret = clk_prepare_enable(pc->clk);
> >  	if (ret)
> >  		return ret;
> >  
> > @@ -342,12 +343,33 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
> >  		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
> >  	}
> >  
> > +	/* Keep the PWM clk enabled if the PWM appears to be up and running. */
> > +	pwm_get_state(pc->chip.pwms, &state);
> > +	if (!state.enabled)  
> 
> Why not just if (!pwm_is_enabled())?

It's a leftover from a previous version where I was deprecating
pwm_enable(). I'll switch back to pwm_enable().

Thanks,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
