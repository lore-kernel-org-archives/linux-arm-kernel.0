From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 15 Apr 2016 09:29:00 +0100
Subject: [RESEND 09/11] pwm: sti: Add PWM Capture call-back
In-Reply-To: <20160413152229.GC29509@ulmo.ba.sec>
References: <1456932729-9667-1-git-send-email-lee.jones@linaro.org>
 <1456932729-9667-10-git-send-email-lee.jones@linaro.org>
 <20160412105314.GE18882@ulmo.ba.sec> <20160413102554.GQ8094@x1>
 <20160413152229.GC29509@ulmo.ba.sec>
Message-ID: <20160415082900.GC3589@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 13 Apr 2016, Thierry Reding wrote:

> On Wed, Apr 13, 2016 at 11:25:54AM +0100, Lee Jones wrote:
> > On Tue, 12 Apr 2016, Thierry Reding wrote:
> > 
> > > On Wed, Mar 02, 2016 at 03:32:07PM +0000, Lee Jones wrote:
> > > > Once a PWM Capture has been initiated, the capture call
> > > > enables a rising edge detection IRQ, then waits.  Once each
> > > > of the 3 phase changes have been recorded the thread then
> > > > wakes.  The remaining part of the call carries out the
> > > > relevant calculations and passes back a formatted string to
> > > > the caller.
> > > > 
> > > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > > ---
> > > >  drivers/pwm/pwm-sti.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 72 insertions(+)
> > > > 
> > > > diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
> > > > index 82a69e4..8de9b4a 100644
> > > > --- a/drivers/pwm/pwm-sti.c
> > > > +++ b/drivers/pwm/pwm-sti.c

[...]

> > > > +	/* Prepare capture measurement */
> > > > +	d->index = 0;
> > > > +	regmap_write(pc->regmap, PWM_CPT_EDGE(channel), CPT_EDGE_RISING);
> > > > +	regmap_field_write(pc->pwm_cpt_int_en, BIT(channel));
> > > > +	ret = wait_event_interruptible_timeout(d->wait, d->index > 1, HZ);
> > > 
> > > The timeout here should make sure callers don't hang forever. But maybe
> > > you can still make sure that when the PWM gets disabled the wait queue
> > > is woken and perhaps return an appropriate error code to let users know
> > > that the operation was interrupted.
> > 
> > Sure.  I'll look into that.
> > 
> > > Also, how about letting callers choose the value of the timeout? In some
> > > cases they may be interested in long-running signals. In other cases the
> > > whole second timeout may be much too long.
> > 
> > I'm not opposed to it.  How do you suggest we do that?
> 
> The easiest would probably be to add an unsigned long timeout parameter
> to the pwm_capture() function and ->capture() callbacks.
> 
> But thinking about this further I'm wondering if it might not be easier
> and more flexible to move the timeout completely outside of this code
> and into callers. I suspect that the most simple way to do that would be
> to add a completion to struct pwm_capture that callers can use to wait
> for completion of a capture. This would make the whole process
> asynchronous and allow interesting things like making the sysfs capture
> file pollable, for example.

Okay, so how do you propose we handle this with sysfs?  Perhaps
another RW file to set it?

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
