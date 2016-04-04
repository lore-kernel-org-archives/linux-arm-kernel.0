From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 4 Apr 2016 17:34:33 +0200
Subject: [PATCH v5 36/46] input: misc: max77693: switch to the atomic API
In-Reply-To: <20160331205718.057a6f38@bbrezillon>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459368249-13241-37-git-send-email-boris.brezillon@free-electrons.com>
 <20160331174801.GC39098@dtor-ws>
 <20160331205718.057a6f38@bbrezillon>
Message-ID: <20160404153433.GD17856@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 31, 2016 at 08:57:18PM +0200, Boris Brezillon wrote:
> On Thu, 31 Mar 2016 10:48:01 -0700
> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> 
> > Hi Boris,
> > 
> > On Wed, Mar 30, 2016 at 10:03:59PM +0200, Boris Brezillon wrote:
> > > pwm_config/enable/disable() have been deprecated and should be replaced
> > > by pwm_apply_state().
> > > 
> > > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > > ---
> > >  drivers/input/misc/max77693-haptic.c | 23 +++++++++++++++++------
> > >  1 file changed, 17 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/drivers/input/misc/max77693-haptic.c b/drivers/input/misc/max77693-haptic.c
> > > index cf6aac0..aef7dc4 100644
> > > --- a/drivers/input/misc/max77693-haptic.c
> > > +++ b/drivers/input/misc/max77693-haptic.c
> > > @@ -70,13 +70,16 @@ struct max77693_haptic {
> > >  
> > >  static int max77693_haptic_set_duty_cycle(struct max77693_haptic *haptic)
> > >  {
> > > +	struct pwm_state pstate;
> > >  	struct pwm_args pargs = { };
> > > -	int delta;
> > >  	int error;
> > >  
> > >  	pwm_get_args(haptic->pwm_dev, &pargs);
> > > -	delta = (pargs.period + haptic->pwm_duty) / 2;
> > > -	error = pwm_config(haptic->pwm_dev, delta, pargs.period);
> > > +	pwm_get_state(haptic->pwm_dev, &pstate);
> > > +
> > > +	pstate.period = pargs.period;
> > > +	pstate.duty_cycle = (pargs.period + haptic->pwm_duty) / 2;
> > > +	error = pwm_apply_state(haptic->pwm_dev, &pstate);
> > 
> > This does not make sense with regard to the atomic API. If you look in
> > max77693_haptic_play_work(), right after calling
> > max77693_haptic_set_duty_cycle() we either try to enable or disable the
> > pwm. When switching to this new API we should combine both actions.
> 
> True. I'll address that, unless Thierry is fine keeping the non-atomic
> API, in which case I'll just drop patches 32 to 46.

I'm fine with keeping the pwm_enable(), pwm_disable() and pwm_config()
APIs, but they should only be used as shortcuts. Where possible the new
atomic API should be used to combine multiple operations into one.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160404/1c55206f/attachment.sig>
