From: david.vrabel@citrix.com (David Vrabel)
Date: Tue, 19 May 2015 16:23:03 +0100
Subject: [Xen-devel] [RFC 15/23] xen/balloon: Don't rely on the page
 granularity is the same for Xen and Linux
In-Reply-To: <1431622863-28575-16-git-send-email-julien.grall@citrix.com>
References: <1431622863-28575-1-git-send-email-julien.grall@citrix.com>
 <1431622863-28575-16-git-send-email-julien.grall@citrix.com>
Message-ID: <555B5557.2090405@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/05/15 18:00, Julien Grall wrote:
> For ARM64 guests, Linux is able to support either 64K or 4K page
> granularity. Although, the hypercall interface is always based on 4K
> page granularity.
> 
> With 64K page granuliarty, a single page will be spread over multiple
> Xen frame.
> 
> When a driver request/free a balloon page, the balloon driver will have
> to split the Linux page in 4K chunk before asking Xen to add/remove the
> frame from the guest.
> 
> Note that this can work on any page granularity assuming it's a multiple
> of 4K.
[...]
> --- a/drivers/xen/balloon.c
> +++ b/drivers/xen/balloon.c
> @@ -91,7 +91,7 @@ struct balloon_stats balloon_stats;
>  EXPORT_SYMBOL_GPL(balloon_stats);
>  
>  /* We increase/decrease in batches which fit in a page */
> -static xen_pfn_t frame_list[PAGE_SIZE / sizeof(unsigned long)];
> +static xen_pfn_t frame_list[XEN_PAGE_SIZE / sizeof(unsigned long)];

PAGE_SIZE is appropriate here, since this is a guest-side array.

> +		if (!(i % XEN_PFN_PER_PAGE)) {

Ick.  Can you refactor this into a loop per page calling a function that
loops per MFN.

Also similar tests elsewhere.

David
