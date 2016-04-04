From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 4 Apr 2016 17:20:48 +0200
Subject: [PATCH v5 08/46] hwmon: pwm-fan: use pwm_get_args() where
 appropriate
In-Reply-To: <20160331090709.5c3bdf70@bbrezillon>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459368249-13241-9-git-send-email-boris.brezillon@free-electrons.com>
 <20160330225244.GA24044@roeck-us.net>
 <20160331090709.5c3bdf70@bbrezillon>
Message-ID: <20160404152048.GA17856@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 31, 2016 at 09:07:09AM +0200, Boris Brezillon wrote:
> Hi Guenter,
> 
> On Wed, 30 Mar 2016 15:52:44 -0700
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
> > On Wed, Mar 30, 2016 at 10:03:31PM +0200, Boris Brezillon wrote:
> > > The PWM framework has clarified the concept of reference PWM config
> > > (the platform dependent config retrieved from the DT or the PWM
> > > lookup table) and real PWM state.
> > > 
> > > Use pwm_get_args() when the PWM user wants to retrieve this reference
> > > config and not the current state.
> > > 
> > > This is part of the rework allowing the PWM framework to support
> > > hardware readout and expose real PWM state even when the PWM has
> > > just been requested (before the user calls pwm_config/enable/disable()).
> > > 
> > > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > > ---
> > >  drivers/hwmon/pwm-fan.c | 19 +++++++++++++------
> > >  1 file changed, 13 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
> > > index 3e23003..82c5656 100644
> > > --- a/drivers/hwmon/pwm-fan.c
> > > +++ b/drivers/hwmon/pwm-fan.c
> > > @@ -40,15 +40,18 @@ struct pwm_fan_ctx {
> > >  
> > >  static int  __set_pwm(struct pwm_fan_ctx *ctx, unsigned long pwm)
> > >  {
> > > +	struct pwm_args pargs = { };
> > 
> > Hi Boris,
> > 
> > I guess I am missing some context; sorry for that. Unfortunately,
> > I did not easily find an explanation, so please bear with me.
> > 
> > Two questions: Why do we need a local copy of struct pwm_args instead
> > of a pointer to it ? If it can change while being used, isn't it
> > inconsistent anyway ?
> 
> It cannot change after pwm_get() is called. For the reason behind
> prototype: I just followed the Thierry's proposal, but I'm perfectly
> fine returning a const struct pwm_args pointer intead of passing
> pwm_args as a parameter.
> 
> Thierry, what's your opinion?

I do prefer the current variant because it is more consistent with the
new atomic API, even if not strictly necessary because of the immutable
data.

> > Also, assuming the local copy is necessary, why initialize pargs ? 
> > After all, pwm_get_args() just overwrites it.
> 
> It's a leftover from a previous version where pwm_get_args was
> implemented this way:
> 
> static inline void pwm_get_args(pwm, args)
> {
> 	if (pwm)
> 		*args = pwm->args
> }
> 
> and this implementation was generating a lot of 'uninitialized
> variable' warnings.
> 
> I just decided to drop the 'if (pwm)' test, because, IMO, this
> should be checked way before calling pwm_get_args() is called.

Sounds fine to me.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160404/02a14af6/attachment.sig>
