From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Mon, 15 Feb 2016 11:44:34 +0000
Subject: [PATCH 1/5] xen: audit usages of module.h ; remove unnecessary
 instances
In-Reply-To: <1455481970-15239-2-git-send-email-paul.gortmaker@windriver.com>
References: <1455481970-15239-1-git-send-email-paul.gortmaker@windriver.com>
 <1455481970-15239-2-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <alpine.DEB.2.02.1602151104300.27008@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 14 Feb 2016, Paul Gortmaker wrote:
> Code that uses no modular facilities whatsoever should not be
> sourcing module.h at all, since that header drags in a bunch
> of other headers with it.
> 
> Similarly, code that is not explicitly using modular facilities
> like module_init() but only is declaring module_param setup
> variables should be using moduleparam.h and not the larger
> module.h file for that.
> 
> In making this change, we also uncover an implicit use of BUG()
> in inline fcns within arch/arm/include/asm/xen/hypercall.h so
> we explicitly source <linux/bug.h> for that file now.
> 
> Cc: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: David Vrabel <david.vrabel@citrix.com>
> Cc: xen-devel at lists.xenproject.org
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Reviewed-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>


>  arch/arm/include/asm/xen/hypercall.h  | 2 ++
>  drivers/xen/events/events_2l.c        | 1 -
>  drivers/xen/events/events_base.c      | 2 +-
>  drivers/xen/events/events_fifo.c      | 1 -
>  drivers/xen/features.c                | 2 +-
>  drivers/xen/grant-table.c             | 1 -
>  drivers/xen/xen-pciback/conf_space.c  | 2 +-
>  drivers/xen/xen-pciback/pciback_ops.c | 2 +-
>  drivers/xen/xen-pciback/xenbus.c      | 2 +-
>  drivers/xen/xen-selfballoon.c         | 1 -
>  drivers/xen/xenbus/xenbus_xs.c        | 1 -
>  drivers/xen/xenfs/xensyms.c           | 1 -
>  12 files changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/include/asm/xen/hypercall.h b/arch/arm/include/asm/xen/hypercall.h
> index d769972db8cb..b6b962d70db9 100644
> --- a/arch/arm/include/asm/xen/hypercall.h
> +++ b/arch/arm/include/asm/xen/hypercall.h
> @@ -33,6 +33,8 @@
>  #ifndef _ASM_ARM_XEN_HYPERCALL_H
>  #define _ASM_ARM_XEN_HYPERCALL_H
>  
> +#include <linux/bug.h>
> +
>  #include <xen/interface/xen.h>
>  #include <xen/interface/sched.h>
>  #include <xen/interface/platform.h>
> diff --git a/drivers/xen/events/events_2l.c b/drivers/xen/events/events_2l.c
> index 7dd46312c180..51b488f5bfe9 100644
> --- a/drivers/xen/events/events_2l.c
> +++ b/drivers/xen/events/events_2l.c
> @@ -9,7 +9,6 @@
>  #include <linux/linkage.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
> -#include <linux/module.h>
>  
>  #include <asm/sync_bitops.h>
>  #include <asm/xen/hypercall.h>
> diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
> index 524c22146429..488017a0806a 100644
> --- a/drivers/xen/events/events_base.c
> +++ b/drivers/xen/events/events_base.c
> @@ -26,7 +26,7 @@
>  #include <linux/linkage.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
> -#include <linux/module.h>
> +#include <linux/moduleparam.h>
>  #include <linux/string.h>
>  #include <linux/bootmem.h>
>  #include <linux/slab.h>
> diff --git a/drivers/xen/events/events_fifo.c b/drivers/xen/events/events_fifo.c
> index eff2b88003d9..9289a17712e2 100644
> --- a/drivers/xen/events/events_fifo.c
> +++ b/drivers/xen/events/events_fifo.c
> @@ -36,7 +36,6 @@
>  #include <linux/linkage.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
> -#include <linux/module.h>
>  #include <linux/smp.h>
>  #include <linux/percpu.h>
>  #include <linux/cpu.h>
> diff --git a/drivers/xen/features.c b/drivers/xen/features.c
> index 99eda169c779..d7d34fdfc993 100644
> --- a/drivers/xen/features.c
> +++ b/drivers/xen/features.c
> @@ -7,7 +7,7 @@
>   */
>  #include <linux/types.h>
>  #include <linux/cache.h>
> -#include <linux/module.h>
> +#include <linux/export.h>
>  
>  #include <asm/xen/hypercall.h>
>  
> diff --git a/drivers/xen/grant-table.c b/drivers/xen/grant-table.c
> index effbaf91791f..bb36b1e1dbcc 100644
> --- a/drivers/xen/grant-table.c
> +++ b/drivers/xen/grant-table.c
> @@ -33,7 +33,6 @@
>  
>  #define pr_fmt(fmt) "xen:" KBUILD_MODNAME ": " fmt
>  
> -#include <linux/module.h>
>  #include <linux/sched.h>
>  #include <linux/mm.h>
>  #include <linux/slab.h>
> diff --git a/drivers/xen/xen-pciback/conf_space.c b/drivers/xen/xen-pciback/conf_space.c
> index 9c234209d8b5..8e67336f8ddd 100644
> --- a/drivers/xen/xen-pciback/conf_space.c
> +++ b/drivers/xen/xen-pciback/conf_space.c
> @@ -10,7 +10,7 @@
>   */
>  
>  #include <linux/kernel.h>
> -#include <linux/module.h>
> +#include <linux/moduleparam.h>
>  #include <linux/pci.h>
>  #include "pciback.h"
>  #include "conf_space.h"
> diff --git a/drivers/xen/xen-pciback/pciback_ops.c b/drivers/xen/xen-pciback/pciback_ops.c
> index 73dafdc494aa..5ad01f9c24fc 100644
> --- a/drivers/xen/xen-pciback/pciback_ops.c
> +++ b/drivers/xen/xen-pciback/pciback_ops.c
> @@ -6,7 +6,7 @@
>  
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
> -#include <linux/module.h>
> +#include <linux/moduleparam.h>
>  #include <linux/wait.h>
>  #include <linux/bitops.h>
>  #include <xen/events.h>
> diff --git a/drivers/xen/xen-pciback/xenbus.c b/drivers/xen/xen-pciback/xenbus.c
> index 4843741e703a..c252eb3f0176 100644
> --- a/drivers/xen/xen-pciback/xenbus.c
> +++ b/drivers/xen/xen-pciback/xenbus.c
> @@ -6,7 +6,7 @@
>  
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
> -#include <linux/module.h>
> +#include <linux/moduleparam.h>
>  #include <linux/init.h>
>  #include <linux/list.h>
>  #include <linux/vmalloc.h>
> diff --git a/drivers/xen/xen-selfballoon.c b/drivers/xen/xen-selfballoon.c
> index 3b2bffde534f..53a085fca00c 100644
> --- a/drivers/xen/xen-selfballoon.c
> +++ b/drivers/xen/xen-selfballoon.c
> @@ -71,7 +71,6 @@
>  #include <linux/swap.h>
>  #include <linux/mm.h>
>  #include <linux/mman.h>
> -#include <linux/module.h>
>  #include <linux/workqueue.h>
>  #include <linux/device.h>
>  #include <xen/balloon.h>
> diff --git a/drivers/xen/xenbus/xenbus_xs.c b/drivers/xen/xenbus/xenbus_xs.c
> index ba804f3d8278..374b12af8812 100644
> --- a/drivers/xen/xenbus/xenbus_xs.c
> +++ b/drivers/xen/xenbus/xenbus_xs.c
> @@ -44,7 +44,6 @@
>  #include <linux/fcntl.h>
>  #include <linux/kthread.h>
>  #include <linux/rwsem.h>
> -#include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <asm/xen/hypervisor.h>
>  #include <xen/xenbus.h>
> diff --git a/drivers/xen/xenfs/xensyms.c b/drivers/xen/xenfs/xensyms.c
> index a03f261b12d8..c6e2b4a542ea 100644
> --- a/drivers/xen/xenfs/xensyms.c
> +++ b/drivers/xen/xenfs/xensyms.c
> @@ -1,4 +1,3 @@
> -#include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/seq_file.h>
>  #include <linux/fs.h>
> -- 
> 2.6.1
> 
