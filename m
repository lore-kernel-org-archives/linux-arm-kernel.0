From: olof@lixom.net (Olof Johansson)
Date: Wed, 16 Nov 2011 16:16:17 -0800
Subject: [PATCH] ARM: Do not call flush_cache_user_range with mmap_sem held
In-Reply-To: <20111116235024.GH9581@n2100.arm.linux.org.uk>
References: <20111107172836.5615.64219.stgit@e102109-lin.cambridge.arm.com>
 <CAOesGMhWxEKUe7C4A+Xqv3RjN_u1t4k8eHWSZE4qMoBPD9=1qw@mail.gmail.com>
 <20111116235024.GH9581@n2100.arm.linux.org.uk>
Message-ID: <CAOesGMgmVdck4rP9iQ+eBc+R1p-eVChnumiszB_D77Q0Rtyf3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Nov 16, 2011 at 3:50 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Nov 16, 2011 at 01:23:02PM -0800, Olof Johansson wrote:
>> Agreed. Russell, please consider picking this up -- the bug is very
>> real and it sounds like the objection is vague.
>
> No, it isn't. ?It's creating an unsafe situation. ?If we're going to do
> this, we might as well give up on architecture correctness because we're
> throwing out locking correctness.
>
> 1. We look up the VMA.
> 2. We pass the VMA to the cache operation.
> 3. The cache operation dereferences the VMA to obtain the VMA flags.

The current implementation doesn't use the flush_cache_user_range
per-cpu function, it uses the coherent_user_page:

from arch/arm/include/asm/cacheflush.h:

#define flush_cache_user_range(vma,start,end) \
    __cpuc_coherent_user_range((start) & PAGE_MASK, PAGE_ALIGN(end))

Which doesn't take flags. So the vma isn't used at all at the flushing
step (which is also why this patch removes the flags being passed in).

> If something else happens to modify the VMA (eg, a concurrent mremap or
> munmap) then without locking, we could end up dereferencing something
> that is no longer the VMA we thought we had.
>
> Plus, consider that the VMA list is modifyable while the mmap_sem is not
> held - do we really want to see the effects of having find_vma() being
> preempted having loaded a vm_next pointer, another thread coming in,
> modifying the VMA list (possibly deleting the next vma), that memory being
> reallocated to something else, and then we resume and fall off the VMA
> list and possibly OOPS because we've accessed what we thought was the
> next vm_next pointer but it wasn't?
>
> While we can say "an application should not do that" that's not a reason
> to ignore this problem and just delete all the locking in the hope that
> we'll always have well behaving applications.
>
> So, it's *totally* unsafe to delete the locking here.
>
> The requirement is that the mmap_sem must be held while you expect to
> hold any reference to a vm_area_struct. ?There's no exceptions to that.

Yep, I would agree if we actually needed the vma for the flags, but we
don't with the current implementation.

We also don't continue iterating over the vmas, we only flush for the
first one in the range that we find. That is possibly a bug.


-Olof
