From: david.vrabel@citrix.com (David Vrabel)
Date: Thu, 20 Aug 2015 10:55:58 +0100
Subject: [Xen-devel] [PATCH v3 11/20] tty/hvc: xen: Use xen page definition
In-Reply-To: <1438966019-19322-12-git-send-email-julien.grall@citrix.com>
References: <1438966019-19322-1-git-send-email-julien.grall@citrix.com>
 <1438966019-19322-12-git-send-email-julien.grall@citrix.com>
Message-ID: <55D5A42E.7070800@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/08/15 17:46, Julien Grall wrote:
> The console ring is always based on the page granularity of Xen.
[...]
> --- a/drivers/tty/hvc/hvc_xen.c
> +++ b/drivers/tty/hvc/hvc_xen.c
> @@ -230,7 +230,7 @@ static int xen_hvm_console_init(void)
>  	if (r < 0 || v == 0)
>  		goto err;
>  	gfn = v;
> -	info->intf = xen_remap(gfn << PAGE_SHIFT, PAGE_SIZE);
> +	info->intf = xen_remap(gfn << XEN_PAGE_SHIFT, PAGE_SIZE);

You need XEN_PAGE_SIZE here I think...

>  	if (info->intf == NULL)
>  		goto err;
>  	info->vtermno = HVC_COOKIE;
> @@ -472,7 +472,7 @@ static int xencons_resume(struct xenbus_device *dev)
>  	struct xencons_info *info = dev_get_drvdata(&dev->dev);
>  
>  	xencons_disconnect_backend(info);
> -	memset(info->intf, 0, PAGE_SIZE);
> +	memset(info->intf, 0, XEN_PAGE_SIZE);

...particularly since you use it here.

David
