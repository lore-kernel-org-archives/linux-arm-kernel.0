From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 20 Jul 2015 10:11:04 +0200
Subject: [RFC PATCH 07/15] pwm: move the enabled/disabled info to
 pwm_state struct
In-Reply-To: <1435738921-25027-8-git-send-email-boris.brezillon@free-electrons.com>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
 <1435738921-25027-8-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20150720081103.GH29614@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 01, 2015 at 10:21:53AM +0200, Boris Brezillon wrote:
> Prepare the transition to PWM atomic update by moving the enabled/disabled
> state into the pwm_state struct. This way we can easily update the whole
> PWM state by copying the new state in the ->state field.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  drivers/pwm/core.c  | 15 ++++++++++++---
>  include/linux/pwm.h |  6 +++---
>  2 files changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index a6bc8e6..3e830ce 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -474,8 +474,15 @@ EXPORT_SYMBOL_GPL(pwm_set_polarity);
>   */
>  int pwm_enable(struct pwm_device *pwm)
>  {
> -	if (pwm && !test_and_set_bit(PWMF_ENABLED, &pwm->flags))
> -		return pwm->chip->ops->enable(pwm->chip, pwm);
> +	if (pwm && !pwm_is_enabled(pwm)) {
> +		int err;
> +
> +		err = pwm->chip->ops->enable(pwm->chip, pwm);
> +		if (!err)
> +			pwm->state.enabled = true;
> +
> +		return err;
> +	}

Technically there's now a race between the pwm_is_enabled() and
pwm->state.enabled = true; statements, but as discussed in the cover
letter I think that's fine because of the assumptions about concurrent
usage of PWMs.

The most important check (PWMF_REQUESTED) is still atomic, so it is
still up to drivers to properly lock concurrent access to a PWM device
and the core will make sure that a device can only be requested once.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150720/4840dad3/attachment.sig>
