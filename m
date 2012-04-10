From: will.deacon@arm.com (Will Deacon)
Date: Tue, 10 Apr 2012 18:17:20 +0100
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
Message-ID: <20120410171720.GH14394@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 09, 2012 at 03:24:29PM +0100, Olof Johansson wrote:
> On Sun, Apr 8, 2012 at 10:58 PM, Dirk Behme <dirk.behme@googlemail.com> wrote:
> >
> > So would it be possible to talk about this patch, again?
> 
> This patch had plenty of talk already. :-)  What it needs is for
> someone to go in and annotate (and thus partially rewrite) the pre-v6
> cacheflush loops with exception fixups, so that the mmap_sem can be
> safely dropped.
> 
> As mentioned above, v6 and v7 are already annotated -- so a bad
> passed-in pointer will just cause a fault, fixup and signal to the
> application like other architectures where the flush can be done from
> userspace, or any other bad pointer passed into a syscall.

Are you sure about this? It looks to me like the v6 implementation just
skips over faulting pages and the v7 implementation gives up after the first
faulting page and just returns 0 (despite the comment suggesting otherwise).

If we want to send a signal, we need to rework do_cache_op slightly and fix
up all of the low-level cache accessors.  We also need to decide whether we
continue past a faulting page or give up at that point. Alternatively, we
could return -EFAULT from the syscall instead of sending a signal.

Will
