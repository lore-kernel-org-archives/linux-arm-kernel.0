From: trblinux@gmail.com (Tushar Behera)
Date: Wed, 02 Jul 2014 11:30:33 +0530
Subject: [PATCHv2 1/3] of: Split early_init_dt_scan into two parts
In-Reply-To: <1404266608-3274-1-git-send-email-lauraa@codeaurora.org>
References: <1404266608-3274-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <53B3A001.1090909@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/02/2014 07:33 AM, Laura Abbott wrote:
> Currently, early_init_dt_scan validates the header, sets the
> boot params, and scans for chosen/memory all in one function.
> Split this up into two separate functions (validation/setting
> boot params in one, scanning in another) to allow for
> additional setup between boot params and scanning the memory.
> 
> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
> ---

Tested the patchset on top of Linus' tree.

Verified after enabling following debug message.
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -865,7 +865,7 @@ int __init early_init_dt_scan_memory(unsigned long
node, const char *uname,

        endp = reg + (l / sizeof(__be32));

-       pr_debug("memory scan node %s, reg size %d, data: %x %x %x %x,\n",
+       pr_err("memory scan node %s, reg size %d, data: %x %x %x %x,\n",


Output before:
memory scan node memory, reg size 96, data: 20 10 30 10,

Output after:
memory scan node memory, reg size 64, data: 20 10 30 10,

Tested-by: Tushar Behera <trblinux@gmail.com>

One minor nit below ...

>  drivers/of/fdt.c       | 18 +++++++++++++++++-
>  include/linux/of_fdt.h |  2 ++
>  2 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index c4cddf0..55bfca9 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -922,7 +922,7 @@ int __init __weak early_init_dt_reserve_memory_arch(phys_addr_t base,
>  }
>  #endif
>  
> -bool __init early_init_dt_scan(void *params)
> +bool __init early_init_dt_verify(void *params)
>  {
>  	if (!params)
>  		return false;
> @@ -936,6 +936,12 @@ bool __init early_init_dt_scan(void *params)
>  		return false;
>  	}
>  
> +	return true;
> +}
> +
> +

Extra blank line here. Can be removed.

-- 
Tushar Behera
