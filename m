From: joe@perches.com (Joe Perches)
Date: Thu, 25 Oct 2018 11:44:38 -0700
Subject: [PATCH] mm/page_owner: use vmalloc instead of kmalloc
In-Reply-To: <1540492481-4144-1-git-send-email-miles.chen@mediatek.com>
References: <1540492481-4144-1-git-send-email-miles.chen@mediatek.com>
Message-ID: <e0cd65fdd6afc17b2be9b3ac64d50b95b2c2f32e.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2018-10-26 at 02:34 +0800, miles.chen at mediatek.com wrote:
> From: Miles Chen <miles.chen@mediatek.com>
> 
> The kbuf used by page owner is allocated by kmalloc(),
> which means it can use only normal memory and there might
> be a "out of memory" issue when we're out of normal memory.
> 
> Use vmalloc() so we can also allocate kbuf from highmem
> on 32bit kernel.

If this is really necessary, using kvmalloc/kvfree would
be better as the vmalloc space is also limited.

> diff --git a/mm/page_owner.c b/mm/page_owner.c
[]
> @@ -1,7 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <linux/debugfs.h>
>  #include <linux/mm.h>
> -#include <linux/slab.h>
>  #include <linux/uaccess.h>
>  #include <linux/bootmem.h>
>  #include <linux/stacktrace.h>
> @@ -10,6 +9,7 @@
>  #include <linux/migrate.h>
>  #include <linux/stackdepot.h>
>  #include <linux/seq_file.h>
> +#include <linux/vmalloc.h>
>  
>  #include "internal.h"
>  
> @@ -351,7 +351,7 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
>  		.skip = 0
>  	};
>  
> -	kbuf = kmalloc(count, GFP_KERNEL);
> +	kbuf = vmalloc(count);
>  	if (!kbuf)
>  		return -ENOMEM;
>  
> @@ -397,11 +397,11 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
>  	if (copy_to_user(buf, kbuf, ret))
>  		ret = -EFAULT;
>  
> -	kfree(kbuf);
> +	vfree(kbuf);
>  	return ret;
>  
>  err:
> -	kfree(kbuf);
> +	vfree(kbuf);
>  	return -ENOMEM;
>  }
>  
