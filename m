From: john.stultz@linaro.org (John Stultz)
Date: Mon, 23 Dec 2013 11:28:28 -0800
Subject: [RFC 02/18] power/reset: vexpress: Use sched_clock as the time
 source
In-Reply-To: <1387815830-8794-3-git-send-email-pawel.moll@arm.com>
References: <1387815830-8794-1-git-send-email-pawel.moll@arm.com>
 <1387815830-8794-3-git-send-email-pawel.moll@arm.com>
Message-ID: <CANcMJZALQ0khcqkdQA5Tnr6_9kfWK=UUmrUB4mCv2MEkmLv0sg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 23, 2013 at 8:23 AM, Pawel Moll <pawel.moll@arm.com> wrote:
> At this stage of system shutdown procedure the jiffies may
> not be updated anymore, so have to base on raw sched_clock
> values.
>
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> Cc: Anton Vorontsov <anton@enomsg.org>
> Cc: David Woodhouse <dwmw2@infradead.org>
> ---
>  drivers/power/reset/vexpress-poweroff.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/power/reset/vexpress-poweroff.c b/drivers/power/reset/vexpress-poweroff.c
> index 476aa49..d752233 100644
> --- a/drivers/power/reset/vexpress-poweroff.c
> +++ b/drivers/power/reset/vexpress-poweroff.c
> @@ -15,6 +15,7 @@
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
> +#include <linux/sched.h>
>  #include <linux/stat.h>
>  #include <linux/vexpress.h>
>
> @@ -27,12 +28,12 @@ static void vexpress_reset_do(struct device *dev, const char *what)
>                         vexpress_config_func_get_by_dev(dev);
>
>         if (func) {
> -               unsigned long timeout;
> +               unsigned long long timeout_ns;
>
>                 err = vexpress_config_write(func, 0, 0);
>
> -               timeout = jiffies + HZ;
> -               while (time_before(jiffies, timeout))
> +               timeout_ns = sched_clock() + 50000000;
> +               while (!err && time_before64(sched_clock(), timeout_ns))
>                         cpu_relax();
>         }

So this may not be a problem in this particular case, but sched_clock
could be backed by jiffies on some hardware, causing the same problem
to appear.

Might udelay/mdelay be a better fit for this sort of case (since
udelay may be counter backed, but may also be loop backed on hardware
without continuous counters)?

thanks
-john
