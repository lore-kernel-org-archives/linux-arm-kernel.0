From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 01 Oct 2013 12:26:07 -0600
Subject: [PATCH 01/10] pwm-backlight: Refactor backlight power on/off
In-Reply-To: <1379972467-11243-2-git-send-email-treding@nvidia.com>
References: <1379972467-11243-1-git-send-email-treding@nvidia.com>
 <1379972467-11243-2-git-send-email-treding@nvidia.com>
Message-ID: <524B13BF.7080902@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/23/2013 03:40 PM, Thierry Reding wrote:
> In preparation for adding an optional regulator and enable GPIO to the
> driver, split the power on and power off sequences into separate
> functions to reduce code duplication at the multiple call sites.

> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c

> +static void pwm_backlight_power_off(struct pwm_bl_data *pb)
> +{
> +	pwm_disable(pb->pwm);

Both the call-sites you're replacing do the following before pwm_disable():

		pwm_config(pb->pwm, 0, pb->period);

While I agree that probably shouldn't be necessary, I think it's at
least worth mentioning that in the commit description just to make it
obvious that it was a deliberate change. Splitting that change into a
separate patch might be reasonable in order to keep refactoring and
functional changes separate, although perhaps it's not worth it.

There are also a couple unrelated whitespace changes thrown in here.
