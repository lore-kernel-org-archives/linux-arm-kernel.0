From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 25 Apr 2017 16:02:12 +0100
Subject: [PATCH] arm64: fix the overlap between the kernel image and
 vmalloc address
In-Reply-To: <CAKv+Gu9RuJC9LgsEDSf91x4gV+VoRTLTjA9hGoPAu1ZkFDODmA@mail.gmail.com>
References: <1493025729-21505-1-git-send-email-zhongjiang@huawei.com>
 <20170424104456.GA4343@leverpostej> <58FDFD90.8050300@huawei.com>
 <20170424155125.GA5972@leverpostej>
 <ffd0a3c5-5d89-4bbd-9995-c545bccaa8f6@redhat.com>
 <CAKv+Gu9RuJC9LgsEDSf91x4gV+VoRTLTjA9hGoPAu1ZkFDODmA@mail.gmail.com>
Message-ID: <20170425150212.GF3792@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 24, 2017 at 06:56:43PM +0100, Ard Biesheuvel wrote:
> On 24 April 2017 at 18:52, Laura Abbott <labbott@redhat.com> wrote:
> > On 04/24/2017 08:51 AM, Mark Rutland wrote:
> >> On Mon, Apr 24, 2017 at 09:28:48PM +0800, zhong jiang wrote:

> >> static struct page *kernel_image_to_page(const void *addr)
> >> {
> >>       return virt_to_page(lm_alias(vmalloc_addr));
> >> }
> >>
> >>> +
> >>>  /*
> >>>    * Walk a vmap address to the struct page it maps.
> >>>    */
> >>> @@ -244,6 +280,9 @@ struct page *vmalloc_to_page(const void *vmalloc_addr)
> >>>          */
> >>>         VIRTUAL_BUG_ON(!is_vmalloc_or_module_addr(vmalloc_addr));
> >>>
> >>> +       if (is_kernel_image_addr(vmalloc_addr))
> >>> +               return kernel_image_to_page(vmalloc_addr, pgd);
> >>
> >> It's not clear to me that this is the right place for this to live.
> >>
> >> It might be best to code the kernel image logic directly in kcore (and
> >> kmem), assuming everyone's OK with that approach.
> >>
> >
> > That will fix kcore and kmem but this will show up in other places too.
> > We've gone through and made sure that virt_addr_valid returns
> > true if and only if virt_to_page returns a valid address. I don't know
> > if we can make as strong a claim about is_vmalloc_addr and
> > vmalloc_to_page in all cases but is_vmalloc_addr should not return true
> > for the kernel image. That would at least let kcore fall back to
> > kern_addr_valid which should correctly handle the kernel image.
> > The suggestion to move the kernel image out of VMALLOC_START/VMALLOC_END
> > seems like the best approach although I haven't tried a prototype
> > at all.
> 
> Moving the kernel into the vmalloc region was kind of the point, for
> KASLR. Undoing that means either disabling KASLR, or splitting the
> vmalloc region into a KASLR region only for the kernel, and a vmalloc
> region like we had when vmlinux lived in the linear region.

AFAICT, x86 don't place the kernel in the vmalloc region for its KASLR
implementation. Is that just to avoid the issues that we're seeing, or
are there aother constraints on x86?

> In general, I think we should be able to deal with different kinds of
> mappings with different granularity in the vmalloc region. If
> necessary, we could introduce a VM_xxx flag for the kernel to
> distinguish such regions from ordinary VM_MAP regions.

I don't think that vmalloc_to_page() should have to deal with anything
other than the usual page-granular memory mappings in the vmalloc area,
as it currently does. We'd have to write a page table walker per-arch
for that to work, and the only thing it would benefit is arm64's kernel
image mapping.

Adding VM_xxx (e.g. VM_KERNEL) sounds sane to me regardless of anything
else.

That still leaves the question as to what is_vmalloc_addr(addr) (should)
imply about addr, though.

Thanks,
Mark.
