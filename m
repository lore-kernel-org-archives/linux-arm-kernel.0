From: avinashphilip@ti.com (Philip, Avinash)
Date: Thu, 10 Jan 2013 04:11:42 +0000
Subject: [PATCH 3/7] pwm: pwm-tiehrpwm: Update the clock handling of
 pwm-tiehrpwm driver
In-Reply-To: <20130102133843.GA4414@avionic-0098.adnet.avionic-design.de>
References: <1357133094-30806-1-git-send-email-avinashphilip@ti.com>
 <1357133094-30806-4-git-send-email-avinashphilip@ti.com>
 <20130102133843.GA4414@avionic-0098.adnet.avionic-design.de>
Message-ID: <518397C60809E147AF5323E0420B992E3EA5A510@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 02, 2013 at 19:08:43, Thierry Reding wrote:
> On Wed, Jan 02, 2013 at 06:54:50PM +0530, Philip Avinash wrote:
> > The clock framework has changed and it's now better to invoke
> > clock_prepare_enable() and clk_disable_unprepare() rather than the
> > legacy clk_enable() and clk_disable() calls. This patch converts the
> > pwm-tiehrpwm driver to the new framework.
> > 
> > Signed-off-by: Philip Avinash <avinashphilip@ti.com>
> > Cc: Thierry Reding <thierry.reding@avionic-design.de>
> > ---
> > In 3.8-rc1, common clock frame work support added to AM335x.
> > 
> >  drivers/pwm/pwm-tiehrpwm.c |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
> > index 72a6dd4..af6f162 100644
> > --- a/drivers/pwm/pwm-tiehrpwm.c
> > +++ b/drivers/pwm/pwm-tiehrpwm.c
> > @@ -341,7 +341,7 @@ static int ehrpwm_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
> >  	configure_polarity(pc, pwm->hwpwm);
> >  
> >  	/* Enable TBCLK before enabling PWM device */
> > -	clk_enable(pc->tbclk);
> > +	clk_prepare_enable(pc->tbclk);
> 
> I apparently didn't catch this before, but maybe it would be useful to
> check the return value here to make sure we only proceed if the clock
> can actually be enabled.

Ok I will check return value & make it return status of pwm_enable().
I will send it as individual patch in next series. I am waiting for
reviews / acceptance of HWMOD and clock tree node patches.

Thanks
Avinash

> 
> Thierry
> 
