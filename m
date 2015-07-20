From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 20 Jul 2015 12:04:51 +0200
Subject: [RFC PATCH 11/15] pwm: add the core infrastructure to allow
 atomic update
In-Reply-To: <20150720114827.2e5d52a5@bbrezillon>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
 <1435738921-25027-12-git-send-email-boris.brezillon@free-electrons.com>
 <20150720085939.GL29614@ulmo> <20150720114827.2e5d52a5@bbrezillon>
Message-ID: <20150720100451.GW29614@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 20, 2015 at 11:48:27AM +0200, Boris Brezillon wrote:
> On Mon, 20 Jul 2015 10:59:40 +0200 Thierry Reding <thierry.reding@gmail.com> wrote:
> > On Wed, Jul 01, 2015 at 10:21:57AM +0200, Boris Brezillon wrote:
[...]
> > > +int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *state)
> > > +{
> > > +	int err = 0;
> > > +
> > > +	if (!pwm)
> > > +		return -EINVAL;
> > > +
> > > +	if (!memcmp(state, &pwm->state, sizeof(*state)))
> > > +		return 0;
> > > +
> > > +	if (pwm->chip->ops->apply) {
> > > +		err = pwm->chip->ops->apply(pwm->chip, pwm, state);
> > > +		if (!err)
> > > +			pwm->state = *state;
> > 
> > Maybe we want pwm_set_state() for this?
> 
> I'm not opposed to the addition of the pwm_set_state() function as long
> as it's a private one: I don't want to let PMW drivers or users mess up
> with the current PWM state.

Yeah, it could be a static function in core.c. What I want to avoid is
having to change a bunch of code if ever state assignment becomes
something other than merely copying a structure.

[...]
> > > diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> > > index b47244a..7e99679 100644
> > > --- a/include/linux/pwm.h
> > > +++ b/include/linux/pwm.h
> > > @@ -151,6 +151,29 @@ static inline enum pwm_polarity pwm_get_polarity(const struct pwm_device *pwm)
> > >  	return pwm ? pwm->state.polarity : PWM_POLARITY_NORMAL;
> > >  }
> > >  
> > > +/*
> > > + * pwm_apply_state - apply a new state to the PWM device
> > > + */
> > > +int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *state);
> > 
> > If you add kerneldoc, please add it properly. It should start with /**
> > and you need to list at least the parameters and return value.
> 
> Yes, I'll fix that.
> BTW, I remember that you were expecting another name for this function
> (pwm_update IIRC).

I don't mind the pwm_apply_state() name very much. It's pretty accurate
with regards to what it does.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150720/ebd802e9/attachment.sig>
