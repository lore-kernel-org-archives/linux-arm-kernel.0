From: david.vrabel@citrix.com (David Vrabel)
Date: Tue, 19 May 2015 14:51:50 +0100
Subject: [Xen-devel] [RFC 02/23] xen/xenbus: client: Fix call of
 virt_to_mfn in xenbus_grant_ring
In-Reply-To: <1431622863-28575-3-git-send-email-julien.grall@citrix.com>
References: <1431622863-28575-1-git-send-email-julien.grall@citrix.com>
 <1431622863-28575-3-git-send-email-julien.grall@citrix.com>
Message-ID: <555B3FF6.4050902@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/05/15 18:00, Julien Grall wrote:
> virt_to_mfn should take a void* rather an unsigned long. While it
> doesn't really matter now, it would throw a compiler warning later when
> virt_to_mfn will enforce the type.
> 
> At the same time, avoid to compute new virtual address every time in the
> loop and directly increment the parameter as we don't use it later.

Reviewed-by: David Vrabel <david.vrabel@citrix.com>

But...

> --- a/drivers/xen/xenbus/xenbus_client.c
> +++ b/drivers/xen/xenbus/xenbus_client.c
> @@ -379,16 +379,16 @@ int xenbus_grant_ring(struct xenbus_device *dev, void *vaddr,
>  	int i, j;
>  
>  	for (i = 0; i < nr_pages; i++) {
> -		unsigned long addr = (unsigned long)vaddr +
> -			(PAGE_SIZE * i);
>  		err = gnttab_grant_foreign_access(dev->otherend_id,
> -						  virt_to_mfn(addr), 0);
> +						  virt_to_mfn(vaddr), 0);
>  		if (err < 0) {
>  			xenbus_dev_fatal(dev, err,
>  					 "granting access to ring page");
>  			goto fail;
>  		}
>  		grefs[i] = err;
> +
> +		vaddr = (char *)vaddr + PAGE_SIZE;

You don't need the cast here since vaddr is a void *.

David
