From: oleg@redhat.com (Oleg Nesterov)
Date: Fri, 11 Apr 2014 16:35:11 +0200
Subject: [RFC PATCH] uprobes: copy to user-space xol page with proper
 cache flushing
In-Reply-To: <CAA3XUr0-KqtBw0WCFvws8g5ChK49d+X+7Un9ngq1UZg-oROx+A@mail.gmail.com>
References: <20140409184507.GA1058@redhat.com>
 <CAA3XUr3w_9318mT2_9+J-nf3wDv5bic+v0H4nVfsYof7wWZs9Q@mail.gmail.com>
 <5347655B.3080307@linaro.org>
 <20140411.003636.272212797007496394.davem@davemloft.net>
 <CAA3XUr0-KqtBw0WCFvws8g5ChK49d+X+7Un9ngq1UZg-oROx+A@mail.gmail.com>
Message-ID: <20140411143511.GA26569@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/11, Victor Kamensky wrote:
>
> On 10 April 2014 21:36, David Miller <davem@davemloft.net> wrote:
> > You really need to pass the proper VMA down to the call site
> > rather than pass NULL, that's extremely ugly and totally
> > unnecesary.
>
> Agreed that VMA is really needed.

I do not ;) but I am still trying to finish my email...

> index 04709b6..1ae4563 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -117,6 +117,7 @@ struct xol_area {
>       * the vma go away, and we must handle that reasonably gracefully.
>       */
>      unsigned long         vaddr;        /* Page(s) of instruction slots */
> +    struct vm_area_struct    *vma;        /* VMA that holds above address */
>  };
> 
>  /*
> @@ -1150,6 +1151,7 @@ static int xol_add_vma(struct mm_struct *mm,
> struct xol_area *area)
> 
>      ret = install_special_mapping(mm, area->vaddr, PAGE_SIZE,
>                  VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO, &area->page);
> +    area->vma = find_vma(mm, area->vaddr);

No, this can't work. This vma can be unmapped/freed/etc.

Oleg.
