From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 2 May 2014 18:22:43 -0700
Subject: [RFC PATCH 1/5] watchdog: Add API to trigger reboots
In-Reply-To: <1398958893-30049-2-git-send-email-linux@roeck-us.net>
References: <1398958893-30049-1-git-send-email-linux@roeck-us.net>
 <1398958893-30049-2-git-send-email-linux@roeck-us.net>
Message-ID: <20140503012243.GG4090@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guenter,

On Thu, May 01, 2014 at 08:41:29AM -0700, Guenter Roeck wrote:
> Some hardware implements reboot through its watchdog hardware,
> for example by triggering a watchdog timeout. Platform specific
> code starts to spread into watchdog drivers, typically by setting
> pointers to a callback functions which is then called from the
> platform reset handler.
> 
> To simplify code and provide a unified API to trigger reboots by
> watchdog drivers, provide a single API to trigger such reboots
> through the watchdog subsystem.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/watchdog/watchdog_core.c |   17 +++++++++++++++++
>  include/linux/watchdog.h         |   11 +++++++++++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
> index cec9b55..4ec6e2f 100644
> --- a/drivers/watchdog/watchdog_core.c
> +++ b/drivers/watchdog/watchdog_core.c
> @@ -43,6 +43,17 @@
>  static DEFINE_IDA(watchdog_ida);
>  static struct class *watchdog_class;
>  
> +static struct watchdog_device *wdd_reboot_dev;
> +
> +void watchdog_do_reboot(enum reboot_mode mode, const char *cmd)
> +{
> +	if (wdd_reboot_dev) {
> +		if (wdd_reboot_dev->ops->reboot)
> +			wdd_reboot_dev->ops->reboot(wdd_reboot_dev, mode, cmd);
> +	}
> +}
> +EXPORT_SYMBOL(watchdog_do_reboot);
> +
>  static void watchdog_check_min_max_timeout(struct watchdog_device *wdd)
>  {
>  	/*
> @@ -162,6 +173,9 @@ int watchdog_register_device(struct watchdog_device *wdd)
>  		return ret;
>  	}
>  
> +	if (wdd->ops->reboot)
> +		wdd_reboot_dev = wdd;
> +

Overall, it looks really great, but I guess we can make it a
list. Otherwise, we might end up in a situation where we could not
reboot anymore, like this one for example:
  - a first watchdog is probed, registers a reboot function
  - a second watchdog is probed, registers a reboot function that
    overwrites the first one.
  - then, the second watchdog disappears for some reason, and the
    reboot is set to NULL

Or maybe we can just use the start callback, with the min timeout already
registered, and prevent the user to kick the watchdog.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140502/06282447/attachment.sig>
