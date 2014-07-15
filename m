From: iamjoonsoo.kim@lge.com (Joonsoo Kim)
Date: Tue, 15 Jul 2014 15:12:19 +0900
Subject: [RFC/PATCH RESEND -next 20/21] fs: dcache: manually unpoison
 dname after allocation to shut up kasan's reports
In-Reply-To: <1404905415-9046-21-git-send-email-a.ryabinin@samsung.com>
References: <1404905415-9046-1-git-send-email-a.ryabinin@samsung.com>
 <1404905415-9046-21-git-send-email-a.ryabinin@samsung.com>
Message-ID: <20140715061219.GK11317@js1304-P5Q-DELUXE>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 09, 2014 at 03:30:14PM +0400, Andrey Ryabinin wrote:
> We need to manually unpoison rounded up allocation size for dname
> to avoid kasan's reports in __d_lookup_rcu.
> __d_lookup_rcu may validly read a little beyound allocated size.

If it read a little beyond allocated size, IMHO, it is better to
allocate correct size.

kmalloc(name->len + 1, GFP_KERNEL); -->
kmalloc(roundup(name->len + 1, sizeof(unsigned long ), GFP_KERNEL);

Isn't it?

Thanks.

> 
> Reported-by: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: Andrey Ryabinin <a.ryabinin@samsung.com>
> ---
>  fs/dcache.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/dcache.c b/fs/dcache.c
> index b7e8b20..dff64f2 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -38,6 +38,7 @@
>  #include <linux/prefetch.h>
>  #include <linux/ratelimit.h>
>  #include <linux/list_lru.h>
> +#include <linux/kasan.h>
>  #include "internal.h"
>  #include "mount.h"
>  
> @@ -1412,6 +1413,8 @@ struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
>  			kmem_cache_free(dentry_cache, dentry); 
>  			return NULL;
>  		}
> +		unpoison_shadow(dname,
> +				roundup(name->len + 1, sizeof(unsigned long)));
>  	} else  {
>  		dname = dentry->d_iname;
>  	}	
> -- 
> 1.8.5.5
> 
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo at kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"dont@kvack.org"> email at kvack.org </a>
