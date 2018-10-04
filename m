From: jrdr.linux@gmail.com (Souptick Joarder)
Date: Thu, 4 Oct 2018 23:51:12 +0530
Subject: [PATCH v2] mm: Introduce new function vm_insert_kmem_page
In-Reply-To: <20181003200003.GA9965@bombadil.infradead.org>
References: <20181003185854.GA1174@jordon-HP-15-Notebook-PC>
 <20181003200003.GA9965@bombadil.infradead.org>
Message-ID: <CAFqt6za_OxXArRQfzK1h3L1o+TgU+Xz02gLy2yp0rxAJfFwnqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matthew,

On Thu, Oct 4, 2018 at 1:30 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, Oct 04, 2018 at 12:28:54AM +0530, Souptick Joarder wrote:
> > These are the approaches which could have been taken to handle
> > this scenario -
> >
> > *  Replace vm_insert_page with vmf_insert_page and then write few
> >    extra lines of code to convert VM_FAULT_CODE to errno which
> >    makes driver users more complex ( also the reverse mapping errno to
> >    VM_FAULT_CODE have been cleaned up as part of vm_fault_t migration ,
> >    not preferred to introduce anything similar again)
> >
> > *  Maintain both vm_insert_page and vmf_insert_page and use it in
> >    respective places. But it won't gurantee that vm_insert_page will
> >    never be used in #PF context.
> >
> > *  Introduce a similar API like vm_insert_page, convert all non #PF
> >    consumer to use it and finally remove vm_insert_page by converting
> >    it to vmf_insert_page.
> >
> > And the 3rd approach was taken by introducing vm_insert_kmem_page().
> >
> > In short, vmf_insert_page will be used in page fault handlers
> > context and vm_insert_kmem_page will be used to map kernel
> > memory to user vma outside page fault handlers context.
>
> As far as I can tell, vm_insert_kmem_page() is line-for-line identical
> with vm_insert_page().  Seriously, here's a diff I just did:
>
> -static int insert_page(struct vm_area_struct *vma, unsigned long addr,
> -                       struct page *page, pgprot_t prot)
> +static int insert_kmem_page(struct vm_area_struct *vma, unsigned long addr,
> +               struct page *page, pgprot_t prot)
> -       /* Ok, finally just insert the thing.. */
> -int vm_insert_page(struct vm_area_struct *vma, unsigned long addr,
> +int vm_insert_kmem_page(struct vm_area_struct *vma, unsigned long addr,
> -       return insert_page(vma, addr, page, vma->vm_page_prot);
> +       return insert_kmem_page(vma, addr, page, vma->vm_page_prot);
> -EXPORT_SYMBOL(vm_insert_page);
> +EXPORT_SYMBOL(vm_insert_kmem_page);
>
> What on earth are you trying to do?

Shall I take below approach rather than just creating a identical API
same as vm_insert_page ??

1. create a wrapper function vm_insert_kmem_page using vm_insert_page.
2. Convert all the non #PF users to use it.
3. Then make vm_insert_page static and convert inline vmf_insert_page to caller.

In that way we will be having two functions vmf_insert_page (#PF) and
vm_insert_kmem_page (non #PF) and both will be using common vm_insert_page
which will be static.

I am clear with the problem statement but not very clear on my solution.
