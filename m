From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 12 Apr 2016 12:15:50 +0200
Subject: [RESEND 02/11] pwm: sysfs: Add PWM Capture support
In-Reply-To: <1456932729-9667-3-git-send-email-lee.jones@linaro.org>
References: <1456932729-9667-1-git-send-email-lee.jones@linaro.org>
 <1456932729-9667-3-git-send-email-lee.jones@linaro.org>
Message-ID: <20160412101550.GB18882@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 02, 2016 at 03:32:00PM +0000, Lee Jones wrote:
> Allow a user to read PWM Capture results from /sysfs. First,
> the user must tell PWM Capture which channel they wish to
> read from:
> 
>   $ echo 2 > $PWMCHIP/capture
> 
> To start a capture and read the result, simply read the file:
> 
>   $ cat $PWMCHIP/capture
> 
> The output format is left to the device.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/pwm/sysfs.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
> index 9c90886..3572ef4 100644
> --- a/drivers/pwm/sysfs.c
> +++ b/drivers/pwm/sysfs.c
> @@ -23,6 +23,8 @@
>  #include <linux/kdev_t.h>
>  #include <linux/pwm.h>
>  
> +static int capture_channel;

Can't do that, this is very racy because it isn't protected by any lock.
Fortunately I don't think the global variable is at all necessary. See
below.

> +
>  struct pwm_export {
>  	struct device child;
>  	struct pwm_device *pwm;
> @@ -167,16 +169,42 @@ static ssize_t polarity_store(struct device *child,
>  	return ret ? : size;
>  }
>  
> +static ssize_t capture_show(struct device *child,
> +			    struct device_attribute *attr,
> +			    char *buf)
> +{
> +	struct pwm_device *pwm = child_to_pwm_device(child);
> +
> +	return pwm_capture(pwm, capture_channel, buf);
> +}
> +
> +static ssize_t capture_store(struct device *child,
> +			     struct device_attribute *attr,
> +			     const char *buf, size_t size)
> +{
> +	int val, ret;
> +
> +	ret = kstrtoint(buf, 0, &val);
> +	if (ret)
> +		return ret;
> +
> +	capture_channel = val;
> +
> +	return size;
> +}
> +
>  static DEVICE_ATTR_RW(period);
>  static DEVICE_ATTR_RW(duty_cycle);
>  static DEVICE_ATTR_RW(enable);
>  static DEVICE_ATTR_RW(polarity);
> +static DEVICE_ATTR_RW(capture);

These are all per-PWM attributes and the specific PWM device that they
are associated with can be retrieved using child_to_pwm_device(child)
(see the other attributes' implementation for examples). So I don't
think the capture attribute needs to be writable at all. You already
implement capture_show() in almost the right way, and if you drop the
channel parameter from pwm_capture() as I suggested in my reply to patch
1/11 this should resolve itself automatically.

Of course capture_show() would become slightly more beefy if we return a
standard result structure rather than leave it up to the drivers to fill
out the sysfs string. The good thing is that it will be common code and
therefore the sysfs interface would return the same format regardless of
the driver.

Perhaps something like

	struct pwm_device *pwm = child_to_pwm_device(child);
	struct pwm_capture result;

	err = pwm_capture(pwm, &result);
	if (err < 0)
		return err;

	return sprintf(buf, "%u %u\n", result.duty_cycle, result.period);
	
would work?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160412/2ee0ebc6/attachment-0001.sig>
