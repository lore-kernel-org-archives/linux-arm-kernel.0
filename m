From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 11 Mar 2016 13:22:40 +0200
Subject: [PATCH 2/3] video: fbdev: imxfb: enable lcd regulator in .probe
In-Reply-To: <1457380425-20244-3-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1457380425-20244-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1457380425-20244-3-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <56E2AA80.4050908@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 07/03/16 21:53, Uwe Kleine-K?nig wrote:
> This asserts that the display is on after the driver is initialized.
> Otherwise, depending on how the boot loader handled the display, it is
> either disabled as the regulator doesn't seem in use, or it stays off.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/video/fbdev/imxfb.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
> index c5fcedde2a60..3dd2824e6773 100644
> --- a/drivers/video/fbdev/imxfb.c
> +++ b/drivers/video/fbdev/imxfb.c
> @@ -979,8 +979,17 @@ static int imxfb_probe(struct platform_device *pdev)
>  	imxfb_enable_controller(fbi);
>  	fbi->pdev = pdev;
>  
> +	if (!IS_ERR(fbi->lcd_pwr)) {
> +		ret = regulator_enable(fbi->lcd_pwr);
> +		if (ret)
> +			goto failed_regulator;
> +	}
> +
>  	return 0;
>  
> +failed_regulator:
> +	imxfb_disable_controller(fbi);
> +
>  failed_lcd:
>  	unregister_framebuffer(info);

So I didn't go through the code in detail, but this doesn't look correct
to me.

Where is the regulator disabled which now gets enabled in probe?

imxfb_lcd_set_power() handles the regulator enable/disable, so doesn't
this mean the regulator would always be enabled? You first enable it in
probe, then imxfb_lcd_set_power() enables it at some point (?), so the
enable-count is two then.

To be honest, I've never used 'struct lcd_ops', but I think the enabling
of the regulator should happen somehow via that. If the regulator needs
to be enabled at probe time, then the probe should somehow cause
lcd_ops->set_power to get called.

Why does the regulator need to be enabled at probe? Or are you saying
imxfb_lcd_set_power() is never called in your case?

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160311/bb4f6137/attachment.sig>
