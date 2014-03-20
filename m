From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 20 Mar 2014 16:57:33 +0100
Subject: [PATCH v3 2/5] pwm: kona: Introduce Kona PWM controller support
In-Reply-To: <CAAYSxhri0evgrbCPew6-MTXVmpzm7Oa6TpmJTSGZpTcV=876HQ@mail.gmail.com>
References: <1394655346-30048-1-git-send-email-tim.kryger@linaro.org>
 <1394655346-30048-3-git-send-email-tim.kryger@linaro.org>
 <20140318215231.GH5917@mithrandir>
 <CAAYSxhri0evgrbCPew6-MTXVmpzm7Oa6TpmJTSGZpTcV=876HQ@mail.gmail.com>
Message-ID: <20140320155732.GB25092@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 18, 2014 at 04:47:36PM -0700, Tim Kryger wrote:
> On Tue, Mar 18, 2014 at 2:52 PM, Thierry Reding
> <thierry.reding@gmail.com> wrote:
> > On Wed, Mar 12, 2014 at 01:15:43PM -0700, Tim Kryger wrote:
> > [...]
> >> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> >> index 22f2f28..1fd42af 100644
> >> --- a/drivers/pwm/Kconfig
> >> +++ b/drivers/pwm/Kconfig
> >> @@ -62,6 +62,16 @@ config PWM_ATMEL_TCB
> >>         To compile this driver as a module, choose M here: the module
> >>         will be called pwm-atmel-tcb.
> >>
> >> +config PWM_BCM_KONA
> >> +     tristate "Kona PWM support"
> >> +     depends on ARCH_BCM_MOBILE
> >> +     default y
> >
> > No "default y", please.
> 
> Even though it depends on ARCH_BCM_MOBILE?  It seems like a reasonable
> default.

Well, that's only true until somebody decides to turn that dependency
into something like:

	depends on ARCH_BCM_MOBILE || COMPILE_TEST

> These SoCs target mobile phones which almost always have a backlight
> controlled by the PWM.

And you can easily turn it on in bcm_defconfig and/or multi_v7_defconfig
if you want it enabled "by default".

> >> diff --git a/drivers/pwm/pwm-bcm-kona.c b/drivers/pwm/pwm-bcm-kona.c
[...]
> >> +
> >> +     /* There is polarity support in HW but it is easier to manage in SW */
> >> +     if (pwm->polarity == PWM_POLARITY_INVERSED)
> >> +             duty_ns = period_ns - duty_ns;
> >
> > No, this is wrong. You're not actually changing the *polarity* here.
> 
> Please elaborate.  I don't understand what is wrong here.

Perhaps the comment for enum pwm_polarity in include/linux/pwm.h makes
this more obvious. What you do here is invert the duty cycle, rather
than the polarity. While it is true that the result is the same for
things like LEDs or backlight (because the signal power remains the
same), but there's a slight difference to what the PWM signal looks
like.

> Does polarity influence the output while a PWM is disabled?

Yes, there is apparently hardware where the polarity causes the PWM pin
to be 1 when the PWM is disabled. But that's really a separate issue.

> >> +static int kona_pwmc_enable(struct pwm_chip *chip, struct pwm_device *pwm)
> >> +{
> >> +     struct kona_pwmc *kp = dev_get_drvdata(chip->dev);
> >> +     int ret;
> >> +
> >> +     /*
> >> +      * The PWM framework does not clear the enable bit in the flags if an
> >> +      * error is returned from a PWM driver's enable function so it must be
> >> +      * cleared here if any trouble is encountered.
> >> +      */
> >> +
> >> +     ret = clk_prepare_enable(kp->clk);
> >> +     if (ret < 0) {
> >> +             dev_err(chip->dev, "failed to enable clock: %d\n", ret);
> >> +             clear_bit(PWMF_ENABLED, &pwm->flags);
> >
> > You're not supposed to touch these. This is a bug in the core, and it
> > should be fixed in the core.
> 
> Okay.  I'll drop the clear_bit lines from this patch.

I was sort of hoping you would post a patch which fixes this in the core
instead of just dropping those lines here and ignoring the issue. That
would've earned you bonus points. =)

> >> +             return ret;
> >> +     }
> >> +
> >> +     ret = kona_pwmc_config(chip, pwm, pwm->duty_cycle, pwm->period);
> >> +     if (ret < 0) {
> >> +             clk_disable_unprepare(kp->clk);
> >> +             clear_bit(PWMF_ENABLED, &pwm->flags);
> >> +             return ret;
> >> +     }
> >
> > Why are you doing this? .config() should be setting everything up
> > according to the given duty cycle and period and .enable() should only
> > be enabling a specific channel. Please don't conflate the two.
> 
> The hardware only supports a configure operation.
> 
> Thus disable has to be simulated by configuring zero duty.
> 
> During an enable operation we have to program the last configuration.

My worry is that by calling one public function from another you'll be
mixing contexts. For instance, with the PWMF_ENABLED issue you mention
one solution to fix this in the core would be to delay setting the flag
until the driver's .enable() implementation actually succeeded. If such
an implementation was chosen, then your driver would be broken, because
PWMF_ENABLED wouldn't be set when .enable() is called, and therefore
calling the kona_pwmc_config() wouldn't have any effect.

> >> +static void kona_pwmc_disable(struct pwm_chip *chip, struct pwm_device *pwm)
> >> +{
> >> +     struct kona_pwmc *kp = dev_get_drvdata(chip->dev);
> >> +     unsigned int chan = pwm->hwpwm;
> >> +
> >> +     /*
> >> +      * The "enable" bits in the control register only affect when settings
> >> +      * start to take effect so the only real way to disable the PWM output
> >> +      * is to program a zero duty cycle.
> >> +      */
> >
> > What's wrong about waiting for the settings to take effect? There's
> > nothing about disable that says it should happen *immediately*.
> 
> The current code does wait for the settings to take effect.
> 
> Can you clarify what you mean?

Things are starting to get confusing here. Looking at the register
definitions, there's PWM_CONTROL_ENABLE_SHIFT(chan), which I suspect
controls whether or not a channel is enabled (if that's not the case
then please add a comment that explains what it does).

But a little further up you said that the hardware does only support a
configure operation and not an enable/disable.

The comment above further confuses me. What I read from it is that you
can in fact disable a channel by clearing the "enable" bit in the
control register. But the reason why you don't do it that way is because
that change won't take effect until "settings start to take effect". So
in order to disable the PWM immediately you resort to writing a 0 duty
cycle.

Perhaps I misunderstood, in which case it might be good to revise that
comment to be more explicit or accurate.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140320/03aadc0f/attachment.sig>
