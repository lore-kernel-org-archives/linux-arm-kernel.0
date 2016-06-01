From: linux@roeck-us.net (Guenter Roeck)
Date: Wed, 1 Jun 2016 14:40:08 -0700
Subject: [PATCH 1/3] watchdog: skip min and max timeout validity check
 when max_hw_heartbeat_ms is defined
In-Reply-To: <1464674890-10512-2-git-send-email-fu.wei@linaro.org>
References: <1464674890-10512-1-git-send-email-fu.wei@linaro.org>
 <1464674890-10512-2-git-send-email-fu.wei@linaro.org>
Message-ID: <20160601214008.GA2841@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 31, 2016 at 02:08:08PM +0800, fu.wei at linaro.org wrote:
> From: Pratyush Anand <panand@redhat.com>
> 
> When max_hw_heartbeat_ms has a none zero value, max_timeout is not used.
> So it's value can be 0. In such case if a driver uses min_timeout
> functionality, then check will always fail.
> 
> This patch fixes above issue.
> 
> Signed-off-by: Pratyush Anand <panand@redhat.com>
> Signed-off-by: Fu Wei <fu.wei@linaro.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/watchdog_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
> index 7c3ba58..65e62d1 100644
> --- a/drivers/watchdog/watchdog_core.c
> +++ b/drivers/watchdog/watchdog_core.c
> @@ -88,7 +88,7 @@ static void watchdog_check_min_max_timeout(struct watchdog_device *wdd)
>  	 * Check that we have valid min and max timeout values, if
>  	 * not reset them both to 0 (=not used or unknown)
>  	 */
> -	if (wdd->min_timeout > wdd->max_timeout) {
> +	if (!wdd->max_hw_heartbeat_ms && wdd->min_timeout > wdd->max_timeout) {
>  		pr_info("Invalid min and max timeout values, resetting to 0!\n");
>  		wdd->min_timeout = 0;
>  		wdd->max_timeout = 0;
> -- 
> 2.5.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
