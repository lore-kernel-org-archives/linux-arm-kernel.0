From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 12 Apr 2016 14:17:18 +0200
Subject: [PATCH v5 15/46] pwm: introduce the pwm_state concept
In-Reply-To: <20160412114904.GM18882@ulmo.ba.sec>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459368249-13241-16-git-send-email-boris.brezillon@free-electrons.com>
 <20160412114904.GM18882@ulmo.ba.sec>
Message-ID: <20160412141718.5fe4cf24@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 12 Apr 2016 13:49:04 +0200
Thierry Reding <thierry.reding@gmail.com> wrote:

> On Wed, Mar 30, 2016 at 10:03:38PM +0200, Boris Brezillon wrote:
> > The PWM state, represented by its period, duty_cycle and polarity,
> > is currently directly stored in the PWM device.
> > Declare a pwm_state structure embedding those field so that we can later
> > use this struct to atomically update all the PWM parameters at once.
> > 
> > All pwm_get_xxx() helpers are now implemented as wrappers around
> > pwm_get_state().
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > ---
> >  drivers/pwm/core.c  |  8 ++++----
> >  include/linux/pwm.h | 54 +++++++++++++++++++++++++++++++++++++++++------------
> >  2 files changed, 46 insertions(+), 16 deletions(-)
> > 
> > diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> > index 6433059..f3f91e7 100644
> > --- a/drivers/pwm/core.c
> > +++ b/drivers/pwm/core.c
> > @@ -268,7 +268,7 @@ int pwmchip_add_with_polarity(struct pwm_chip *chip,
> >  		pwm->chip = chip;
> >  		pwm->pwm = chip->base + i;
> >  		pwm->hwpwm = i;
> > -		pwm->polarity = polarity;
> > +		pwm->state.polarity = polarity;
> 
> Would this not more correctly be assigned to pwm->args.polarity? After
> all this is setting up the "initial" state, much like DT or the lookup
> tables would for duty cycle and period.

Yes, I wasn't sure about the pwm_add_with_polarity() meaning. To me,
all the reference info should be extracted from DT, PWM lookup table or
driver specific ->request() implementation, but I can definitely
initialize the args.polarity here too.

Should I keep the pwm->state.polarity assignment (to set the initial
polarity when the driver does not support hardware readout)?

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
