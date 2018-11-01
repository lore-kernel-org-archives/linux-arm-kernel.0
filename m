From: akpm@linux-foundation.org (Andrew Morton)
Date: Thu, 1 Nov 2018 14:47:23 -0700
Subject: [PATCH v4] mm/page_owner: clamp read count to PAGE_SIZE
In-Reply-To: <1541091607-27402-1-git-send-email-miles.chen@mediatek.com>
References: <1541091607-27402-1-git-send-email-miles.chen@mediatek.com>
Message-ID: <20181101144723.3ddc1fa1ab7f81184bc2fdb8@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2 Nov 2018 01:00:07 +0800 <miles.chen@mediatek.com> wrote:

> From: Miles Chen <miles.chen@mediatek.com>
> 
> The page owner read might allocate a large size of memory with
> a large read count. Allocation fails can easily occur when doing
> high order allocations.
> 
> Clamp buffer size to PAGE_SIZE to avoid arbitrary size allocation
> and avoid allocation fails due to high order allocation.
> 
> ...
>
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -351,6 +351,7 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
>  		.skip = 0
>  	};
>  
> +	count = count > PAGE_SIZE ? PAGE_SIZE : count;
>  	kbuf = kmalloc(count, GFP_KERNEL);
>  	if (!kbuf)
>  		return -ENOMEM;

A bit tidier:

--- a/mm/page_owner.c~mm-page_owner-clamp-read-count-to-page_size-fix
+++ a/mm/page_owner.c
@@ -351,7 +351,7 @@ print_page_owner(char __user *buf, size_
 		.skip = 0
 	};
 
-	count = count > PAGE_SIZE ? PAGE_SIZE : count;
+	count = min_t(size_t, count, PAGE_SIZE);
 	kbuf = kmalloc(count, GFP_KERNEL);
 	if (!kbuf)
 		return -ENOMEM;
