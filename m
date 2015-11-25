From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 25 Nov 2015 16:16:27 +0100
Subject: [PATCH] pwm: berlin: Add PM support
In-Reply-To: <20151125163019.64e80799@xhacker>
References: <1448343785-1540-1-git-send-email-jszhang@marvell.com>
 <20151124162306.GC32623@ulmo.nvidia.com>
 <20151125163019.64e80799@xhacker>
Message-ID: <20151125151627.GB31492@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2015 at 04:30:19PM +0800, Jisheng Zhang wrote:
> On Tue, 24 Nov 2015 17:23:06 +0100 Thierry Reding wrote:
> > On Tue, Nov 24, 2015 at 01:43:05PM +0800, Jisheng Zhang wrote:
> > > This patch adds S2R support for berlin pwm driver.
> > > 
> > > Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> > > ---
> > >  drivers/pwm/pwm-berlin.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++-
> > >  1 file changed, 56 insertions(+), 1 deletion(-)
[...]
> > > +	for (i = 0; i < pwm->chip.npwm; i++) {
> > > +		struct berlin_pwm_context *ctx = &pwm->ctx[i];
> > > +
> > > +		berlin_pwm_writel(pwm, i, ctx->ctrl, BERLIN_PWM_CONTROL);
> > > +		berlin_pwm_writel(pwm, i, ctx->duty, BERLIN_PWM_DUTY);
> > > +		berlin_pwm_writel(pwm, i, ctx->tcnt, BERLIN_PWM_TCNT);
> > > +		berlin_pwm_writel(pwm, i, ctx->enable, BERLIN_PWM_ENABLE);
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static SIMPLE_DEV_PM_OPS(berlin_pwm_pm_ops, berlin_pwm_suspend,
> > > +			 berlin_pwm_resume);
> > > +#define BERLIN_PWM_PM_OPS	(&berlin_pwm_pm_ops)
> > > +#else
> > > +#define BERLIN_PWM_PM_OPS	NULL
> > > +#endif  
> > 
> > This is a weird way of writing this. I think a more typical way would be
> > to have the #ifdef contain only the implementation and then define the
> > dev_pm_ops variable unconditonally, so you don't need a separate macro
> > for it.
> > 
> 
> The reason why I introduced one more macro is: struct dev_pm_ops contains
> 23 pointers now, if there's no BERLIN_PWM_PM_OPS macro, there will be always a
> dev_pm_ops even if PM_SLEEP isn't enabled. I dunno whether there's any
> elegant solution for this case.

I wouldn't bother. PM_SLEEP is in almost all cases going to be enabled.
If it isn't enabled it's likely going to be in test builds, at which
point nobody will care about the extra 23 pointers.

> How about define SIMPLE_DEV_PM_OPS as NULL if PM_SLEEP isn't enabled?

That won't work, "static NULL;" wouldn't be valid syntax. Like I said,
if you go through the trouble of implementing suspend/resume, you're
almost certainly going to want to enable it, so just define it
unconditionally.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151125/1c85baa1/attachment-0001.sig>
