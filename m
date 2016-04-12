From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 12 Apr 2016 12:08:45 +0200
Subject: [RESEND 01/11] pwm: Add PWM Capture support
In-Reply-To: <1456932729-9667-2-git-send-email-lee.jones@linaro.org>
References: <1456932729-9667-1-git-send-email-lee.jones@linaro.org>
 <1456932729-9667-2-git-send-email-lee.jones@linaro.org>
Message-ID: <20160412100845.GA18882@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 02, 2016 at 03:31:59PM +0000, Lee Jones wrote:
> Supply a PWM Capture call-back Op in order to pass back
> information obtained by running analysis on PWM a signal.
> This would normally (at least during testing) be called from
> the Sysfs routines with a view to printing out PWM Capture
> data which has been encoded into a string.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/pwm/core.c  | 26 ++++++++++++++++++++++++++
>  include/linux/pwm.h | 13 +++++++++++++
>  2 files changed, 39 insertions(+)

Overall I like the concept of introducing this capture functionality.

However I have a couple of questions, see below.

> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index d24ca5f..8f4a8a9 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -494,6 +494,32 @@ unlock:
>  EXPORT_SYMBOL_GPL(pwm_set_polarity);
>  
>  /**
> + * pwm_capture() - capture and report a PWM signal
> + * @pwm: PWM device
> + * @channel: PWM capture channel to use
> + * @buf: buffer to place output message into
> + *
> + * Returns: 0 on success or a negative error code on failure.
> + */
> +int pwm_capture(struct pwm_device *pwm, int channel, char *buf)

This public interface seems to be targetted specifically at sysfs. As
such I'm not sure if there is reason to make it public, since the code
is unlikely to ever be called by other users in the kernel.

Do you think it would be possible to make the interface more generic by
passing back some form of structure containing the capture result? That
way users within the kernel could use the result without having to go
and parse a string filled in by the driver. It would also be easy to
implement sysfs support on top of that. Another advantage is that there
would be a standard result structure rather than a free-form string
filled by drivers that can't be controlled.

What kind of result does the STi hardware return? Looking at the driver
later in the series it seems to support triggering interrupts on rising
and falling edges and capture some running counter at these events. If
the frequency of the counter increment is known, these numbers should
allow us to determine both the period and duty cycle of the PWM signal
in nanoseconds. Would it be possible to rewrite this function and the
driver patch to something like this:

	int pwm_capture(struct pwm_device *pwm, struct pwm_capture *result);

Where

	struct pwm_capture {
		unsigned int period;
		unsigned int duty_cycle;
	};

?

Another thing I noticed is that the code here seems to be confusing
channels and devices. In the PWM subsystem a struct pwm_device
represents a single channel. Allowing the channel to be specified is
redundant at best, and confusing at worst.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160412/d4916185/attachment.sig>
