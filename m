From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 25 Apr 2017 15:51:38 +0100
Subject: [PATCH] arm64: fix the overlap between the kernel image and
 vmalloc address
In-Reply-To: <ffd0a3c5-5d89-4bbd-9995-c545bccaa8f6@redhat.com>
References: <1493025729-21505-1-git-send-email-zhongjiang@huawei.com>
 <20170424104456.GA4343@leverpostej> <58FDFD90.8050300@huawei.com>
 <20170424155125.GA5972@leverpostej>
 <ffd0a3c5-5d89-4bbd-9995-c545bccaa8f6@redhat.com>
Message-ID: <20170425145138.GE3792@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 24, 2017 at 10:52:08AM -0700, Laura Abbott wrote:
> On 04/24/2017 08:51 AM, Mark Rutland wrote:
> > On Mon, Apr 24, 2017 at 09:28:48PM +0800, zhong jiang wrote:

> >>  /*
> >>    * Walk a vmap address to the struct page it maps.
> >>    */
> >> @@ -244,6 +280,9 @@ struct page *vmalloc_to_page(const void *vmalloc_addr)
> >>          */
> >>         VIRTUAL_BUG_ON(!is_vmalloc_or_module_addr(vmalloc_addr));
> >>
> >> +       if (is_kernel_image_addr(vmalloc_addr))
> >> +               return kernel_image_to_page(vmalloc_addr, pgd);
> > 
> > It's not clear to me that this is the right place for this to live.
> > 
> > It might be best to code the kernel image logic directly in kcore (and
> > kmem), assuming everyone's OK with that approach.
> > 
> 
> That will fix kcore and kmem but this will show up in other places too.

True.

> We've gone through and made sure that virt_addr_valid returns
> true if and only if virt_to_page returns a valid address. I don't know
> if we can make as strong a claim about is_vmalloc_addr and
> vmalloc_to_page in all cases but is_vmalloc_addr should not return true
> for the kernel image. That would at least let kcore fall back to
> kern_addr_valid which should correctly handle the kernel image.

That would largely be my preference.

My fear is that other users of is_vmalloc_addr() are doing the right
thing for the kernel image today (e.g. not doing virt_to_phys()),
because they see it as a vmalloc addr.

So we might have to audit all of those.

> The suggestion to move the kernel image out of VMALLOC_START/VMALLOC_END
> seems like the best approach although I haven't tried a prototype
> at all.

Given that (AFAICT) we're the only architecture that puts the kernel in
the vmalloc area, I agree that this is likely to be the simplest correct
approach. The interaction with KASLR is somewhat unfortunate.

Thanks,
Mark.
