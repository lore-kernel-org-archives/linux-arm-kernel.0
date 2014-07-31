From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 31 Jul 2014 13:54:31 +0200
Subject: [RFC] pwm-backlight: Allow backlight to remain disabled on boot
In-Reply-To: <1406806970-12561-1-git-send-email-thierry.reding@gmail.com>
References: <1406806970-12561-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <20140731115429.GA12627@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 31, 2014 at 01:42:50PM +0200, Thierry Reding wrote:
[...]
> @@ -317,6 +319,12 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>  	}
>  
>  	bl->props.brightness = data->dft_brightness;
> +
> +	if (data->boot_off)
> +		bl->props.power = FB_BLANK_POWERDOWN;
> +	else
> +		bl->props.power = FB_BLANK_UNBLANK;
> +
>  	backlight_update_status(bl);

Looking at this again, perhaps a more sensible thing to do would be to
not call backlight_update_status() in the first place. For example if
the board defines that backlight should be kept off at boot, but the
bootloader had already enabled it, then this would effectively turn off
the backlight again.

I think it's safe to assume that if the bootloader sets up the backlight
then it would also set up the display. Therefore not touching the
backlight state at all at probe time seems like the safest default.

Of course that doesn't help people who use some dumb framebuffer driver
and therefore nothing explicitly enables the backlight. So it would
still be changing behaviour for people for whom the bootloader doesn't
set up the backlight at all and who therefore rely on the kernel to turn
it on.

We could perhaps alleviate that pain a little by making this dependent
on whether or not the board is booted using DT on the assumption that
anything that uses DT would be "modern" enough to provide a means to
automatically enable the backlight at the right moment.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140731/6492d959/attachment-0001.sig>
