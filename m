From: msalter@redhat.com (Mark Salter)
Date: Fri, 21 Nov 2014 10:21:13 -0500
Subject: [PATCH v3 11/13] arm64/efi: use plain memblock API for adding
 and removing reserved RAM
In-Reply-To: <CAKv+Gu_2kn10dh7LMbhVVYu8+LkMoN_Vxi-tnmCEcBTJ7qs_Jg@mail.gmail.com>
References: <1416315432-8534-1-git-send-email-ard.biesheuvel@linaro.org>
 <1416315432-8534-12-git-send-email-ard.biesheuvel@linaro.org>
 <1416504536.6398.58.camel@deneb.redhat.com>
 <CAKv+Gu9XQWrQyPi+8=vhXWkJXtnJ+8=evNC-Z_MkWR8Wuk6Awg@mail.gmail.com>
 <1416506069.6398.64.camel@deneb.redhat.com>
 <CAKv+Gu_2kn10dh7LMbhVVYu8+LkMoN_Vxi-tnmCEcBTJ7qs_Jg@mail.gmail.com>
Message-ID: <1416583273.6398.71.camel@deneb.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-11-21 at 13:07 +0100, Ard Biesheuvel wrote:
> On 20 November 2014 18:54, Mark Salter <msalter@redhat.com> wrote:
> > On Thu, 2014-11-20 at 18:38 +0100, Ard Biesheuvel wrote:
> >> On 20 November 2014 18:28, Mark Salter <msalter@redhat.com> wrote:
> >> > On Tue, 2014-11-18 at 13:57 +0100, Ard Biesheuvel wrote:
> >> >> diff --git a/drivers/firmware/efi/virtmap.c
> >> >> b/drivers/firmware/efi/virtmap.c
> >> >> index 98735fb43581..4b6a5c31629f 100644
> >> >> --- a/drivers/firmware/efi/virtmap.c
> >> >> +++ b/drivers/firmware/efi/virtmap.c
> >> >> @@ -8,6 +8,7 @@
> >> >>   */
> >> >>
> >> >>  #include <linux/efi.h>
> >> >> +#include <linux/memblock.h>
> >> >>  #include <linux/mm_types.h>
> >> >>  #include <linux/rbtree.h>
> >> >>  #include <linux/rwsem.h>
> >> >> @@ -97,8 +98,15 @@ void __init efi_virtmap_init(void)
> >> >>                 u64 paddr, npages, size;
> >> >>                 pgprot_t prot;
> >> >>
> >> >> -               if (!efi_mem_is_usable_region(md))
> >> >> +               paddr = md->phys_addr;
> >> >> +               npages = md->num_pages;
> >> >> +               memrange_efi_to_native(&paddr, &npages);
> >> >> +               size = npages << PAGE_SHIFT;
> >> >> +
> >> >> +               if (!efi_mem_is_usable_region(md)) {
> >> >>                         efi_register_mem_resource(md);
> >> >> +                       memblock_remove(paddr, size);
> >> >> +               }
> >> >
> >> > What exactly is the memblock_remove trying to accomplish? With it, I
> >> > get:
> >> >
> >>
> >> The idea was pfn_valid() will then return false for those pfns,
> >> allowing us to distinguish them from memory that the kernel may be
> >> using, primarily for /dev/mem filtering. But apparently it is causing
> >> problems for you, so I will have to figure out if there is a better
> >> way of addressing this.
> >>
> > Okay. Well I think that works for pfn_valid, but it is confusing the
> > mem_cgroup code. I think because you end up with multiple memory regions
> > after creating the holes. Earlier memory management code saw one memory
> > region. And because this comes after paging_init(), all of the memory
> > ends up in the kernel linear mapping which is something we were trying
> > to avoid.
> >
> 
> I will drop the memblock_remove() then. I guess I could make the test
> in devmem_is_allowed() do
> 
> if (!memblock_is_memory() || memblock_is_reserved())
> 
> instead of 'if (!pfn_valid())' so that reserved regions become
> accessible with having to remove them.

Maybe we should add a new memblock to keep track of uefi tables.
The memblock_is_reserved() seems overly permissive to me.

> 
> Are you happy with the other change in this patch, i.e., using
> memblock_add() directly so that we don't have to deal with the
> rounding?
> 

Yeah, I think that's okay. Everything else seems to be working fine
in my testing.
