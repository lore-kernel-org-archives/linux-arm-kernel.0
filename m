From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 30 Apr 2018 11:51:59 +0200
Subject: [PATCH V2 1/9] pwm: core: Add support for PWM HW driver with pwm
 capture only
In-Reply-To: <1521607244-29734-2-git-send-email-rrajk@nvidia.com>
References: <1521607244-29734-1-git-send-email-rrajk@nvidia.com>
 <1521607244-29734-2-git-send-email-rrajk@nvidia.com>
Message-ID: <20180430095159.GD2476@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 21, 2018 at 10:10:36AM +0530, Rajkumar Rampelli wrote:
> Add support for pwm HW driver which has only capture functionality.
> This helps to implement the PWM based Tachometer driver which reads
> the PWM output signals from electronic fans.
> 
> PWM Tachometer captures the period and duty cycle of the PWM signal
> 
> Add conditional checks for callabacks enable(), disable(), config()
> to check if they are supported by the client driver or not. Skip these
> callbacks if they are not supported.
> 
> Signed-off-by: Rajkumar Rampelli <rrajk@nvidia.com>
> ---
> 
> V2: Added if conditional checks for pwm callbacks since drivers may
>     implements only pwm capture functionality.
> 
>  drivers/pwm/core.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 1581f6a..f70fe68 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -246,6 +246,10 @@ static bool pwm_ops_check(const struct pwm_ops *ops)
>  	if (ops->apply)
>  		return true;
>  
> +	/* driver supports capture operation */
> +	if (ops->capture)
> +		return true;
> +
>  	return false;
>  }
>  
> @@ -495,7 +499,8 @@ int pwm_apply_state(struct pwm_device *pwm, struct pwm_state *state)
>  			 * ->apply().
>  			 */
>  			if (pwm->state.enabled) {
> -				pwm->chip->ops->disable(pwm->chip, pwm);
> +				if (pwm->chip->ops->disable)
> +					pwm->chip->ops->disable(pwm->chip, pwm);

This is not a good idea. It means that you'll be able to successfully
configure a capture-only PWM channel for output. I think all of the
output configuration functions should return an error (-ENOSYS?) for
capture-only devices, much like we return -ENOSYS for pwm_capture() if
the driver doesn't implement capture support.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180430/2ad7ea34/attachment.sig>
