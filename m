From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 20 Jul 2015 10:16:00 +0200
Subject: [RFC PATCH 08/15] backlight: pwm_bl: remove useless call to
 pwm_set_period
In-Reply-To: <1435738921-25027-9-git-send-email-boris.brezillon@free-electrons.com>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
 <1435738921-25027-9-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20150720081559.GI29614@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 01, 2015 at 10:21:54AM +0200, Boris Brezillon wrote:
> The PWM period will be set when calling pwm_config. Remove this useless
> call to pwm_set_period, which might mess up with the initial PWM state
> once we have added proper support for PWM init state retrieval.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  drivers/video/backlight/pwm_bl.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> index ae498c1..fe5597c 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -295,10 +295,8 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>  	 * via the PWM lookup table.
>  	 */
>  	pb->period = pwm_get_default_period(pb->pwm);
> -	if (!pb->period && (data->pwm_period_ns > 0)) {
> +	if (!pb->period && (data->pwm_period_ns > 0))
>  		pb->period = data->pwm_period_ns;
> -		pwm_set_period(pb->pwm, data->pwm_period_ns);
> -	}
>  
>  	pb->lth_brightness = data->lth_brightness * (pb->period / pb->scale);

As far as I remember this line is there in order to pass in a period if
the backlight driver is initialized from board setup files. In such a
case there won't be an period associated with the PWM channel in the
first place.

I think even with the introduction of a default period, we'd be missing
out on the board setup case because there is no standard place where it
is being set, so it must come from the platform data.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150720/ba0f22ea/attachment.sig>
