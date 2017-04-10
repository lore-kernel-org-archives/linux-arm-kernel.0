From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 10 Apr 2017 17:10:11 +0200
Subject: [PATCH] drivers: pwm: pwm-atmel: implement suspend/resume
 functions
In-Reply-To: <20170410163558.494cf9be@bbrezillon>
References: <1491834020-3194-1-git-send-email-claudiu.beznea@microchip.com>
 <20170410163558.494cf9be@bbrezillon>
Message-ID: <20170410151011.GA18753@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 10, 2017 at 04:35:58PM +0200, Boris Brezillon wrote:
> On Mon, 10 Apr 2017 17:20:20 +0300
> Claudiu Beznea <claudiu.beznea@microchip.com> wrote:
> 
> > Implement suspend and resume power management specific
> > function to allow PWM controller to correctly suspend
> > and resume.
> > 
> > Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> > ---
> >  drivers/pwm/pwm-atmel.c | 81 +++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 81 insertions(+)
> > 
> > diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
> > index 530d7dc..75177c6 100644
> > --- a/drivers/pwm/pwm-atmel.c
> > +++ b/drivers/pwm/pwm-atmel.c
> > @@ -58,6 +58,8 @@
> >  #define PWM_MAX_PRD		0xFFFF
> >  #define PRD_MAX_PRES		10
> >  
> > +#define PWM_MAX_CH_NUM		(4)
> > +
> >  struct atmel_pwm_registers {
> >  	u8 period;
> >  	u8 period_upd;
> > @@ -65,11 +67,18 @@ struct atmel_pwm_registers {
> >  	u8 duty_upd;
> >  };
> >  
> > +struct atmel_pwm_pm_ctx {
> > +	u32 cmr;
> > +	u32 cdty;
> > +	u32 cprd;
> > +};
> > +
> >  struct atmel_pwm_chip {
> >  	struct pwm_chip chip;
> >  	struct clk *clk;
> >  	void __iomem *base;
> >  	const struct atmel_pwm_registers *regs;
> > +	struct atmel_pwm_pm_ctx ctx[PWM_MAX_CH_NUM];
> 
> Hm, I'm pretty sure you can rely on the current PWM state and call
> atmel_pwm_apply() at resume time instead of doing that. See what I did
> here [1].
> 
> Thierry, maybe it's time to start thinking about a generic solution to
> save/restore PWM states.

Generally speaking I think applying the states are the right way to go.
Ideally the PWM core could simply resume all of the PWM channels that a
device exports and the ->apply() callback would be enough to restore
that. I'm not sure if that's going to work with current implementations,
though. Your pwm-atmel-hlcdc patch certainly indicates that we're not
quite there yet.

On the other hand, I'm beginning to think that maybe PWMs are too low-
level for this kind of suspend/resume. For example if you use the PWM to
control a backlight brightness, restoring it via the driver core's
resume hook is potentially going to turn it back on at the wrong time. I
have a feeling that we might be better off just pushing this up to the
PWM users. A slight special case might be sysfs, for which no external
user driver exists. But we already have separate data structures to keep
track of sysfs-related context, so suspend/resume support could be added
there.

Any thoughts on that?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170410/8dd56f59/attachment-0001.sig>
