From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 13 Nov 2014 09:52:38 +0100
Subject: [PATCH 3/4] simplefb: Change simplefb_init from module_init to
 fs_initcall
In-Reply-To: <1415830124-28787-3-git-send-email-hdegoede@redhat.com>
References: <1415830124-28787-1-git-send-email-hdegoede@redhat.com>
 <1415830124-28787-3-git-send-email-hdegoede@redhat.com>
Message-ID: <20141113085238.GE20972@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 12, 2014 at 11:08:43PM +0100, Hans de Goede wrote:
> One of the reasons for having the simplefb nodes in /chosen, and doing
> explicit enumeration of the nodes there, is too allow enumerating them sooner,
> so that we get a console earlier on.
> 
> Doing this earlier then fs_initcall is not useful, since the fb only turns into
> a console when fbcon intializes, which is a fs_initcall too.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/video/fbdev/simplefb.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
> index be7d288..8c0c972 100644
> --- a/drivers/video/fbdev/simplefb.c
> +++ b/drivers/video/fbdev/simplefb.c
> @@ -415,7 +415,11 @@ static void __exit simplefb_exit(void)
>  	platform_driver_unregister(&simplefb_driver);
>  }
>  
> -module_init(simplefb_init);
> +/*
> + * While this can be a module, if builtin it's most likely the console
> + * So let's leave module_exit but move module_init to an earlier place
> + */

Not really related to this patch itself, but do we want to support
simplefb as a module? It seems like it's going to be most of the time
broken.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141113/6baced6e/attachment-0001.sig>
