From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 3 Oct 2018 23:14:45 +0100
Subject: [PATCH v2] mm: Introduce new function vm_insert_kmem_page
In-Reply-To: <20181003200003.GA9965@bombadil.infradead.org>
References: <20181003185854.GA1174@jordon-HP-15-Notebook-PC>
 <20181003200003.GA9965@bombadil.infradead.org>
Message-ID: <20181003221444.GZ30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 03, 2018 at 01:00:03PM -0700, Matthew Wilcox wrote:
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

Reading the commit log, it seems that the intention is to split out
vm_insert_page() used outside of page-fault handling with the use
within page-fault handling, so that different return codes can be
used.

I don't see that justifies the code duplication - can't
vm_insert_page() and vm_insert_kmem_page() use the same mechanics
to do their job, and just translate the error code from the most-
specific to the least-specific error code?  Do we really need two
copies of the same code just to return different error codes.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
