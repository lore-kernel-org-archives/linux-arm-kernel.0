From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 7 Mar 2012 17:42:40 +0100
Subject: [PATCH] watchdog/coh901327: convert to use watchdog core
In-Reply-To: <1331131929-22383-1-git-send-email-linus.walleij@stericsson.com>
References: <1331131929-22383-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20120307164240.GA1130@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

> -static long coh901327_ioctl(struct file *file, unsigned int cmd,
> +static long coh901327_ioctl(struct watchdog_device *wdt_dev, unsigned int cmd,
>  			    unsigned long arg)
>  {
>  	int ret = -ENOTTY;
>  	u16 val;
> -	int time;
> -	int new_options;
>  	union {
>  		struct watchdog_info __user *ident;
>  		int __user *i;
>  	} uarg;

'uarg' is nice name for the union ;) You probably don't need that anymore.
If we keep the ioctl, that is, because...

...

>  	case WDIOC_GETTIMELEFT:
>  		clk_enable(clk);
>  		/* Read repeatedly until the value is stable! */

I was wondering if it pays to put this IOCTL to watchdog_dev and add another
callback to watchdog_ops? I'd think so. Wim, Linus, what do you think? We don't
save much (yet?), but since this is part of the kernel-API it might be nice to
have the common part centralized, even if it is mainly put_user (which might be
nice, too, since most users of GETTIMELEFT cast the result to various types).

> +static struct watchdog_device coh901327_wdt = {
> +	.info = &coh901327_ident,
> +	.ops = &coh901327_ops,
> +	/*
> +	 * Max margin is 327 since the 10ms
> +	 * timeout register is max
> +	 * 0x7FFF = 327670ms ~= 327s.
> +	 */

I'd drop that comment, but well...

> +	.min_timeout = 0,
> +	.max_timeout = 327,

Thanks!

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120307/60dc17ea/attachment.sig>
