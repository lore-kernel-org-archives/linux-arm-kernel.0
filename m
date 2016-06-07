From: briannorris@chromium.org (Brian Norris)
Date: Tue, 7 Jun 2016 10:26:19 -0700
Subject: [PATCH 04/14] pwm: rockchip: Add support for hardware readout
In-Reply-To: <20160604082426.493b220d@bbrezillon>
References: <1464942192-25967-1-git-send-email-boris.brezillon@free-electrons.com>
 <1464942192-25967-5-git-send-email-boris.brezillon@free-electrons.com>
 <20160603202006.GC124478@google.com>
 <20160604082426.493b220d@bbrezillon>
Message-ID: <20160607172619.GB130037@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 04, 2016 at 08:24:26AM +0200, Boris Brezillon wrote:
> On Fri, 3 Jun 2016 13:20:06 -0700 Brian Norris <briannorris@chromium.org> wrote:
> > On Fri, Jun 03, 2016 at 10:23:02AM +0200, Boris Brezillon wrote:
> > > @@ -75,6 +77,19 @@ static void rockchip_pwm_set_enable_v1(struct pwm_chip *chip,
> > >  	writel_relaxed(val, pc->base + pc->data->regs.ctrl);
> > >  }
> > >  
> > > +static void rockchip_pwm_get_state_v1(struct pwm_chip *chip,
> > > +				      struct pwm_device *pwm,
> > > +				      struct pwm_state *state)
> > > +{
> > > +	struct rockchip_pwm_chip *pc = to_rockchip_pwm_chip(chip);
> > > +	u32 enable_conf = PWM_CTRL_OUTPUT_EN | PWM_CTRL_TIMER_EN;
> > > +	u32 val;
> > > +
> > > +	val = readl(pc->base + pc->data->regs.ctrl);  
> > 
> > Nit: I just noticed you've been starting to use readl()/writel() in this
> > series, where previously {readl,writel}_relaxed() were being used. Any
> > reason?
> 
> Because I'm lazy and usually don't take the time to think whether it's
> safe of not to use the _relaxed() versions :-). Not sure you'll have a
> noticeable improvement by using _relaxed() for a PWM device by the
> way, but I can change that ;-).

I just figured consistency would be nice.

Brian
