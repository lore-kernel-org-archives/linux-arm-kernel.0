From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Mon, 4 May 2015 23:17:46 +0200
Subject: [PATCHv7 1/8] watchdog: Extend kernel API to know about HW
 limitations
In-Reply-To: <1429701102-22320-2-git-send-email-timo.kokkonen@offcode.fi>
References: <1429701102-22320-1-git-send-email-timo.kokkonen@offcode.fi>
 <1429701102-22320-2-git-send-email-timo.kokkonen@offcode.fi>
Message-ID: <5547E1FA.1070301@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/22/2015 01:11 PM, Timo Kokkonen wrote:
> There is a great deal of diversity in the watchdog hardware found on
> different devices. Differen hardware have different contstraints on
> them, many of the constraints that are excessively difficult for the
> user space to satisfy.
> 
> One such constraint is the length of the timeout value, which in many
> cases can be just a few seconds. Drivers are creating ad hoc solutions
> with timers and workqueues to extend the timeout in order to give user
> space more time between updates. Looking at the drivers it is clear
> that this has resulted to a lot of duplicate code.
> 
> Add an extension to the watchdog kernel API that allows the driver to
> describe tis HW constraints to the watchdog code. A kernel worker in
> the core is then used to extend the watchdog timeout on behalf of the
> user space. This allows the drivers to be simplified as core takes
> over the timer extending.
> 
> Tested-by: Wenyou Yang <wenyou.yang@atmel.com>
> Signed-off-by: Timo Kokkonen <timo.kokkonen@offcode.fi>
> ---
>  drivers/watchdog/watchdog_core.c | 101 +++++++++++++++++++++++++++++++++++++--
>  drivers/watchdog/watchdog_dev.c  |  75 ++++++++++++++++++++++++++---
>  include/linux/watchdog.h         |  23 +++++++++
>  3 files changed, 189 insertions(+), 10 deletions(-)
> 
[...]

>  static int watchdog_set_timeout(struct watchdog_device *wddev,
>  							unsigned int timeout)
>  {
> -	int err;
> +	int err = 0;
> +
> +	if (wddev->hw_max_timeout) {
> +		int hw_timeout;
> +		/*
> +		 * We can't support too short timeout values. There is
> +		 * really no maximu however, anything longer than HW
> +		 * maximum will be supported by the watchdog core on
> +		 * behalf of the actual HW.
> +		 */
> +		if (timeout < wddev->min_timeout)
> +			return -EINVAL;
> +
> +		mutex_lock(&wddev->lock);

The locking in this function looks weird.

> +		if (test_bit(WDOG_UNREGISTERED, &wddev->status)) {
> +			err = -ENODEV;
> +			goto out_timeout;
> +		}
> +
> +		if (timeout * HZ > wddev->hw_max_timeout)
> +			schedule_delayed_work(&wddev->work,
> +					wddev->hw_heartbeat);
> +
> +		hw_timeout = min(timeout, wddev->hw_max_timeout / HZ);
> +		if (wddev->info->options & WDIOF_SETTIMEOUT)
> +			err = wddev->ops->set_timeout(wddev, hw_timeout);
> +
> +		if (hw_timeout < timeout)
> +			wddev->timeout = timeout;
> +
> +		goto out_timeout;
> +	}
>  
>  	if ((wddev->ops->set_timeout == NULL) ||
>  	    !(wddev->info->options & WDIOF_SETTIMEOUT))

Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150504/5d0f92c6/attachment.sig>
