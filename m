From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 5 Jan 2015 13:17:31 +0200
Subject: [PATCH] simplefb: Fix build failure on Sparc
In-Reply-To: <1420445716-13468-1-git-send-email-hdegoede@redhat.com>
References: <1420445716-13468-1-git-send-email-hdegoede@redhat.com>
Message-ID: <54AA72CB.1020303@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/01/15 10:15, Hans de Goede wrote:
> of_platform_device_create is only defined when CONFIG_OF_ADDRESS is set,
> which is normally always the case when CONFIG_OF is defined, except on Sparc,
> so explicitly check for CONFIG_OF_ADDRESS rather then for CONFIG_OF.
> 
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/video/fbdev/simplefb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
> index 92cac80..1085c04 100644
> --- a/drivers/video/fbdev/simplefb.c
> +++ b/drivers/video/fbdev/simplefb.c
> @@ -402,7 +402,7 @@ static int __init simplefb_init(void)
>  	if (ret)
>  		return ret;
>  
> -	if (IS_ENABLED(CONFIG_OF) && of_chosen) {
> +	if (IS_ENABLED(CONFIG_OF_ADDRESS) && of_chosen) {
>  		for_each_child_of_node(of_chosen, np) {
>  			if (of_device_is_compatible(np, "simple-framebuffer"))
>  				of_platform_device_create(np, NULL, NULL);
> 

Doesn't this depend on the compiler optimizing the
of_platform_device_create call away? Isn't that rather dangerous assumption?

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150105/2e912057/attachment.sig>
