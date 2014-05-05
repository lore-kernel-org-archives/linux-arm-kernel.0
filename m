From: balbi@ti.com (Felipe Balbi)
Date: Mon, 5 May 2014 13:36:06 -0500
Subject: [RFC PATCH 1/5] watchdog: Add API to trigger reboots
In-Reply-To: <1398958893-30049-2-git-send-email-linux@roeck-us.net>
References: <1398958893-30049-1-git-send-email-linux@roeck-us.net>
 <1398958893-30049-2-git-send-email-linux@roeck-us.net>
Message-ID: <20140505183606.GJ17875@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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

you can decrease one level of indentation:

	if (wdd_reboot_dev && wdd_reboot_dev->ops->reboot)

also, shouldn't you test if 'ops' is valid too ? In that case:

	if (wdd_reboot_dev && wdd_reboot_dev->ops &&
		wdd_reboot_dev->ops->reboot)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140505/117d29bc/attachment.sig>
