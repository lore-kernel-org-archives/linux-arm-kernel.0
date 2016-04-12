From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 12 Apr 2016 14:20:29 +0200
Subject: [PATCH v5 05/46] pwm: introduce the pwm_args concept
In-Reply-To: <20160412140412.42704302@bbrezillon>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459368249-13241-6-git-send-email-boris.brezillon@free-electrons.com>
 <20160412113912.GK18882@ulmo.ba.sec>
 <20160412140412.42704302@bbrezillon>
Message-ID: <20160412122029.GO18882@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 12, 2016 at 02:04:12PM +0200, Boris Brezillon wrote:
> On Tue, 12 Apr 2016 13:39:12 +0200
> Thierry Reding <thierry.reding@gmail.com> wrote:
> 
> > On Wed, Mar 30, 2016 at 10:03:28PM +0200, Boris Brezillon wrote:
> > > Currently the PWM core mixes the current PWM state with the per-platform
> > > reference config (specified through the PWM lookup table, DT definition or
> > > directly hardcoded in PWM drivers).
> > > 
> > > Create a pwm_args struct to store this reference config, so that PWM users
> > > can differentiate the current config from the reference one.
> > > 
> > > Patch all places where pwm->args should be initialized. We keep the
> > > pwm_set_polarity/period() calls until all PWM users are patched to
> > > use pwm_args instead of pwm_get_period/polarity().
> > 
> > Perhaps a helper would be useful? Something like:
> > 
> > 	static inline void
> > 	pwm_apply_args(struct pwm_device *pwm, const struct pwm_args *args)
> > 	{
> > 		pwm_set_duty_cycle(pwm, args->duty_cycle);
> > 		pwm_set_period(pwm, args->period);
> > 	}
> > 
> > ? That would make it slightly easier to get rid of it again after all
> > clients have been converted.
> 
> Sure. I'll add this helper.
> 
> > 
> > With the exception of pwm-clps711x all of these args are set at of_xlate
> > time (for DT) or from the lookup table in pwm_get() (for non-DT), so it
> > might even be possible to move this call to the core, so that removal of
> > it will be a one-liner.
> 
> Not sure I get that one. Some drivers are implementing their own
> ->of_xlate() method, how would you get rid of this pwm_apply_args() in
> those custom implementations?

I was proposing to have pwm_apply_args() called from the core.
of_pwm_get() is where ->of_xlate() is called from, and the lookup table
arguments would be applied in pwm_get(). Taking into account clps711x,
which sets the arguments in ->request() it might be possible to simply
call pwm_apply_args() from pwm_device_request(), since that's also
called by all other request functions, even the legacy ones.

That said, the amount of code to modify isn't that large, so I'm fine if
you want to keep sprinkling the calls across multiple files, especially
since it's temporary.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160412/48d3419b/attachment.sig>
