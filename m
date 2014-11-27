From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed, 26 Nov 2014 16:01:47 -0800
Subject: [PATCH v5 2/6] uio: Add new UIO_MEM_PHYS_CACHE type for mem
 regions
In-Reply-To: <1416220572-13381-3-git-send-email-ankit.jindal@linaro.org>
References: <1416220572-13381-1-git-send-email-ankit.jindal@linaro.org>
 <1416220572-13381-3-git-send-email-ankit.jindal@linaro.org>
Message-ID: <20141127000147.GC5313@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 17, 2014 at 04:06:08PM +0530, Ankit Jindal wrote:
> Currently, three types of mem regions are supported: UIO_MEM_PHYS,
> UIO_MEM_LOGICAL and UIO_MEM_VIRTUAL. Among these UIO_MEM_PHYS helps
> UIO driver export physcial memory to user space as non-cacheable
> user memory. Typcially memory-mapped registers of a device are exported
> to user space as UIO_MEM_PHYS type mem region. The UIO_MEM_PHYS type
> is not efficient if dma-capable devices are capable of maintaining coherency
> with CPU caches.

Not efficient in what way?

> This patch adds new type UIO_MEM_PHYS_CACHE for mem regions to enable
> cacheable access to physical memory from user space.
> 
> Signed-off-by: Ankit Jindal <ankit.jindal@linaro.org>
> Signed-off-by: Tushar Jagad <tushar.jagad@linaro.org>
> ---
>  drivers/uio/uio.c          |   11 ++++++++---
>  include/linux/uio_driver.h |    1 +
>  2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
> index 97e6444..120a84b 100644
> --- a/drivers/uio/uio.c
> +++ b/drivers/uio/uio.c
> @@ -644,7 +644,7 @@ static const struct vm_operations_struct uio_physical_vm_ops = {
>  #endif
>  };
>  
> -static int uio_mmap_physical(struct vm_area_struct *vma)
> +static int uio_mmap_physical(struct vm_area_struct *vma, bool cacheable)

I despise "bool" flags in a function, as they don't give any idea of
what is going on when you see the function being called.  Please create
a new function that does this properly, with a correct name, if it's
needed.

thanks,

greg k-h
