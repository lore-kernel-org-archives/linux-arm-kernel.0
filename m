From: oleg@redhat.com (Oleg Nesterov)
Date: Wed, 16 Apr 2014 21:18:25 +0200
Subject: [RFC PATCH v4] ARM: uprobes xol write directly to userspace
In-Reply-To: <20140416.133831.364304583096073299.davem@davemloft.net>
References: <20140416145107.GA11039@redhat.com>
 <20140416.110031.1269128188581361698.davem@davemloft.net>
 <20140416164310.GA15739@redhat.com>
 <20140416.133831.364304583096073299.davem@davemloft.net>
Message-ID: <20140416191825.GA22246@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/16, David Miller wrote:
>
> From: Oleg Nesterov <oleg@redhat.com>
> Date: Wed, 16 Apr 2014 18:43:10 +0200
>
> > But did you really mean get_unmapped_area(pgoff => page_to_pfn(area->page)) ?
>
> Yes.
>
> > I simply can't understand how this can work, arm (and x86) really use it as
> > "pgoff << PAGE_SHIFT" align_offset accounted in unmapped_area() ?
>
> When a platform has D-cache aliasing issues, it must make sure that
> every shared page is mapped to the same D-cache alias in all such
> shared mappings.
>
> The way this is done is to map each pgoff to a page in the D-cache.
> For example, pgoff 0 would be given a virtual address that maps to the
> first page in the D-cache, pgoff 1 to the second, and so forth.
>
> What we're doing with this get_unmapped_area() call is to make it so
> that userspace's virtual address will land at the same virtual alias
> as the kernel one does.
         ^^^^^^^^^^^^^^^

and page_address() == xxx + (pfn << PAGE_SHIFT), I seem to understand...

David, thanks a lot. I am not saying I fully understand this all, I'll
try to reread your email tomorrow, but it seems that I see the light.

The last question... area->page = alloc_page(GFP_HIGHUSER), and I am
not sure that arch/arm/mm/highmem.c:kmap_atomic() can't break the
aliasing, __fix_to_virt() in this case will use the same (per-cpu) idx.

Looks like, __kunmap_atomic()->__cpuc_flush_dcache_area() should take
care, but could you please ack/nack my understanding?

Thanks!

> >> So we end up with all of the benefits of storing directly to
> >> userspace, along with what you're trying to achieve.
> >
> > And in this case we can avoid copy_to_user(), right ?
>
> Yes, that's the whole idea, you can forget about the VM_WRITE etc.
> that caused your concerns.
>
> It'd be just memcpy to kernel side mapping of the page + i-cache flush
> where necessary.

Great.

Victor, Russel, what do you think? It seems that this patch can be updated.

Oleg.
