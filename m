From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 12 Apr 2016 13:39:12 +0200
Subject: [PATCH v5 05/46] pwm: introduce the pwm_args concept
In-Reply-To: <1459368249-13241-6-git-send-email-boris.brezillon@free-electrons.com>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459368249-13241-6-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20160412113912.GK18882@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 30, 2016 at 10:03:28PM +0200, Boris Brezillon wrote:
> Currently the PWM core mixes the current PWM state with the per-platform
> reference config (specified through the PWM lookup table, DT definition or
> directly hardcoded in PWM drivers).
> 
> Create a pwm_args struct to store this reference config, so that PWM users
> can differentiate the current config from the reference one.
> 
> Patch all places where pwm->args should be initialized. We keep the
> pwm_set_polarity/period() calls until all PWM users are patched to
> use pwm_args instead of pwm_get_period/polarity().

Perhaps a helper would be useful? Something like:

	static inline void
	pwm_apply_args(struct pwm_device *pwm, const struct pwm_args *args)
	{
		pwm_set_duty_cycle(pwm, args->duty_cycle);
		pwm_set_period(pwm, args->period);
	}

? That would make it slightly easier to get rid of it again after all
clients have been converted.

With the exception of pwm-clps711x all of these args are set at of_xlate
time (for DT) or from the lookup table in pwm_get() (for non-DT), so it
might even be possible to move this call to the core, so that removal of
it will be a one-liner.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160412/1ba42f8a/attachment.sig>
