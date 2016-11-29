From: boris.ostrovsky@oracle.com (Boris Ostrovsky)
Date: Tue, 29 Nov 2016 17:26:18 -0500
Subject: [PATCHv4 06/10] xen: Switch to using __pa_symbol
In-Reply-To: <1480445729-27130-7-git-send-email-labbott@redhat.com>
References: <1480445729-27130-1-git-send-email-labbott@redhat.com>
 <1480445729-27130-7-git-send-email-labbott@redhat.com>
Message-ID: <935fefbf-97dc-83fc-b7c3-ba3f19f2087f@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/29/2016 01:55 PM, Laura Abbott wrote:
> __pa_symbol is the correct macro to use on kernel
> symbols. Switch to this from __pa.
>
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
> Found during a sweep of the kernel. Untested.
> ---
>  drivers/xen/xenbus/xenbus_dev_backend.c | 2 +-
>  drivers/xen/xenfs/xenstored.c           | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/xen/xenbus/xenbus_dev_backend.c b/drivers/xen/xenbus/xenbus_dev_backend.c
> index 4a41ac9..31ca2bf 100644
> --- a/drivers/xen/xenbus/xenbus_dev_backend.c
> +++ b/drivers/xen/xenbus/xenbus_dev_backend.c
> @@ -99,7 +99,7 @@ static int xenbus_backend_mmap(struct file *file, struct vm_area_struct *vma)
>  		return -EINVAL;
>  
>  	if (remap_pfn_range(vma, vma->vm_start,
> -			    virt_to_pfn(xen_store_interface),
> +			    PHYS_PFN(__pa_symbol(xen_store_interface)),
>  			    size, vma->vm_page_prot))
>  		return -EAGAIN;
>  
> diff --git a/drivers/xen/xenfs/xenstored.c b/drivers/xen/xenfs/xenstored.c
> index fef20db..21009ea 100644
> --- a/drivers/xen/xenfs/xenstored.c
> +++ b/drivers/xen/xenfs/xenstored.c
> @@ -38,7 +38,7 @@ static int xsd_kva_mmap(struct file *file, struct vm_area_struct *vma)
>  		return -EINVAL;
>  
>  	if (remap_pfn_range(vma, vma->vm_start,
> -			    virt_to_pfn(xen_store_interface),
> +			    PHYS_PFN(__pa_symbol(xen_store_interface)),
>  			    size, vma->vm_page_prot))
>  		return -EAGAIN;
>  


I suspect this won't work --- xen_store_interface doesn't point to a
kernel symbol.

-boris
