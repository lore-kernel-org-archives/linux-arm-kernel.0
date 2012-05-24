From: akpm@linux-foundation.org (Andrew Morton)
Date: Thu, 24 May 2012 15:12:31 -0700
Subject: mm: fix faulty initialization in vmalloc_init()
In-Reply-To: <001c01cd3987$d1a71a50$74f54ef0$%cho@samsung.com>
References: <001c01cd3987$d1a71a50$74f54ef0$%cho@samsung.com>
Message-ID: <20120524151231.e3a18ac5.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 24 May 2012 17:32:56 +0900
KyongHo <pullip.cho@samsung.com> wrote:

> vmalloc_init() adds 'vmap_area's for early 'vm_struct's.
> This patch fixes vmalloc_init() to correctly initialize
> vmap_area for the given vm_struct.
> 

<daily message>
Insufficient information.  When fixing a bug please always always
always describe the user-visible effects of the bug.  Does the kernel
instantly crash?  Is it a comestic cleanliness thing which has no
effect?  Something in between?  I have simply no idea, and am dependent
upon you to tell me.

> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1185,9 +1185,10 @@ void __init vmalloc_init(void)
>  	/* Import existing vmlist entries. */
>  	for (tmp = vmlist; tmp; tmp = tmp->next) {
>  		va = kzalloc(sizeof(struct vmap_area), GFP_NOWAIT);
> -		va->flags = tmp->flags | VM_VM_AREA;
> +		va->flags = VM_VM_AREA;

This change is a mystery.  Why do we no longer transfer ->flags?

>  		va->va_start = (unsigned long)tmp->addr;
>  		va->va_end = va->va_start + tmp->size;
> +		va->vm = tmp;

OK, I can see how this might be important.  But why did you find it
necessary?  Why was this change actually needed?

>  		__insert_vmap_area(va);
>  	}
