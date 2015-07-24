From: david.vrabel@citrix.com (David Vrabel)
Date: Fri, 24 Jul 2015 10:52:16 +0100
Subject: [PATCH v2 11/20] tty/hvc: xen: Use xen page definition
In-Reply-To: <1436474552-31789-12-git-send-email-julien.grall@citrix.com>
References: <1436474552-31789-1-git-send-email-julien.grall@citrix.com>
 <1436474552-31789-12-git-send-email-julien.grall@citrix.com>
Message-ID: <55B20AD0.8050007@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/07/15 21:42, Julien Grall wrote:
> The console ring is always based on the page granularity of Xen.
[...]
> --- a/drivers/tty/hvc/hvc_xen.c
> +++ b/drivers/tty/hvc/hvc_xen.c
> @@ -392,7 +392,7 @@ static int xencons_connect_backend(struct xenbus_device *dev,
>  	if (xen_pv_domain())
>  		mfn = virt_to_mfn(info->intf);
>  	else
> -		mfn = __pa(info->intf) >> PAGE_SHIFT;
> +		mfn = __pa(info->intf) >> XEN_PAGE_SHIFT;

Change this to

gfn = xen_page_to_gfn(virt_to_page(info->intf));

and drop the if()?

David
