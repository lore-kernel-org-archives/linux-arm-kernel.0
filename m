From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 18 Apr 2012 09:40:58 +0100
Subject: [PATCH] ARM: Do not call flush_cache_user_range with mmap_sem held
In-Reply-To: <CAOesGMjEW0cj2v-2OuWTd9WhLdZr3xOdEpZ2qy_UTdyMhYvaDA@mail.gmail.com>
References: <20111107172836.5615.64219.stgit@e102109-lin.cambridge.arm.com>
 <CAOesGMhWxEKUe7C4A+Xqv3RjN_u1t4k8eHWSZE4qMoBPD9=1qw@mail.gmail.com>
 <20111116235024.GH9581@n2100.arm.linux.org.uk>
 <20111117102205.GF4748@arm.com>
 <20111117104245.GL9581@n2100.arm.linux.org.uk>
 <20111117105935.GH4748@arm.com>
 <20111117110339.GO9581@n2100.arm.linux.org.uk>
 <20111117112508.GA20412@arm.com> <4F827A82.4000407@googlemail.com>
 <CAOesGMjEW0cj2v-2OuWTd9WhLdZr3xOdEpZ2qy_UTdyMhYvaDA@mail.gmail.com>
Message-ID: <20120418084058.GA723@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 09, 2012 at 03:24:29PM +0100, Olof Johansson wrote:
> On Sun, Apr 8, 2012 at 10:58 PM, Dirk Behme <dirk.behme@googlemail.com> wrote:
> > In an other thread
> >
> > http://lists.arm.linux.org.uk/lurker/message/20120406.033509.ca9fe8cf.en.html
> >
> > it seems that we have an additional user where this patch fixed an issue.
> >
> > So would it be possible to talk about this patch, again?
> 
> This patch had plenty of talk already. :-)  What it needs is for
> someone to go in and annotate (and thus partially rewrite) the pre-v6
> cacheflush loops with exception fixups, so that the mmap_sem can be
> safely dropped.

There is no need to annotate the pre-v6 cacheflush loops as the cache
maintenance ops on v5 and early do not generate translation or page
faults (VIVT cache that doesn't do page table walks).

> As mentioned above, v6 and v7 are already annotated -- so a bad
> passed-in pointer will just cause a fault, fixup and signal to the
> application like other architectures where the flush can be done from
> userspace, or any other bad pointer passed into a syscall.

A bad pointer is already ignored by do_cache_op() since find_vma()
cannot find a proper address. There is a scenario for multi-threaded
apps where one thread unmaps a range while another tries to flush. For
consistency with the other bad pointer case (i.e. ignoring it), the
cache flushing fixup code simply skips the faulting page without sending
signals to the application.

>From my perspective, this patch is still valid (it keeps the find_vma()
call under the mmap_sem lock but calls the cache flushing outside this
critical region).

-- 
Catalin
