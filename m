From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 2 Nov 2016 10:24:40 +0200
Subject: [PATCH] video: ARM CLCD: fix Vexpress regression
In-Reply-To: <1476945992-5164-1-git-send-email-linus.walleij@linaro.org>
References: <1476945992-5164-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <6e29bcec-e8c5-d00f-4257-4ec14e90fae1@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/10/16 09:46, Linus Walleij wrote:
> The CLCD does not come up on Versatile Express as it does not
> (currently) have a syscon node for controlling the block apart
> from the CLCD itself. Make sure the .init() function can bail
> out without an error making it probe again.
> 
> Reported-by: Amit Pundir <amit.pundir@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/video/fbdev/amba-clcd-versatile.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/amba-clcd-versatile.c b/drivers/video/fbdev/amba-clcd-versatile.c
> index 19ad8645d93c..d909b7dda14d 100644
> --- a/drivers/video/fbdev/amba-clcd-versatile.c
> +++ b/drivers/video/fbdev/amba-clcd-versatile.c
> @@ -527,7 +527,8 @@ int versatile_clcd_init_panel(struct clcd_fb *fb,
>  					     &clcd_id);
>  	if (!np) {
>  		dev_err(dev, "no Versatile syscon node\n");
> -		return -ENODEV;
> +		/* Vexpress does not have this */
> +		return 0;
>  	}
>  	versatile_clcd_type = (enum versatile_clcd)clcd_id->data;
>  
> 

Thanks, queued for 4.9 fixes.

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161102/46980a9e/attachment.sig>
