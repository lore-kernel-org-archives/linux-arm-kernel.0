From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 7 Apr 2014 13:16:40 +0200
Subject: [PATCH 08/16] backlight: pwm_bl: set pwm polarity when using
 platform data
In-Reply-To: <1395234209-15546-9-git-send-email-alexandre.belloni@free-electrons.com>
References: <1395234209-15546-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1395234209-15546-9-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20140407111639.GB26985@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 19, 2014 at 02:03:21PM +0100, Alexandre Belloni wrote:
> Set inversed polarity when .pwm_active_low is set in the platform_data. With
> device tree, this is taken care of by of_pwm_xlate_with_flags(), called from
> of_pwm_get().
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  drivers/video/backlight/pwm_bl.c | 8 ++++++++
>  include/linux/pwm_backlight.h    | 1 +
>  2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> index b75201ff46f6..ffdd3b2b2742 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -309,6 +309,14 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>  	if (data->pwm_period_ns > 0)
>  		pwm_set_period(pb->pwm, data->pwm_period_ns);
>  
> +	/*
> +	 * The DT case is taking care of polarity in of_pwm_get(). For the
> +	 * non-DT case, set the polarity from platform data.
> +	 */
> +	if (data->pwm_active_low)
> +		if (pwm_set_polarity(pb->pwm, PWM_POLARITY_INVERSED))
> +			dev_err(&pdev->dev, "impossible to invert polarity\n");

Could this perhaps be solved by adding a field to the PWM lookup table
that's used for non-DT cases? The idea being that we can use the same
interfaces for DT and non-DT cases, so we should try to move both
towards the same representation.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140407/6b3bd058/attachment.sig>
